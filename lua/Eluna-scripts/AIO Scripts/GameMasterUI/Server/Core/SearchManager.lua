--[[
    GameMasterUI Unified Search Manager - Server Core

    Provides centralized search orchestration for all search types:
    - Spell search
    - Item search
    - Player search
    - Extensible for new types

    Features:
    - Config-based registration
    - Built-in caching
    - Validation pipeline
    - Pagination support
    - Permission checking

    Architecture:
    - Strategy Pattern: Each search type implements SearchConfig
    - Pipeline Pattern: Validation -> Cache -> Query -> Transform -> Send
    - Registry Pattern: Dynamic handler registration
]]--

local SearchManager = {}

-- Module dependencies (injected)
local GameMasterSystem, Config, Utils, DatabaseHelper
local QueryCache, QueryUtils

-- Search configuration registry
local searchRegistry = {}

-- Statistics tracking
local searchStats = {}

-- Status tracking
local isInitialized = false
local initializationTime = 0
local registeredTypes = {}

-- =====================================================
-- Module Initialization
-- =====================================================

function SearchManager.Initialize(gms, config, utils, dbHelper)
    GameMasterSystem = gms
    Config = config
    Utils = utils
    DatabaseHelper = dbHelper

    -- Load optimization modules
    QueryCache = require("GameMasterUI.Server.Utils.QueryCache")
    QueryUtils = require("GameMasterUI.Server.Utils.QueryUtils")

    -- Mark as initialized
    isInitialized = true
    initializationTime = os.time()

    -- Simplified initialization message
    print("[SearchManager] Unified Search Manager initialized")
end

-- =====================================================
-- Search Type Registration
-- =====================================================

--[[
    Register a new search type with configuration

    @param searchConfig table Configuration object with:
        - searchType: string (unique identifier)
        - requiredGMRank: number (minimum GM rank)
        - cache: table {enabled, ttl, keyGenerator}
        - pagination: table {defaultPageSize, minPageSize, maxPageSize}
        - buildQuery: function(params) -> string
        - buildCountQuery: function(params) -> string (optional)
        - transformResult: function(dbRow) -> table
        - validateParams: function(params) -> boolean, error (optional)
        - filters: table (optional filter definitions)
        - sorting: table (optional sort configuration)
]]--
function SearchManager.RegisterSearchType(searchConfig)
    local searchType = searchConfig.searchType

    if not searchType then
        error("[SearchManager] Cannot register search type without searchType field")
        return
    end

    if searchRegistry[searchType] then
        if Config.debug then
            print(string.format("[SearchManager] Warning: Overwriting existing search type '%s'", searchType))
        end
    end

    -- Validate required fields
    -- Either customExecutor OR (buildQuery + transformResult) must be provided
    if not searchConfig.customExecutor then
        if not searchConfig.buildQuery then
            error(string.format("[SearchManager] Search type '%s' missing required field: buildQuery (or customExecutor)", searchType))
            return
        end

        if not searchConfig.transformResult then
            error(string.format("[SearchManager] Search type '%s' missing required field: transformResult (or customExecutor)", searchType))
            return
        end
    end

    -- Set defaults
    searchConfig.requiredGMRank = searchConfig.requiredGMRank or 2
    searchConfig.cache = searchConfig.cache or { enabled = false }
    searchConfig.pagination = searchConfig.pagination or {
        defaultPageSize = 50,
        minPageSize = 10,
        maxPageSize = 500
    }

    -- Register in registry
    searchRegistry[searchType] = searchConfig

    -- Track registered type
    table.insert(registeredTypes, searchType)

    -- Initialize stats
    searchStats[searchType] = {
        searches = 0,
        cacheHits = 0,
        cacheMisses = 0,
        errors = 0,
        registeredAt = os.time()
    }

    -- Auto-register AIO handler on both namespaces for compatibility
    local handlerName = "search_" .. searchType

    -- Register on GameMasterSystem (legacy)
    GameMasterSystem[handlerName] = function(player, params)
        SearchManager.ExecuteSearch(player, searchType, params)
    end

    -- Also track for SearchManager namespace (will be registered below)
    if not SearchManager._pendingHandlers then
        SearchManager._pendingHandlers = {}
    end
    SearchManager._pendingHandlers[handlerName] = searchType

    -- Debug only: detailed registration info
    if Config and Config.debug then
        print(string.format("[SearchManager] Registered '%s' (cache: %s, TTL: %ds)",
            searchType,
            searchConfig.cache.enabled and "ON" or "OFF",
            searchConfig.cache.ttl or 0))
    end
