local AIO = AIO or require("AIO")

if AIO.AddAddon() then
    return -- Exit if on server
end

-- Get the shared namespace
local GameMasterSystem = _G.GameMasterSystem
if not GameMasterSystem then
    print("[ERROR] GameMasterSystem namespace not found! Check load order.")
    return
end

-- Get module references
local GMMenus = _G.GMMenus
if not GMMenus then
    print("[ERROR] GMMenus not found! Check load order.")
    return
end

-- ================================================================================
-- ITEM SELECTION MODULE COORDINATOR
-- The ItemSelection submodules are automatically loaded by AIO because they have
-- "GMClient" prefix in their filenames:
--   - GMClient_06d1_ItemSelectionCore.lua
--   - GMClient_06d2_ItemModal.lua
--   - GMClient_06d3_ItemCards.lua
--   - GMClient_06d4_ItemFilters.lua
--   - GMClient_06d5_ItemActions.lua
--   - GMClient_06d6_MailIntegration.lua
-- ================================================================================

-- This file now serves as a coordinator/documentation file
-- print("[GMMenus] ItemSelection module coordinator loaded")