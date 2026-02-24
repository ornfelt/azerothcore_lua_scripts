--[[
    GameMasterUI - Player Search Strategy

    Configuration for player search using the unified SearchManager

    Features:
    - Search by player name
    - Online players only
    - Ban status checking
    - Zone name resolution
    - Batch optimization
    - Result caching (30 seconds)

    Note: Player search is different from item/spell search because it:
    - Operates on in-memory data (online players) not database
    - Requires batch processing for ban status and zones
    - Has shorter cache TTL due to dynamic nature
]]--

local PlayerSearchStrategy = {}

-- Module dependencies
local Utils, QueryUtils

function PlayerSearchStrategy.Initialize(utils, queryUtils)
    Utils = utils
    QueryUtils = queryUtils
end

--[[
    Create and return the player search configuration

    Note: This config is adapted for in-memory searching
    and uses custom execution logic
]]--
function PlayerSearchStrategy.GetConfig()
    return {
        -- Unique identifier
        searchType = "players",

        -- Permissions
        requiredGMRank = 2,

        -- Caching configuration (shorter TTL for dynamic data)
        cache = {
            enabled = true,
            ttl = 30,  -- 30 seconds (players come/go frequently)
            keyGenerator = function(params)
                local includeOffline = params.filters and params.filters.includeOffline or false
                return table.concat({
                    params.query or "",
                    params.sortOrder or "ASC",
                    tostring(includeOffline)
                }, ":")
            end
        },

        -- Pagination configuration
        pagination = {
            defaultPageSize = 50,
            minPageSize = 10,
            maxPageSize = 200
        },

        -- Player search doesn't use database queries
        buildCountQuery = nil,
        buildQuery = nil,

        -- Transform function not used (custom processing)
        transformResult = nil,

        -- Custom search executor for player search
        customExecutor = function(player, params, sendResults)
            PlayerSearchStrategy.ExecutePlayerSearch(player, params, sendResults)
        end,

        -- Parameter validation
        validateParams = function(params)
            -- No special validation needed for player search
            return true, nil
        end
    }
end

--[[
    Custom player search executor
    Handles in-memory player filtering and batch data enrichment
]]--
function PlayerSearchStrategy.ExecutePlayerSearch(player, params, sendResults)
    local query = (params.query or ""):lower()
    local offset = params.offset or 0
    local pageSize = params.pageSize or 50
    local sortOrder = params.sortOrder or "ASC"
    local includeOffline = params.filters and params.filters.includeOffline or false

    -- Get online players
    local onlinePlayers = GetPlayersInWorld()
    local matchingPlayers = {}

    -- If includeOffline is true, we need to fetch from database
    if includeOffline then
        -- Delegate to database-based search for offline players
        PlayerSearchStrategy.ExecuteOfflinePlayerSearch(player, params, sendResults)
        return
    end

    -- Online-only search: Filter by search query
    if query == "" then
        matchingPlayers = onlinePlayers
    else
        for _, targetPlayer in ipairs(onlinePlayers) do
            if targetPlayer:GetName():lower():find(query, 1, true) then
                table.insert(matchingPlayers, targetPlayer)
            end
        end
    end

    local totalCount = #matchingPlayers

    -- Calculate pagination
    local paginationInfo = {
        currentOffset = offset,
        pageSize = pageSize,
        totalCount = totalCount,
        resultCount = math.min(pageSize, totalCount - offset),
        hasNextPage = (offset + pageSize) < totalCount,
        hasPrevPage = offset > 0,
        currentPage = math.floor(offset / pageSize) + 1,
        totalPages = math.ceil(totalCount / pageSize)
    }

    -- Handle empty results
    if totalCount == 0 then
        sendResults({
            results = {},
            pagination = paginationInfo
        })
        return
    end

    -- Sort matching players
    table.sort(matchingPlayers, function(a, b)
        if sortOrder == "ASC" then
            return a:GetName() < b:GetName()
        else
            return a:GetName() > b:GetName()
        end
    end)

    -- Apply pagination
    local startIdx = offset + 1
    local endIdx = math.min(offset + pageSize, totalCount)
    local playersToProcess = {}

    for i = startIdx, endIdx do
        local targetPlayer = matchingPlayers[i]
        if targetPlayer then
            table.insert(playersToProcess, {
                player = targetPlayer,
                accountId = targetPlayer:GetAccountId(),
                charGuid = targetPlayer:GetGUIDLow(),
                areaId = targetPlayer:GetAreaId()
            })
        end
    end

    -- Collect unique area IDs for batch zone lookup
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
            local playerResults = {}

            -- Build player data with cached results
            for _, playerInfo in ipairs(playersToProcess) do
                local targetPlayer = playerInfo.player
                local class = targetPlayer:GetClass()
                local race = targetPlayer:GetRace()
                local guild = targetPlayer:GetGuild()
                local totalMoney = targetPlayer:GetCoinage()
                local gold = math.floor(totalMoney / 10000)

                -- Get ban status from batch results
                local banInfo = banResults[playerInfo.charGuid] or { banned = false, type = nil }

                -- Get zone name from batch results
                local zoneName = zoneResults[playerInfo.areaId] or "Unknown"

                local finalPlayerInfo = {
                    name = targetPlayer:GetName(),
                    level = targetPlayer:GetLevel(),
                    class = Utils.classInfo[class] and Utils.classInfo[class].name or "Unknown",
                    classColor = Utils.classInfo[class] and Utils.classInfo[class].color or "FFFFFF",
                    race = Utils.raceInfo[race] or "Unknown",
                    zone = zoneName,
                    gold = gold,
                    guildName = guild and guild:GetName() or nil,
                    online = true,
                    displayId = targetPlayer:GetDisplayId(),
                    isBanned = banInfo.banned,
                    banType = banInfo.type
                }

                table.insert(playerResults, finalPlayerInfo)
            end

            -- Send results
            sendResults({
                results = playerResults,
                pagination = paginationInfo
            })
        end)
    end)
