--[[
    GameMasterUI Query Utilities Module

    Centralized, optimized query functions to eliminate code duplication:
    - Cached zone name lookups
    - Batched ban status checking
    - Optimized player data queries
    - Async-first with sync fallbacks

    Replaces duplicated functions in:
    - PlayerSearchHandlers.lua
    - PlayerDataQueryHandlers.lua
    - Other handler files

    Performance Improvements:
    - Reduces N+1 queries to batched operations
    - Implements caching to eliminate repeated database calls
    - Provides async patterns for non-blocking operations
]]--

local QueryUtils = {}

-- Module dependencies (will be injected)
local DatabaseHelper, Config, QueryCache

-- =====================================================
-- Module Initialization
-- =====================================================

function QueryUtils.Initialize(databaseHelper, config, queryCache)
    DatabaseHelper = databaseHelper
    Config = config
    QueryCache = queryCache

    if Config and Config.debug then
        print("[QueryUtils] Initialized with caching and batching support")
    end
end

-- =====================================================
-- Zone Name Utilities (Cached)
-- =====================================================

-- Get zone name with caching (async version) - TrinityCore 3.3.5 Compatible
function QueryUtils.getZoneNameAsync(areaId, callback)
    if not areaId or areaId <= 0 then
        if callback then callback("Unknown") end
        return
    end

    -- Check cache first
    local cachedZone = QueryCache.getZoneName(areaId)
    if cachedZone then
        if callback then callback(cachedZone) end
        return
    end

    -- Use GetAreaName API (the proper way in TrinityCore 3.3.5)
    local success, areaName = pcall(function()
        return GetAreaName(areaId)
    end)

    local zoneName = "Unknown"
    if success and areaName and areaName ~= "" then
        zoneName = areaName
    elseif Config and Config.debug then
        print(string.format("[QueryUtils] GetAreaName failed for area %d, using 'Unknown'", areaId))
    end

    -- Cache the result (even if "Unknown" to avoid repeated API calls)
    QueryCache.setZoneName(areaId, zoneName)

    if callback then callback(zoneName) end
end

-- Synchronous version with caching (for backward compatibility) - TrinityCore 3.3.5 Compatible
function QueryUtils.getZoneName(areaId)
    if not areaId or areaId <= 0 then
        return "Unknown"
    end

    -- Check cache first
    local cachedZone = QueryCache.getZoneName(areaId)
    if cachedZone then
        return cachedZone
    end

    -- Use GetAreaName API (the proper way in TrinityCore 3.3.5)
    local success, areaName = pcall(function()
        return GetAreaName(areaId)
    end)

    local zoneName = "Unknown"
    if success and areaName and areaName ~= "" then
        zoneName = areaName
    elseif Config and Config.debug then
        print(string.format("[QueryUtils] GetAreaName failed for area %d, using 'Unknown'", areaId))
    end

    -- Cache the result
    QueryCache.setZoneName(areaId, zoneName)
    return zoneName
end

-- Batch zone name lookup (async) - TrinityCore 3.3.5 Compatible
function QueryUtils.getZoneNamesBatch(areaIds, callback)
    local results = {}
    local missing = {}

    -- Check cache for all requested zones
    for _, areaId in ipairs(areaIds) do
        local cachedZone = QueryCache.getZoneName(areaId)
        if cachedZone then
            results[areaId] = cachedZone
        else
            table.insert(missing, areaId)
        end
    end

    if #missing == 0 then
        -- All zones were cached
        if callback then callback(results) end
        return
    end

    -- Process missing zones using GetAreaName API
    for _, areaId in ipairs(missing) do
        local success, areaName = pcall(function()
            return GetAreaName(areaId)
        end)

        local zoneName = "Unknown"
        if success and areaName and areaName ~= "" then
            zoneName = areaName
        elseif Config and Config.debug then
            print(string.format("[QueryUtils] GetAreaName failed for area %d in batch lookup", areaId))
        end

        results[areaId] = zoneName
        QueryCache.setZoneName(areaId, zoneName)
    end

    if callback then callback(results) end
end

-- =====================================================
-- Ban Status Utilities (Cached & Batched)
-- =====================================================

