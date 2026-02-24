-- GameMaster UI System - Main Entry Point
-- This file creates the namespace and initializes global data structures
-- Load order: 00 (First)

local AIO = AIO or require("AIO")

if AIO.AddAddon() then
    return
end

-- Create the namespace for the addon (only done in main file)
_G.GameMasterSystem = AIO.AddHandlers("GameMasterSystem", {})

-- Create global data structures that will be used across all modules
_G.GMData = {
    -- Core data storage
    DataStore = {},
    
    -- System state
    coreName = "",
    gmLevel = 3, -- Default to non-GM level
    
    -- State flags
    isGmLevelFetched = false,
    isCoreNameFetched = false,
    
    -- UI state (current tab reference)
    currentOffset = 0,
    lastRequestedOffset = 0,  -- Track last requested offset to prevent duplicate requests
    activeTab = 1,
    sortOrder = "DESC",
    currentSearchQuery = "",
    hasMoreData = false,
    
    -- Per-tab pagination states
    tabStates = {},
    
    -- UI references (will be populated by UI module)
    frames = {},
    models = {},
    
    -- Performance tracking
    lastUpdate = 0,
    updateThrottle = 0.1, -- Minimum time between updates
}

-- Create module tables for organization
_G.GMUtils = {}      -- Utility functions
_G.GMConfig = {}     -- Configuration data
_G.GMUI = {}         -- UI creation and management
_G.GMCards = {}      -- Card creation functions
_G.GMModels = {}     -- Model management
_G.GMMenus = {}      -- Menu system
_G.GMDataHandler = {} -- Data filtering and management

-- Debug flag (can be overridden by config)
_G.GM_DEBUG = false

-- Version information
_G.GM_VERSION = "2.0.0"
_G.GM_ADDON_NAME = "GameMaster UI System"

-- System initialization function
local function InitializeGameMasterSystem()
    -- Wait for all modules to load
    local frame = CreateFrame("Frame")
    local checkElapsed = 0
    local initStarted = false
    local initStartTime = 0

    frame:SetScript("OnUpdate", function(self, delta)
        checkElapsed = checkElapsed + delta
        if checkElapsed >= 0.1 then -- Check every 100ms
            -- Check if state machine is available
            local StateMachine = _G.GMStateMachine
            if StateMachine and not initStarted then
                -- Request initial data from server (these may not exist on server)
                AIO.Handle("GameMasterSystem", "requestGmLevel")
                AIO.Handle("GameMasterSystem", "requestCoreName")

                initStarted = true
                initStartTime = GetTime()
            end

            -- Fallback: If server doesn't respond within 3 seconds, initialize anyway
            if initStarted and StateMachine then
                local elapsed = GetTime() - initStartTime
                if elapsed > 3.0 and StateMachine.getCurrentState() == "INITIALIZING" then
                    -- Set default values
                    local GMData = _G.GMData
                    if GMData then
                        GMData.PlayerGMLevel = GMData.PlayerGMLevel or 3 -- Default GM level
                        GMData.CoreName = GMData.CoreName or "Unknown" -- Default core name
                        GMData.isGmLevelFetched = true
                        GMData.isCoreNameFetched = true
                    end

                    -- Force transition to IDLE
                    StateMachine.initialize()

                    -- Stop the update timer
                    self:SetScript("OnUpdate", nil)
                end
            end

            if checkElapsed > 10.0 then -- Stop trying after 10 seconds total
                if StateMachine and StateMachine.getCurrentState() == "INITIALIZING" then
                    StateMachine.initialize()
                end
                self:SetScript("OnUpdate", nil)
            end
        end
    end)
end

-- Initialize when this module loads
InitializeGameMasterSystem()

-- Main namespace initialized