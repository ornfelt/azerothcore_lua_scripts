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
local Cards = ItemSelection.Cards

-- Quality name mapping
local qualityNames = {
    [0] = "Poor",
    [1] = "Common", 
    [2] = "Uncommon",
    [3] = "Rare",
    [4] = "Epic",
    [5] = "Legendary",
    [6] = "Artifact",
    [7] = "Heirloom"
}

-- Helper function to create item cards in the modal
function Cards.createModalItemCard(parent, itemData, index)
    local state = ItemSelection.state
    
    -- Convert numeric quality to string
    local qualityName = qualityNames[itemData.quality] or "Common"
    
    local card = CreateStyledCard(parent, 64, {
        texture = ItemSelection.GetItemIconSafe(itemData.entry),
        count = 1,
        quality = qualityName,
        link = itemData.link,
        onClick = function(self)
            -- Check if we're in mail selection mode
            local modal = state.itemSelectionModal
            if modal and modal.callback and not modal.isMultiSelect then
                ItemSelection.selectItemCardForMail(self, itemData)
            else
                ItemSelection.selectItemCard(self, itemData)
            end
        end
    })
    
    -- Position in grid (10 columns)
    local col = (index - 1) % 10
    local row = math.floor((index - 1) / 10)
    -- Calculate centered position
    card:SetPoint("TOPLEFT", parent, "TOPLEFT", 70 + (col * 70), -10 - (row * 70))
    
    -- Add selection overlay
    card.selectionOverlay = card:CreateTexture(nil, "OVERLAY")
    card.selectionOverlay:SetTexture("Interface\\Buttons\\CheckButtonHilight")
    card.selectionOverlay:SetBlendMode("ADD")
    card.selectionOverlay:SetAlpha(0.3)
    card.selectionOverlay:SetAllPoints()
    card.selectionOverlay:Hide()
    
    card.itemData = itemData
    card.isSelected = false
    
    return card
end

-- Export the function to ItemSelection namespace
ItemSelection.createModalItemCard = Cards.createModalItemCard