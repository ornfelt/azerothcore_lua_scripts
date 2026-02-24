local AIO = AIO or require("AIO")

if AIO.AddAddon() then
    return
end

-- State Machine Test Module
-- This module provides debug commands to test the state machine functionality

local StateMachine = _G.GMStateMachine
if not StateMachine then
    return
end

-- Test commands table
local testCommands = {
    ["smstate"] = function()
        if StateMachine then
            print("Current State:", StateMachine.getCurrentState())
            print("Is Idle:", StateMachine.isIdle())
            print("Is Modal Open:", StateMachine.isModalOpen())
            print("Is Loading:", StateMachine.isLoading())
            print("Can Open Modal:", StateMachine.canOpenModal())
        else
            print("State Machine not available")
        end
    end,

    ["smhistory"] = function()
        if StateMachine then
            print("=== State Machine History ===")
            local history = StateMachine.getStateHistory()
            for i, entry in ipairs(history) do
                print(string.format("[%d] %s -> %s (%.2f)", i, entry.from, entry.to, entry.timestamp))
            end
            if #history == 0 then
                print("No state transitions recorded")
            end
        else
            print("State Machine not available")
        end
    end,

    ["smcontext"] = function()
        if StateMachine then
            print("=== State Machine Context ===")
            local context = StateMachine.getContext()
            for key, value in pairs(context) do
                if type(value) == "table" then
                    print(string.format("%s: [table with %d entries]", key, #value))
                else
                    print(string.format("%s: %s", key, tostring(value)))
                end
            end
        else
            print("State Machine not available")
        end
    end,

    ["smtest"] = function()
        if not StateMachine then
            print("State Machine not available")
            return
        end

        print("=== State Machine Test ===")

        -- Test basic state queries
        print("1. Basic State Queries:")
        print("   Current State:", StateMachine.getCurrentState())
        print("   Is Idle:", StateMachine.isIdle())
        print("   Can Open Modal:", StateMachine.canOpenModal())

        -- Test state transitions (if in idle state)
        if StateMachine.isIdle() then
            print("2. Testing State Transitions:")

            -- Test opening item selection
            print("   Testing Item Selection...")
            if StateMachine.openItemSelection("TestPlayer") then
                print("   ✓ Successfully opened item selection")
                print("   Current State:", StateMachine.getCurrentState())

                -- Test closing
                if StateMachine.closeModal() then
                    print("   ✓ Successfully closed modal")
                    print("   Current State:", StateMachine.getCurrentState())
                end
            else
                print("   ✗ Failed to open item selection")
            end

            -- Test opening spell selection
            print("   Testing Spell Selection...")
            if StateMachine.openSpellSelection("TestPlayer", "buff") then
                print("   ✓ Successfully opened spell selection")
                print("   Current State:", StateMachine.getCurrentState())

                -- Test closing
                if StateMachine.closeModal() then
                    print("   ✓ Successfully closed modal")
                    print("   Current State:", StateMachine.getCurrentState())
                end
            else
                print("   ✗ Failed to open spell selection")
            end

            -- Test opening dialog
            print("   Testing Dialog...")
            if StateMachine.openDialog("gold") then
                print("   ✓ Successfully opened dialog")
                print("   Current State:", StateMachine.getCurrentState())

                -- Test closing
                if StateMachine.closeModal() then
                    print("   ✓ Successfully closed dialog")
                    print("   Current State:", StateMachine.getCurrentState())
                end
            else
                print("   ✗ Failed to open dialog")
            end

        else
            print("2. Cannot test transitions - system not in idle state")
        end

        print("=== Test Complete ===")
    end,

    ["smforce"] = function()
        if StateMachine then
            print("Forcing state machine to IDLE...")
            local GMData = _G.GMData
            if GMData then
                GMData.PlayerGMLevel = GMData.PlayerGMLevel or 3
                GMData.CoreName = GMData.CoreName or "Forced"
                GMData.isGmLevelFetched = true
                GMData.isCoreNameFetched = true
            end
            StateMachine.initialize()
            print("State machine forced to:", StateMachine.getCurrentState())
            print("Can open modal:", StateMachine.canOpenModal())
        else
            print("State Machine not available")
        end
    end,

    ["smsave"] = function()
        if StateMachine then
            local success = StateMachine.saveState()
            if success then
                print("State machine state saved successfully")
            else
                print("Failed to save state machine state")
            end
        else
            print("State Machine not available")
        end
    end,

    ["smrestore"] = function()
        if StateMachine then
            local success = StateMachine.restoreState()
            if success then
                print("State machine state restored successfully")
            else
                print("No saved state to restore or restore failed")
            end
        else
            print("State Machine not available")
        end
    end,

    ["smclear"] = function()
        if StateMachine then
            StateMachine.clearPersistedState()
            print("Persisted state cleared")
        else
            print("State Machine not available")
        end
    end,

    ["smtimeout"] = function()
        if StateMachine then
            local currentTime = GetTime()
            local stateEnterTime = StateMachine.context.stateEnterTime or currentTime
            local timeInState = currentTime - stateEnterTime
            local timeout = StateMachine.timeouts[StateMachine.currentState]
            local remaining = timeout and (timeout - timeInState) or "No timeout"

            print("=== Timeout Status ===")
            print("Current State:", StateMachine.currentState)
            print("Time in State:", string.format("%.1f seconds", timeInState))
            if timeout then
                print("Timeout Limit:", string.format("%.1f seconds", timeout))
                if type(remaining) == "number" then
                    if remaining > 0 then
                        print("Time Remaining:", string.format("%.1f seconds", remaining))
                    else
                        print("Time Remaining: OVERDUE by", string.format("%.1f seconds", -remaining))
                    end
                end
            else
                print("Timeout Limit: None")
            end
            print("Recovery Attempts:", StateMachine.context.recoveryAttempts or 0)
        else
            print("State Machine not available")
        end
    end,

    ["smtrigger"] = function()
        if StateMachine then
            print("Triggering timeout check...")
            local timedOut = StateMachine.checkForTimeout()
            if timedOut then
                print("Timeout detected and handled")
            else
                print("No timeout detected")
            end
        else
            print("State Machine not available")
        end
    end,

    ["smerrors"] = function()
        if StateMachine then
            print("=== State Machine Error Information ===")
            local errors = StateMachine.getErrorInfo()
            if #errors == 0 then
                print("No recent errors found")
            else
                for i, error in ipairs(errors) do
                    print(string.format("[%d] %s: %s", i, error.type:upper(), error.message))
                    if error.from and error.to then
                        print(string.format("    Transition: %s -> %s", error.from, error.to))
                    end
                    if error.timestamp then
                        print(string.format("    Time: %.2f", error.timestamp))
                    end
                    print("")
                end
            end
        else
            print("State Machine not available")
        end
    end,

    ["smhelp"] = function()
        print("=== State Machine Debug Commands ===")
        print("/gmtest smstate    - Show current state machine status")
        print("/gmtest smhistory  - Show state transition history")
        print("/gmtest smcontext  - Show state machine context")
        print("/gmtest smtest     - Run comprehensive state machine test")
        print("/gmtest smforce    - Force transition to IDLE state")
        print("/gmtest smsave     - Save current state for persistence")
        print("/gmtest smrestore  - Restore saved state")
        print("/gmtest smclear    - Clear persisted state")
        print("/gmtest smtimeout  - Show timeout status for current state")
        print("/gmtest smtrigger  - Trigger timeout check manually")
        print("/gmtest smerrors   - Show recent error information")
        print("/gmtest smhelp     - Show this help")
        print("")
        print("Note: Use /gm for normal GameMaster UI commands")
    end
}

-- Add debug commands to the GameMaster system
local GameMasterSystem = _G.GameMasterSystem
if GameMasterSystem then
    -- Add test commands to the system
    GameMasterSystem.StateMachineTestCommands = testCommands

    -- Try to add a chat command handler if it doesn't exist
    local function handleChatCommand(msg)
        -- Extract the full command (should be like "smstate", "smhelp", etc.)
        local command = msg:match("^(%w+)")
        if command and testCommands[command] then
            testCommands[command]()
            return true
        end
        return false
    end

    -- Register chat command if possible
    if not GameMasterSystem.chatCommandHandler then
        GameMasterSystem.chatCommandHandler = handleChatCommand

        -- Create a simple slash command (only /gmtest, not /gm to avoid conflicts)
        SLASH_GMTEST1 = "/gmtest"
        SlashCmdList["GMTEST"] = function(msg)
            if handleChatCommand(msg) then
                return
            end
            -- Show help if no valid command
            testCommands["smhelp"]()
        end

        if _G.GM_DEBUG then
            print("[StateMachineTest] Debug commands registered. Type /gmtest smhelp for help.")
        end
    end
end

-- Auto-testing removed for production - use /gmtest smstate to check manually