-- Check ban status with caching (async version)
function QueryUtils.checkBanStatusAsync(accountId, charGuid, callback)
    if not accountId or not charGuid then
        if callback then callback(false, nil) end
        return
    end

    -- Check cache first
    local cachedBan = QueryCache.getBanStatus(accountId, charGuid)
    if cachedBan then
        if callback then callback(cachedBan.banned, cachedBan.type) end
        return
    end

    -- Query both account and character bans in parallel
    local banResults = { account = nil, character = nil }
    local queriesComplete = 0

    local function onQueryComplete()
        queriesComplete = queriesComplete + 1
        if queriesComplete >= 2 then
            -- Both queries complete, determine ban status
            local isBanned = false
            local banType = nil

            if banResults.account then
                isBanned = true
                banType = "Account"
            elseif banResults.character then
                isBanned = true
                banType = "Character"
            end

            -- Cache the result
            QueryCache.setBanStatus(accountId, charGuid, isBanned, banType)

            if callback then callback(isBanned, banType) end
        end
    end

    -- Query 1: Account ban
    local accountQuery = string.format(
        "SELECT 1 FROM account_banned WHERE id = %d AND (unbandate > UNIX_TIMESTAMP() OR unbandate = 0)",
        accountId
    )

    DatabaseHelper.SafeQueryAsync(accountQuery, function(result, error)
        banResults.account = result ~= nil
        onQueryComplete()
    end, "auth", true)  -- allowEmptyResults = true (no bans is valid)

    -- Query 2: Character ban (try both char and auth databases)
    local charQuery = string.format(
        "SELECT 1 FROM character_banned WHERE guid = %d AND (unbandate > UNIX_TIMESTAMP() OR unbandate = 0)",
        charGuid
    )

    DatabaseHelper.SafeQueryAsync(charQuery, function(result, error)
        if result then
            banResults.character = true
            onQueryComplete()
        else
            -- Try auth database as fallback
            DatabaseHelper.SafeQueryAsync(charQuery, function(authResult, authError)
                banResults.character = authResult ~= nil
                onQueryComplete()
            end, "auth", true)  -- allowEmptyResults = true (no char bans is valid)
        end
    end, "char", true)  -- allowEmptyResults = true (no char bans is valid)
end

-- Synchronous version with caching (for backward compatibility)
function QueryUtils.checkBanStatus(accountId, charGuid)
    if not accountId or not charGuid then
        return false, nil
    end

    -- Check cache first
    local cachedBan = QueryCache.getBanStatus(accountId, charGuid)
    if cachedBan then
        return cachedBan.banned, cachedBan.type
    end

    local isBanned = false
    local banType = nil

    -- Check account ban
    local accountQuery = string.format(
        "SELECT 1 FROM account_banned WHERE id = %d AND (unbandate > UNIX_TIMESTAMP() OR unbandate = 0)",
        accountId
    )

    local accountResult, accountError = DatabaseHelper.SafeQuery(accountQuery, "auth")
    if accountResult then
        isBanned = true
        banType = "Account"
    else
        -- Check character ban
        local charQuery = string.format(
            "SELECT 1 FROM character_banned WHERE guid = %d AND (unbandate > UNIX_TIMESTAMP() OR unbandate = 0)",
            charGuid
        )

        local charResult, charError = DatabaseHelper.SafeQuery(charQuery, "char")
        if not charResult then
            -- Try auth database as fallback
            charResult, charError = DatabaseHelper.SafeQuery(charQuery, "auth")
        end

        if charResult then
            isBanned = true
            banType = "Character"
        end
    end

    -- Cache the result
    QueryCache.setBanStatus(accountId, charGuid, isBanned, banType)

    return isBanned, banType
end

