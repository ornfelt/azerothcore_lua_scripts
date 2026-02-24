local AIO = AIO or require("AIO")

if AIO.AddAddon() then
    return -- Exit if on server
end

-- Get module references
local GMMenus = _G.GMMenus
if not GMMenus or not GMMenus.ItemSelection then
    print("[ERROR] ItemSelection module not found! Check load order.")
    return
end

local ItemSelection = GMMenus.ItemSelection
local Filters = ItemSelection.Filters

-- Filter items by search text
function Filters.filterItems(searchText)
    -- Request filtered data from server
    ItemSelection.requestItemsForModal()
end

-- Filter by category
function Filters.filterByCategory(category)
    local state = ItemSelection.state
    local modal = state.itemSelectionModal
    if modal then
        modal.currentCategory = category
        ItemSelection.requestItemsForModal()
    end
end

-- Update quality filter
function Filters.updateQualityFilter()
    local state = ItemSelection.state
    local modal = state.itemSelectionModal
    if not modal then return end
    
    local qualityFilters = {}
    if modal.qualityToggles then
        for i, toggle in ipairs(modal.qualityToggles) do
            if toggle:GetChecked() then
                table.insert(qualityFilters, toggle.qualityIndex)
            end
        end
    end
    modal.qualityFilters = qualityFilters
    
    ItemSelection.requestItemsForModal()
end