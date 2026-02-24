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
local Mail = ItemSelection.Mail

-- Single selection for mail
function Mail.selectItemCardForMail(card, itemData)
    local state = ItemSelection.state
    local modal = state.itemSelectionModal
    if not modal then return end
    
    -- Clear all previous selections
    if modal.itemCards then
        for _, c in ipairs(modal.itemCards) do
            if c.isSelected then
                c.isSelected = false
                c.selectionOverlay:Hide()
            end
        end
    end
    wipe(state.selectedItems)
    
    -- Select this item
    card.isSelected = true
    card.selectionOverlay:Show()
    state.selectedItems[itemData.entry] = {
        entry = itemData.entry,
        name = itemData.name,
        icon = ItemSelection.GetItemIconSafe(itemData.entry),
        quality = itemData.quality,
        maxStack = itemData.maxStack or 20
    }
    
    -- Update selected info
    if modal.selectedInfo then
        modal.selectedInfo:SetText("Selected: " .. itemData.name)
        modal.selectedInfo:SetTextColor(1, 1, 1)
    end
    
    if modal.selectedLabel then
        modal.selectedLabel:SetText("Selected: " .. itemData.name)
    end
end

-- Confirm attach items for mail
function Mail.confirmAttachItems()
    local state = ItemSelection.state
    local modal = state.itemSelectionModal
    if not modal then return end
    
    -- Get selected items
    local itemList = {}
    local count = 0
    
    -- Get quantity from slider
    local quantity = modal.currentQuantity or 1
    if modal.quantitySlider and modal.quantitySlider.slider then
        quantity = modal.quantitySlider.slider:GetValue() or 1
    end
    
    for _, itemData in pairs(state.selectedItems) do
        if count < (modal.maxItems or 12) then
            -- Add the quantity to each item
            local itemWithQty = {}
            for k, v in pairs(itemData) do
                itemWithQty[k] = v
            end
            itemWithQty.count = quantity
            table.insert(itemList, itemWithQty)
            count = count + 1
        end
    end
    
    if modal.callback and count > 0 then
        modal.callback(itemList)
    end
    
    -- Close modal
    modal:Hide()
end

-- Confirm selected item for mail attachment
function Mail.confirmSelectItem()
    local state = ItemSelection.state
    local modal = state.itemSelectionModal
    if not modal then return end
    
    -- Get the first (and only) selected item
    local selectedItem = nil
    for _, itemData in pairs(state.selectedItems) do
        selectedItem = itemData
        break
    end
    
    if selectedItem and modal.callback then
        -- Call the callback with the selected item
        modal.callback(selectedItem)
    end
    
    -- Close modal
    modal:Hide()
end