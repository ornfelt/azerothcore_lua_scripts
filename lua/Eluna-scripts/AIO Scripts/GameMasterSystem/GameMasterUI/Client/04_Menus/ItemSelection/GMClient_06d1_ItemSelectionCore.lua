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

local GMConfig = _G.GMConfig
local GMUtils = _G.GMUtils

-- Item Selection Coordinator Module
local ItemSelection = {}
GMMenus.ItemSelection = ItemSelection

-- Export submodules for internal use
ItemSelection.Modal = {}
ItemSelection.Cards = {}
ItemSelection.Filters = {}
ItemSelection.Actions = {}
ItemSelection.Mail = {}

-- Local state (shared by all submodules)
ItemSelection.state = {
    itemSelectionModal = nil,
    selectedItems = {},
    targetPlayerName = nil,
    currentItemData = {}
}

-- Helper function to get safe item icon (used by multiple modules)
function ItemSelection.GetItemIconSafe(itemId)
    local _, _, _, _, _, _, _, _, _, icon = GetItemInfo(itemId)
    return icon or "Interface\\Icons\\INV_Misc_QuestionMark"
end

-- Main exported functions

-- Request items from server
function ItemSelection.requestItemsForModal()
    local modal = ItemSelection.state.itemSelectionModal
    if not modal then return end
    
    local searchText = ""
    if modal.searchBox and modal.searchBox.editBox then
        searchText = modal.searchBox.editBox:GetText() or ""
    end
    local category = modal.currentCategory or "all"
    local qualities = modal.qualityFilters or {0, 1, 2, 3, 4, 5}
    
    -- Convert qualities array to comma-separated string for AIO
    local qualitiesStr = table.concat(qualities, ",")
    
    AIO.Handle("GameMasterSystem", "requestModalItems", searchText, category, qualitiesStr)
end

-- Update modal with item data
function ItemSelection.updateModalItems(items)
    -- Delegate to Actions module
    if ItemSelection.Actions.updateModalItems then
        ItemSelection.Actions.updateModalItems(items)
    end
end

-- Filter items by search text
function ItemSelection.filterItems(searchText)
    -- Delegate to Filters module
    if ItemSelection.Filters.filterItems then
        ItemSelection.Filters.filterItems(searchText)
    end
end

-- Filter by category
function ItemSelection.filterByCategory(category)
    -- Delegate to Filters module
    if ItemSelection.Filters.filterByCategory then
        ItemSelection.Filters.filterByCategory(category)
    end
end

-- Update quality filter
function ItemSelection.updateQualityFilter()
    -- Delegate to Filters module
    if ItemSelection.Filters.updateQualityFilter then
        ItemSelection.Filters.updateQualityFilter()
    end
end

-- Select/deselect item card
function ItemSelection.selectItemCard(card, itemData)
    -- Delegate to Actions module
    if ItemSelection.Actions.selectItemCard then
        ItemSelection.Actions.selectItemCard(card, itemData)
    end
end

-- Unselect all items
function ItemSelection.unselectAllItems()
    -- Delegate to Actions module
    if ItemSelection.Actions.unselectAllItems then
        ItemSelection.Actions.unselectAllItems()
    end
end

-- Select all visible items
function ItemSelection.selectAllItems()
    -- Delegate to Actions module
    if ItemSelection.Actions.selectAllItems then
        ItemSelection.Actions.selectAllItems()
    end
end

-- Confirm giving items
function ItemSelection.confirmGiveItems()
    -- Delegate to Actions module
    if ItemSelection.Actions.confirmGiveItems then
        ItemSelection.Actions.confirmGiveItems()
    end
end

-- Single selection for mail
function ItemSelection.selectItemCardForMail(card, itemData)
    -- Delegate to Mail module
    if ItemSelection.Mail.selectItemCardForMail then
        ItemSelection.Mail.selectItemCardForMail(card, itemData)
    end
end

-- Confirm attach items for mail
function ItemSelection.confirmAttachItems()
    -- Delegate to Mail module
    if ItemSelection.Mail.confirmAttachItems then
        ItemSelection.Mail.confirmAttachItems()
    end
end

-- Confirm selected item for mail attachment
function ItemSelection.confirmSelectItem()
    -- Delegate to Mail module
    if ItemSelection.Mail.confirmSelectItem then
        ItemSelection.Mail.confirmSelectItem()
    end
end

-- Export update function for server responses
GMMenus.updateModalItems = function(items)
    if ItemSelection.updateModalItems then
        ItemSelection.updateModalItems(items)
    end
end