local AIO = AIO or require("AIO")
if AIO.AddAddon() then return end

local DC = DeathChestUI

-- Item type → category mapping
local TYPE_TO_CATEGORY = {
    ["Armor"]       = "Equipment",
    ["Weapon"]      = "Equipment",
    ["Consumable"]  = "Consumable",
    ["Trade Goods"] = "TradeGoods",
    ["Reagent"]     = "TradeGoods",
    ["Quest"]       = "Quest",
}

-- Category definitions for UI display
DeathChestUI.CATEGORIES = {
    { id = "All",        label = "All" },
    { id = "Equipment",  label = "Equipment" },
    { id = "Consumable", label = "Consumables" },
    { id = "TradeGoods", label = "Trade Goods" },
    { id = "Quest",      label = "Quest" },
    { id = "Other",      label = "Other" },
}

-- Map a WoW itemType string to a category ID
function DeathChestUI.GetItemCategory(itemType)
    if not itemType then return "Other" end
    return TYPE_TO_CATEGORY[itemType] or "Other"
end

-- Process raw server data: separate gold, store items, then filter and display
function DeathChestUI.StoreAndDisplay(itemData)
    local state = DC.state
    state.rawItems = {}
    state.goldAmount = 0
    state.goldDbId = 0

    for _, item in ipairs(itemData) do
        if item.entry == 0 then
            state.goldAmount = state.goldAmount + item.count
            state.goldDbId = item.id
        else
            state.rawItems[#state.rawItems + 1] = item
        end
    end

    DC.UpdateGoldDisplay()
    DC.ApplyFilters()
    if DC.UpdateQuickTakeButtons then DC.UpdateQuickTakeButtons() end
end

-- Apply active filter + search to rawItems, then populate the display
function DeathChestUI.ApplyFilters()
    local state = DC.state
    local results = {}
    local searchLower = state.searchText ~= "" and state.searchText:lower() or ""

    for _, item in ipairs(state.rawItems) do
        local name, _, _, _, _, itemType = GetItemInfo(item.entry)
        local category = DC.GetItemCategory(itemType)

        local matchesFilter = (state.activeFilter == "All")
            or (category == state.activeFilter)
        local matchesSearch = (searchLower == "")
            or (name and name:lower():find(searchLower, 1, true))

        if matchesFilter and matchesSearch then
            results[#results + 1] = item
        end
    end

    state.displayItems = results
    DC.PopulateItems(results)
    if DC.UpdateItemCount then DC.UpdateItemCount() end
end

-- Collect DB row IDs for all raw items matching a category (for TakeMultiple)
function DeathChestUI.CollectIdsByCategory(categoryId)
    local ids = {}
    for _, item in ipairs(DC.state.rawItems) do
        if item.entry ~= 0 then
            local _, _, _, _, _, itemType = GetItemInfo(item.entry)
            if DC.GetItemCategory(itemType) == categoryId then
                ids[#ids + 1] = item.id
            end
        end
    end
    return ids
end
