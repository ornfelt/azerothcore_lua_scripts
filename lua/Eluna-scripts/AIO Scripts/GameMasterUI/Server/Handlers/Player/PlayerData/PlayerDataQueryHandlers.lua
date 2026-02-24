--[[
    GameMaster UI - Player Data Query Handlers Sub-Module

    This sub-module handles player data queries:
    - Getting online player data
    - Getting offline player data from database
    - Getting all players (online + offline)

    Optimized with:
    - Cached zone name lookups
    - Batched ban status checking
    - Reduced database calls via QueryUtils
]]--

local PlayerDataQueryHandlers = {}

-- Module dependencies (will be injected)
local GameMasterSystem, Config, Utils, Database, DatabaseHelper
local QueryUtils, QueryCache

function PlayerDataQueryHandlers.RegisterHandlers(gms, config, utils, database, dbHelper)
    GameMasterSystem = gms
    Config = config
    Utils = utils
    Database = database
    DatabaseHelper = dbHelper

    -- Load optimization modules
    QueryCache = require("GameMasterUI.Server.Utils.QueryCache")
    QueryUtils = require("GameMasterUI.Server.Utils.QueryUtils")

    -- Initialize optimization modules
    QueryCache.Initialize(config)
    QueryUtils.Initialize(dbHelper, config, QueryCache)

    -- Register query handlers
    GameMasterSystem.getPlayerData = PlayerDataQueryHandlers.getPlayerData
    GameMasterSystem.getOfflinePlayerData = PlayerDataQueryHandlers.getOfflinePlayerData
    GameMasterSystem.getAllPlayerData = PlayerDataQueryHandlers.getAllPlayerData
end


