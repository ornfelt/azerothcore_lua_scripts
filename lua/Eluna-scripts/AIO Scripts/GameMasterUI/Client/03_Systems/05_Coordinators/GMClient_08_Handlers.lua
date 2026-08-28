local AIO = AIO or require("AIO")

if AIO.AddAddon() then
    return  -- Exit if on server
end

-- Use existing namespace
if not GM_RequireNamespace() then return end
local GameMasterSystem = _G.GameMasterSystem

-- Access shared data and UI references
local GMData = _G.GMData
local GMUI = _G.GMUI

if not GMData then
    print("[GameMasterSystem] ERROR: GMData not found! Check load order.")
    return
end

-- ================================================================================
-- MODULE VERIFICATION
-- Check that the expected functions have been loaded from the handler modules
-- (DataHandlers, DialogHandlers, MailDialog, DatabaseErrorDialog, etc.)
-- ================================================================================

-- Using OnUpdate for 3.3.5 compatibility (no C_Timer)
local verifyHandlersFrame = CreateFrame("Frame")
local verifyHandlersElapsed = 0
verifyHandlersFrame:SetScript("OnUpdate", function(self, delta)
    verifyHandlersElapsed = verifyHandlersElapsed + delta
    if verifyHandlersElapsed >= 0.1 then
        local requiredFunctions = {
            -- From DataReceiveHandlers
            "receiveItemData",
            "receiveNPCData",
            "receiveGameObjectData",
            "receiveSpellData",
            "receiveSpellVisualData",
            "receiveGmLevel",
            "receiveCoreName",
            "receiveModalItemData",
            "receiveSpellSearchResults",
            "receiveServerCapabilities",

            -- From DialogHandlers
            "ShowGiveGoldDialog",
            "ShowBanDialog",

            -- From MailHandlers
            "OpenMailDialog",

            -- From ErrorHandlers
            "handlePaginationError",
            "handleError",

            -- From DataHandlers (GMClient_08a)
            "FinalizeHandlers",
            "ShowToast"
        }
        
        local allLoaded = true
        for _, funcName in ipairs(requiredFunctions) do
            if not GameMasterSystem[funcName] then
                print(string.format("[ERROR] Handler function not loaded: GameMasterSystem.%s", funcName))
                allLoaded = false
            end
        end
        
        local GMConfig = _G.GMConfig
        if allLoaded and GMConfig and GMConfig.config and GMConfig.config.debug then
            print("[GameMasterSystem] All handler modules loaded successfully")
        end
        
        self:SetScript("OnUpdate", nil)
    end
end)

-- Debug message
local GMConfig = _G.GMConfig
if GMConfig and GMConfig.config and GMConfig.config.debug then
    print("[GameMasterSystem] Handler module loader initialized")
end