--[[
    GameMasterUI Database Helper Module
    
    Provides safe database query functions with:
    - Table existence checking
    - Database prefix support
    - Error handling
    - Query result caching
]]--

local DatabaseHelper = {}

-- Cache for table existence checks
local tableExistsCache = {}
local CACHE_MAX_SIZE = 100  -- Prevent unlimited cache growth

-- Reference to config (will be loaded)
local Config

-- Log level constants (will be loaded from config)
local LOG_LEVEL

-- =====================================================
-- Logging Functions
-- =====================================================

local function log(level, message, ...)
    if not Config then return end
    
    local currentLevel = Config.debug and LOG_LEVEL.DEBUG or LOG_LEVEL.INFO
    if level > currentLevel then return end
    
    local prefix = "[GameMasterUI]"
    local levelStr = ""
    
    if level == LOG_LEVEL.ERROR then
        levelStr = "[ERROR]"
    elseif level == LOG_LEVEL.WARN then
        levelStr = "[WARN]"
    elseif level == LOG_LEVEL.DEBUG then
        levelStr = "[DEBUG]"
    end
    
    print(string.format("%s %s %s", prefix, levelStr, string.format(message, ...)))
end

-- =====================================================
-- Database Query Router
-- =====================================================

local function executeDatabaseFunction(databaseType, queryFunc, executeFunc, query)
    local dbFunc
    
    if databaseType == "world" then
        dbFunc = queryFunc and WorldDBQuery or WorldDBExecute
    elseif databaseType == "char" then
        dbFunc = queryFunc and CharDBQuery or CharDBExecute
    elseif databaseType == "auth" then
        dbFunc = queryFunc and AuthDBQuery or AuthDBExecute
    else
        return nil, string.format("Invalid database type: %s", tostring(databaseType))
    end
    
    return dbFunc(query), nil
end

-- =====================================================
-- Initialization
-- =====================================================

-- Initialize the module with config
function DatabaseHelper.Initialize(config)
    Config = config
    tableExistsCache = {}
    
    -- Load constants from config
    LOG_LEVEL = Config.LOG_LEVEL
    
    if Config.database.checkTablesOnStartup then
        DatabaseHelper.CheckRequiredTables()
    end
end

-- =====================================================
-- Utility Functions
-- =====================================================

-- Validate database type
local function isValidDatabaseType(databaseType)
    return databaseType == "world" or databaseType == "char" or databaseType == "auth"
end

-- Manage cache size
local function manageCacheSize()
    local cacheCount = 0
    for _ in pairs(tableExistsCache) do
        cacheCount = cacheCount + 1
    end
    
    if cacheCount > CACHE_MAX_SIZE then
        -- Clear oldest entries (simple approach: clear all)
        log(LOG_LEVEL.DEBUG, "Cache size exceeded %d, clearing cache", CACHE_MAX_SIZE)
        tableExistsCache = {}
    end
end

-- =====================================================
-- Core Functions
-- =====================================================

-- Build a qualified table name with database prefix
function DatabaseHelper.GetQualifiedTableName(tableName, databaseType)
    databaseType = databaseType or "world"
    
    -- Validate inputs
    if not tableName or type(tableName) ~= "string" or tableName == "" then
        log(LOG_LEVEL.ERROR, "Invalid table name provided: %s", tostring(tableName))
        return tableName
    end
    
    if not isValidDatabaseType(databaseType) then
        log(LOG_LEVEL.WARN, "Invalid database type: %s, defaulting to world", tostring(databaseType))
        databaseType = "world"
    end
    
    -- Get prefix from unified config structure
    local prefix = Config.database.prefixes[databaseType] or ""
    
    if prefix and prefix ~= "" then
        return prefix .. tableName
    end
    return tableName
end

-- Check if a table exists in the database
function DatabaseHelper.TableExists(tableName, databaseType)
    databaseType = databaseType or "world"
    
    -- Validate inputs
    if not tableName or type(tableName) ~= "string" or tableName == "" then
        log(LOG_LEVEL.ERROR, "Invalid table name for existence check: %s", tostring(tableName))
        return false
    end
    
    if not isValidDatabaseType(databaseType) then
        log(LOG_LEVEL.WARN, "Invalid database type for table check: %s", tostring(databaseType))
        return false
    end
    
    -- Check cache first
    local cacheKey = databaseType .. "." .. tableName
    if Config.database.cacheTableChecks and tableExistsCache[cacheKey] ~= nil then
        return tableExistsCache[cacheKey]
    end
    
    -- Query to check table existence
    local checkQuery = string.format("SHOW TABLES LIKE '%s'", tableName)
    
    local success, result = pcall(function()
        return executeDatabaseFunction(databaseType, true, false, checkQuery)
    end)
    
    local exists = success and result ~= nil
    
    -- Cache the result
    if Config.database.cacheTableChecks then
        manageCacheSize()
        tableExistsCache[cacheKey] = exists
    end
    
    return exists
