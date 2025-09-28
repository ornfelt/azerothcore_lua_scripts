local AIO = AIO or require("AIO")

if AIO.AddAddon() then
    return  -- Exit if on server
end

-- Use existing namespace
local GameMasterSystem = _G.GameMasterSystem
if not GameMasterSystem then
    print("[GameMasterSystem] ERROR: Namespace not found in Handlers! Check load order.")
    return
end

-- Access shared data and UI references
local GMData = _G.GMData
local GMUI = _G.GMUI

if not GMData then
    print("[GameMasterSystem] ERROR: GMData not found! Check load order.")
    return
end

-- ================================================================================
-- HANDLER MODULE COORDINATOR
-- The handler submodules from the Handlers subdirectory are automatically loaded
-- by AIO because they have "Client" in their filenames.
-- The original 1,760 line file has been split into manageable modules:
--   - DataReceiveHandlersClient.lua  -- Data reception handlers (~280 lines)
--   - DialogHandlersClient.lua       -- Dialog handlers (~400 lines)  
--   - MailHandlersClient.lua         -- Mail system handlers (~830 lines)
--   - ErrorHandlersClient.lua        -- Error handling (~30 lines)
--   - CoreHandlersClient.lua         -- Core system handlers (~60 lines)
-- ================================================================================

-- ================================================================================
-- MODULE VERIFICATION
-- Check that the expected functions have been loaded from the modules
-- ================================================================================

-- Using OnUpdate for 3.3.5 compatibility (no C_Timer)
local verifyHandlersFrame = CreateFrame("Frame")
local verifyHandlersElapsed = 0
verifyHandlersFrame:SetScript("OnUpdate", function(self, delta)
    verifyHandlersElapsed = verifyHandlersElapsed + delta
    if verifyHandlersElapsed >= 0.1 then
        local requiredFunctions = {
            -- From DataReceiveHandlers
            "testPing",
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
            
            -- From CoreHandlers
            "FinalizeHandlers"
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