end

-- =====================================================
-- Search Execution Pipeline
-- =====================================================

--[[
    Execute search with full validation and optimization pipeline

    Pipeline stages:
    1. Validate permissions
    2. Validate and normalize parameters
    3. Check cache
    4. Build and execute query
    5. Transform results
    6. Cache results
    7. Send to client
]]--
function SearchManager.ExecuteSearch(player, searchType, params)
    local searchConfig = searchRegistry[searchType]

    if not searchConfig then
        Utils.sendMessage(player, "error", "Unknown search type: " .. searchType)
        return
    end

    -- Track search
    searchStats[searchType].searches = searchStats[searchType].searches + 1

    -- [STAGE 1] Validate Permissions
    if not SearchManager.ValidatePermissions(player, searchConfig) then
        return
    end

    -- [STAGE 2] Validate and Normalize Parameters
    local validParams, error = SearchManager.ValidateParams(params, searchConfig)
    if not validParams then
        Utils.sendMessage(player, "error", "Invalid search parameters: " .. (error or "unknown"))
        searchStats[searchType].errors = searchStats[searchType].errors + 1
        return
    end

    -- [STAGE 3] Check Cache
    if searchConfig.cache.enabled then
        local cacheKey = SearchManager.GenerateCacheKey(searchConfig, validParams)
        local cachedResult = QueryCache.get(searchType, cacheKey)

        if cachedResult then
            searchStats[searchType].cacheHits = searchStats[searchType].cacheHits + 1
            SearchManager.SendResults(player, searchType, cachedResult, validParams)
            return
        end

        searchStats[searchType].cacheMisses = searchStats[searchType].cacheMisses + 1
    end

    -- [STAGE 4] Execute Search
    -- Check if custom executor is provided (for non-database searches like player search)
    if searchConfig.customExecutor then
        -- Custom executor for special search types
        local sendResultsWrapper = function(responseData)
            -- Cache results if enabled
            if searchConfig.cache.enabled then
                local cacheKey = SearchManager.GenerateCacheKey(searchConfig, validParams)
                QueryCache.set(searchType, cacheKey, responseData, searchConfig.cache.ttl)
            end

            -- Send to client
            SearchManager.SendResults(player, searchType, responseData, validParams)
        end

        searchConfig.customExecutor(player, validParams, sendResultsWrapper)
    else
        -- Standard database query execution
        SearchManager.ExecuteQuery(player, searchType, searchConfig, validParams)
    end
end

-- =====================================================
-- Validation Functions
-- =====================================================

function SearchManager.ValidatePermissions(player, searchConfig)
    if player:GetGMRank() < searchConfig.requiredGMRank then
        Utils.sendMessage(player, "error", "You do not have permission to use this search.")
        return false
    end
    return true
end

function SearchManager.ValidateParams(params, searchConfig)
    params = params or {}

    -- Flatten filters into params if they exist (from ClientSearchManager)
    if params.filters and type(params.filters) == "table" then
        for key, value in pairs(params.filters) do
            if params[key] == nil then
                params[key] = value
            end
        end
    end

    -- Normalize pagination
    params.offset = tonumber(params.offset) or 0
    params.pageSize = tonumber(params.pageSize) or searchConfig.pagination.defaultPageSize

    -- Validate page size bounds
    if params.pageSize < searchConfig.pagination.minPageSize then
        params.pageSize = searchConfig.pagination.minPageSize
    elseif params.pageSize > searchConfig.pagination.maxPageSize then
        params.pageSize = searchConfig.pagination.maxPageSize
    end

    -- Sanitize search text if present
    if params.query then
        params.query = Utils.escapeString(params.query)
    end

    -- Custom validation if provided
    if searchConfig.validateParams then
        local isValid, error = searchConfig.validateParams(params)
        if not isValid then
            return nil, error
        end
    end

    return params, nil
