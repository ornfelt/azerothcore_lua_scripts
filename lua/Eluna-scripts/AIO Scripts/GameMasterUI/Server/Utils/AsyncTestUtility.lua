--[[
    GameMasterUI Async Test Utility

    This utility provides functions to test the async database implementation
    and compare performance between sync and async modes.

    Usage:
    - Call AsyncTestUtility.RunBasicTest() to test basic async functionality
    - Call AsyncTestUtility.RunPerformanceComparison() to compare sync vs async
]]--

local AsyncTestUtility = {}

-- Module dependencies (will be injected)
local Config, DatabaseHelper, Database, Utils

function AsyncTestUtility.Initialize(config, dbHelper, database, utils)
    Config = config
    DatabaseHelper = dbHelper
    Database = database
    Utils = utils
end

-- Test basic async functionality
function AsyncTestUtility.RunBasicTest(player)
    if not player then
        print("[AsyncTestUtility] ERROR: No player provided for test")
        return
    end

    print("[AsyncTestUtility] Starting basic async test...")

    -- Test 1: Simple item count query
    local testQuery = "SELECT COUNT(*) FROM item_template LIMIT 1"

    print("[AsyncTestUtility] Test 1: Basic async query")
    DatabaseHelper.SafeQueryAsync(testQuery, function(result, error)
        if result then
            local count = result:GetUInt32(0)
            print(string.format("[AsyncTestUtility] ✓ Async query successful: %d items in database", count))
            Utils.sendMessage(player, "success", string.format("Async test passed: %d items found", count))
        else
            print(string.format("[AsyncTestUtility] ✗ Async query failed: %s", error or "unknown error"))
            Utils.sendMessage(player, "error", "Async test failed: " .. (error or "unknown error"))
        end
    end, "world")

    -- Test 2: BuildSafeQueryAsync
    print("[AsyncTestUtility] Test 2: BuildSafeQueryAsync")
    DatabaseHelper.BuildSafeQueryAsync(
        "SELECT entry, name FROM item_template ORDER BY entry DESC LIMIT 5",
        {"item_template"},
        function(result, error)
            if result then
                local itemCount = 0
                repeat
                    itemCount = itemCount + 1
                until not result:NextRow()
                print(string.format("[AsyncTestUtility] ✓ BuildSafeQueryAsync successful: %d items", itemCount))
                Utils.sendMessage(player, "success", string.format("BuildSafeQueryAsync test passed: %d items", itemCount))
            else
                print(string.format("[AsyncTestUtility] ✗ BuildSafeQueryAsync failed: %s", error or "unknown error"))
                Utils.sendMessage(player, "error", "BuildSafeQueryAsync test failed: " .. (error or "unknown error"))
            end
        end,
        "world"
    )
end

-- Test configuration toggle
function AsyncTestUtility.TestConfigToggle(player)
    if not player then
        print("[AsyncTestUtility] ERROR: No player provided for config test")
        return
    end

    print("[AsyncTestUtility] Starting config toggle test...")

    local originalAsyncSetting = Config.database.enableAsync
    print(string.format("[AsyncTestUtility] Original async setting: %s", tostring(originalAsyncSetting)))

    -- Test with async disabled
    Config.database.enableAsync = false
    print("[AsyncTestUtility] Testing with async disabled...")

    DatabaseHelper.SafeQueryAsync("SELECT COUNT(*) FROM item_template LIMIT 1", function(result, error)
        if result then
            print("[AsyncTestUtility] ✓ Sync fallback working correctly")
            Utils.sendMessage(player, "info", "Sync fallback test passed")
        else
            print(string.format("[AsyncTestUtility] ✗ Sync fallback failed: %s", error or "unknown error"))
            Utils.sendMessage(player, "error", "Sync fallback test failed")
        end

        -- Restore original setting and test async
        Config.database.enableAsync = true
        print("[AsyncTestUtility] Testing with async enabled...")

        DatabaseHelper.SafeQueryAsync("SELECT COUNT(*) FROM item_template LIMIT 1", function(result2, error2)
            if result2 then
                print("[AsyncTestUtility] ✓ Async mode working correctly")
                Utils.sendMessage(player, "info", "Async mode test passed")
            else
                print(string.format("[AsyncTestUtility] ✗ Async mode failed: %s", error2 or "unknown error"))
                Utils.sendMessage(player, "error", "Async mode test failed")
            end

            -- Restore original setting
            Config.database.enableAsync = originalAsyncSetting
            print(string.format("[AsyncTestUtility] Config restored to: %s", tostring(originalAsyncSetting)))
        end, "world")
    end, "world")
end

-- Performance comparison (rough timing)
function AsyncTestUtility.RunPerformanceComparison(player, queryCount)
    if not player then
        print("[AsyncTestUtility] ERROR: No player provided for performance test")
        return
    end

    queryCount = queryCount or 10
    print(string.format("[AsyncTestUtility] Starting performance comparison with %d queries...", queryCount))

    local testQuery = "SELECT entry, name FROM item_template ORDER BY entry ASC LIMIT 10"

    -- Test sync performance
    local syncStartTime = GetCurrTime()
    local syncCompletedQueries = 0

    for i = 1, queryCount do
        local result, error = DatabaseHelper.SafeQuery(testQuery, "world")
        if result then
            syncCompletedQueries = syncCompletedQueries + 1
        end
    end

    local syncEndTime = GetCurrTime()
    local syncTotalTime = syncEndTime - syncStartTime

    print(string.format("[AsyncTestUtility] Sync: %d/%d queries completed in %d ms",
        syncCompletedQueries, queryCount, syncTotalTime))

    -- Test async performance
    local asyncStartTime = GetCurrTime()
    local asyncCompletedQueries = 0
    local asyncExpectedQueries = queryCount

    local function onAsyncComplete()
        asyncCompletedQueries = asyncCompletedQueries + 1
        if asyncCompletedQueries >= asyncExpectedQueries then
            local asyncEndTime = GetCurrTime()
            local asyncTotalTime = asyncEndTime - asyncStartTime

            print(string.format("[AsyncTestUtility] Async: %d/%d queries completed in %d ms",
                asyncCompletedQueries, queryCount, asyncTotalTime))

            -- Report results
            local improvement = syncTotalTime > 0 and ((syncTotalTime - asyncTotalTime) / syncTotalTime * 100) or 0
            local message = string.format("Performance test completed:\nSync: %dms, Async: %dms\nImprovement: %.1f%%",
                syncTotalTime, asyncTotalTime, improvement)
            print("[AsyncTestUtility] " .. message)
            Utils.sendMessage(player, "info", message)
        end
    end

    for i = 1, queryCount do
        DatabaseHelper.SafeQueryAsync(testQuery, function(result, error)
            onAsyncComplete()
        end, "world")
    end
end

-- Command handler for admin testing
function AsyncTestUtility.HandleTestCommand(player, testType)
    if not player or player:GetGMRank() < 2 then
        if player then
            Utils.sendMessage(player, "error", "You need GM level 2+ to run async tests")
        end
        return
    end

    testType = testType or "basic"

    if testType == "basic" then
        AsyncTestUtility.RunBasicTest(player)
    elseif testType == "config" then
        AsyncTestUtility.TestConfigToggle(player)
    elseif testType == "performance" then
        AsyncTestUtility.RunPerformanceComparison(player, 5) -- Use 5 queries for testing
    else
        Utils.sendMessage(player, "error", "Unknown test type. Use: basic, config, or performance")
    end
end

return AsyncTestUtility