end

-- Execute a safe query with error handling
function DatabaseHelper.SafeQuery(query, databaseType)
    databaseType = databaseType or "world"
    
    -- Validate inputs
    if not query or type(query) ~= "string" or query == "" then
        local err = "Invalid query provided"
        log(LOG_LEVEL.ERROR, err)
        return nil, err
    end
    
    if not isValidDatabaseType(databaseType) then
        local err = string.format("Invalid database type: %s", tostring(databaseType))
        log(LOG_LEVEL.ERROR, err)
        return nil, err
    end
    
    local success, result = pcall(function()
        return executeDatabaseFunction(databaseType, true, false, query)
    end)
    
    if not success then
        log(LOG_LEVEL.ERROR, "Database query failed: %s", tostring(result))
        log(LOG_LEVEL.DEBUG, "Failed query: %s", query)
        return nil, tostring(result)
    end
    
    return result, nil
end

-- Execute a safe database update/insert/delete
function DatabaseHelper.SafeExecute(query, databaseType)
    databaseType = databaseType or "world"
    
    -- Validate inputs
    if not query or type(query) ~= "string" or query == "" then
        local err = "Invalid query provided for execute"
        log(LOG_LEVEL.ERROR, err)
        return false, err
    end
    
    if not isValidDatabaseType(databaseType) then
        local err = string.format("Invalid database type: %s", tostring(databaseType))
        log(LOG_LEVEL.ERROR, err)
        return false, err
    end
    
    local success, result = pcall(function()
        return executeDatabaseFunction(databaseType, false, true, query)
    end)
    
    if not success then
        log(LOG_LEVEL.ERROR, "Database execute failed: %s", tostring(result))
        log(LOG_LEVEL.DEBUG, "Failed query: %s", query)
        return false, tostring(result)
    end
    
    return true, nil
end

-- Optimized table name replacement with caching
local tableReplacementCache = {}
local REPLACEMENT_CACHE_MAX = 50

local function replaceTableNames(query, tableName, qualifiedName)
    -- Cache key includes both names to handle different prefixes
    local cacheKey = query .. "|" .. tableName .. "|" .. qualifiedName
    
    -- Check cache
    if tableReplacementCache[cacheKey] then
        return tableReplacementCache[cacheKey]
    end
    
    -- Escape special pattern characters in table name
    local escapedTableName = tableName:gsub("([%(%)%.%%%+%-%*%?%[%]%^%$])", "%%%1")
    
    -- More efficient replacement patterns
    local patterns = {
        -- Table name at start of query or after whitespace
        { "^" .. escapedTableName .. "([^%w])", qualifiedName .. "%1" },
        { "([%s%(])" .. escapedTableName .. "([^%w])", "%1" .. qualifiedName .. "%2" },
        -- Table name at end of query
        { "([^%w])" .. escapedTableName .. "$", "%1" .. qualifiedName },
        -- Table name followed by whitespace or punctuation
        { "([^%w])" .. escapedTableName .. "([%s%p])", "%1" .. qualifiedName .. "%2" }
    }
    
    local modifiedQuery = query
    for _, pattern in ipairs(patterns) do
        modifiedQuery = modifiedQuery:gsub(pattern[1], pattern[2])
    end
    
    -- Manage cache size
    local cacheCount = 0
    for _ in pairs(tableReplacementCache) do
        cacheCount = cacheCount + 1
    end
    if cacheCount > REPLACEMENT_CACHE_MAX then
        tableReplacementCache = {}
    end
    
    -- Cache result
    tableReplacementCache[cacheKey] = modifiedQuery
    
    return modifiedQuery
end