end

-- =====================================================
-- Cache Management
-- =====================================================

function SearchManager.GenerateCacheKey(searchConfig, params)
    if searchConfig.cache.keyGenerator then
        return searchConfig.cache.keyGenerator(params)
    end

    -- Default key generator
    local keyParts = {
        params.query or "",
        params.offset or 0,
        params.pageSize or 50
    }

    -- Include filters if present
    if params.filters then
        for k, v in pairs(params.filters) do
            table.insert(keyParts, k .. "=" .. tostring(v))
        end
    end

    return table.concat(keyParts, ":")
end

-- =====================================================
-- Query Execution
-- =====================================================

function SearchManager.ExecuteQuery(player, searchType, searchConfig, params)
    -- Build main query
    local query = searchConfig.buildQuery(params)

    -- Build count query if provided (for accurate pagination)
    local countQuery = nil
    if searchConfig.buildCountQuery then
        countQuery = searchConfig.buildCountQuery(params)
    end

    -- Execute count query first if available
    if countQuery then
        DatabaseHelper.SafeQueryAsync(countQuery, function(countResult, countError)
            if countError or not countResult then
                -- Fallback to query without count
                SearchManager.ExecuteMainQuery(player, searchType, searchConfig, params, query, nil)
                return
            end

            local totalCount = countResult:GetUInt32(0)
            SearchManager.ExecuteMainQuery(player, searchType, searchConfig, params, query, totalCount)
        end, "world")
    else
        -- No count query, execute main query directly
        SearchManager.ExecuteMainQuery(player, searchType, searchConfig, params, query, nil)
    end
end

function SearchManager.ExecuteMainQuery(player, searchType, searchConfig, params, query, totalCount)
    DatabaseHelper.SafeQueryAsync(query, function(result, error)
        if error then
            Utils.sendMessage(player, "error", "Search failed: " .. error)
            searchStats[searchType].errors = searchStats[searchType].errors + 1
            return
        end

        -- [STAGE 5] Transform Results
        local results = SearchManager.TransformResults(result, searchConfig, params)

        -- Calculate pagination info
        local paginationInfo = SearchManager.CalculatePagination(
            totalCount or #results,
            params.offset,
            params.pageSize,
            #results
        )

        local responseData = {
            results = results,
            pagination = paginationInfo
        }

        -- [STAGE 5.5] Post-Processing (e.g., fuzzy suggestions)
        if searchConfig.postProcess then
            local processedResults, metadata = searchConfig.postProcess(responseData.results, params)
            responseData.results = processedResults or responseData.results
            if metadata then
                responseData.metadata = metadata
            end
        end

        -- [STAGE 6] Cache Results
        if searchConfig.cache.enabled then
            local cacheKey = SearchManager.GenerateCacheKey(searchConfig, params)
            QueryCache.set(searchType, cacheKey, responseData, searchConfig.cache.ttl)
        end

        -- [STAGE 7] Send to Client
        SearchManager.SendResults(player, searchType, responseData, params)

    end, "world")
end

-- =====================================================
-- Result Transformation
-- =====================================================

function SearchManager.TransformResults(dbResult, searchConfig, params)
    local results = {}

    if not dbResult then
        return results
    end

    repeat
        local transformedRow = searchConfig.transformResult(dbResult, params)
        if transformedRow then
            table.insert(results, transformedRow)
        end
    until not dbResult:NextRow()

    return results
end

-- =====================================================
-- Pagination
-- =====================================================

function SearchManager.CalculatePagination(totalCount, offset, pageSize, resultCount)
    local hasNextPage = false

    if totalCount then
        -- Accurate calculation with total count
        hasNextPage = (offset + pageSize) < totalCount
    else
        -- Estimate based on result count
        hasNextPage = (resultCount == pageSize)
        totalCount = -1  -- Unknown
    end

    local currentPage = math.floor(offset / pageSize) + 1
    local totalPages = totalCount > 0 and math.ceil(totalCount / pageSize) or -1

    return {
        currentOffset = offset,
        pageSize = pageSize,
        totalCount = totalCount,
        resultCount = resultCount,
        hasNextPage = hasNextPage,
        hasPrevPage = offset > 0,
        currentPage = currentPage,
        totalPages = totalPages
    }
