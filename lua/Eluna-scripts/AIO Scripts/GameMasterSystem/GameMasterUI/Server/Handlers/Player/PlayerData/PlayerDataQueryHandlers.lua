--[[
    GameMaster UI - Player Data Query Handlers Sub-Module
    
    This sub-module handles player data queries:
    - Getting online player data
    - Getting offline player data from database
    - Getting all players (online + offline)
    - Helper functions for ban checking and zone resolution
]]--

local PlayerDataQueryHandlers = {}

-- Module dependencies (will be injected)
local GameMasterSystem, Config, Utils, Database, DatabaseHelper

function PlayerDataQueryHandlers.RegisterHandlers(gms, config, utils, database, dbHelper)
    GameMasterSystem = gms
    Config = config
    Utils = utils
    Database = database
    DatabaseHelper = dbHelper
    
    -- Register query handlers
    GameMasterSystem.getPlayerData = PlayerDataQueryHandlers.getPlayerData
    GameMasterSystem.getOfflinePlayerData = PlayerDataQueryHandlers.getOfflinePlayerData
    GameMasterSystem.getAllPlayerData = PlayerDataQueryHandlers.getAllPlayerData
end

-- Helper function to check ban status
local function checkBanStatus(accountId, charGuid)
    local isBanned = false
    local banType = nil
    
    -- Check account ban
    local accountBan = AuthDBQuery(string.format(
        "SELECT 1 FROM account_banned WHERE id = %d AND (unbandate > UNIX_TIMESTAMP() OR unbandate = 0)",
        accountId
    ))
    if accountBan then
        isBanned = true
        banType = "Account"
    else
        -- Check character ban (try both databases)
        local charBan = CharDBQuery(string.format(
            "SELECT 1 FROM character_banned WHERE guid = %d AND (unbandate > UNIX_TIMESTAMP() OR unbandate = 0)",
            charGuid
        ))
        if not charBan then
            charBan = AuthDBQuery(string.format(
                "SELECT 1 FROM character_banned WHERE guid = %d AND (unbandate > UNIX_TIMESTAMP() OR unbandate = 0)",
                charGuid
            ))
        end
        if charBan then
            isBanned = true
            banType = "Character"
        end
    end
    
    return isBanned, banType
end

-- Helper function to get zone name
local function getZoneName(areaId)
    local zoneName = "Unknown"
    
    if areaId and areaId > 0 then
        -- Try to get area name using global function
        local success, areaName = pcall(function()
            return GetAreaName(areaId)
        end)
        if success and areaName then
            zoneName = areaName
        else
            -- Fallback: Query database if GetAreaName fails
            local zoneQuery = WorldDBQuery(string.format(
                "SELECT name FROM area_template WHERE entry = %d",
                areaId
            ))
            if zoneQuery then
                zoneName = zoneQuery:GetString(0) or "Unknown"
            end
        end
    end
    
    return zoneName
end

-- Get online player data
function PlayerDataQueryHandlers.getPlayerData(player, offset, pageSize, sortOrder, includeOffline)
    offset = offset or 0
    pageSize = Utils.validatePageSize(pageSize or Config.defaultPageSize)
    sortOrder = Utils.validateSortOrder(sortOrder or "ASC")
    includeOffline = includeOffline or false
    
    print(string.format("[GameMasterSystem] getPlayerData called - includeOffline: %s", tostring(includeOffline)))
    
    local playerData = {}
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
    
    -- Apply pagination
    local startIdx = offset + 1
    local endIdx = math.min(offset + pageSize, #onlinePlayers)
    
    for i = startIdx, endIdx do
        local targetPlayer = onlinePlayers[i]
        
        if targetPlayer then
            -- Wrap player data collection in pcall for error handling
            local success, err = pcall(function()
                -- Safely get player properties with nil checks
                local name = targetPlayer:GetName() or "Unknown"
                
                local class = targetPlayer:GetClass() or 1
                local race = targetPlayer:GetRace() or 1
                local level = targetPlayer:GetLevel() or 1
                local guild = targetPlayer:GetGuild()
                local totalMoney = targetPlayer:GetCoinage() or 0
                local gold = math.floor(totalMoney / 10000)
                
                -- Try to get display ID, with fallback
                local displayId = 0
                local displaySuccess = pcall(function()
                    displayId = targetPlayer:GetDisplayId() or 0
                end)
                if not displaySuccess then
                    displayId = 0 -- Use 0 as fallback
                end
                
                -- Get zone name
                local areaId = targetPlayer:GetAreaId()
                local zoneName = getZoneName(areaId)
                
                -- Check ban status
                local accountId = targetPlayer:GetAccountId()
                local isBanned, banType = checkBanStatus(accountId, targetPlayer:GetGUIDLow())
                
                local playerInfo = {
                    name = name,
                    level = level,
                    class = Utils.classInfo[class] and Utils.classInfo[class].name or "Unknown",
                    classColor = Utils.classInfo[class] and Utils.classInfo[class].color or "FFFFFF",
                    race = Utils.raceInfo[race] or "Unknown",
                    zone = zoneName,
                    gold = gold,
                    guildName = guild and guild:GetName() or nil,
                    online = true,
                    displayId = displayId,
                    isBanned = isBanned,
                    banType = banType
                }
                
                table.insert(playerData, playerInfo)
            end)
            
            if not success then
                print("[GameMasterSystem] ERROR collecting player data:", err)
            end
        end
    end
    
    -- Send message if no players found
    if #playerData == 0 and totalCount == 0 then
        player:SendBroadcastMessage("No players online.")
    end
    
    print(string.format("[GameMasterSystem] Sending %d players to client (online only)", #playerData))
    AIO.Handle(player, "GameMasterSystem", "receivePlayerData", 
        playerData, offset, pageSize, paginationInfo.hasNextPage, 
        paginationInfo.totalCount, paginationInfo.totalPages, paginationInfo.currentPage)
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
                local zoneName = getZoneName(zone)
                
                -- Check ban status
                local isBanned, banType = checkBanStatus(accountId, guid)
                
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
                local isBanned, banType = checkBanStatus(accountId, guid)
                
                -- Get zone name
                local areaId = targetPlayer:GetAreaId()
                local zoneName = getZoneName(areaId)
                
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
                local isBanned, banType = checkBanStatus(accountId, guid)
                
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