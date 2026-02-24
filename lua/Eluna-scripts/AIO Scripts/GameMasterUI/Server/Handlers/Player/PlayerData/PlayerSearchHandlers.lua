--[[
    GameMaster UI - Player Search Handlers Sub-Module

    This sub-module handles player search and refresh operations:
    - Search players by name
    - Refresh player data
    - Search helper functions

    Optimized with:
    - Cached zone name lookups
    - Batched ban status checking
    - Reduced database calls via QueryUtils
]]--

local PlayerSearchHandlers = {}

-- Module dependencies (will be injected)
local GameMasterSystem, Config, Utils, Database, DatabaseHelper
local QueryUtils, QueryCache

-- Reference to query handlers for refresh operation
local PlayerDataQueryHandlers

function PlayerSearchHandlers.RegisterHandlers(gms, config, utils, database, dbHelper)
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

    -- Register search handlers
    GameMasterSystem.searchPlayerData = PlayerSearchHandlers.searchPlayerData
    GameMasterSystem.refreshPlayerData = PlayerSearchHandlers.refreshPlayerData
end

-- Set reference to PlayerDataQueryHandlers for refresh operation
function PlayerSearchHandlers.SetQueryHandlers(queryHandlers)
    PlayerDataQueryHandlers = queryHandlers
end


-- Search players by name (OPTIMIZED with batching and caching)
function PlayerSearchHandlers.searchPlayerData(player, query, offset, pageSize, sortOrder)
    if not query or query == "" then
        -- If no query, fall back to getting all player data
        if PlayerDataQueryHandlers then
            return PlayerDataQueryHandlers.getPlayerData(player, offset, pageSize, sortOrder)
        else
            print("[PlayerSearchHandlers] Warning: PlayerDataQueryHandlers not set, cannot fall back to getPlayerData")
            return
        end
    end

    offset = offset or 0
    pageSize = Utils.validatePageSize(pageSize or Config.defaultPageSize)
    sortOrder = Utils.validateSortOrder(sortOrder or "ASC")

    local onlinePlayers = GetPlayersInWorld()
    local matchingPlayers = {}

    -- Filter players by search query
    query = query:lower()
    for _, targetPlayer in ipairs(onlinePlayers) do
        if targetPlayer:GetName():lower():find(query, 1, true) then
            table.insert(matchingPlayers, targetPlayer)
        end
    end

    local totalCount = #matchingPlayers

    -- For search, we use limited pagination info since we're working with in-memory data
    local paginationInfo = {
        totalCount = totalCount,
        hasNextPage = (offset + pageSize) < totalCount,
        currentOffset = offset,
        pageSize = pageSize,
        isEmpty = totalCount == 0
    }

    -- If no matching players, send empty response
    if paginationInfo.isEmpty then
        AIO.Handle(player, "GameMasterSystem", "receivePlayerData",
            {}, offset, pageSize, false,
            paginationInfo.totalCount, paginationInfo.totalPages, paginationInfo.currentPage)
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

    -- Apply pagination to get the players we actually need to process
    local startIdx = offset + 1
    local endIdx = math.min(offset + pageSize, #matchingPlayers)
    local playersToProcess = {}

    -- Collect players for batch processing
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
            local playerData = {}

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

                table.insert(playerData, finalPlayerInfo)
            end

            -- Send results to client
            AIO.Handle(player, "GameMasterSystem", "receivePlayerData",
                playerData, offset, pageSize, paginationInfo.hasNextPage,
                paginationInfo.totalCount, paginationInfo.totalPages, paginationInfo.currentPage)
        end)
    end)
end

-- Refresh player data (forces a fresh fetch)
function PlayerSearchHandlers.refreshPlayerData(player)
    -- Force a complete refresh by clearing cached data first
    if QueryUtils then
        QueryUtils.clearBanCache()        -- Clear ban status cache for fresh checks
        QueryUtils.clearPlayerDataCache() -- Clear player data cache
        -- Note: Zone cache is kept as zones rarely change

        if Config and Config.debug then
            print("[PlayerSearchHandlers] Cleared ban and player data caches for refresh")
        end
    end

    -- Simply call getPlayerData with default parameters
    if PlayerDataQueryHandlers then
        PlayerDataQueryHandlers.getPlayerData(player, 0, Config.defaultPageSize, "ASC")
    else
        print("[PlayerSearchHandlers] Warning: PlayerDataQueryHandlers not set, cannot refresh player data")
    end
end

return PlayerSearchHandlers