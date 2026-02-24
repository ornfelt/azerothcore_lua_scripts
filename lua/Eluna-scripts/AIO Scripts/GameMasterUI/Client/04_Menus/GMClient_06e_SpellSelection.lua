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
-- SPELL SELECTION MODULE COORDINATOR
-- The SpellSelection submodules are automatically loaded by AIO because they have
-- "GMClient" prefix in their filenames:
--   - GMClient_06e1_SpellSelectionCore.lua
--   - GMClient_06e2_SpellSearch.lua
--   - GMClient_06e3_SpellDialog.lua
--   - GMClient_06e4_SpellRows.lua
--   - GMClient_06e5_SpellContextMenu.lua
--   - GMClient_06e6_SpellDuration.lua
-- ================================================================================

-- This file now serves as a coordinator/documentation file
-- print("[GMMenus] SpellSelection module coordinator loaded")