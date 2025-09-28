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
local GMUtils = _G.GMUtils

-- Create inventory slot using proper UIStyleLibrary
function PlayerInventory.createInventorySlot(parent, slotData, isEquipment)
    local INVENTORY_CONFIG = PlayerInventory.INVENTORY_CONFIG
    local ENCHANT_NAMES = PlayerInventory.ENCHANT_NAMES
    
    -- Prepare initial card data
    local cardData = {
        texture = "Interface\\PaperDoll\\UI-Backpack-EmptySlot",
        count = 0,
        quality = "Common",
        link = nil,
        onClick = function(self, button)
            if button == "LeftButton" then
                -- Could implement item linking or inspection
                if GMConfig.config.debug then
                    print("[PlayerInventory] Left clicked slot with item:", self.itemData and self.itemData.entry or "empty")
                end
            elseif button == "RightButton" then
                -- Show context menu for both filled and empty slots
                if self.itemData then
                    if self.itemData.entry and self.itemData.entry > 0 then
                        -- Show regular item context menu for filled slots
                        if PlayerInventory.showItemContextMenu then
                            PlayerInventory.showItemContextMenu(self, self.itemData, isEquipment)
                        else
                            -- Function not loaded yet - provide a message
                            if GMConfig and GMConfig.config and GMConfig.config.debug then
                                print("[PlayerInventory] Context menu not yet loaded")
                            end
                        end
                    else
                        -- Show empty slot context menu
                        if PlayerInventory.showEmptySlotContextMenu then
                            PlayerInventory.showEmptySlotContextMenu(self, isEquipment)
                        else
                            if GMConfig and GMConfig.config and GMConfig.config.debug then
                                print("[PlayerInventory] Context menu not yet loaded")
                            end
                        end
                    end
                end
            end
        end
    }
    
    -- Create the card using UIStyleLibrary
    local slot = CreateStyledCard(parent, INVENTORY_CONFIG.SLOT_SIZE, cardData)
    
    -- Ensure the slot renders above the content frame
    slot:SetFrameLevel(parent:GetFrameLevel() + 2)
    
    -- Store item data reference
    slot.itemData = slotData
    slot.bagId = slotData and slotData.bag or nil
    slot.slotId = slotData and slotData.slot or nil
    slot.isEquipment = isEquipment
    
    -- Debug: Ensure bag and slot are preserved in itemData
    if slotData and not isEquipment then
        -- Make sure bag and slot fields are present in itemData
        if slotData.bag and slotData.slot then
            if GMConfig.config.debug then
                print(string.format("[PlayerInventory] Slot data includes bag=%d, slot=%d for item: %s", 
                    slotData.bag, slotData.slot, slotData.name or "empty"))
            end
        else
            -- This shouldn't happen but let's handle it
            print(string.format("[WARNING] Missing bag/slot in itemData for item: %s", slotData.name or "unknown"))
        end
    end
    
    -- Store the original onClick handler
    slot.originalOnClick = cardData.onClick
    
    -- Add error flash animation function
    slot.FlashError = function(self)
        -- Create a red overlay for error indication
        if not self.errorOverlay then
            self.errorOverlay = self:CreateTexture(nil, "OVERLAY")
            self.errorOverlay:SetAllPoints()
            self.errorOverlay:SetTexture("Interface\\Buttons\\WHITE8X8")
            self.errorOverlay:SetVertexColor(1, 0, 0, 0.3)
            self.errorOverlay:Hide()
        end
        
        -- Flash the error overlay
        self.errorOverlay:Show()
        self.errorOverlay:SetAlpha(0.5)
        
        -- Fade out animation using animation group
        if not self.errorFadeAnim then
            self.errorFadeAnim = self.errorOverlay:CreateAnimationGroup()
            local fade = self.errorFadeAnim:CreateAnimation("Alpha")
            fade:SetFromAlpha(0.5)
            fade:SetToAlpha(0)
            fade:SetDuration(1.0)
            fade:SetStartDelay(0)
            self.errorFadeAnim:SetScript("OnFinished", function()
                self.errorOverlay:Hide()
            end)
        end
        self.errorFadeAnim:Stop()
        self.errorFadeAnim:Play()
    end
    
    -- Update slot with item data using card's built-in Update method
    function slot:UpdateSlot(itemData)
        -- Clean up any existing animations before updating
        PlayerInventory.cleanupEnchantAnimation(self)
        
        -- Clean up cache indicators
        if self.cacheIndicator then
            self.cacheIndicator:Hide()
        end
        if self.cachePulse then
            self.cachePulse:Stop()
        end
        self.hasCacheIssue = false
        
        -- Store the data for reference
        self.itemData = itemData
        
        if itemData and itemData.entry and itemData.entry > 0 then
            -- Get item info
            local itemName, _, itemQuality, itemLevel, itemMinLevel, itemType, itemSubType, 
                  itemStackCount, itemEquipLoc, itemTexture = GetItemInfo(itemData.entry)
            
            -- Create item link with enchantment if present (WoW 3.3.5 format)
            local enchantId = itemData.enchantId or 0
            -- Format: item:itemId:enchantId:gem1:gem2:gem3:gem4:suffixId:uniqueId:level
            local itemLink = string.format("item:%d:%d:0:0:0:0:0:0:80", itemData.entry, enchantId)
            
            -- Debug print for enchantment data
            if GMConfig.config.debug and enchantId > 0 then
                print(string.format("[PlayerInventory] UpdateSlot: Item %s (ID: %d) has enchantId: %d", 
                    itemName or "Unknown", itemData.entry, enchantId))
            end
            
            if itemTexture then
                -- Convert numeric quality to string
                local qualityNames = {"Poor", "Common", "Uncommon", "Rare", "Epic", "Legendary"}
                local qualityString = qualityNames[itemQuality + 1] or "Common"
                
                -- Add visual indicator for enchanted items
                local isEnchanted = enchantId and enchantId > 0
                if isEnchanted then
                    -- Always show at least Uncommon (green) quality for enchanted items
                    -- This ensures enchanted items are visually distinct
                    if itemQuality < 2 then  -- If Poor (0) or Common (1)
                        qualityString = "Uncommon"  -- Force green border
                    end
                    
                    -- Debug: log enchantment visual update
                    if GMConfig.config.debug then
                        print(string.format("[PlayerInventory] Item %s is enchanted, quality: %s", 
                            itemName or "Unknown", qualityString))
                    end
                end
                
                -- Prepare card data for update, preserving the onClick handler
                local updateData = {
                    texture = itemTexture,
                    count = (itemData.count and itemData.count > 1) and itemData.count or nil,
                    quality = qualityString,
                    link = itemLink,
                    name = itemName,
                    level = itemLevel,
                    onClick = self.originalOnClick  -- Preserve the original onClick handler
                }
                
                -- Use the card's built-in Update method
                self:Update(updateData)
                
                -- Reset alpha to full for filled slots
                self:SetAlpha(1.0)
                
                -- Set custom tooltip for inventory items
                self:SetScript("OnEnter", function(frame)
                    GameTooltip:SetOwner(frame, "ANCHOR_RIGHT")
                    if itemLink then
                        GameTooltip:SetHyperlink(itemLink)
                        -- Add prominent enchantment indicator
                        if isEnchanted then
                            GameTooltip:AddLine(" ")  -- Add spacing
                            local enchantName = ENCHANT_NAMES[enchantId] or string.format("Enchant ID: %d", enchantId)
                            GameTooltip:AddLine("|cff00ff00✦ Enchanted ✦|r", 0, 1, 0)
                            GameTooltip:AddLine(string.format("|cff00ff00%s|r", enchantName), 0, 0.8, 0)
                        end
                    else
                        GameTooltip:SetText(itemName or "Unknown Item")
                        if itemLevel and itemLevel > 0 then
                            GameTooltip:AddLine("Item Level: " .. itemLevel, 1, 1, 1)
                        end
                        if itemData.count and itemData.count > 1 then
                            GameTooltip:AddLine("Count: " .. itemData.count, 0.7, 0.7, 0.7)
                        end
                        if isEnchanted then
                            GameTooltip:AddLine(" ")  -- Add spacing
                            local enchantName = ENCHANT_NAMES[enchantId] or string.format("Enchant ID: %d", enchantId)
                            GameTooltip:AddLine("|cff00ff00✦ Enchanted ✦|r", 0, 1, 0)
                            GameTooltip:AddLine(string.format("|cff00ff00%s|r", enchantName), 0, 0.8, 0)
                        end
                    end
                    GameTooltip:Show()
                end)
                
                self:SetScript("OnLeave", function(frame)
                    GameTooltip:Hide()
                    -- Keep full alpha for filled slots
                    frame:SetAlpha(1.0)
                end)
            else
                -- Item not in client cache - create cache miss indicator
                -- Mark this slot as having a cache issue
                self.hasCacheIssue = true
                
                -- Track cache miss for status display
                if not PlayerInventory.cacheMissedItems then
                    PlayerInventory.cacheMissedItems = {}
                end
                PlayerInventory.cacheMissedItems[itemData.entry] = true
                
                -- Use server-provided name if available
                local displayName = itemData.name or string.format("Item #%d", itemData.entry)
                local displayQuality = itemData.quality or 1
                local qualityNames = {"Poor", "Common", "Uncommon", "Rare", "Epic", "Legendary"}
                local qualityString = qualityNames[displayQuality + 1] or "Common"
                
                -- Use a loading icon for cache-missed items
                local fallbackTexture = "Interface\\Icons\\INV_Misc_QuestionMark"
                
                -- Apply enchantment visual if present
                local enchantId = itemData.enchantId or 0
                local isEnchanted = enchantId and enchantId > 0
                
                -- Force yellow/warning border for cache issues
                qualityString = "Rare"  -- Yellow border to indicate cache issue
                
                local fallbackData = {
                    texture = fallbackTexture,
                    count = (itemData.count and itemData.count > 1) and itemData.count or nil,
                    quality = qualityString,
                    onClick = self.originalOnClick  -- Preserve the original onClick handler
                }
                self:Update(fallbackData)
                
                -- Reset alpha to full for filled slots (even if cache-missed)
                self:SetAlpha(1.0)
                
                -- Add cache indicator overlay
                if not self.cacheIndicator then
                    self.cacheIndicator = self:CreateTexture(nil, "OVERLAY")
                    self.cacheIndicator:SetSize(16, 16)
                    self.cacheIndicator:SetPoint("TOPLEFT", self, "TOPLEFT", 2, -2)
                    self.cacheIndicator:SetTexture("Interface\\DialogFrame\\UI-Dialog-Icon-AlertNew")
                end
                self.cacheIndicator:Show()
                
                -- Create pulsing animation for cache-missed items
                if not self.cachePulse then
                    self.cachePulse = self:CreateAnimationGroup()
                    local pulse = self.cachePulse:CreateAnimation("Alpha")
                    pulse:SetFromAlpha(0.5)
                    pulse:SetToAlpha(1.0)
                    pulse:SetDuration(1.0)
                    pulse:SetSmoothing("IN_OUT")
                    self.cachePulse:SetLooping("BOUNCE")
                end
                self.cachePulse:Play()
                
                -- Set detailed tooltip with cache information
                self:SetScript("OnEnter", function(frame)
                    GameTooltip:SetOwner(frame, "ANCHOR_RIGHT")
                    GameTooltip:SetText(displayName, 1, 1, 0)  -- Yellow name for cache issue
                    GameTooltip:AddLine(string.format("Item ID: %d", itemData.entry), 0.8, 0.8, 0.8)
                    if itemData.count and itemData.count > 1 then
                        GameTooltip:AddLine(string.format("Count: %d", itemData.count), 0.7, 0.7, 0.7)
                    end
                    if isEnchanted then
                        GameTooltip:AddLine(" ")
                        local enchantName = ENCHANT_NAMES[enchantId] or string.format("Enchant ID: %d", enchantId)
                        GameTooltip:AddLine("|cff00ff00✦ Enchanted ✦|r", 0, 1, 0)
                        GameTooltip:AddLine(string.format("|cff00ff00%s|r", enchantName), 0, 0.8, 0)
                    end
                    GameTooltip:AddLine(" ")
                    GameTooltip:AddLine("|cffffcc00⚠ Cache Issue|r", 1, 0.8, 0)
                    GameTooltip:AddLine("|cff808080This item is not in your client cache.|r", 0.5, 0.5, 0.5)
                    GameTooltip:AddLine("|cff808080The item exists but cannot be fully displayed.|r", 0.5, 0.5, 0.5)
                    GameTooltip:AddLine("|cff00ff00Tip: Link the item in chat to cache it.|r", 0, 1, 0)
                    GameTooltip:Show()
                end)
                self:SetScript("OnLeave", function(frame)
                    GameTooltip:Hide()
                    -- Keep full alpha for filled slots
                    frame:SetAlpha(1.0)
                end)
                
                -- Debug log for uncached items (only once, not repeatedly)
                if GMConfig.config.debug then
                    print(string.format("[PlayerInventory] Item %d not in client cache, showing cache indicator", 
                        itemData.entry))
                end
                
                -- Update cache status display if available
                if PlayerInventory.updateCacheStatus then
                    PlayerInventory.updateCacheStatus()
                end
            end
        else
            -- Empty slot - use appropriate texture based on slot type
            local emptyTexture = "Interface\\PaperDoll\\UI-Backpack-EmptySlot"
            if isEquipment and self.slotId then
                -- Use equipment-specific empty slot textures if available
                local equipmentEmptyTextures = {
                    [0] = "Interface\\PaperDoll\\UI-PaperDoll-Slot-Head",
                    [1] = "Interface\\PaperDoll\\UI-PaperDoll-Slot-Neck",
                    [2] = "Interface\\PaperDoll\\UI-PaperDoll-Slot-Shoulder",
                    [3] = "Interface\\PaperDoll\\UI-PaperDoll-Slot-Shirt",
                    [4] = "Interface\\PaperDoll\\UI-PaperDoll-Slot-Chest",
                    [5] = "Interface\\PaperDoll\\UI-PaperDoll-Slot-Waist",
                    [6] = "Interface\\PaperDoll\\UI-PaperDoll-Slot-Legs",
                    [7] = "Interface\\PaperDoll\\UI-PaperDoll-Slot-Feet",
                    [8] = "Interface\\PaperDoll\\UI-PaperDoll-Slot-Wrists",
                    [9] = "Interface\\PaperDoll\\UI-PaperDoll-Slot-Hands",
                    [10] = "Interface\\PaperDoll\\UI-PaperDoll-Slot-Finger",
                    [11] = "Interface\\PaperDoll\\UI-PaperDoll-Slot-Finger",
                    [12] = "Interface\\PaperDoll\\UI-PaperDoll-Slot-Trinket",
                    [13] = "Interface\\PaperDoll\\UI-PaperDoll-Slot-Trinket",
                    [14] = "Interface\\PaperDoll\\UI-PaperDoll-Slot-Chest",  -- Back uses chest texture
                    [15] = "Interface\\PaperDoll\\UI-PaperDoll-Slot-MainHand",
                    [16] = "Interface\\PaperDoll\\UI-PaperDoll-Slot-SecondaryHand",
                    [17] = "Interface\\PaperDoll\\UI-PaperDoll-Slot-Ranged",
                    [18] = "Interface\\PaperDoll\\UI-PaperDoll-Slot-Tabard",
                }
                emptyTexture = equipmentEmptyTextures[self.slotId] or emptyTexture
            end
            
            local emptyData = {
                texture = emptyTexture,
                count = nil,
                quality = "Common",
                onClick = self.originalOnClick  -- Preserve the original onClick handler
            }
            self:Update(emptyData)
            
            -- Set alpha to make empty slots slightly transparent
            self:SetAlpha(0.6)
            
            self:SetScript("OnEnter", function(frame)
                GameTooltip:SetOwner(frame, "ANCHOR_RIGHT")
                if isEquipment and self.slotId then
                    GameTooltip:SetText(INVENTORY_CONFIG.EQUIPMENT_SLOTS[self.slotId] or "Equipment Slot")
                    GameTooltip:AddLine("Empty", 0.5, 0.5, 0.5)
                else
                    GameTooltip:SetText("Empty Slot")
                    if self.bagId and self.slotId then
                        GameTooltip:AddLine(string.format("Bag %d, Slot %d", self.bagId, self.slotId + 1), 0.5, 0.5, 0.5)
                    end
                end
                GameTooltip:AddLine(" ")
                GameTooltip:AddLine("|cff00ff00Right-click to add item|r", 0, 1, 0)
                GameTooltip:Show()
                
                -- Highlight on hover
                frame:SetAlpha(1.0)
            end)
            self:SetScript("OnLeave", function(frame)
                GameTooltip:Hide()
                -- Return to dimmed state
                frame:SetAlpha(0.6)
            end)
        end
    end
    
    return slot