-- Get online player data (OPTIMIZED with batching and caching)
function PlayerDataQueryHandlers.getPlayerData(player, offset, pageSize, sortOrder, includeOffline)
    offset = offset or 0
    pageSize = Utils.validatePageSize(pageSize or Config.defaultPageSize)
    sortOrder = Utils.validateSortOrder(sortOrder or "ASC")
    includeOffline = includeOffline or false

    print(string.format("[GameMasterSystem] getPlayerData called - includeOffline: %s", tostring(includeOffline)))

    local onlinePlayers = GetPlayersInWorld()

    -- Ensure we have a valid table
    if not onlinePlayers then
        print("[GameMasterSystem] ERROR: GetPlayersInWorld() returned nil")
        onlinePlayers = {}
    end

    local totalCount = #onlinePlayers

    -- Calculate pagination info
    local paginationInfo = Utils.calculatePaginationInfo(totalCount, offset, pageSize)

    -- Sort players by name
    table.sort(onlinePlayers, function(a, b)
        if sortOrder == "ASC" then
            return a:GetName() < b:GetName()
        else
            return a:GetName() > b:GetName()
        end
    end)

    -- Apply pagination to get only the players we need to process
    local startIdx = offset + 1
    local endIdx = math.min(offset + pageSize, #onlinePlayers)
    local playersToProcess = {}

    -- Collect players for batch processing
    for i = startIdx, endIdx do
        local targetPlayer = onlinePlayers[i]
        if targetPlayer then
            -- Safely get player properties with nil checks
            local success, playerData = pcall(function()
                return {
                    player = targetPlayer,
                    name = targetPlayer:GetName() or "Unknown",
                    class = targetPlayer:GetClass() or 1,
                    race = targetPlayer:GetRace() or 1,
                    level = targetPlayer:GetLevel() or 1,
                    guild = targetPlayer:GetGuild(),
                    totalMoney = targetPlayer:GetCoinage() or 0,
                    displayId = (function()
                        local success, id = pcall(function() return targetPlayer:GetDisplayId() or 0 end)
                        return success and id or 0
                    end)(),
                    accountId = targetPlayer:GetAccountId(),
                    charGuid = targetPlayer:GetGUIDLow(),
                    areaId = targetPlayer:GetAreaId()
                }
            end)

            if success then
                table.insert(playersToProcess, playerData)
            else
                print("[GameMasterSystem] ERROR collecting player data:", playerData)
            end
        end
    end

    -- Send empty response if no players to process
    if #playersToProcess == 0 then
        if totalCount == 0 then
            Utils.sendMessage(player, "info", "No players online.")
        end

        print(string.format("[GameMasterSystem] Sending 0 players to client"))
        AIO.Handle(player, "GameMasterSystem", "receivePlayerData",
            {}, offset, pageSize, paginationInfo.hasNextPage,
            paginationInfo.totalCount, paginationInfo.totalPages, paginationInfo.currentPage)
        return
    end

    -- OPTIMIZATION: Batch process ban status and zone names
    -- Collect unique area IDs for zone batch lookup
    local uniqueAreaIds = {}
    local areaIdSet = {}
    for _, playerData in ipairs(playersToProcess) do
        local areaId = playerData.areaId
        if areaId and areaId > 0 and not areaIdSet[areaId] then
            areaIdSet[areaId] = true
            table.insert(uniqueAreaIds, areaId)
        end
    end

    -- Batch lookup zone names
    QueryUtils.getZoneNamesBatch(uniqueAreaIds, function(zoneResults)
        -- Batch lookup ban status
        QueryUtils.checkBanStatusBatch(playersToProcess, function(banResults)
            local finalPlayerData = {}

            -- Build final player data with cached results
            for _, playerInfo in ipairs(playersToProcess) do
                local gold = math.floor(playerInfo.totalMoney / 10000)

                -- Get ban status from batch results
                local banInfo = banResults[playerInfo.charGuid] or { banned = false, type = nil }

                -- Get zone name from batch results
                local zoneName = zoneResults[playerInfo.areaId] or "Unknown"

                local finalInfo = {
                    name = playerInfo.name,
                    level = playerInfo.level,
                    class = Utils.classInfo[playerInfo.class] and Utils.classInfo[playerInfo.class].name or "Unknown",
                    classColor = Utils.classInfo[playerInfo.class] and Utils.classInfo[playerInfo.class].color or "FFFFFF",
                    race = Utils.raceInfo[playerInfo.race] or "Unknown",
                    zone = zoneName,
                    gold = gold,
                    guildName = playerInfo.guild and playerInfo.guild:GetName() or nil,
                    online = true,
                    displayId = playerInfo.displayId,
                    isBanned = banInfo.banned,
                    banType = banInfo.type
                }

                table.insert(finalPlayerData, finalInfo)
            end

            print(string.format("[GameMasterSystem] Sending %d players to client (online only)", #finalPlayerData))
            AIO.Handle(player, "GameMasterSystem", "receivePlayerData",
                finalPlayerData, offset, pageSize, paginationInfo.hasNextPage,
                paginationInfo.totalCount, paginationInfo.totalPages, paginationInfo.currentPage)
        end)
    end)
end

-- Get offline player data from database
function PlayerDataQueryHandlers.getOfflinePlayerData(player, offset, pageSize, sortOrder)
    offset = offset or 0
    pageSize = Utils.validatePageSize(pageSize or Config.defaultPageSize)
    sortOrder = Utils.validateSortOrder(sortOrder or "ASC")
    
    local playerData = {}
    
    -- Get online player GUIDs to exclude them from offline query
    local onlinePlayers = GetPlayersInWorld()
    local onlineGuids = {}
    if onlinePlayers then
        for _, p in ipairs(onlinePlayers) do
            onlineGuids[p:GetGUIDLow()] = true
        end
    end
    
    -- Query for offline characters
    local countQuery = CharDBQuery("SELECT COUNT(*) FROM characters WHERE deleteDate IS NULL")
    local totalCount = 0
    if countQuery then
        totalCount = countQuery:GetUInt32(0)
    end
    
    -- Subtract online players from total
    totalCount = totalCount - #onlinePlayers
    
    -- Calculate pagination
    local paginationInfo = Utils.calculatePaginationInfo(totalCount, offset, pageSize)
    
    -- Main query for offline characters with all needed data
    local query = string.format([[
        SELECT 
            c.guid,
            c.name,
            c.race,
            c.class,
            c.gender,
            c.level,
            c.zone,
            c.map,
            c.logout_time,
            c.account,
            c.totaltime,
            c.money,
            gm.guildid,
            g.name as guild_name
        FROM characters c
        LEFT JOIN guild_member gm ON c.guid = gm.guid
        LEFT JOIN guild g ON gm.guildid = g.guildid
        WHERE c.deleteDate IS NULL
        ORDER BY c.name %s
        LIMIT %d OFFSET %d
    ]], sortOrder, pageSize, offset)
    
    local result = CharDBQuery(query)
    
    if result then
        repeat
            local guid = result:GetUInt32(0)
            
            -- Skip if player is online
            if not onlineGuids[guid] then
                local name = result:GetString(1)
                local race = result:GetUInt32(2)
                local class = result:GetUInt32(3)
                local gender = result:GetUInt32(4)
                local level = result:GetUInt32(5)
                local zone = result:GetUInt32(6)
                local map = result:GetUInt32(7)
                local logoutTime = result:GetUInt32(8)
                local accountId = result:GetUInt32(9)
                local totalTime = result:GetUInt32(10)
                local money = result:GetUInt32(11)
                local guildId = result:GetUInt32(12)
                local guildName = result:GetString(13)


                -- Get zone name
                local zoneName = QueryUtils.getZoneName(zone)

                -- Check ban status
                local isBanned, banType = QueryUtils.checkBanStatus(accountId, guid)
                
                -- Calculate time since logout
                local currentTime = os.time()
                local timeSinceLogout = currentTime - logoutTime
                local lastSeen = "Unknown"
                
                if timeSinceLogout < 3600 then
                    lastSeen = string.format("%d minutes ago", math.floor(timeSinceLogout / 60))
                elseif timeSinceLogout < 86400 then
                    lastSeen = string.format("%d hours ago", math.floor(timeSinceLogout / 3600))
                elseif timeSinceLogout < 604800 then
                    lastSeen = string.format("%d days ago", math.floor(timeSinceLogout / 86400))
                else
                    lastSeen = string.format("%d weeks ago", math.floor(timeSinceLogout / 604800))
                end
                
                local gold = math.floor(money / 10000)
                
                local playerInfo = {
                    name = name,
                    level = level,
                    class = Utils.classInfo[class] and Utils.classInfo[class].name or "Unknown",
                    classColor = Utils.classInfo[class] and Utils.classInfo[class].color or "FFFFFF",
                    race = Utils.raceInfo[race] or "Unknown",
                    zone = zoneName,
                    gold = gold,
                    guildName = guildName,
                    online = false,
                    displayId = 0,  -- Offline players don't have display ID
                    isBanned = isBanned,
                    banType = banType,
                    lastSeen = lastSeen,
                    guid = guid,
                    accountId = accountId
                }
                
                table.insert(playerData, playerInfo)
            end
        until not result:NextRow()
    end
    
    AIO.Handle(player, "GameMasterSystem", "receivePlayerData", 
        playerData, offset, pageSize, paginationInfo.hasNextPage, 
        paginationInfo.totalCount, paginationInfo.totalPages, paginationInfo.currentPage)
end

-- Get all players (online and offline)
function PlayerDataQueryHandlers.getAllPlayerData(player, offset, pageSize, sortOrder)
    offset = offset or 0
    pageSize = Utils.validatePageSize(pageSize or Config.defaultPageSize)
    sortOrder = Utils.validateSortOrder(sortOrder or "ASC")
    
    print("[GameMasterSystem] getAllPlayerData called - will return online AND offline players")
    
    local allPlayers = {}
    
    -- First get online players
    local onlinePlayers = GetPlayersInWorld()
    local onlineGuids = {}
    
    if onlinePlayers then
        for _, targetPlayer in ipairs(onlinePlayers) do
            local guid = targetPlayer:GetGUIDLow()
            onlineGuids[guid] = true
            
            local success, playerInfo = pcall(function()
                local class = targetPlayer:GetClass() or 1
                local race = targetPlayer:GetRace() or 1
                local guild = targetPlayer:GetGuild()
                local totalMoney = targetPlayer:GetCoinage() or 0
                local gold = math.floor(totalMoney / 10000)
                local accountId = targetPlayer:GetAccountId()

                -- Check ban status
                local isBanned, banType = QueryUtils.checkBanStatus(accountId, guid)

                -- Get zone name
                local areaId = targetPlayer:GetAreaId()
                local zoneName = QueryUtils.getZoneName(areaId)
                
                return {
                    name = targetPlayer:GetName() or "Unknown",
                    level = targetPlayer:GetLevel() or 1,
                    class = Utils.classInfo[class] and Utils.classInfo[class].name or "Unknown",
                    classColor = Utils.classInfo[class] and Utils.classInfo[class].color or "FFFFFF",
                    race = Utils.raceInfo[race] or "Unknown",
                    zone = zoneName,
                    gold = gold,
                    guildName = guild and guild:GetName() or nil,
                    online = true,
                    displayId = targetPlayer:GetDisplayId() or 0,
                    isBanned = isBanned,
                    banType = banType,
                    lastSeen = "Online",
                    guid = guid,
                    accountId = accountId
                }
            end)
            
            if success and playerInfo then
                table.insert(allPlayers, playerInfo)
            end
        end
    end
    
    -- Then add offline players from database
    local offlineQuery = CharDBQuery([[
        SELECT 
            c.guid,
            c.name,
            c.race,
            c.class,
            c.gender,
            c.level,
            c.zone,
            c.map,
            c.logout_time,
            c.account,
            c.totaltime,
            c.money,
            gm.guildid,
            g.name as guild_name
        FROM characters c
        LEFT JOIN guild_member gm ON c.guid = gm.guid
        LEFT JOIN guild g ON gm.guildid = g.guildid
        WHERE c.deleteDate IS NULL
    ]])
    
    if offlineQuery then
        repeat
            local guid = offlineQuery:GetUInt32(0)
            
            -- Only add if not online
            if not onlineGuids[guid] then
                local logoutTime = offlineQuery:GetUInt32(8)
                local currentTime = os.time()
                local timeSinceLogout = currentTime - logoutTime
                local lastSeen = "Unknown"
                
                if timeSinceLogout < 3600 then
                    lastSeen = string.format("%d min ago", math.floor(timeSinceLogout / 60))
                elseif timeSinceLogout < 86400 then
                    lastSeen = string.format("%d hrs ago", math.floor(timeSinceLogout / 3600))
                elseif timeSinceLogout < 604800 then
                    lastSeen = string.format("%d days ago", math.floor(timeSinceLogout / 86400))
                else
                    lastSeen = string.format("%d wks ago", math.floor(timeSinceLogout / 604800))
                end
                
                local class = offlineQuery:GetUInt32(3)
                local race = offlineQuery:GetUInt32(2)
                local money = offlineQuery:GetUInt32(11)
                local accountId = offlineQuery:GetUInt32(9)

                -- Check ban status
                local isBanned, banType = QueryUtils.checkBanStatus(accountId, guid)
                
                local playerInfo = {
                    name = offlineQuery:GetString(1),
                    level = offlineQuery:GetUInt32(5),
                    class = Utils.classInfo[class] and Utils.classInfo[class].name or "Unknown",
                    classColor = Utils.classInfo[class] and Utils.classInfo[class].color or "FFFFFF",
                    race = Utils.raceInfo[race] or "Unknown",
                    zone = "Offline",
                    gold = math.floor(money / 10000),
                    guildName = offlineQuery:GetString(13),
                    online = false,
                    displayId = 0,
                    isBanned = isBanned,
                    banType = banType,
                    lastSeen = lastSeen,
                    guid = guid,
                    accountId = accountId
                }
                
                table.insert(allPlayers, playerInfo)
            end
        until not offlineQuery:NextRow()
    end
    
    -- Sort all players
    table.sort(allPlayers, function(a, b)
        -- First sort by online status (online first)
        if a.online ~= b.online then
            return a.online
        end
        -- Then by name
        if sortOrder == "ASC" then
            return a.name < b.name
        else
            return a.name > b.name
        end
    end)
    
    -- Apply pagination
    local totalCount = #allPlayers
    local paginationInfo = Utils.calculatePaginationInfo(totalCount, offset, pageSize)
    
    local paginatedData = {}
    local startIdx = offset + 1
    local endIdx = math.min(offset + pageSize, totalCount)
    
    for i = startIdx, endIdx do
        if allPlayers[i] then
            table.insert(paginatedData, allPlayers[i])
        end
    end
    
    print(string.format("[GameMasterSystem] Sending %d players to client (online + offline)", #paginatedData))
    AIO.Handle(player, "GameMasterSystem", "receivePlayerData", 
        paginatedData, offset, pageSize, paginationInfo.hasNextPage, 
        paginationInfo.totalCount, paginationInfo.totalPages, paginationInfo.currentPage)
end

return PlayerDataQueryHandlers