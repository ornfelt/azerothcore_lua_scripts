-- ===================================
-- LOGGING SYSTEM TEST SCRIPT
-- ===================================
-- Simple test to verify the logging system functionality
-- This script can be used to test all logging features

-- Test if Log function is available
if not Log then
    -- print("ERROR: Log function not available! Make sure LoggingCore.lua is loaded.")
    return
end

-- ===================================
-- BASIC FUNCTIONALITY TESTS
-- ===================================
-- Tests are disabled by default to avoid console spam
-- Uncomment the lines below to run the tests

--[[ TESTS DISABLED
-- print("=== Logging System Test Started ===")

-- Test all log levels
Log.Error("This is an error message")
Log.Warn("This is a warning message")
Log.Info("This is an info message")
Log.Debug("This is a debug message")
Log.Trace("This is a trace message")

-- Test the default Log function (should default to INFO level)
Log("This is a default log message")

-- Test multiple arguments
Log.Info("Testing multiple arguments:", 1, 2, 3, "test", true)

-- Test with table (should convert to string)
local testTable = { name = "Test", value = 42 }
Log.Debug("Testing with table:", testTable)

-- ===================================
-- CONFIGURATION TESTS
-- ===================================

-- Test log level checking
if Log.IsEnabled() then
    Log.Info("Logging is currently enabled")
else
    Log.Info("Logging is currently disabled")
end

-- Show current log level
local currentLevel = Log.GetLogLevel()
Log.Info("Current global log level:", currentLevel, "(" .. (LOGGING_CONFIG.LOG_LEVEL_NAMES[currentLevel] or "UNKNOWN") .. ")")

-- Test statistics
local stats = Log.GetStats()
Log.Info("Current logging stats:",
    "Messages logged:", stats.messagesLogged,
    "Filtered:", stats.messagesFiltered,
    "Errors:", stats.errorCount)

-- ===================================
-- SERVER-SIDE TESTS (if available)
-- ===================================

if Log.Server then
    Log.Info("Server-side logging extensions detected")

    -- Test performance timing
    local timer = Log.Server.StartTimer("TestOperation")

    -- Simulate some work
    for i = 1, 1000 do
        local dummy = i * 2
    end

    Log.Server.EndTimer(timer)
    Log.Info("Performance timer test completed")

    -- Test player logging (will only work if called with a player context)
    -- This would typically be called from an event handler
    -- Log.Server.PlayerInfo(player, "Player-specific log message")
else
    Log.Info("Server-side logging extensions not loaded (this is normal for client-side)")
end

-- ===================================
-- CLIENT-SIDE TESTS (if available)
-- ===================================

if Log.Client then
    Log.Info("Client-side logging extensions detected")

    -- Test notification (won't show unless in-game client)
    Log.Client.Notify("Test notification message", LOGGING_CONFIG.LOG_LEVELS.WARN)

    Log.Info("Client debug overlay available with /logdebug command")
else
    Log.Info("Client-side logging extensions not loaded (this is normal for server-side)")
end

-- ===================================
-- CONFIGURATION MODIFICATION TESTS
-- ===================================

-- Test changing log level
local originalLevel = LOGGING_CONFIG.globalLogLevel
Log.Info("Testing log level changes...")

-- Set to ERROR only
Log.SetLogLevel(LOGGING_CONFIG.LOG_LEVELS.ERROR)
Log.Debug("This debug message should not appear")
Log.Error("This error message should appear")

-- Set to DEBUG
Log.SetLogLevel(LOGGING_CONFIG.LOG_LEVELS.DEBUG)
Log.Debug("This debug message should now appear")
Log.Trace("This trace message should not appear")

-- Restore original level
Log.SetLogLevel(originalLevel)
Log.Info("Log level restored to original setting")

-- ===================================
-- FILTER TESTS
-- ===================================

-- Test with module-specific log level
LOGGING_CONFIG.moduleLogLevels["LoggingSystemTest"] = LOGGING_CONFIG.LOG_LEVELS.ERROR
Log.Debug("This debug message should be filtered out for this module")
Log.Error("This error message should still appear")

-- Restore module level
LOGGING_CONFIG.moduleLogLevels["LoggingSystemTest"] = nil
Log.Debug("Debug messages should work again for this module")

-- ===================================
-- BACKWARDS COMPATIBILITY TESTS
-- ===================================

-- Test the CreateDebugFunction helper
local debugMsg = CreateDebugFunction("TestModule", LOGGING_CONFIG.LOG_LEVELS.DEBUG)
debugMsg("This is a custom debug message from TestModule")

-- ===================================
-- FINAL STATS
-- ===================================

-- Show final statistics
local finalStats = Log.GetStats()
Log.Info("Final logging stats:",
    "Messages logged:", finalStats.messagesLogged,
    "Filtered:", finalStats.messagesFiltered,
    "Errors:", finalStats.errorCount)

-- print("=== Logging System Test Completed ===")

-- ===================================
-- TEST RESULTS
-- ===================================

-- print("")
-- print("TEST RESULTS:")
-- print("✓ Basic log functions available:", Log.Error ~= nil and "YES" or "NO")
-- print("✓ Configuration loaded:", LOGGING_CONFIG ~= nil and "YES" or "NO")
-- print("✓ Statistics working:", finalStats.messagesLogged > 0 and "YES" or "NO")
-- print("✓ Level filtering working:", finalStats.messagesFiltered > 0 and "YES" or "NO")
-- print("✓ Server extensions:", Log.Server ~= nil and "YES" or "NO")
-- print("✓ Client extensions:", Log.Client ~= nil and "YES" or "NO")

-- print("")
-- print("USAGE EXAMPLES:")
-- print("  Log('Basic message')")
-- print("  Log.Error('Error message')")
-- print("  Log.Debug('Debug message')")
-- print("  Log.SetLogLevel(4) -- Set to DEBUG level")
-- print("  Server: .log level 3 -- Admin command to set INFO level")
-- print("  Client: /logdebug toggle -- Toggle debug overlay")

Log.Info("Logging system is ready for use!")
--]] -- END TESTS DISABLED