end

-- Create equipment panel with slot management
function PlayerInventory.createEquipmentPanel(parent)
    local INVENTORY_CONFIG = PlayerInventory.INVENTORY_CONFIG
    
    local equipPanel = CreateStyledFrame(parent, UISTYLE_COLORS.ContentBg)
    equipPanel:SetAllPoints()
    
    -- Create equipment slots in proper layout (centered in 900px modal)
    local equipmentLayout = {
        -- Left column (defensive items) - properly positioned
        {slotId = 0, x = 190, y = -20},    -- Head
        {slotId = 1, x = 190, y = -70},    -- Neck
        {slotId = 2, x = 190, y = -120},   -- Shoulder
        {slotId = 14, x = 190, y = -170},  -- Back
        {slotId = 4, x = 190, y = -220},   -- Chest
        {slotId = 3, x = 190, y = -270},   -- Shirt
        {slotId = 18, x = 190, y = -320},  -- Tabard
        {slotId = 8, x = 190, y = -370},   -- Wrists
        
        -- Center column (character stats will go here)
        
        -- Right column (offensive/utility items) - properly positioned
        {slotId = 9, x = 660, y = -20},   -- Hands
        {slotId = 5, x = 660, y = -70},   -- Belt
        {slotId = 6, x = 660, y = -120},  -- Legs
        {slotId = 7, x = 660, y = -170},  -- Feet
        {slotId = 10, x = 660, y = -220}, -- Ring 1
        {slotId = 11, x = 660, y = -270}, -- Ring 2
        {slotId = 12, x = 660, y = -320}, -- Trinket 1
        {slotId = 13, x = 660, y = -370}, -- Trinket 2
        
        -- Bottom row (weapons) - centered in frame
        {slotId = 15, x = 380, y = -430}, -- Main Hand
        {slotId = 16, x = 450, y = -430}, -- Off Hand
        {slotId = 17, x = 520, y = -430}, -- Ranged
    }
    
    equipPanel.slots = {}
    
    for _, layout in ipairs(equipmentLayout) do
        -- Create empty slot data for equipment slots
        local emptySlotData = {
            entry = 0,
            count = 0,
            name = nil
        }
        
        local slot = PlayerInventory.createInventorySlot(equipPanel, emptySlotData, true)
        slot:SetPoint("TOPLEFT", equipPanel, "TOPLEFT", layout.x, layout.y)
        slot.slotId = layout.slotId
        
        -- Add slot name label
        local label = slot:CreateFontString(nil, "OVERLAY", "GameFontNormalSmall")
        label:SetPoint("BOTTOM", slot, "TOP", 0, 2)
        label:SetText(INVENTORY_CONFIG.EQUIPMENT_SLOTS[layout.slotId] or "Unknown")
        label:SetTextColor(0.7, 0.7, 0.7)
        
        equipPanel.slots[layout.slotId] = slot
    end
    
    -- Create three stat panels: left (melee), center (basic), right (spell)
    
    -- LEFT PANEL: Melee Stats
    local meleeFrame = CreateStyledFrame(equipPanel, UISTYLE_COLORS.SectionBg)
    meleeFrame:SetSize(150, 380)
    meleeFrame:SetPoint("TOPLEFT", equipPanel, "TOPLEFT", 20, -20)
    
    -- Melee Stats Header
    local meleeHeader = meleeFrame:CreateFontString(nil, "OVERLAY", "GameFontNormal")
    meleeHeader:SetPoint("TOP", meleeFrame, "TOP", 0, -10)
    meleeHeader:SetText("Melee Stats")
    meleeHeader:SetTextColor(UISTYLE_COLORS.Gold[1], UISTYLE_COLORS.Gold[2], UISTYLE_COLORS.Gold[3])
    
    -- Separator
    local meleeSep1 = meleeFrame:CreateTexture(nil, "OVERLAY")
    meleeSep1:SetHeight(1)
    meleeSep1:SetWidth(130)
    meleeSep1:SetPoint("TOP", meleeHeader, "BOTTOM", 0, -5)
    meleeSep1:SetTexture("Interface\\Buttons\\WHITE8X8")
    meleeSep1:SetVertexColor(0.5, 0.5, 0.5, 0.5)
    
    -- Melee stat grid layout
    local meleeGridLeft = 10
    local meleeLabelWidth = 65
    local meleeValueOffset = 70
    local meleeStartY = -40
    local meleeLineHeight = 20
    
    -- Attack Power
    local apLabel = meleeFrame:CreateFontString(nil, "OVERLAY", "GameFontNormalSmall")
    apLabel:SetPoint("TOPLEFT", meleeFrame, "TOPLEFT", meleeGridLeft, meleeStartY)
    apLabel:SetText("Attack Power:")
    apLabel:SetTextColor(0.7, 0.7, 0.7)
    apLabel:SetJustifyH("LEFT")
    apLabel:SetWidth(meleeLabelWidth)
    
    local apValue = meleeFrame:CreateFontString(nil, "OVERLAY", "GameFontNormalSmall")
    apValue:SetPoint("TOPLEFT", meleeFrame, "TOPLEFT", meleeGridLeft + meleeValueOffset, meleeStartY)
    apValue:SetText("0")
    apValue:SetTextColor(1, 0.82, 0)
    apValue:SetJustifyH("LEFT")
    
    -- Melee Crit
    local critLabel = meleeFrame:CreateFontString(nil, "OVERLAY", "GameFontNormalSmall")
    critLabel:SetPoint("TOPLEFT", meleeFrame, "TOPLEFT", meleeGridLeft, meleeStartY - meleeLineHeight)
    critLabel:SetText("Critical:")
    critLabel:SetTextColor(0.7, 0.7, 0.7)
    critLabel:SetJustifyH("LEFT")
    critLabel:SetWidth(meleeLabelWidth)
    
    local critValue = meleeFrame:CreateFontString(nil, "OVERLAY", "GameFontNormalSmall")
    critValue:SetPoint("TOPLEFT", meleeFrame, "TOPLEFT", meleeGridLeft + meleeValueOffset, meleeStartY - meleeLineHeight)
    critValue:SetText("0%")
    critValue:SetTextColor(1, 0.82, 0)
    critValue:SetJustifyH("LEFT")
    
    -- Hit Rating
    local hitLabel = meleeFrame:CreateFontString(nil, "OVERLAY", "GameFontNormalSmall")
    hitLabel:SetPoint("TOPLEFT", meleeFrame, "TOPLEFT", meleeGridLeft, meleeStartY - meleeLineHeight * 2)
    hitLabel:SetText("Hit:")
    hitLabel:SetTextColor(0.7, 0.7, 0.7)
    hitLabel:SetJustifyH("LEFT")
    hitLabel:SetWidth(meleeLabelWidth)
    
    local hitValue = meleeFrame:CreateFontString(nil, "OVERLAY", "GameFontNormalSmall")
    hitValue:SetPoint("TOPLEFT", meleeFrame, "TOPLEFT", meleeGridLeft + meleeValueOffset, meleeStartY - meleeLineHeight * 2)
    hitValue:SetText("0%")
    hitValue:SetTextColor(1, 0.82, 0)
    hitValue:SetJustifyH("LEFT")
    
    -- Expertise
    local expLabel = meleeFrame:CreateFontString(nil, "OVERLAY", "GameFontNormalSmall")
    expLabel:SetPoint("TOPLEFT", meleeFrame, "TOPLEFT", meleeGridLeft, meleeStartY - meleeLineHeight * 3)
    expLabel:SetText("Expertise:")
    expLabel:SetTextColor(0.7, 0.7, 0.7)
    expLabel:SetJustifyH("LEFT")
    expLabel:SetWidth(meleeLabelWidth)
    
    local expValue = meleeFrame:CreateFontString(nil, "OVERLAY", "GameFontNormalSmall")
    expValue:SetPoint("TOPLEFT", meleeFrame, "TOPLEFT", meleeGridLeft + meleeValueOffset, meleeStartY - meleeLineHeight * 3)
    expValue:SetText("0")
    expValue:SetTextColor(1, 0.82, 0)
    expValue:SetJustifyH("LEFT")
    
    -- Haste
    local hasteLabel = meleeFrame:CreateFontString(nil, "OVERLAY", "GameFontNormalSmall")
    hasteLabel:SetPoint("TOPLEFT", meleeFrame, "TOPLEFT", meleeGridLeft, meleeStartY - meleeLineHeight * 4)
    hasteLabel:SetText("Haste:")
    hasteLabel:SetTextColor(0.7, 0.7, 0.7)
    hasteLabel:SetJustifyH("LEFT")
    hasteLabel:SetWidth(meleeLabelWidth)
    
    local hasteValue = meleeFrame:CreateFontString(nil, "OVERLAY", "GameFontNormalSmall")
    hasteValue:SetPoint("TOPLEFT", meleeFrame, "TOPLEFT", meleeGridLeft + meleeValueOffset, meleeStartY - meleeLineHeight * 4)
    hasteValue:SetText("0%")
    hasteValue:SetTextColor(1, 0.82, 0)
    hasteValue:SetJustifyH("LEFT")
    
    -- Separator 2
    local meleeSep2 = meleeFrame:CreateTexture(nil, "OVERLAY")
    meleeSep2:SetHeight(1)
    meleeSep2:SetWidth(130)
    meleeSep2:SetPoint("TOP", meleeFrame, "TOP", 0, -160)
    meleeSep2:SetTexture("Interface\\Buttons\\WHITE8X8")
    meleeSep2:SetVertexColor(0.5, 0.5, 0.5, 0.5)
    
    -- Defense Stats
    local defStartY = -175
    
    -- Armor
    local armorLabel = meleeFrame:CreateFontString(nil, "OVERLAY", "GameFontNormalSmall")
    armorLabel:SetPoint("TOPLEFT", meleeFrame, "TOPLEFT", meleeGridLeft, defStartY)
    armorLabel:SetText("Armor:")
    armorLabel:SetTextColor(0.7, 0.7, 0.7)
    armorLabel:SetJustifyH("LEFT")
    armorLabel:SetWidth(meleeLabelWidth)
    
    local armorValue = meleeFrame:CreateFontString(nil, "OVERLAY", "GameFontNormalSmall")
    armorValue:SetPoint("TOPLEFT", meleeFrame, "TOPLEFT", meleeGridLeft + meleeValueOffset, defStartY)
    armorValue:SetText("0")
    armorValue:SetTextColor(0.7, 0.9, 0.7)
    armorValue:SetJustifyH("LEFT")
    
    -- Defense
    local defLabel = meleeFrame:CreateFontString(nil, "OVERLAY", "GameFontNormalSmall")
    defLabel:SetPoint("TOPLEFT", meleeFrame, "TOPLEFT", meleeGridLeft, defStartY - meleeLineHeight)
    defLabel:SetText("Defense:")
    defLabel:SetTextColor(0.7, 0.7, 0.7)
    defLabel:SetJustifyH("LEFT")
    defLabel:SetWidth(meleeLabelWidth)
    
    local defValue = meleeFrame:CreateFontString(nil, "OVERLAY", "GameFontNormalSmall")
    defValue:SetPoint("TOPLEFT", meleeFrame, "TOPLEFT", meleeGridLeft + meleeValueOffset, defStartY - meleeLineHeight)
    defValue:SetText("0")
    defValue:SetTextColor(0.7, 0.9, 0.7)
    defValue:SetJustifyH("LEFT")
    
    -- Dodge
    local dodgeLabel = meleeFrame:CreateFontString(nil, "OVERLAY", "GameFontNormalSmall")
    dodgeLabel:SetPoint("TOPLEFT", meleeFrame, "TOPLEFT", meleeGridLeft, defStartY - meleeLineHeight * 2)
    dodgeLabel:SetText("Dodge:")
    dodgeLabel:SetTextColor(0.7, 0.7, 0.7)
    dodgeLabel:SetJustifyH("LEFT")
    dodgeLabel:SetWidth(meleeLabelWidth)
    
    local dodgeValue = meleeFrame:CreateFontString(nil, "OVERLAY", "GameFontNormalSmall")
    dodgeValue:SetPoint("TOPLEFT", meleeFrame, "TOPLEFT", meleeGridLeft + meleeValueOffset, defStartY - meleeLineHeight * 2)
    dodgeValue:SetText("0%")
    dodgeValue:SetTextColor(0.7, 0.9, 0.7)
    dodgeValue:SetJustifyH("LEFT")
    
    -- Parry
    local parryLabel = meleeFrame:CreateFontString(nil, "OVERLAY", "GameFontNormalSmall")
    parryLabel:SetPoint("TOPLEFT", meleeFrame, "TOPLEFT", meleeGridLeft, defStartY - meleeLineHeight * 3)
    parryLabel:SetText("Parry:")
    parryLabel:SetTextColor(0.7, 0.7, 0.7)
    parryLabel:SetJustifyH("LEFT")
    parryLabel:SetWidth(meleeLabelWidth)
    
    local parryValue = meleeFrame:CreateFontString(nil, "OVERLAY", "GameFontNormalSmall")
    parryValue:SetPoint("TOPLEFT", meleeFrame, "TOPLEFT", meleeGridLeft + meleeValueOffset, defStartY - meleeLineHeight * 3)
    parryValue:SetText("0%")
    parryValue:SetTextColor(0.7, 0.9, 0.7)
    parryValue:SetJustifyH("LEFT")
    
    -- Block
    local blockLabel = meleeFrame:CreateFontString(nil, "OVERLAY", "GameFontNormalSmall")
    blockLabel:SetPoint("TOPLEFT", meleeFrame, "TOPLEFT", meleeGridLeft, defStartY - meleeLineHeight * 4)
    blockLabel:SetText("Block:")
    blockLabel:SetTextColor(0.7, 0.7, 0.7)
    blockLabel:SetJustifyH("LEFT")
    blockLabel:SetWidth(meleeLabelWidth)
    
    local blockValue = meleeFrame:CreateFontString(nil, "OVERLAY", "GameFontNormalSmall")
    blockValue:SetPoint("TOPLEFT", meleeFrame, "TOPLEFT", meleeGridLeft + meleeValueOffset, defStartY - meleeLineHeight * 4)
    blockValue:SetText("0%")
    blockValue:SetTextColor(0.7, 0.9, 0.7)
    blockValue:SetJustifyH("LEFT")
    
    -- Store melee stat references
    equipPanel.meleeStats = {
        attackPower = apValue,
        crit = critValue,
        hit = hitValue,
        expertise = expValue,
        haste = hasteValue,
        armor = armorValue,
        defense = defValue,
        dodge = dodgeValue,
        parry = parryValue,
        block = blockValue
    }
    
    -- CENTER PANEL: Basic Stats (existing code, adjusted position)
    local infoFrame = CreateStyledFrame(equipPanel, UISTYLE_COLORS.SectionBg)
    infoFrame:SetSize(260, 380)  -- Width increased to fill space between equipment columns
    infoFrame:SetPoint("TOPLEFT", equipPanel, "TOPLEFT", 320, -20)  -- Centered between equipment columns
    
    local characterIcon = infoFrame:CreateTexture(nil, "ARTWORK")
    characterIcon:SetSize(48, 48)
    characterIcon:SetPoint("TOP", infoFrame, "TOP", 0, -10)
    characterIcon:SetTexture("Interface\\Icons\\Achievement_Character_Human_Male")
    
    local characterName = infoFrame:CreateFontString(nil, "OVERLAY", "GameFontNormalLarge")
    characterName:SetPoint("TOP", characterIcon, "BOTTOM", 0, -5)
    characterName:SetText(PlayerInventory.currentPlayerName or "Unknown")
    characterName:SetTextColor(UISTYLE_COLORS.Gold[1], UISTYLE_COLORS.Gold[2], UISTYLE_COLORS.Gold[3])
    
    -- Level and Class
    local levelClassText = infoFrame:CreateFontString(nil, "OVERLAY", "GameFontNormal")
    levelClassText:SetPoint("TOP", characterName, "BOTTOM", 0, -5)
    levelClassText:SetText("Level 1 Unknown")
    levelClassText:SetTextColor(0.8, 0.8, 0.8)
    
    -- Separator line
    local separator1 = infoFrame:CreateTexture(nil, "OVERLAY")
    separator1:SetHeight(1)
    separator1:SetWidth(240)  -- Adjusted for wider panel
    separator1:SetPoint("TOP", levelClassText, "BOTTOM", 0, -7)  -- Moved up from -10
    separator1:SetTexture("Interface\\Buttons\\WHITE8X8")
    separator1:SetVertexColor(0.5, 0.5, 0.5, 0.5)
    
    -- Grid layout for stats - consistent left margin and positioning
    local gridLeftMargin = 10
    local labelWidth = 55  -- Increased from 50
    local valueXOffset = 65  -- Increased from 55
    
    -- Health (added more padding from separator)
    local healthLabel = infoFrame:CreateFontString(nil, "OVERLAY", "GameFontNormalSmall")
    healthLabel:SetPoint("TOPLEFT", infoFrame, "TOPLEFT", gridLeftMargin, -110)  -- Increased padding
    healthLabel:SetText("Health:")
    healthLabel:SetTextColor(0.7, 0.7, 0.7)
    healthLabel:SetJustifyH("LEFT")
    healthLabel:SetWidth(labelWidth)
    
    local healthValue = infoFrame:CreateFontString(nil, "OVERLAY", "GameFontNormalSmall")
    healthValue:SetPoint("TOPLEFT", infoFrame, "TOPLEFT", gridLeftMargin + valueXOffset, -110)
    healthValue:SetText("0 / 0")
    healthValue:SetTextColor(0.2, 1, 0.2)
    healthValue:SetJustifyH("LEFT")
    
    -- Power (Mana/Rage/Energy)
    local powerLabel = infoFrame:CreateFontString(nil, "OVERLAY", "GameFontNormalSmall")
    powerLabel:SetPoint("TOPLEFT", infoFrame, "TOPLEFT", gridLeftMargin, -125)  -- Adjusted
    powerLabel:SetText("Mana:")
    powerLabel:SetTextColor(0.7, 0.7, 0.7)
    powerLabel:SetJustifyH("LEFT")
    powerLabel:SetWidth(labelWidth)
    
    local powerValue = infoFrame:CreateFontString(nil, "OVERLAY", "GameFontNormalSmall")
    powerValue:SetPoint("TOPLEFT", infoFrame, "TOPLEFT", gridLeftMargin + valueXOffset, -125)
    powerValue:SetText("0 / 0")
    powerValue:SetTextColor(0.4, 0.4, 1)
    powerValue:SetJustifyH("LEFT")
    
    -- Separator line 2
    local separator2 = infoFrame:CreateTexture(nil, "OVERLAY")
    separator2:SetHeight(1)
    separator2:SetWidth(240)  -- Adjusted for wider panel
    separator2:SetPoint("TOP", infoFrame, "TOP", 0, -145)  -- Adjusted
    separator2:SetTexture("Interface\\Buttons\\WHITE8X8")
    separator2:SetVertexColor(0.5, 0.5, 0.5, 0.5)
    
    -- Primary Stats with grid layout
    local statStartY = -160  -- Adjusted
    local statLineHeight = 18
    
    -- Strength
    local strLabel = infoFrame:CreateFontString(nil, "OVERLAY", "GameFontNormalSmall")
    strLabel:SetPoint("TOPLEFT", infoFrame, "TOPLEFT", gridLeftMargin, statStartY)
    strLabel:SetText("Strength:")
    strLabel:SetTextColor(0.7, 0.7, 0.7)
    strLabel:SetJustifyH("LEFT")
    strLabel:SetWidth(labelWidth)
    
    local strValue = infoFrame:CreateFontString(nil, "OVERLAY", "GameFontNormalSmall")
    strValue:SetPoint("TOPLEFT", infoFrame, "TOPLEFT", gridLeftMargin + valueXOffset, statStartY)
    strValue:SetText("0")
    strValue:SetTextColor(1, 0.82, 0)
    strValue:SetJustifyH("LEFT")
    
    -- Agility
    local agiLabel = infoFrame:CreateFontString(nil, "OVERLAY", "GameFontNormalSmall")
    agiLabel:SetPoint("TOPLEFT", infoFrame, "TOPLEFT", gridLeftMargin, statStartY - statLineHeight)
    agiLabel:SetText("Agility:")
    agiLabel:SetTextColor(0.7, 0.7, 0.7)
    agiLabel:SetJustifyH("LEFT")
    agiLabel:SetWidth(labelWidth)
    
    local agiValue = infoFrame:CreateFontString(nil, "OVERLAY", "GameFontNormalSmall")
    agiValue:SetPoint("TOPLEFT", infoFrame, "TOPLEFT", gridLeftMargin + valueXOffset, statStartY - statLineHeight)
    agiValue:SetText("0")
    agiValue:SetTextColor(1, 0.82, 0)
    agiValue:SetJustifyH("LEFT")
    
    -- Stamina
    local staLabel = infoFrame:CreateFontString(nil, "OVERLAY", "GameFontNormalSmall")
    staLabel:SetPoint("TOPLEFT", infoFrame, "TOPLEFT", gridLeftMargin, statStartY - (statLineHeight * 2))
    staLabel:SetText("Stamina:")
    staLabel:SetTextColor(0.7, 0.7, 0.7)
    staLabel:SetJustifyH("LEFT")
    staLabel:SetWidth(labelWidth)
    
    local staValue = infoFrame:CreateFontString(nil, "OVERLAY", "GameFontNormalSmall")
    staValue:SetPoint("TOPLEFT", infoFrame, "TOPLEFT", gridLeftMargin + valueXOffset, statStartY - (statLineHeight * 2))
    staValue:SetText("0")
    staValue:SetTextColor(1, 0.82, 0)
    staValue:SetJustifyH("LEFT")
    
    -- Intellect
    local intLabel = infoFrame:CreateFontString(nil, "OVERLAY", "GameFontNormalSmall")
    intLabel:SetPoint("TOPLEFT", infoFrame, "TOPLEFT", gridLeftMargin, statStartY - (statLineHeight * 3))
    intLabel:SetText("Intellect:")
    intLabel:SetTextColor(0.7, 0.7, 0.7)
    intLabel:SetJustifyH("LEFT")
    intLabel:SetWidth(labelWidth)
    
    local intValue = infoFrame:CreateFontString(nil, "OVERLAY", "GameFontNormalSmall")
    intValue:SetPoint("TOPLEFT", infoFrame, "TOPLEFT", gridLeftMargin + valueXOffset, statStartY - (statLineHeight * 3))
    intValue:SetText("0")
    intValue:SetTextColor(1, 0.82, 0)
    intValue:SetJustifyH("LEFT")
    
    -- Spirit
    local spiLabel = infoFrame:CreateFontString(nil, "OVERLAY", "GameFontNormalSmall")
    spiLabel:SetPoint("TOPLEFT", infoFrame, "TOPLEFT", gridLeftMargin, statStartY - (statLineHeight * 4))
    spiLabel:SetText("Spirit:")
    spiLabel:SetTextColor(0.7, 0.7, 0.7)
    spiLabel:SetJustifyH("LEFT")
    spiLabel:SetWidth(labelWidth)
    
    local spiValue = infoFrame:CreateFontString(nil, "OVERLAY", "GameFontNormalSmall")
    spiValue:SetPoint("TOPLEFT", infoFrame, "TOPLEFT", gridLeftMargin + valueXOffset, statStartY - (statLineHeight * 4))
    spiValue:SetText("0")
    spiValue:SetTextColor(1, 0.82, 0)
    spiValue:SetJustifyH("LEFT")
    
    -- Separator line 3
    local separator3 = infoFrame:CreateTexture(nil, "OVERLAY")
    separator3:SetHeight(1)
    separator3:SetWidth(240)  -- Adjusted for wider panel
    separator3:SetPoint("TOP", infoFrame, "TOP", 0, -260)  -- Adjusted position
    separator3:SetTexture("Interface\\Buttons\\WHITE8X8")
    separator3:SetVertexColor(0.5, 0.5, 0.5, 0.5)
    
    -- Currency with grid layout
    local currencyStartY = -275  -- Adjusted position
    
    -- Gold
    local goldLabel = infoFrame:CreateFontString(nil, "OVERLAY", "GameFontNormalSmall")
    goldLabel:SetPoint("TOPLEFT", infoFrame, "TOPLEFT", gridLeftMargin, currencyStartY)
    goldLabel:SetText("Gold:")
    goldLabel:SetTextColor(0.7, 0.7, 0.7)
    goldLabel:SetJustifyH("LEFT")
    goldLabel:SetWidth(labelWidth)
    
    local goldValue = infoFrame:CreateFontString(nil, "OVERLAY", "GameFontNormalSmall")
    goldValue:SetPoint("TOPLEFT", infoFrame, "TOPLEFT", gridLeftMargin + valueXOffset, currencyStartY)
    goldValue:SetText("0g 0s 0c")
    goldValue:SetTextColor(1, 0.85, 0)
    goldValue:SetJustifyH("LEFT")
    
    -- Honor
    local honorLabel = infoFrame:CreateFontString(nil, "OVERLAY", "GameFontNormalSmall")
    honorLabel:SetPoint("TOPLEFT", infoFrame, "TOPLEFT", gridLeftMargin, currencyStartY - statLineHeight)
    honorLabel:SetText("Honor:")
    honorLabel:SetTextColor(0.7, 0.7, 0.7)
    honorLabel:SetJustifyH("LEFT")
    honorLabel:SetWidth(labelWidth)
    
    local honorValue = infoFrame:CreateFontString(nil, "OVERLAY", "GameFontNormalSmall")
    honorValue:SetPoint("TOPLEFT", infoFrame, "TOPLEFT", gridLeftMargin + valueXOffset, currencyStartY - statLineHeight)
    honorValue:SetText("0")
    honorValue:SetTextColor(0.8, 0.4, 0.1)
    honorValue:SetJustifyH("LEFT")
    
    -- Arena
    local arenaLabel = infoFrame:CreateFontString(nil, "OVERLAY", "GameFontNormalSmall")
    arenaLabel:SetPoint("TOPLEFT", infoFrame, "TOPLEFT", gridLeftMargin, currencyStartY - (statLineHeight * 2))
    arenaLabel:SetText("Arena:")
    arenaLabel:SetTextColor(0.7, 0.7, 0.7)
    arenaLabel:SetJustifyH("LEFT")
    arenaLabel:SetWidth(labelWidth)
    
    local arenaValue = infoFrame:CreateFontString(nil, "OVERLAY", "GameFontNormalSmall")
    arenaValue:SetPoint("TOPLEFT", infoFrame, "TOPLEFT", gridLeftMargin + valueXOffset, currencyStartY - (statLineHeight * 2))
    arenaValue:SetText("0")
    arenaValue:SetTextColor(0.6, 0.2, 0.8)
    arenaValue:SetJustifyH("LEFT")
    
    -- RIGHT PANEL: Spell Stats
    local spellFrame = CreateStyledFrame(equipPanel, UISTYLE_COLORS.SectionBg)
    spellFrame:SetSize(150, 380)
    spellFrame:SetPoint("TOPLEFT", equipPanel, "TOPLEFT", 730, -20)
    
    -- Spell Stats Header
    local spellHeader = spellFrame:CreateFontString(nil, "OVERLAY", "GameFontNormal")
    spellHeader:SetPoint("TOP", spellFrame, "TOP", 0, -10)
    spellHeader:SetText("Spell Stats")
    spellHeader:SetTextColor(UISTYLE_COLORS.Gold[1], UISTYLE_COLORS.Gold[2], UISTYLE_COLORS.Gold[3])
    
    -- Separator
    local spellSep1 = spellFrame:CreateTexture(nil, "OVERLAY")
    spellSep1:SetHeight(1)
    spellSep1:SetWidth(130)
    spellSep1:SetPoint("TOP", spellHeader, "BOTTOM", 0, -5)
    spellSep1:SetTexture("Interface\\Buttons\\WHITE8X8")
    spellSep1:SetVertexColor(0.5, 0.5, 0.5, 0.5)
    
    -- Spell stat grid layout
    local spellGridLeft = 10
    local spellLabelWidth = 65
    local spellValueOffset = 70
    local spellStartY = -40
    local spellLineHeight = 20
    
    -- Spell Power
    local spLabel = spellFrame:CreateFontString(nil, "OVERLAY", "GameFontNormalSmall")
    spLabel:SetPoint("TOPLEFT", spellFrame, "TOPLEFT", spellGridLeft, spellStartY)
    spLabel:SetText("Spell Power:")
    spLabel:SetTextColor(0.7, 0.7, 0.7)
    spLabel:SetJustifyH("LEFT")
    spLabel:SetWidth(spellLabelWidth)
    
    local spValue = spellFrame:CreateFontString(nil, "OVERLAY", "GameFontNormalSmall")
    spValue:SetPoint("TOPLEFT", spellFrame, "TOPLEFT", spellGridLeft + spellValueOffset, spellStartY)
    spValue:SetText("0")
    spValue:SetTextColor(0.6, 0.6, 1)
    spValue:SetJustifyH("LEFT")
    
    -- Spell Crit
    local scritLabel = spellFrame:CreateFontString(nil, "OVERLAY", "GameFontNormalSmall")
    scritLabel:SetPoint("TOPLEFT", spellFrame, "TOPLEFT", spellGridLeft, spellStartY - spellLineHeight)
    scritLabel:SetText("Spell Crit:")
    scritLabel:SetTextColor(0.7, 0.7, 0.7)
    scritLabel:SetJustifyH("LEFT")
    scritLabel:SetWidth(spellLabelWidth)
    
    local scritValue = spellFrame:CreateFontString(nil, "OVERLAY", "GameFontNormalSmall")
    scritValue:SetPoint("TOPLEFT", spellFrame, "TOPLEFT", spellGridLeft + spellValueOffset, spellStartY - spellLineHeight)
    scritValue:SetText("0%")
    scritValue:SetTextColor(0.6, 0.6, 1)
    scritValue:SetJustifyH("LEFT")
    
    -- Spell Hit
    local shitLabel = spellFrame:CreateFontString(nil, "OVERLAY", "GameFontNormalSmall")
    shitLabel:SetPoint("TOPLEFT", spellFrame, "TOPLEFT", spellGridLeft, spellStartY - spellLineHeight * 2)
    shitLabel:SetText("Spell Hit:")
    shitLabel:SetTextColor(0.7, 0.7, 0.7)
    shitLabel:SetJustifyH("LEFT")
    shitLabel:SetWidth(spellLabelWidth)
    
    local shitValue = spellFrame:CreateFontString(nil, "OVERLAY", "GameFontNormalSmall")
    shitValue:SetPoint("TOPLEFT", spellFrame, "TOPLEFT", spellGridLeft + spellValueOffset, spellStartY - spellLineHeight * 2)
    shitValue:SetText("0%")
    shitValue:SetTextColor(0.6, 0.6, 1)
    shitValue:SetJustifyH("LEFT")
    
    -- Spell Haste
    local shasteLabel = spellFrame:CreateFontString(nil, "OVERLAY", "GameFontNormalSmall")
    shasteLabel:SetPoint("TOPLEFT", spellFrame, "TOPLEFT", spellGridLeft, spellStartY - spellLineHeight * 3)
    shasteLabel:SetText("Spell Haste:")
    shasteLabel:SetTextColor(0.7, 0.7, 0.7)
    shasteLabel:SetJustifyH("LEFT")
    shasteLabel:SetWidth(spellLabelWidth)
    
    local shasteValue = spellFrame:CreateFontString(nil, "OVERLAY", "GameFontNormalSmall")
    shasteValue:SetPoint("TOPLEFT", spellFrame, "TOPLEFT", spellGridLeft + spellValueOffset, spellStartY - spellLineHeight * 3)
    shasteValue:SetText("0%")
    shasteValue:SetTextColor(0.6, 0.6, 1)
    shasteValue:SetJustifyH("LEFT")
    
    -- MP5
    local mp5Label = spellFrame:CreateFontString(nil, "OVERLAY", "GameFontNormalSmall")
    mp5Label:SetPoint("TOPLEFT", spellFrame, "TOPLEFT", spellGridLeft, spellStartY - spellLineHeight * 4)
    mp5Label:SetText("MP5:")
    mp5Label:SetTextColor(0.7, 0.7, 0.7)
    mp5Label:SetJustifyH("LEFT")
    mp5Label:SetWidth(spellLabelWidth)
    
    local mp5Value = spellFrame:CreateFontString(nil, "OVERLAY", "GameFontNormalSmall")
    mp5Value:SetPoint("TOPLEFT", spellFrame, "TOPLEFT", spellGridLeft + spellValueOffset, spellStartY - spellLineHeight * 4)
    mp5Value:SetText("0")
    mp5Value:SetTextColor(0.6, 0.6, 1)
    mp5Value:SetJustifyH("LEFT")
    
    -- Separator 2
    local spellSep2 = spellFrame:CreateTexture(nil, "OVERLAY")
    spellSep2:SetHeight(1)
    spellSep2:SetWidth(130)
    spellSep2:SetPoint("TOP", spellFrame, "TOP", 0, -160)
    spellSep2:SetTexture("Interface\\Buttons\\WHITE8X8")
    spellSep2:SetVertexColor(0.5, 0.5, 0.5, 0.5)
    
    -- Resistances
    local resStartY = -175
    
    -- Arcane Resistance
    local arcaneLabel = spellFrame:CreateFontString(nil, "OVERLAY", "GameFontNormalSmall")
    arcaneLabel:SetPoint("TOPLEFT", spellFrame, "TOPLEFT", spellGridLeft, resStartY)
    arcaneLabel:SetText("Arcane:")
    arcaneLabel:SetTextColor(0.7, 0.7, 0.7)
    arcaneLabel:SetJustifyH("LEFT")
    arcaneLabel:SetWidth(spellLabelWidth)
    
    local arcaneValue = spellFrame:CreateFontString(nil, "OVERLAY", "GameFontNormalSmall")
    arcaneValue:SetPoint("TOPLEFT", spellFrame, "TOPLEFT", spellGridLeft + spellValueOffset, resStartY)
    arcaneValue:SetText("0")
    arcaneValue:SetTextColor(0.8, 0.6, 1)
    arcaneValue:SetJustifyH("LEFT")
    
    -- Fire Resistance
    local fireLabel = spellFrame:CreateFontString(nil, "OVERLAY", "GameFontNormalSmall")
    fireLabel:SetPoint("TOPLEFT", spellFrame, "TOPLEFT", spellGridLeft, resStartY - spellLineHeight)
    fireLabel:SetText("Fire:")
    fireLabel:SetTextColor(0.7, 0.7, 0.7)
    fireLabel:SetJustifyH("LEFT")
    fireLabel:SetWidth(spellLabelWidth)
    
    local fireValue = spellFrame:CreateFontString(nil, "OVERLAY", "GameFontNormalSmall")
    fireValue:SetPoint("TOPLEFT", spellFrame, "TOPLEFT", spellGridLeft + spellValueOffset, resStartY - spellLineHeight)
    fireValue:SetText("0")
    fireValue:SetTextColor(1, 0.4, 0.2)
    fireValue:SetJustifyH("LEFT")
    
    -- Frost Resistance
    local frostLabel = spellFrame:CreateFontString(nil, "OVERLAY", "GameFontNormalSmall")
    frostLabel:SetPoint("TOPLEFT", spellFrame, "TOPLEFT", spellGridLeft, resStartY - spellLineHeight * 2)
    frostLabel:SetText("Frost:")
    frostLabel:SetTextColor(0.7, 0.7, 0.7)
    frostLabel:SetJustifyH("LEFT")
    frostLabel:SetWidth(spellLabelWidth)
    
    local frostValue = spellFrame:CreateFontString(nil, "OVERLAY", "GameFontNormalSmall")
    frostValue:SetPoint("TOPLEFT", spellFrame, "TOPLEFT", spellGridLeft + spellValueOffset, resStartY - spellLineHeight * 2)
    frostValue:SetText("0")
    frostValue:SetTextColor(0.4, 0.8, 1)
    frostValue:SetJustifyH("LEFT")
    
    -- Nature Resistance
    local natureLabel = spellFrame:CreateFontString(nil, "OVERLAY", "GameFontNormalSmall")
    natureLabel:SetPoint("TOPLEFT", spellFrame, "TOPLEFT", spellGridLeft, resStartY - spellLineHeight * 3)
    natureLabel:SetText("Nature:")
    natureLabel:SetTextColor(0.7, 0.7, 0.7)
    natureLabel:SetJustifyH("LEFT")
    natureLabel:SetWidth(spellLabelWidth)
    
    local natureValue = spellFrame:CreateFontString(nil, "OVERLAY", "GameFontNormalSmall")
    natureValue:SetPoint("TOPLEFT", spellFrame, "TOPLEFT", spellGridLeft + spellValueOffset, resStartY - spellLineHeight * 3)
    natureValue:SetText("0")
    natureValue:SetTextColor(0.4, 1, 0.4)
    natureValue:SetJustifyH("LEFT")
    
    -- Shadow Resistance
    local shadowLabel = spellFrame:CreateFontString(nil, "OVERLAY", "GameFontNormalSmall")
    shadowLabel:SetPoint("TOPLEFT", spellFrame, "TOPLEFT", spellGridLeft, resStartY - spellLineHeight * 4)
    shadowLabel:SetText("Shadow:")
    shadowLabel:SetTextColor(0.7, 0.7, 0.7)
    shadowLabel:SetJustifyH("LEFT")
    shadowLabel:SetWidth(spellLabelWidth)
    
    local shadowValue = spellFrame:CreateFontString(nil, "OVERLAY", "GameFontNormalSmall")
    shadowValue:SetPoint("TOPLEFT", spellFrame, "TOPLEFT", spellGridLeft + spellValueOffset, resStartY - spellLineHeight * 4)
    shadowValue:SetText("0")
    shadowValue:SetTextColor(0.6, 0.4, 0.8)
    shadowValue:SetJustifyH("LEFT")
    
    -- Store spell stat references
    equipPanel.spellStats = {
        spellPower = spValue,
        spellCrit = scritValue,
        spellHit = shitValue,
        spellHaste = shasteValue,
        mp5 = mp5Value,
        arcane = arcaneValue,
        fire = fireValue,
        frost = frostValue,
        nature = natureValue,
        shadow = shadowValue
    }
    
    -- Store references
    equipPanel.characterName = characterName
    equipPanel.characterIcon = characterIcon
    equipPanel.levelClassText = levelClassText
    equipPanel.healthValue = healthValue
    equipPanel.powerLabel = powerLabel
    equipPanel.powerValue = powerValue
    equipPanel.strValue = strValue
    equipPanel.agiValue = agiValue
    equipPanel.staValue = staValue
    equipPanel.intValue = intValue
    equipPanel.spiValue = spiValue
    equipPanel.goldValue = goldValue
    equipPanel.honorValue = honorValue
    equipPanel.arenaValue = arenaValue
    
    -- Add update function
    function equipPanel:updateStats(stats)
        if not stats then return end
        
        -- Update level and class
        if stats.level and stats.className then
            self.levelClassText:SetText(string.format("Level %d %s", stats.level, stats.className))
        end
        
        -- Update health
        if stats.health and stats.maxHealth then
            self.healthValue:SetText(string.format("%d / %d", stats.health, stats.maxHealth))
        end
        
        -- Update power
        if stats.powerTypeName and stats.power and stats.maxPower then
            self.powerLabel:SetText(stats.powerTypeName .. ":")
            self.powerValue:SetText(string.format("%d / %d", stats.power, stats.maxPower))
            
            -- Color based on power type
            if stats.powerType == 0 then -- Mana
                self.powerValue:SetTextColor(0.4, 0.4, 1)
            elseif stats.powerType == 1 then -- Rage
                self.powerValue:SetTextColor(1, 0.2, 0.2)
            elseif stats.powerType == 3 then -- Energy
                self.powerValue:SetTextColor(1, 1, 0.4)
            elseif stats.powerType == 6 then -- Runic Power
                self.powerValue:SetTextColor(0, 0.82, 1)
            end
        end
        
        -- Update primary stats
        if stats.strength then self.strValue:SetText(tostring(stats.strength)) end
        if stats.agility then self.agiValue:SetText(tostring(stats.agility)) end
        if stats.stamina then self.staValue:SetText(tostring(stats.stamina)) end
        if stats.intellect then self.intValue:SetText(tostring(stats.intellect)) end
        if stats.spirit then self.spiValue:SetText(tostring(stats.spirit)) end
        
        -- Update currency
        if stats.money then
            local gold = math.floor(stats.money / 10000)
            local silver = math.floor((stats.money % 10000) / 100)
            local copper = stats.money % 100
            self.goldValue:SetText(string.format("%dg %ds %dc", gold, silver, copper))
        end
        
        if stats.honorPoints then
            self.honorValue:SetText(tostring(stats.honorPoints))
        end
        
        if stats.arenaPoints then
            self.arenaValue:SetText(tostring(stats.arenaPoints))
        end
        
        -- Update melee stats
        if self.meleeStats then
            if stats.attackPower then 
                self.meleeStats.attackPower:SetText(tostring(stats.attackPower))
            end
            if stats.meleeCrit then 
                self.meleeStats.crit:SetText(string.format("%.1f%%", stats.meleeCrit))
            end
            if stats.meleeHit then 
                self.meleeStats.hit:SetText(string.format("%d%%", stats.meleeHit))
            end
            if stats.expertise then 
                self.meleeStats.expertise:SetText(tostring(stats.expertise))
            end
            if stats.meleeHaste then 
                self.meleeStats.haste:SetText(string.format("%d%%", stats.meleeHaste))
            end
            if stats.armor then 
                self.meleeStats.armor:SetText(tostring(stats.armor))
            end
            if stats.defense then 
                self.meleeStats.defense:SetText(tostring(stats.defense))
            end
            if stats.dodgeChance then 
                self.meleeStats.dodge:SetText(string.format("%.1f%%", stats.dodgeChance))
            end
            if stats.parryChance then 
                self.meleeStats.parry:SetText(string.format("%.1f%%", stats.parryChance))
            end
            if stats.blockChance then 
                self.meleeStats.block:SetText(string.format("%.1f%%", stats.blockChance))
            end
        end
        
        -- Update spell stats
        if self.spellStats then
            if stats.spellPower then 
                self.spellStats.spellPower:SetText(tostring(stats.spellPower))
            end
            if stats.spellCrit then 
                self.spellStats.spellCrit:SetText(string.format("%.1f%%", stats.spellCrit))
            end
            if stats.spellHit then 
                self.spellStats.spellHit:SetText(string.format("%d%%", stats.spellHit))
            end
            if stats.spellHaste then 
                self.spellStats.spellHaste:SetText(string.format("%d%%", stats.spellHaste))
            end
            if stats.mp5 then 
                self.spellStats.mp5:SetText(tostring(stats.mp5))
            end
            
            -- For now, set resistances to 0 (would need additional API calls)
            self.spellStats.arcane:SetText("0")
            self.spellStats.fire:SetText("0")
            self.spellStats.frost:SetText("0")
            self.spellStats.nature:SetText("0")
            self.spellStats.shadow:SetText("0")
        end
        
        -- Update character icon based on class/race if needed
        -- This could be expanded to show class-specific icons
    end
    
    -- Check if we have cached stats and update immediately
    if PlayerInventory.currentPlayerStats then
        equipPanel:updateStats(PlayerInventory.currentPlayerStats)
    end
    
    return equipPanel
