local AIO = AIO or require("AIO")

if AIO.AddAddon() then
    return  -- Exit if on server
end

-- Use existing namespace
local GameMasterSystem = _G.GameMasterSystem
if not GameMasterSystem then
    print("[GameMasterSystem] ERROR: Namespace not found in CoreHandlers! Check load order.")
    return
end

-- Access shared data and UI references
local GMData = _G.GMData
local GMUI = _G.GMUI
local GMConfig = _G.GMConfig

if not GMData then
    print("[GameMasterSystem] ERROR: GMData not found! Check load order.")
    return
end

-- ============================================================================
-- Core System Handlers
-- ============================================================================

-- Show toast notification
function GameMasterSystem.ShowToast(player, message, messageType)
    if not message then return end

    messageType = messageType or "info"

    -- Map message types to durations
    local durations = {
        error = 5,      -- Errors need more time to read
        warning = 5,    -- Warnings need more time to read
        success = 2,    -- Quick success feedback
        info = 3        -- Standard duration
    }

    local duration = durations[messageType] or 3

    -- Display toast at top center
    CreateStyledToast(message, duration, 0.5, "TOP")
end

-- Finalize UI pattern for cross-file dependencies
function GameMasterSystem.FinalizeHandlers()
    -- This function can be called after all modules are loaded
    -- to ensure any cross-file dependencies are resolved

    -- Check if main UI is created and needs initial data
    if GMUI.mainFrame and not GMData.initialDataLoaded then
        -- Request initial data from server
        -- Requesting initial data from server
        AIO.Handle("GameMasterSystem", "requestInitialData")

        -- Request server capabilities
        AIO.Handle("GameMasterSystem", "getServerCapabilities")

        GMData.initialDataLoaded = true
    end
end

-- Debug message
if GMConfig and GMConfig.config and GMConfig.config.debug then
    print("[GameMasterSystem] Core handlers module loaded")
end