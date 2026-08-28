-- ===================================
-- SIMPLE LOGGING SYSTEM TEST
-- ===================================
-- Basic test that should work in TrinityCore environment
-- Tests are disabled by default to avoid console spam
-- Uncomment the lines below to run the tests

--[[ TESTS DISABLED
-- print("=== Simple Logging Test ===")

-- Check if Log is available
if not Log then
    -- print("ERROR: Log function not available!")
    return
else
    -- print("✓ Log function is available")
end

-- Check if it's a table
if type(Log) == "table" then
    -- print("✓ Log is properly set up as a table")
else
    -- print("✗ Log is not a table, type is:", type(Log))
    return
end

-- Test basic function calls
pcall(function()
    Log("Basic log test - this should work")
    -- print("✓ Basic Log() call successful")
end)

pcall(function()
    Log.Info("Info test - this should work")
    -- print("✓ Log.Info() call successful")
end)

pcall(function()
    Log.Error("Error test - this should work")
    -- print("✓ Log.Error() call successful")
end)

pcall(function()
    Log.Debug("Debug test - this should work")
    -- print("✓ Log.Debug() call successful")
end)

-- Test if LOGGING_CONFIG is loaded
if LOGGING_CONFIG then
    -- print("✓ LOGGING_CONFIG is loaded")
    -- print("  Global log level:", LOGGING_CONFIG.globalLogLevel)
else
    -- print("✗ LOGGING_CONFIG not loaded")
end

-- Test utility functions
if Log.IsEnabled then
    local enabled = Log.IsEnabled()
    -- print("✓ Log.IsEnabled() works, result:", enabled)
else
    -- print("✗ Log.IsEnabled() not available")
end

if Log.GetStats then
    local stats = Log.GetStats()
    -- print("✓ Log.GetStats() works")
    if stats then
        -- print("  Messages logged:", stats.messagesLogged or "N/A")
    end
else
    -- print("✗ Log.GetStats() not available")
end

-- print("=== Simple Logging Test Complete ===")
-- print("If you see this message, the basic logging system is working!")
--]] -- END TESTS DISABLED