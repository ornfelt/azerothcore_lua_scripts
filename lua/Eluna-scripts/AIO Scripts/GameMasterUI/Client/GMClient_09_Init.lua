-- GameMaster UI System - Initialization
-- This file handles final initialization, slash commands, and login events
-- Load order: 09 (Last)

local AIO = AIO or require("AIO")

if AIO.AddAddon() then
    return
end

-- Verify namespace exists
local GameMasterSystem = _G.GameMasterSystem
if not GameMasterSystem then
    print("[ERROR] GameMasterSystem namespace not found! Check load order.")
    return
end

-- Local references
local GMData = _G.GMData
local GMConfig = _G.GMConfig
local GMUtils = _G.GMUtils
local GMUI = _G.GMUI
local GMMenus = _G.GMMenus
local GMModels = _G.GMModels
local GMDataHandler = _G.GMDataHandler

-- ObjectEditor modules are loaded automatically by AIO
-- They contain AIO.AddAddon() checks and will initialize themselves
local ObjectEditor = _G.ObjectEditor
local CreatureTemplateEditor = _G.CreatureTemplateEditor
local FlagEditor = _G.FlagEditor

-- Login handler
local function OnLogin(event, player)
    GMUtils.debug("Player login detected")
    
    -- Request GM level and core name
    AIO.Handle("GameMasterSystem", "handleGMLevel")
    AIO.Handle("GameMasterSystem", "getCoreName")
    
    -- Initialize model pool
    if GMModels and GMModels.initializeModelPool then
        GMModels.initializeModelPool()
    end
    
    -- Initialize menu system
    if GMMenus and GMMenus.Initialize then
        GMMenus.Initialize()
    end
    
    -- Initialize report dialog system
    if GMUtils and GMUtils.RunInitializers then
        GMUtils.RunInitializers()
    end
    
    -- Delay UI creation to ensure data is received
    GMUtils.delayedExecution(0.5, function()
        -- Create UI if GM level is sufficient
        if GMData.gmLevel >= GMConfig.config.REQUIRED_GM_LEVEL then
            if GMUI and GMUI.initializeUI then
                GMUI.initializeUI()
                GMUtils.debug("GM UI created successfully")
                
                -- Finalize any cross-module dependencies
                if GameMasterSystem.FinalizeHandlers then
                    GameMasterSystem.FinalizeHandlers()
                end
            else
                GMUtils.debug("GMUI.createMainFrame not found")
            end
        else
            GMUtils.debug("Insufficient GM level:", GMData.gmLevel)
        end
    end)
end

