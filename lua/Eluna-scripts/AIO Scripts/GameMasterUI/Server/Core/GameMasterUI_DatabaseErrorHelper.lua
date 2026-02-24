--[[
    GameMasterUI Database Error Helper Module

    Provides enhanced database error handling with client-side notifications:
    - Wraps database queries with table existence checking
    - Sends structured error messages to client when tables/data are missing
    - Provides helpful suggestions for fixing missing database issues
]]--

local DatabaseErrorHelper = {}

-- Module dependencies (will be injected)
local Config, DatabaseHelper, Utils

-- =====================================================
-- Error Message Templates
-- =====================================================

-- Suggestions for missing tables
local tableSuggestions = {
    -- Core WoW tables
    creature_template = "Missing DBC import or world database. Import creature_template data from TrinityCore SQL files.",
    gameobject_template = "Missing DBC import or world database. Import gameobject_template data from TrinityCore SQL files.",
    item_template = "Missing DBC import or world database. Import item_template data from TrinityCore SQL files.",
    spell = "Missing spell DBC data. Import spell.dbc from WoW client using DBC extractors.",
    game_tele = "Missing teleport locations table. Import game_tele.sql from TrinityCore/world database.",

    -- Optional tables
    gameobjectdisplayinfo = "Optional DBC table. Extract from WoW client DBC files if needed for GameObject previews.",
    spellvisualeffectname = "Optional DBC table. Extract from WoW client DBC files if needed for spell visuals.",
    creature_template_model = "Optional table for creature model data. May be available in newer core versions.",
    creature_equip_template = "Optional table for creature equipment. Import from world database if needed.",

    -- Default suggestion
    default = "Check your database setup. This table may be missing or have a different name in your core version."
}

-- Get suggestion for a table
local function getTableSuggestion(tableName)
    return tableSuggestions[tableName] or tableSuggestions.default
end

-- =====================================================
-- Client Error Notification
-- =====================================================

-- Send structured database error to client
local function sendDatabaseErrorToClient(player, errorType, missingTables, contextMessage)
    if not player then return end

    -- Build error data structure
    local errorData = {
        errorType = errorType or "missing_table",
        context = contextMessage or "Database query failed",
        missingTables = {},
        timestamp = os.date("%Y-%m-%d %H:%M:%S")
    }

    -- Add missing table information
    if type(missingTables) == "table" then
        for _, tableName in ipairs(missingTables) do
            table.insert(errorData.missingTables, {
                name = tableName,
                suggestion = getTableSuggestion(tableName)
            })
        end
    elseif type(missingTables) == "string" then
        table.insert(errorData.missingTables, {
            name = missingTables,
            suggestion = getTableSuggestion(missingTables)
        })
    end

    -- Send to client via AIO
    AIO.Handle(player, "GameMasterSystem", "ShowDatabaseError", errorData)

    -- Also send a simple error message for immediate feedback
    local tableNames = {}
    for _, tableInfo in ipairs(errorData.missingTables) do
        table.insert(tableNames, tableInfo.name)
    end
    local tableList = table.concat(tableNames, ", ")
    Utils.sendMessage(player, "error", string.format("Database error: Missing table(s): %s", tableList))
end

-- =====================================================
-- Safe Query Functions with Client Error Handling
-- =====================================================

-- Safe query wrapper that notifies client of missing tables
function DatabaseErrorHelper.SafeQueryWithClientError(player, query, requiredTables, databaseType, contextMessage)
    databaseType = databaseType or "world"

    -- Validate player
    if not player then
        if Config.debug then
            print("[DatabaseErrorHelper] ERROR: No player provided for error notification")
        end
        return nil, "No player for error notification"
    end

    -- Validate inputs
    if not query or type(query) ~= "string" then
        sendDatabaseErrorToClient(player, "invalid_query", {}, "Invalid query provided")
        return nil, "Invalid query"
    end

    if not requiredTables or type(requiredTables) ~= "table" then
        sendDatabaseErrorToClient(player, "invalid_params", {}, "Invalid required tables list")
        return nil, "Invalid required tables"
    end

    -- Check if all required tables exist
    local missingTables = {}
    for _, tableName in ipairs(requiredTables) do
        if not DatabaseHelper.TableExists(tableName, databaseType) then
            table.insert(missingTables, tableName)
        end
    end

    -- If tables are missing, notify client
    if #missingTables > 0 then
        sendDatabaseErrorToClient(player, "missing_table", missingTables, contextMessage)
        return nil, string.format("Missing tables: %s", table.concat(missingTables, ", "))
    end

    -- Build the safe query
    local modifiedQuery, buildError = DatabaseHelper.BuildSafeQuery(query, requiredTables, databaseType)
    if not modifiedQuery then
        sendDatabaseErrorToClient(player, "query_error", {}, buildError or "Query build failed")
        return nil, buildError
    end

    -- Execute the query
    local result, queryError = DatabaseHelper.SafeQuery(modifiedQuery, databaseType)
    if queryError then
        -- Query execution failed, notify client
        sendDatabaseErrorToClient(player, "query_failed", {}, queryError)
        return nil, queryError
    end

    return result, nil
