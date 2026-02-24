-- ================================================================================
-- INVENTORY CONTEXT MENU MODULE LOADER
-- This file verifies that the modularized context menu components are loaded
-- The actual implementations are in separate files with the same prefix (07c)
-- ================================================================================

local AIO = AIO or require("AIO")

if AIO.AddAddon() then
    return -- Exit if on server
end

-- Get module references
local PlayerInventory = _G.PlayerInventory
if not PlayerInventory then
    print("[ERROR] PlayerInventory namespace not found! Check load order.")
    return
end

local GameMasterSystem = _G.GameMasterSystem
local GMConfig = _G.GMConfig

-- ================================================================================
-- CONTEXT MENU MODULE VERIFICATION
-- The context menu implementation is split into multiple files that load alphabetically:
-- - GMClient_07c1_ContextMenuCore.lua - Core functions and helpers
-- - GMClient_07c2_ItemContextMenu.lua - Item-specific context menu actions  
-- - GMClient_07c3_EnchantmentMenus.lua - Enchantment menu logic
-- - GMClient_07c4_EnchantmentData.lua - Enchantment data and categorization
-- These files load automatically after this file due to their naming
-- ================================================================================

-- ================================================================================
-- MODULE VERIFICATION
-- Check that the expected functions have been loaded from the modules
-- ================================================================================

local function VerifyModulesLoaded()
    local requiredFunctions = {
        -- From ContextMenuCore
        "CreateInputDialog",
        "closeContextMenu",
        "showContextMenuWithSmartPositioning",
        
        -- From ItemContextMenu
        "showEmptySlotContextMenu",
        "showItemContextMenu",
        "showAddItemByIdDialog",
        
        -- From EnchantmentMenus
        "createEnchantmentMenu",
        "createPopularEnchantsNestedMenu",
        "showEnchantSearchDialog",
        "filterEnchantSearchResults",
        "populateEnchantSearchResults",
        "showBatchEnchantSelectionDialog",
        "showCustomBatchEnchantDialog",
        "showScrollablePopularEnchantsMenu",
        
        -- From EnchantmentData
        "determineItemSlotTypeForMenu",
        "getEnchantCategoriesForItem",
        "getRecentlyUsedEnchants",
        "getPopularEnchantsForSlot",
        "getEnchantIcon",
        "getGenericEnchantIcon"
    }
    
    local allLoaded = true
    for _, funcName in ipairs(requiredFunctions) do
        if not PlayerInventory[funcName] then
            print(string.format("[ERROR] Context menu function not loaded: PlayerInventory.%s", funcName))
            allLoaded = false
        end
    end
    
    if allLoaded and GMConfig and GMConfig.config and GMConfig.config.debug then
        print("[PlayerInventory] All context menu modules loaded successfully")
    end
    
    return allLoaded
end

-- Run verification after a small delay to ensure all modules are loaded
-- Using OnUpdate for 3.3.5 compatibility (no C_Timer)
local verifyFrame = CreateFrame("Frame")
local verifyElapsed = 0
verifyFrame:SetScript("OnUpdate", function(self, delta)
    verifyElapsed = verifyElapsed + delta
    if verifyElapsed >= 0.1 then
        VerifyModulesLoaded()
        self:SetScript("OnUpdate", nil)
    end
end)

-- ================================================================================
-- VERIFICATION THAT STUBS EXIST
-- The stubs are now created in GMClient_07a_InventoryCore.lua for earliest availability
-- This section just verifies they exist and will be replaced by real implementations
-- ================================================================================

-- Verify stubs exist (they should have been created in InventoryCore)
if not PlayerInventory.closeContextMenu then
    print("[ERROR] closeContextMenu stub was not created in InventoryCore!")
    -- Emergency fallback
    PlayerInventory.closeContextMenu = function() end
end

if not PlayerInventory.showItemContextMenu then
    print("[ERROR] showItemContextMenu stub was not created in InventoryCore!")
    -- Emergency fallback
    PlayerInventory.showItemContextMenu = function() end
end

if not PlayerInventory.showEmptySlotContextMenu then
    print("[ERROR] showEmptySlotContextMenu stub was not created in InventoryCore!")
    -- Emergency fallback
    PlayerInventory.showEmptySlotContextMenu = function() end
end

-- Check after a delay if real implementations loaded successfully
-- Using OnUpdate for 3.3.5 compatibility (no C_Timer)
local checkFrame = CreateFrame("Frame")
local checkElapsed = 0
checkFrame:SetScript("OnUpdate", function(self, delta)
    checkElapsed = checkElapsed + delta
    if checkElapsed >= 1.0 then
        local hasRealImplementation = false
        
        -- Check if we have the real implementations by looking for other expected functions
        if PlayerInventory.CreateInputDialog or PlayerInventory.showContextMenuWithSmartPositioning then
            hasRealImplementation = true
        end
        
        if not hasRealImplementation and GMConfig and GMConfig.config and GMConfig.config.debug then
            print("[WARNING] Context menu modules may not have loaded completely - using stub implementations")
        end
        
        self:SetScript("OnUpdate", nil)
    end
end)

-- Debug message
if GMConfig and GMConfig.config and GMConfig.config.debug then
    print("[PlayerInventory] Context menu module loader initialized")
end