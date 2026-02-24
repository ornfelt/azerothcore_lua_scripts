local AIO = AIO or require("AIO")

if AIO.AddAddon() then
    return  -- Exit if on server
end

-- Use existing namespace
local GameMasterSystem = _G.GameMasterSystem
if not GameMasterSystem then
    print("[GameMasterSystem] ERROR: Namespace not found in ErrorHandlers! Check load order.")
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
-- Error Handling Functions
-- ============================================================================

-- Error handler for pagination errors
function GameMasterSystem.handlePaginationError(player, message)
    -- Check if this is a "no more data" error
    if message and (message:find("No tab") or message:find("data found")) then
        -- Set hasMoreData to false to prevent further scrolling
        GMData.hasMoreData = false
        
        -- Optionally show a subtle notification (commented out to avoid spam)
        -- print("You've reached the end of the data.")
        
        -- Update UI to reflect end of data
        if GMUI and GMUI.updateContentForActiveTab then
            GMUI.updateContentForActiveTab()
        end
    end
end

-- Generic error handler
function GameMasterSystem.handleError(player, errorType, message)
    if errorType == "pagination" then
        GameMasterSystem.handlePaginationError(player, message)
    else
        -- Handle other error types as needed
        if GMConfig and GMConfig.config and GMConfig.config.debug then
            print("[GameMasterUI Error]", errorType, message)
        end
    end
end

-- Debug message
if GMConfig and GMConfig.config and GMConfig.config.debug then
    print("[GameMasterSystem] Error handlers module loaded")
end