-- Build a safe query that checks for table existence first
function DatabaseHelper.BuildSafeQuery(query, requiredTables, databaseType)
    databaseType = databaseType or "world"
    
    -- Validate inputs
    if not query or type(query) ~= "string" then
        local err = "Invalid query provided to BuildSafeQuery"
        log(LOG_LEVEL.ERROR, err)
        return nil, err
    end
    
    if not requiredTables or type(requiredTables) ~= "table" then
        local err = "Invalid required tables list"
        log(LOG_LEVEL.ERROR, err)
        return nil, err
    end
    
    if not isValidDatabaseType(databaseType) then
        local err = string.format("Invalid database type: %s", tostring(databaseType))
        log(LOG_LEVEL.ERROR, err)
        return nil, err
    end
    
    -- Check if all required tables exist
    for _, tableName in ipairs(requiredTables) do
        if not DatabaseHelper.TableExists(tableName, databaseType) then
            log(LOG_LEVEL.WARN, "Table '%s' does not exist in %s database", tableName, databaseType)
            return nil, string.format("Table '%s' not found", tableName)
        end
    end
    
    -- Replace table names with qualified names
    local modifiedQuery = query
    for _, tableName in ipairs(requiredTables) do
        local qualifiedName = DatabaseHelper.GetQualifiedTableName(tableName, databaseType)
        -- Only replace if we have a prefix
        if qualifiedName ~= tableName then
            modifiedQuery = replaceTableNames(modifiedQuery, tableName, qualifiedName)
        end
    end
    
    return modifiedQuery, nil
end

-- =====================================================
-- Database Maintenance Functions
-- =====================================================

-- Check for required tables on startup
function DatabaseHelper.CheckRequiredTables()
    log(LOG_LEVEL.INFO, "Checking database tables...")
    
    -- Report database prefix configuration
    local hasPrefix = false
    for dbType, prefix in pairs(Config.database.prefixes) do
        if prefix ~= "" then
            log(LOG_LEVEL.INFO, "Using %s database prefix: %s", dbType, prefix)
            hasPrefix = true
        end
    end
    
    if not hasPrefix then
        log(LOG_LEVEL.INFO, "Using default database names (no prefixes configured)")
        log(LOG_LEVEL.INFO, "To use custom database names, edit GameMasterUI_Config.lua")
    end
    
    local missingRequired = {}
    local missingOptional = {}
    
    -- Check required tables
    for _, tableName in ipairs(Config.database.requiredTables) do
        if not DatabaseHelper.TableExists(tableName, "world") then
            table.insert(missingRequired, tableName)
        end
    end
    
    -- Check optional tables
    for _, tableName in ipairs(Config.database.optionalTables) do
        if not DatabaseHelper.TableExists(tableName, "world") then
            table.insert(missingOptional, tableName)
        end
    end
    
    -- Report missing tables
    if #missingRequired > 0 then
        log(LOG_LEVEL.WARN, "Missing required tables: %s", table.concat(missingRequired, ", "))
        log(LOG_LEVEL.WARN, "Some features may not work correctly!")
    end
    
    if #missingOptional > 0 then
        log(LOG_LEVEL.DEBUG, "Missing optional tables: %s", table.concat(missingOptional, ", "))
        log(LOG_LEVEL.DEBUG, "Some features will work with reduced functionality.")
    end
    
    if #missingRequired == 0 and #missingOptional == 0 then
        log(LOG_LEVEL.INFO, "All database tables found!")
    end
end

-- Clear the table existence cache
function DatabaseHelper.ClearCache()
    tableExistsCache = {}
    tableReplacementCache = {}
    log(LOG_LEVEL.DEBUG, "Database helper caches cleared")
end

-- Check if an optional table is available
function DatabaseHelper.IsOptionalTableAvailable(tableName, databaseType)
    databaseType = databaseType or "world"
    
    -- Validate inputs
    if not tableName or type(tableName) ~= "string" then
        log(LOG_LEVEL.WARN, "Invalid table name for optional check: %s", tostring(tableName))
        return false
    end
    
    -- Check if it's in the optional tables list
    local isOptional = false
    for _, optTable in ipairs(Config.database.optionalTables) do
        if optTable == tableName then
            isOptional = true
            break
        end
    end
    
    -- If it's optional and fallback is enabled, check existence
    if isOptional and Config.database.fallbackOnMissingTable then
        return DatabaseHelper.TableExists(tableName, databaseType)
    end
    
    -- If not optional, assume it exists (will error if it doesn't)
    return true
end

-- =====================================================
-- Module Export
-- =====================================================

return DatabaseHelper