end

-- =====================================================
-- Response Sending
-- =====================================================

function SearchManager.SendResults(player, searchType, responseData, params)
    local data = {
        searchType = searchType,
        results = responseData.results,
        pagination = responseData.pagination,
        timestamp = os.time()
    }

    -- Include metadata if present (e.g., fuzzy suggestions)
    if responseData.metadata then
        data.metadata = responseData.metadata
    end

    AIO.Handle(player, "SearchManager", "receiveResults", data)
end

-- =====================================================
-- Statistics and Debugging
-- =====================================================

function SearchManager.GetStats(searchType)
    if searchType then
        return searchStats[searchType]
    end
    return searchStats
end

function SearchManager.ResetStats(searchType)
    if searchType then
        searchStats[searchType] = {
            searches = 0,
            cacheHits = 0,
            cacheMisses = 0,
            errors = 0
        }
    else
        for type, _ in pairs(searchStats) do
            SearchManager.ResetStats(type)
        end
    end
end

function SearchManager.PrintStats()
    print("=== SearchManager Statistics ===")
    for searchType, stats in pairs(searchStats) do
        local hitRate = stats.searches > 0 and
            (stats.cacheHits / stats.searches * 100) or 0

        print(string.format("  %s:", searchType))
        print(string.format("    Searches: %d", stats.searches))
        print(string.format("    Cache Hits: %d (%.1f%%)", stats.cacheHits, hitRate))
        print(string.format("    Cache Misses: %d", stats.cacheMisses))
        print(string.format("    Errors: %d", stats.errors))
    end
    print("================================")
end

-- =====================================================
-- Status and Verification
-- =====================================================

function SearchManager.IsActive()
    return isInitialized
end

function SearchManager.GetStatus()
    local uptime = os.time() - initializationTime
    local totalSearches = 0
    local totalCacheHits = 0

    for _, stats in pairs(searchStats) do
        totalSearches = totalSearches + stats.searches
        totalCacheHits = totalCacheHits + stats.cacheHits
    end

    local overallHitRate = totalSearches > 0 and (totalCacheHits / totalSearches * 100) or 0

    return {
        active = isInitialized,
        initTime = initializationTime,
        uptime = uptime,
        registeredTypes = registeredTypes,
        typeCount = #registeredTypes,
        totalSearches = totalSearches,
        totalCacheHits = totalCacheHits,
        overallHitRate = overallHitRate
    }
end

function SearchManager.PrintStatus()
    local status = SearchManager.GetStatus()

    print("========================================")
    print("    UNIFIED SEARCH MANAGER STATUS")
    print("========================================")
    print(string.format("Status:           %s", status.active and "✓ ACTIVE" or "✗ INACTIVE"))
    print(string.format("Uptime:           %d seconds (%.1f minutes)",
        status.uptime, status.uptime / 60))
    print(string.format("Registered Types: %d", status.typeCount))

    for i, searchType in ipairs(status.registeredTypes) do
        print(string.format("  [%d] %s", i, searchType))
    end

    print(string.format("\nTotal Searches:   %d", status.totalSearches))
    print(string.format("Total Cache Hits: %d (%.1f%%)",
        status.totalCacheHits, status.overallHitRate))
    print("========================================")
end

function SearchManager.IsTypeRegistered(searchType)
    return searchRegistry[searchType] ~= nil
end

-- =====================================================
-- AIO Handler Registration
-- =====================================================

-- Register SearchManager as an AIO handler namespace
-- This is called AFTER all search types are registered
function SearchManager.RegisterAIOHandlers()
    print("[SearchManager] Registering AIO handlers...")

    -- Create the SearchManager handler namespace
    local SearchManagerHandlers = AIO.AddHandlers("SearchManager", {})

    -- Register all pending search handlers
    if SearchManager._pendingHandlers then
        for handlerName, searchType in pairs(SearchManager._pendingHandlers) do
            SearchManagerHandlers[handlerName] = function(player, params)
                SearchManager.ExecuteSearch(player, searchType, params)
            end
        end
    end

    print("[SearchManager] AIO handlers registered")
end

return SearchManager