end

-- Async version of SafeQueryWithClientError
function DatabaseErrorHelper.SafeQueryWithClientErrorAsync(player, query, requiredTables, callback, databaseType, contextMessage)
    databaseType = databaseType or "world"

    -- Validate player
    if not player then
        if Config.debug then
            print("[DatabaseErrorHelper] ERROR: No player provided for error notification")
        end
        if callback then callback(nil, "No player for error notification") end
        return
    end

    -- Validate inputs
    if not query or type(query) ~= "string" then
        sendDatabaseErrorToClient(player, "invalid_query", {}, "Invalid query provided")
        if callback then callback(nil, "Invalid query") end
        return
    end

    if not requiredTables or type(requiredTables) ~= "table" then
        sendDatabaseErrorToClient(player, "invalid_params", {}, "Invalid required tables list")
        if callback then callback(nil, "Invalid required tables") end
        return
    end

    if not callback or type(callback) ~= "function" then
        sendDatabaseErrorToClient(player, "invalid_params", {}, "Invalid callback function")
        return
    end

    -- Check if all required tables exist
    local missingTables = {}
    for _, tableName in ipairs(requiredTables) do
        if not DatabaseHelper.TableExists(tableName, databaseType) then
            table.insert(missingTables, tableName)
        end
    end

    -- If tables are missing, notify client
    if #missingTables > 0 then
        sendDatabaseErrorToClient(player, "missing_table", missingTables, contextMessage)
        callback(nil, string.format("Missing tables: %s", table.concat(missingTables, ", ")))
        return
    end

    -- Execute the query asynchronously using DatabaseHelper
    DatabaseHelper.BuildSafeQueryAsync(query, requiredTables, function(result, error)
        if error then
            sendDatabaseErrorToClient(player, "query_failed", {}, error)
        end
        callback(result, error)
    end, databaseType)
end

-- =====================================================
-- Batch Table Checking
-- =====================================================

-- Check multiple tables and return comprehensive error info
function DatabaseErrorHelper.CheckTablesForFeature(player, featureName, requiredTables, databaseType)
    databaseType = databaseType or "world"

    local missingTables = {}
    for _, tableName in ipairs(requiredTables) do
        if not DatabaseHelper.TableExists(tableName, databaseType) then
            table.insert(missingTables, tableName)
        end
    end

    if #missingTables > 0 then
        local contextMessage = string.format("Feature '%s' requires missing database tables", featureName)
        sendDatabaseErrorToClient(player, "missing_table", missingTables, contextMessage)
        return false, missingTables
    end

    return true, nil
end

-- =====================================================
-- Startup Notification
-- =====================================================

-- Send startup database status to player
function DatabaseErrorHelper.SendStartupDatabaseStatus(player)
    if not player or player:GetGMRank() < Config.REQUIRED_GM_LEVEL then
        return
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

    -- Send notification if there are missing tables
    if #missingRequired > 0 then
        local contextMessage = "CRITICAL: GameMasterUI requires these database tables to function properly"
        sendDatabaseErrorToClient(player, "missing_required", missingRequired, contextMessage)
    elseif #missingOptional > 0 and Config.debug then
        -- Only notify about optional tables in debug mode
        local contextMessage = "Some optional GameMasterUI features may not be available"
        sendDatabaseErrorToClient(player, "missing_optional", missingOptional, contextMessage)
    end

    -- Send success message if all tables present
    if #missingRequired == 0 and #missingOptional == 0 then
        Utils.sendMessage(player, "success", "GameMasterUI: All database tables found!")
    end
end

-- =====================================================
-- Initialization
-- =====================================================

function DatabaseErrorHelper.Initialize(config, databaseHelper, utils)
    Config = config
    DatabaseHelper = databaseHelper
    Utils = utils

    if Config.debug then
        print("[GameMasterUI] DatabaseErrorHelper initialized")
    end
end

-- =====================================================
-- Module Export
-- =====================================================

return DatabaseErrorHelper
