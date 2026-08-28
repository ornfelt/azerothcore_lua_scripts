-- ===================================
-- LOGGING SYSTEM USAGE EXAMPLE
-- ===================================
-- This shows how to use the logging system in your existing scripts

-- The logging system should already be loaded due to the 00_ prefix
-- If Log is not available, there might be a loading issue

if not Log then
    
    -- Create a simple fallback
    Log = function(msg) print("[LOG]", msg) end
    Log.Error = function(msg) print("[ERROR]", msg) end
    Log.Warn = function(msg) print("[WARN]", msg) end
    Log.Info = function(msg) print("[INFO]", msg) end
    Log.Debug = function(msg) print("[DEBUG]", msg) end
    Log.Trace = function(msg) print("[TRACE]", msg) end
end

-- ===================================
-- EXAMPLE: PLAYER LOGIN HANDLER
-- ===================================

local function OnPlayerLogin(event, player)
    Log.Info("Player logged in:", player:GetName(), "Level:", player:GetLevel())
    
    -- Example of conditional logging
    if player:GetLevel() == 1 then
        Log.Debug("New player detected:", player:GetName())
    end
    
    -- Example of error handling with logging
    local success, err = pcall(function()
        -- Some operation that might fail
        local gold = player:GetCoinage()
        if gold > 1000000 then
            Log.Warn("High gold amount detected for player:", player:GetName(), "Gold:", gold)
        end
    end)
    
    if not success then
        Log.Error("Error processing player login:", player:GetName(), "Error:", err)
    end
end

-- ===================================
-- EXAMPLE: ITEM USAGE HANDLER  
-- ===================================

local function OnItemUse(event, player, item)
    local itemId = item:GetEntry()
    local itemName = item:GetName()
    
    Log.Debug("Player", player:GetName(), "used item", itemId, "(" .. itemName .. ")")
    
    -- Example of server-side logging with player context
    if Log.Server and Log.Server.PlayerInfo then
        Log.Server.PlayerInfo(player, "Used item: " .. itemName .. " (ID: " .. itemId .. ")")
    end
    
    -- Example of performance monitoring
    if Log.Server and Log.Server.StartTimer then
        local timer = Log.Server.StartTimer("ItemProcessing")
        
        -- Simulate some processing
        for i = 1, 100 do
            local dummy = i * 2
        end
        
        Log.Server.EndTimer(timer)
    end
end

-- ===================================
-- EXAMPLE: DATABASE OPERATION
-- ===================================

local function SavePlayerData(player, data)
    Log.Trace("Saving data for player:", player:GetName())
    
    local query = string.format([[
        UPDATE custom_player_data 
        SET data = '%s' 
        WHERE guid = %d
    ]], data, player:GetGUIDLow())
    
    -- Log the query if in trace mode
    if Log.Server and Log.Server.LogQuery then
        Log.Server.LogQuery(query)
    end
    
    local success = WorldDBExecute(query)
    
    if success then
        Log.Info("Successfully saved data for player:", player:GetName())
    else
        Log.Error("Failed to save data for player:", player:GetName())
    end
end

-- ===================================
-- EXAMPLE: CONFIGURATION CHANGES
-- ===================================

local function SetupLogging()
    -- Example of changing log levels programmatically
    if Log.SetLogLevel then
        -- Set debug level for this specific module
        Log.SetLogLevel(LOGGING_CONFIG.LOG_LEVELS.DEBUG, "UsageExample")
        
        -- Log.Debug("Debug logging enabled for this example")
    end
    
    -- Example of checking current settings
    if Log.GetLogLevel then
        local currentLevel = Log.GetLogLevel("UsageExample")
        -- Log.Info("Current log level for this module:", currentLevel)
    end
end

-- ===================================
-- EXAMPLE: ERROR HANDLING PATTERN
-- ===================================

local function SafeOperation(player, operationName, operation)
    Log.Debug("Starting operation:", operationName, "for player:", player:GetName())
    
    local success, result = pcall(operation)
    
    if success then
        Log.Info("Operation", operationName, "completed successfully for", player:GetName())
        return result
    else
        Log.Error("Operation", operationName, "failed for", player:GetName(), "Error:", result)
        
        -- Notify player of error if it's critical
        if Log.Client and Log.Client.Notify then
            Log.Client.Notify("Operation failed: " .. operationName, LOGGING_CONFIG.LOG_LEVELS.ERROR)
        end
        
        return nil
    end
end

-- ===================================
-- EXAMPLE: MODULE INITIALIZATION
-- ===================================

local function InitializeModule()
    -- Log.Info("UsageExample module initializing...")
    
    -- Setup logging preferences
    SetupLogging()
    
    -- Register event handlers (example)
    -- RegisterPlayerEvent(3, OnPlayerLogin)    -- PLAYER_EVENT_ON_LOGIN
    -- RegisterPlayerEvent(50, OnItemUse)       -- PLAYER_EVENT_ON_USE_ITEM
    
    -- Log.Info("UsageExample module initialized successfully")
    
    -- Show statistics if available
    if Log.GetStats then
        local stats = Log.GetStats()
        -- Log.Debug("Current logging stats:",
            -- "Messages:", stats.messagesLogged or 0,
            -- "Filtered:", stats.messagesFiltered or 0)
    end
end

-- ===================================
-- BACKWARDS COMPATIBILITY EXAMPLE
-- ===================================

-- If you have existing debug functions, you can easily replace them
local function CreateOldStyleDebugFunction()
    -- Old way (replace this pattern in your existing code)
    --[[
    local config = { debug = true }
    local function debugMsg(...)
        if config.debug then
        end
    end
    --]]
    
    -- New way (simple replacement)
    local debugMsg = function(...)
        Log.Debug(...)
    end
    
    -- Or use the helper function
    local debugMsg2 = CreateDebugFunction("MyModule", LOGGING_CONFIG.LOG_LEVELS.DEBUG)
    
    return debugMsg, debugMsg2
end

-- ===================================
-- RUN EXAMPLES
-- ===================================
-- Examples are disabled by default to avoid console spam
-- Uncomment the lines below to test the examples

--[[ EXAMPLES DISABLED
-- Initialize the module
InitializeModule()

-- Test the backwards compatibility
local oldDebugMsg, newDebugMsg = CreateOldStyleDebugFunction()
oldDebugMsg("This is an old-style debug message")
newDebugMsg("This is a new-style debug message")

-- Log.Info("Usage examples completed - check the functions above for implementation patterns")
--]] -- END EXAMPLES DISABLED