-- Slash command handler
local function OnCommand(msg, player)
    msg = msg:lower()
    
    if msg == "" then
        -- Check GM level
        if GMData.gmLevel < GMConfig.config.REQUIRED_GM_LEVEL then
            print("|cffff0000You do not have permission to use this command.|r")
            return
        end
        
        -- Create or show the UI
        if not GMData.frames.mainFrame then
            if GMUI and GMUI.initializeUI then
                GMUI.initializeUI()
            else
                print("|cffff0000Error: UI module not loaded properly.|r")
                return
            end
        end
        
        if GMData.frames.mainFrame then
            if GMData.frames.mainFrame:IsShown() then
                GMData.frames.mainFrame:Hide()
            else
                -- Reset position to center before showing
                GMData.frames.mainFrame:ClearAllPoints()
                GMData.frames.mainFrame:SetPoint("CENTER")
                GMData.frames.mainFrame:Show()
                -- Request data for current tab
                if GMDataHandler and GMDataHandler.RequestDataForCurrentTab then
                    GMDataHandler.RequestDataForCurrentTab()
                end
            end
        end
    elseif msg == "reload" then
        -- Reload UI (admin command)
        if GMData.gmLevel < 3 then
            print("|cffff0000You do not have permission to reload the GM UI.|r")
            return
        end
        
        print("|cff00ff00Reloading GameMaster UI...|r")
        ReloadUI()
    elseif msg == "debug" then
        -- Toggle debug mode
        if GMData.gmLevel < 3 then
            print("|cffff0000You do not have permission to toggle debug mode.|r")
            return
        end
        
        _G.GM_DEBUG = not _G.GM_DEBUG
        GMConfig.config.debug = _G.GM_DEBUG
        print("|cff00ff00GameMaster debug mode:|r", _G.GM_DEBUG and "|cff00ff00ON|r" or "|cffff0000OFF|r")
    elseif msg == "objtest" then
        -- Test ObjectEditor
        print("|cff00ff00Testing ObjectEditor...|r")
        print("ObjectEditor loaded:", _G.ObjectEditor and "Yes" or "No")
        if _G.ObjectEditor then
            print("- OpenEditor function:", _G.ObjectEditor.OpenEditor and "Yes" or "No")
            print("- CreateEditorModal function:", _G.ObjectEditor.CreateEditorModal and "Yes" or "No")
        end
        print("EntityMenus loaded:", _G.EntityMenus and "Yes" or "No")
        if _G.EntityMenus then
            print("- updateNearbyObjectsMenu function:", _G.EntityMenus.updateNearbyObjectsMenu and "Yes" or "No")
            print("- nearbyObjectsMenu table:", _G.EntityMenus.nearbyObjectsMenu and "Yes" or "No")
        end
        -- Request nearby objects
        print("|cffffcc00Requesting nearby objects...|r")
        AIO.Handle("GameMasterSystem", "getNearbyGameObjects", 30)
    elseif msg == "objedit" then
        -- Test opening editor with mock data
        print("|cff00ff00Testing ObjectEditor.OpenEditor with mock data...|r")
        if _G.ObjectEditor and _G.ObjectEditor.OpenEditor then
            local mockData = {
                guid = 12345,
                entry = 244606,
                x = 100,
                y = 200,
                z = 50,
                o = 0,
                scale = 1.0
            }
            _G.ObjectEditor.OpenEditor(mockData)
            print("|cff00ff00Editor should be open now!|r")
        else
            print("|cffff0000ObjectEditor.OpenEditor not found!|r")
        end
    elseif msg == "status" then
        -- Show system status
        print("|cff00ff00GameMaster UI Status:|r")
        print("  Version: " .. (_G.GM_VERSION or "Unknown"))
        print("  GM Level: " .. (GMData.gmLevel or "Unknown"))
        print("  Core: " .. (GMData.CoreName or "Unknown"))
        print("  Debug Mode: " .. (_G.GM_DEBUG and "|cff00ff00ON|r" or "|cffff0000OFF|r"))

        -- Check state machine
        local StateMachine = _G.GMStateMachine
        if StateMachine then
            local currentState = StateMachine.getCurrentState()
            local stateTime = GetTime() - (StateMachine.context.stateEnterTime or GetTime())

            print("  State Machine: |cff00ff00Active|r")
            print("    Current State: " .. currentState)
            print("    Time in State: " .. string.format("%.1f seconds", stateTime))
            print("    Can Open Modals: " .. (StateMachine.canOpenModal() and "|cff00ff00Yes|r" or "|cffff0000No|r"))
            print("    Is Modal Open: " .. (StateMachine.isModalOpen() and "|cffffcc00Yes|r" or "|cff888888No|r"))

            -- Check for recent errors
            local errors = StateMachine.getErrorInfo()
            if #errors > 0 then
                print("    Recent Errors: |cffff0000" .. #errors .. " found|r (use /gmtest smerrors)")
            else
                print("    Recent Errors: |cff00ff00None|r")
            end

            -- Show timeout status if applicable
            local timeout = StateMachine.timeouts[currentState]
            if timeout then
                local remaining = timeout - stateTime
                if remaining > 0 then
                    print("    Timeout: " .. string.format("%.1f/%.1f seconds", stateTime, timeout))
                else
                    print("    Timeout: |cffff0000OVERDUE by %.1f seconds|r", -remaining)
                end
            else
                print("    Timeout: None")
            end

            -- Show recovery attempts if any
            if StateMachine.context.recoveryAttempts and StateMachine.context.recoveryAttempts > 0 then
                print("    Recovery Attempts: |cffffcc00" .. StateMachine.context.recoveryAttempts .. "|r")
            end
        else
            print("  State Machine: |cffff0000Not Available|r")
        end
    elseif msg == "help" then
        print("|cff00ff00GameMaster UI Commands:|r")
        print("  |cffffcc00/gm|r or |cffffcc00/gamemaster|r - Toggle the UI")
        print("  |cffffcc00/gm status|r - Show system status")
        if GMData.gmLevel >= 3 then
            print("  |cffffcc00/gm reload|r - Reload the UI")
            print("  |cffffcc00/gm debug|r - Toggle debug mode")
            print("  |cffffcc00/gm objtest|r - Test ObjectEditor system")
        end
        print("  |cffffcc00/gm help|r - Show this help")
        print("")
        print("For advanced debugging: |cffffcc00/gmtest smhelp|r")
    else
        print("|cffff0000Unknown GameMaster command. Use /gm help for available commands.|r")
    end
end

-- Create event frame for login handling
local eventFrame = CreateFrame("Frame")
eventFrame:RegisterEvent("PLAYER_LOGIN")
eventFrame:SetScript("OnEvent", function(self, event, ...)
    if event == "PLAYER_LOGIN" then
        OnLogin(event, ...)
    end
end)

-- Add refresh data function for sort order changes
function GameMasterSystem.refreshData()
    if GMData.activeTab and GMUI.requestDataForTab then
        GMUI.requestDataForTab(GMData.activeTab)
    end
end

-- Register slash commands
SLASH_GAMEMASTER1 = "/gm"
SLASH_GAMEMASTER2 = "/gamemaster"
SlashCmdList["GAMEMASTER"] = OnCommand

-- Module initialization complete
-- All modules loaded successfully
-- Type /gm or /gamemaster to open the UI