end

--[[
    Execute offline player search (includes both online and offline players)
    Uses database queries to fetch all players
]]--
function PlayerSearchStrategy.ExecuteOfflinePlayerSearch(player, params, sendResults)
    local query = (params.query or ""):lower()
    local offset = params.offset or 0
    local pageSize = params.pageSize or 50
    local sortOrder = params.sortOrder or "ASC"

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
                    isBanned = false,
                    banType = nil
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
            c.level,
            c.logout_time,
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
                local logoutTime = offlineQuery:GetUInt32(5)
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
                local money = offlineQuery:GetUInt32(6)

                local playerInfo = {
                    name = offlineQuery:GetString(1),
                    level = offlineQuery:GetUInt32(4),
                    class = Utils.classInfo[class] and Utils.classInfo[class].name or "Unknown",
                    classColor = Utils.classInfo[class] and Utils.classInfo[class].color or "FFFFFF",
                    race = Utils.raceInfo[race] or "Unknown",
                    zone = "Offline",
                    gold = math.floor(money / 10000),
                    guildName = offlineQuery:GetString(8),
                    online = false,
                    displayId = 0,
                    isBanned = false,
                    banType = nil,
                    lastSeen = lastSeen
                }

                table.insert(allPlayers, playerInfo)
            end
        until not offlineQuery:NextRow()
    end

    -- Filter by search query if provided
    local matchingPlayers = {}
    if query == "" then
        matchingPlayers = allPlayers
    else
        for _, playerInfo in ipairs(allPlayers) do
            if playerInfo.name:lower():find(query, 1, true) then
                table.insert(matchingPlayers, playerInfo)
            end
        end
    end

    -- Sort all players
    table.sort(matchingPlayers, function(a, b)
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

    local totalCount = #matchingPlayers

    -- Calculate pagination
    local paginationInfo = {
        currentOffset = offset,
        pageSize = pageSize,
        totalCount = totalCount,
        resultCount = math.min(pageSize, math.max(0, totalCount - offset)),
        hasNextPage = (offset + pageSize) < totalCount,
        hasPrevPage = offset > 0,
        currentPage = math.floor(offset / pageSize) + 1,
        totalPages = math.max(1, math.ceil(totalCount / pageSize))
    }

    -- Apply pagination
    local startIdx = offset + 1
    local endIdx = math.min(offset + pageSize, totalCount)
    local paginatedResults = {}

    for i = startIdx, endIdx do
        if matchingPlayers[i] then
            table.insert(paginatedResults, matchingPlayers[i])
        end
    end

    -- Send results
    sendResults({
        results = paginatedResults,
        pagination = paginationInfo
    })
end

--[[
    Register this search strategy with SearchManager
]]--
function PlayerSearchStrategy.Register(searchManager, utils, queryUtils)
    PlayerSearchStrategy.Initialize(utils, queryUtils)
    local config = PlayerSearchStrategy.GetConfig()
    searchManager.RegisterSearchType(config)
end

return PlayerSearchStrategy