end

-- Create inventory panel with grid layout
function PlayerInventory.createInventoryPanel(parent)
    local INVENTORY_CONFIG = PlayerInventory.INVENTORY_CONFIG
    
    local invPanel = CreateStyledFrame(parent, UISTYLE_COLORS.ContentBg)
    invPanel:SetAllPoints()
    
    -- Create search bar at the top with proper styling
    local searchBox = CreateStyledSearchBox(invPanel, 350, "Search...", function(text)
        PlayerInventory.filterInventoryItems(text)
    end)
    searchBox:SetPoint("TOP", invPanel, "TOP", 0, -10)
    
    -- Item count display
    local itemCountText = invPanel:CreateFontString(nil, "OVERLAY", "GameFontNormal")
    itemCountText:SetPoint("LEFT", searchBox, "RIGHT", 15, 0)
    itemCountText:SetText("Items: 0 / 0")
    itemCountText:SetTextColor(UISTYLE_COLORS.TextGrey[1], UISTYLE_COLORS.TextGrey[2], UISTYLE_COLORS.TextGrey[3])
    invPanel.itemCountText = itemCountText
    
    -- Add Collapse All button
    local collapseAllBtn = CreateStyledButton(invPanel, "[-]", 30, 20)
    collapseAllBtn:SetPoint("TOPRIGHT", invPanel, "TOPRIGHT", -60, -12)
    collapseAllBtn:SetScript("OnClick", function()
        PlayerInventory.collapseAllBags()
    end)
    collapseAllBtn:SetTooltip("Collapse All", "Hide all bag contents")
    
    -- Add Expand All button
    local expandAllBtn = CreateStyledButton(invPanel, "[+]", 30, 20)
    expandAllBtn:SetPoint("RIGHT", collapseAllBtn, "LEFT", -5, 0)
    expandAllBtn:SetScript("OnClick", function()
        PlayerInventory.expandAllBags()
    end)
    expandAllBtn:SetTooltip("Expand All", "Show all bag contents")
    
    -- Create scrollable container for inventory slots
    local containerWidth = 550  -- Fixed width for consistency
    local containerHeight = 400  -- Fixed height
    
    -- Use CreateScrollableFrame if available
    local container, content, scrollBar, updateScrollBar
    if CreateScrollableFrame then
        container, content, scrollBar, updateScrollBar = CreateScrollableFrame(
            invPanel,
            containerWidth,
            containerHeight
        )
        container:SetPoint("TOPLEFT", searchBox, "BOTTOMLEFT", -175, -15)
        container:SetPoint("BOTTOMRIGHT", invPanel, "BOTTOMRIGHT", -25, 10)
    else
        -- Fallback to manual creation
        container = CreateFrame("Frame", nil, invPanel)
        container:SetPoint("TOPLEFT", searchBox, "BOTTOMLEFT", -175, -15)
        container:SetPoint("BOTTOMRIGHT", invPanel, "BOTTOMRIGHT", -25, 10)
        
        local scrollFrame = CreateFrame("ScrollFrame", nil, container)
        scrollFrame:SetAllPoints()
        
        content = CreateFrame("Frame", nil, scrollFrame)
        content:SetWidth(container:GetWidth() - 20)
        content:SetHeight(1)
        scrollFrame:SetScrollChild(content)
        
        scrollBar = CreateFrame("Slider", nil, scrollFrame, "UIPanelScrollBarTemplate")
        scrollBar:SetPoint("TOPLEFT", scrollFrame, "TOPRIGHT", 4, -16)
        scrollBar:SetPoint("BOTTOMLEFT", scrollFrame, "BOTTOMRIGHT", 4, 16)
        scrollBar:SetMinMaxValues(0, 0)
        scrollBar:SetValueStep(20)
        scrollBar:SetValue(0)
        scrollBar:SetWidth(16)
        
        updateScrollBar = function()
            local maxScroll = math.max(0, content:GetHeight() - container:GetHeight())
            scrollBar:SetMinMaxValues(0, maxScroll)
            if maxScroll > 0 then
                scrollBar:Show()
            else
                scrollBar:Hide()
                scrollBar:SetValue(0)
            end
        end
        
        scrollBar:SetScript("OnValueChanged", function(self, value)
            scrollFrame:SetVerticalScroll(value)
        end)
        
        scrollFrame:EnableMouseWheel(true)
        scrollFrame:SetScript("OnMouseWheel", function(self, delta)
            local current = scrollBar:GetValue()
            local min, max = scrollBar:GetMinMaxValues()
            local step = 40
            if delta > 0 then
                scrollBar:SetValue(math.max(min, current - step))
            else
                scrollBar:SetValue(math.min(max, current + step))
            end
        end)
        
        -- Store the scrollFrame reference for compatibility
        container.scrollFrame = scrollFrame
    end
    
    invPanel.container = container
    
    -- Store references
    invPanel.scrollFrame = container.scrollFrame or container  -- Reference scrollFrame or container
    invPanel.content = content
    invPanel.scrollBar = scrollBar
    invPanel.updateScrollBar = updateScrollBar
    invPanel.searchBox = searchBox
    
    -- Initialize slot storage
    invPanel.slots = {}
    invPanel.slotMap = {} -- For O(1) lookup
    invPanel.bagHeaders = {} -- Store bag header frames
    
    return invPanel