-- Batch ban status checking (MAJOR OPTIMIZATION)
function QueryUtils.checkBanStatusBatch(playerList, callback)
    if not playerList or #playerList == 0 then
        if callback then callback({}) end
        return
    end

    -- Check cache for all players
    local results = {}
    local missingPlayers = {}

    for _, player in ipairs(playerList) do
        local cachedBan = QueryCache.getBanStatus(player.accountId, player.charGuid)
        if cachedBan then
            results[player.charGuid] = { banned = cachedBan.banned, type = cachedBan.type }
        else
            table.insert(missingPlayers, player)
        end
    end

    if #missingPlayers == 0 then
        -- All ban status were cached
        if callback then callback(results) end
        return
    end

    -- Build batch queries for missing players
    local accountIds = {}
    local charGuids = {}

    for _, player in ipairs(missingPlayers) do
        table.insert(accountIds, tostring(player.accountId))
        table.insert(charGuids, tostring(player.charGuid))
    end

    local queriesComplete = 0
    local bannedAccounts = {}
    local bannedCharacters = {}

    local function onBatchQueryComplete()
        queriesComplete = queriesComplete + 1
        if queriesComplete >= 2 then
            -- Process results for all missing players
            for _, player in ipairs(missingPlayers) do
                local isBanned = false
                local banType = nil

                if bannedAccounts[player.accountId] then
                    isBanned = true
                    banType = "Account"
                elseif bannedCharacters[player.charGuid] then
                    isBanned = true
                    banType = "Character"
                end

                results[player.charGuid] = { banned = isBanned, type = banType }
                QueryCache.setBanStatus(player.accountId, player.charGuid, isBanned, banType)
            end

            if callback then callback(results) end
        end
    end

    -- Batch query 1: All account bans
    local accountQuery = string.format(
        "SELECT id FROM account_banned WHERE id IN (%s) AND (unbandate > UNIX_TIMESTAMP() OR unbandate = 0)",
        table.concat(accountIds, ",")
    )

    DatabaseHelper.SafeQueryAsync(accountQuery, function(result, error)
        if result then
            repeat
                local accountId = result:GetUInt32(0)
                bannedAccounts[accountId] = true
            until not result:NextRow()
        end
        onBatchQueryComplete()
    end, "auth", true)  -- allowEmptyResults = true (no bans is valid)

    -- Batch query 2: All character bans
    local charQuery = string.format(
        "SELECT guid FROM character_banned WHERE guid IN (%s) AND (unbandate > UNIX_TIMESTAMP() OR unbandate = 0)",
        table.concat(charGuids, ",")
    )

    DatabaseHelper.SafeQueryAsync(charQuery, function(result, error)
        if result then
            repeat
                local charGuid = result:GetUInt32(0)
                bannedCharacters[charGuid] = true
            until not result:NextRow()
        end

        -- Try auth database as fallback for any missing character bans
        DatabaseHelper.SafeQueryAsync(charQuery, function(authResult, authError)
            if authResult then
                repeat
                    local charGuid = authResult:GetUInt32(0)
                    bannedCharacters[charGuid] = true
                until not authResult:NextRow()
            end
            onBatchQueryComplete()
        end, "auth", true)  -- allowEmptyResults = true (no char bans is valid)
    end, "char", true)  -- allowEmptyResults = true (no char bans is valid)
end

-- =====================================================
-- Player Data Utilities (Cached)
-- =====================================================

-- Get cached player data or fetch if needed
function QueryUtils.getPlayerDataCached(playerGuid, fetchCallback)
    -- Check cache first
    local cachedData = QueryCache.getPlayerData(playerGuid)
    if cachedData then
        return cachedData
    end

    -- If not cached and callback provided, fetch asynchronously
    if fetchCallback then
        fetchCallback(playerGuid, function(playerData)
            if playerData then
                QueryCache.setPlayerData(playerGuid, playerData)
            end
        end)
    end

    return nil
end

-- Cache player data
function QueryUtils.cachePlayerData(playerGuid, playerData, customTTL)
    return QueryCache.setPlayerData(playerGuid, playerData, customTTL)
end

-- Clear player data cache (useful when player data changes)
function QueryUtils.invalidatePlayerData(playerGuid)
    QueryCache.set("playerData", tostring(playerGuid), nil, 0) -- Expire immediately
end

-- =====================================================
-- General Query Optimization Utilities
-- =====================================================

-- Execute query with result caching
function QueryUtils.executeCachedQuery(query, cacheKey, cacheTTL, callback, databaseType)
    databaseType = databaseType or "world"

    -- Check cache first
    local cachedResult = QueryCache.get("queryResults", cacheKey)
    if cachedResult then
        if callback then callback(cachedResult, nil) end
        return
    end

    -- Execute query and cache result
    DatabaseHelper.SafeQueryAsync(query, function(result, error)
        if result then
            -- Convert result to cacheable format
            local rows = {}
            repeat
                local row = {}
                -- Note: This is a simplified example - you'd need to know column count
                -- In practice, you'd pass column info or use a different caching strategy
                table.insert(rows, row)
            until not result:NextRow()

            QueryCache.set("queryResults", cacheKey, rows, cacheTTL)
            if callback then callback(rows, nil) end
        else
            if callback then callback(nil, error) end
        end
    end, databaseType)
end

-- =====================================================
-- Cache Management
-- =====================================================

-- Clear specific caches (useful when data changes)
function QueryUtils.clearZoneCache()
    QueryCache.clear("zones")
end

function QueryUtils.clearBanCache()
    QueryCache.clear("banStatus")
end

function QueryUtils.clearPlayerDataCache()
    QueryCache.clear("playerData")
end

-- Get cache statistics
function QueryUtils.getCacheStats()
    return QueryCache.getStats()
end

-- Periodic cleanup (call this from a timer or periodically)
function QueryUtils.performMaintenance()
    return QueryCache.periodicCleanup()
end

return QueryUtils