end

-- Create bank panel with grid layout
function PlayerInventory.createBankPanel(parent)
    local INVENTORY_CONFIG = PlayerInventory.INVENTORY_CONFIG
    
    local bankPanel = CreateStyledFrame(parent, UISTYLE_COLORS.ContentBg)
    bankPanel:SetAllPoints()
    
    -- Create search bar at the top with proper styling (matching inventory panel)
    local searchBox = CreateStyledSearchBox(bankPanel, 350, "Search...", function(text)
        PlayerInventory.filterBankItems(text)
    end)
    searchBox:SetPoint("TOP", bankPanel, "TOP", 0, -10)
    
    -- Bank item count display (positioned like inventory panel)
    local bankItemCountText = bankPanel:CreateFontString(nil, "OVERLAY", "GameFontNormal")
    bankItemCountText:SetPoint("LEFT", searchBox, "RIGHT", 15, 0)
    bankItemCountText:SetText("Bank Items: 0 / 0")
    bankItemCountText:SetTextColor(UISTYLE_COLORS.TextGrey[1], UISTYLE_COLORS.TextGrey[2], UISTYLE_COLORS.TextGrey[3])
    bankPanel.bankItemCountText = bankItemCountText
    
    -- Add Collapse All button (matching inventory panel)
    local collapseAllBtn = CreateStyledButton(bankPanel, "[-]", 30, 20)
    collapseAllBtn:SetPoint("TOPRIGHT", bankPanel, "TOPRIGHT", -60, -12)
    collapseAllBtn:SetScript("OnClick", function()
        PlayerInventory.collapseAllBags()
    end)
    collapseAllBtn:SetTooltip("Collapse All", "Hide all bag contents")
    
    -- Add Expand All button (matching inventory panel)
    local expandAllBtn = CreateStyledButton(bankPanel, "[+]", 30, 20)
    expandAllBtn:SetPoint("RIGHT", collapseAllBtn, "LEFT", -5, 0)
    expandAllBtn:SetScript("OnClick", function()
        PlayerInventory.expandAllBags()
    end)
    expandAllBtn:SetTooltip("Expand All", "Show all bag contents")
    
    -- Create scrollable container for bank slots
    local containerWidth = 550  -- Fixed width for consistency
    local containerHeight = 400  -- Same as inventory panel
    
    -- Use CreateScrollableFrame if available
    local container, content, scrollBar, updateScrollBar
    if CreateScrollableFrame then
        container, content, scrollBar, updateScrollBar = CreateScrollableFrame(
            bankPanel,
            containerWidth,
            containerHeight
        )
        container:SetPoint("TOPLEFT", searchBox, "BOTTOMLEFT", -175, -15)
        container:SetPoint("BOTTOMRIGHT", bankPanel, "BOTTOMRIGHT", -25, 10)
    else
        -- Fallback to manual creation
        container = CreateFrame("Frame", nil, bankPanel)
        container:SetPoint("TOPLEFT", searchBox, "BOTTOMLEFT", -175, -15)
        container:SetPoint("BOTTOMRIGHT", bankPanel, "BOTTOMRIGHT", -25, 10)
        
        local scrollFrame = CreateFrame("ScrollFrame", nil, container)
        scrollFrame:SetAllPoints()
        
        content = CreateFrame("Frame", nil, scrollFrame)
        content:SetWidth(container:GetWidth() - 20)
        content:SetHeight(1)
        scrollFrame:SetScrollChild(content)
        
        scrollBar = CreateFrame("Slider", nil, scrollFrame, "UIPanelScrollBarTemplate")
        scrollBar:SetPoint("TOPLEFT", scrollFrame, "TOPRIGHT", 4, -16)
        scrollBar:SetPoint("BOTTOMLEFT", scrollFrame, "BOTTOMRIGHT", 4, 16)
        scrollBar:SetMinMaxValues(0, 0)
        scrollBar:SetValueStep(20)
        scrollBar:SetValue(0)
        scrollBar:SetWidth(16)
        
        updateScrollBar = function()
            local maxScroll = math.max(0, content:GetHeight() - container:GetHeight())
            scrollBar:SetMinMaxValues(0, maxScroll)
            if maxScroll > 0 then
                scrollBar:Show()
            else
                scrollBar:Hide()
                scrollBar:SetValue(0)
            end
        end
        
        scrollBar:SetScript("OnValueChanged", function(self, value)
            scrollFrame:SetVerticalScroll(value)
        end)
        
        scrollFrame:EnableMouseWheel(true)
        scrollFrame:SetScript("OnMouseWheel", function(self, delta)
            local current = scrollBar:GetValue()
            local min, max = scrollBar:GetMinMaxValues()
            local step = 40
            if delta > 0 then
                scrollBar:SetValue(math.max(min, current - step))
            else
                scrollBar:SetValue(math.min(max, current + step))
            end
        end)
        
        -- Store the scrollFrame reference for compatibility
        container.scrollFrame = scrollFrame
    end
    
    bankPanel.container = container
    
    -- Store references
    bankPanel.scrollFrame = container.scrollFrame or container  -- Reference scrollFrame or container
    bankPanel.content = content
    bankPanel.scrollBar = scrollBar
    bankPanel.updateScrollBar = updateScrollBar
    bankPanel.searchBox = searchBox
    
    -- Initialize slot storage
    bankPanel.slots = {}
    bankPanel.slotMap = {} -- For O(1) lookup
    bankPanel.bagHeaders = {} -- Store bank bag header frames
    
    return bankPanel
end

-- Debug message
if GMConfig.config.debug then
    print("[PlayerInventory] Slots module loaded")
end