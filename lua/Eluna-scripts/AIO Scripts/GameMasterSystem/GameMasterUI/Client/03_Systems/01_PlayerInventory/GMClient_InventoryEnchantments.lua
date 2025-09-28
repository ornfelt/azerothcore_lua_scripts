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

-- Apply optimistic enchant update to show immediate visual feedback
local function applyOptimisticEnchantUpdate(slot, itemData, enchantId)
    if not slot or not itemData then return end
    
    -- Create enchant glow effect
    if not slot.enchantGlow then
        slot.enchantGlow = slot:CreateTexture(nil, "OVERLAY")
        slot.enchantGlow:SetAllPoints()
        slot.enchantGlow:SetTexture("Interface\\Buttons\\UI-ActionButton-Border")
        slot.enchantGlow:SetBlendMode("ADD")
        slot.enchantGlow:SetVertexColor(0, 1, 0, 0.5)
    end
    
    -- Create animated border effect
    if not slot.enchantBorder then
        slot.enchantBorder = slot:CreateTexture(nil, "OVERLAY")
        slot.enchantBorder:SetPoint("TOPLEFT", -2, 2)
        slot.enchantBorder:SetPoint("BOTTOMRIGHT", 2, -2)
        slot.enchantBorder:SetTexture("Interface\\Tooltips\\UI-Tooltip-Border")
        slot.enchantBorder:SetVertexColor(0, 1, 0, 0.8)
    end
    
    -- Create glow frame for additional effect
    if not slot.enchantGlowFrame then
        slot.enchantGlowFrame = CreateFrame("Frame", nil, slot)
        slot.enchantGlowFrame:SetAllPoints()
        slot.enchantGlowFrame:SetFrameLevel(slot:GetFrameLevel() + 1)
        
        local glowTexture = slot.enchantGlowFrame:CreateTexture(nil, "OVERLAY")
        glowTexture:SetAllPoints()
        glowTexture:SetTexture("Interface\\TargetingFrame\\UI-TargetingFrame-Flash")
        glowTexture:SetBlendMode("ADD")
        glowTexture:SetVertexColor(0, 1, 0, 0.3)
        slot.enchantGlowFrame.texture = glowTexture
    end
    
    -- Show all effects
    slot.enchantGlow:Show()
    slot.enchantBorder:Show()
    slot.enchantGlowFrame:Show()
    
    -- Animate the glow with pulsing effect
    if not slot.enchantAnimation then
        slot.enchantAnimation = CreateFrame("Frame")
    end
    
    local animTime = 0
    slot.enchantAnimation:SetScript("OnUpdate", function(self, elapsed)
        animTime = animTime + elapsed
        local alpha = 0.3 + (math.sin(animTime * 3) * 0.3)
        
        if slot.enchantGlow then
            slot.enchantGlow:SetAlpha(alpha)
        end
        if slot.enchantBorder then
            slot.enchantBorder:SetAlpha(alpha * 1.5)
        end
        if slot.enchantGlowFrame and slot.enchantGlowFrame.texture then
            slot.enchantGlowFrame.texture:SetAlpha(alpha * 0.7)
        end
        
        -- Stop animation after 3 seconds but keep a subtle glow
        if animTime > 3 then
            self:SetScript("OnUpdate", nil)
            if slot.enchantGlow then
                slot.enchantGlow:SetAlpha(0.3)
            end
            if slot.enchantBorder then
                slot.enchantBorder:SetAlpha(0.5)
            end
            if slot.enchantGlowFrame then
                slot.enchantGlowFrame:Hide()
            end
        end
    end)
    
    -- Update item data optimistically
    local updatedData = {}
    for k, v in pairs(itemData) do
        updatedData[k] = v
    end
    updatedData.enchantId = enchantId
    
    -- Update the slot immediately
    slot:UpdateSlot(updatedData)
end

-- Queue enchantment for batch processing
function PlayerInventory.queueEnchantment(itemData, enchantId, isEquipment, slot)
    table.insert(PlayerInventory.enchantmentQueue, {
        itemData = itemData,
        enchantId = enchantId,
        isEquipment = isEquipment,
        slot = slot
    })
    
    -- Process queue if not already processing
    if not PlayerInventory.isProcessingQueue then
        PlayerInventory.processEnchantmentQueue()
    end
end

-- Process enchantment queue with delay between each
function PlayerInventory.processEnchantmentQueue()
    if #PlayerInventory.enchantmentQueue == 0 then
        PlayerInventory.isProcessingQueue = false
        return
    end
    
    PlayerInventory.isProcessingQueue = true
    
    -- Get next item from queue
    local enchantData = table.remove(PlayerInventory.enchantmentQueue, 1)
    
    -- Apply the enchantment
    PlayerInventory.applyEnchantment(
        enchantData.itemData,
        enchantData.enchantId,
        enchantData.isEquipment,
        enchantData.slot
    )
    
    -- Schedule next item with delay using frame timer
    local timerFrame = CreateFrame("Frame")
    local elapsed = 0
    timerFrame:SetScript("OnUpdate", function(self, delta)
        elapsed = elapsed + delta
        if elapsed >= 0.5 then
            self:SetScript("OnUpdate", nil)
            PlayerInventory.processEnchantmentQueue()
        end
    end)
end

-- Apply enchantment to item
function PlayerInventory.applyEnchantment(itemData, enchantId, isEquipment, slot)
    if not itemData or not enchantId then return end
    
    -- Track recently used enchants
    PlayerInventory.recentEnchants = PlayerInventory.recentEnchants or {}
    
    -- Remove if already in list
    for i = #PlayerInventory.recentEnchants, 1, -1 do
        if PlayerInventory.recentEnchants[i] == enchantId then
            table.remove(PlayerInventory.recentEnchants, i)
        end
    end
    
    -- Add to front of list
    table.insert(PlayerInventory.recentEnchants, 1, enchantId)
    
    -- Keep only last 10 enchants
    while #PlayerInventory.recentEnchants > 10 do
        table.remove(PlayerInventory.recentEnchants)
    end
    
    -- Store pending enchantment info for optimistic update
    PlayerInventory.pendingEnchantment = {
        itemData = itemData,
        enchantId = enchantId,
        isEquipment = isEquipment,
        slot = slot
    }
    
    -- Apply optimistic visual update immediately
    if slot then
        applyOptimisticEnchantUpdate(slot, itemData, enchantId)
    end
    
    -- Determine slot info for the server
    local slotInfo
    if isEquipment then
        slotInfo = tostring(slot.slotId)
    else
        -- For custom bags (1500+), include the item GUID
        if itemData.bag >= 1500 and itemData.itemGuid then
            slotInfo = string.format("%d:%d:%d", itemData.bag, itemData.slot, itemData.itemGuid)
        else
            slotInfo = string.format("%d:%d", itemData.bag, itemData.slot)
        end
    end
    
    if GMConfig.config.debug then
        print(string.format("[PlayerInventory] Applying enchant %d to %s (slotInfo: %s, isEquipment: %s)",
            enchantId, itemData.name or "item", slotInfo, tostring(isEquipment)))
        
        -- Additional debug for the pending enchantment
        print(string.format("[PlayerInventory] Pending enchantment set: bag=%d, slot=%d, enchantId=%d, guid=%s",
            itemData.bag or -1, itemData.slot or -1, enchantId, tostring(itemData.itemGuid)))
    end
    
    -- Send request to server
    AIO.Handle("GameMasterSystem", "enchantPlayerItem", 
        PlayerInventory.currentPlayerName, slotInfo, enchantId, isEquipment)
    
    -- Show success message
    local enchantName = PlayerInventory.ENCHANT_NAMES[enchantId] or string.format("Enchant %d", enchantId)
    print(string.format("|cff00ff00Applying %s to %s...|r", enchantName, itemData.name or "item"))
    
    -- Don't trigger full refresh - wait for specific item update
    -- The server will send updateSpecificInventoryItem or updateSpecificEquipmentSlot
end

-- Remove enchantments from item
function PlayerInventory.removeEnchantments(itemData, isEquipment, slot)
    if not itemData then return end
    
    -- Determine slot info for the server
    local slotInfo
    if isEquipment then
        slotInfo = tostring(slot.slotId)
    else
        -- For custom bags (1500+), include the item GUID
        if itemData.bag >= 1500 and itemData.itemGuid then
            slotInfo = string.format("%d:%d:%d", itemData.bag, itemData.slot, itemData.itemGuid)
        else
            slotInfo = string.format("%d:%d", itemData.bag, itemData.slot)
        end
    end
    
    if GMConfig.config.debug then
        print(string.format("[PlayerInventory] Removing enchants from %s (slotInfo: %s, isEquipment: %s)",
            itemData.name or "item", slotInfo, tostring(isEquipment)))
    end
    
    -- Send request to server
    AIO.Handle("GameMasterSystem", "removeItemEnchant", 
        PlayerInventory.currentPlayerName, slotInfo, isEquipment)
    
    print(string.format("|cffffff00Removing enchantments from %s...|r", itemData.name or "item"))
    
    -- Refresh display after a short delay using frame timer
    local timerFrame = CreateFrame("Frame")
    local elapsed = 0
    timerFrame:SetScript("OnUpdate", function(self, delta)
        elapsed = elapsed + delta
        if elapsed >= 0.5 then
            self:SetScript("OnUpdate", nil)
            PlayerInventory.refreshInventoryDisplay()
        end
    end)
end

-- Show batch enchant dialog for multiple items
function PlayerInventory.showBatchEnchantDialog(itemData, enchantId, enchantName)
    -- Find all matching items in inventory
    local matchingItems = {}
    
    if PlayerInventory.originalInventoryData then
        for _, item in ipairs(PlayerInventory.originalInventoryData) do
            if item.entry == itemData.entry then
                table.insert(matchingItems, item)
            end
        end
    end
    
    local itemCount = #matchingItems
    
    local dialog = CreateStyledDialog({
        title = "Batch Enchant Confirmation",
        message = string.format(
            "Apply |cff00ff00%s|r to |cffffff00%d|r %s?\n\n" ..
            "This will enchant all matching items in your inventory.",
            enchantName,
            itemCount,
            itemData.name or "items"
        ),
        buttons = {
            {
                text = "Apply to All",
                onClick = function(dialog)
                    -- Queue all items for enchanting
                    for _, item in ipairs(matchingItems) do
                        -- Find the slot for this item
                        local slotKey = string.format("%d:%d", item.bag or 0, item.slot or 0)
                        local slot = nil
                        
                        if PlayerInventory.currentModal and PlayerInventory.currentModal.invPanel then
                            slot = PlayerInventory.currentModal.invPanel.slotMap[slotKey]
                        end
                        
                        PlayerInventory.queueEnchantment(item, enchantId, false, slot)
                    end
                    
                    print(string.format("|cff00ff00Queued %d items for enchanting with %s|r", 
                        itemCount, enchantName))
                    
                    dialog:Hide()
                end
            },
            {
                text = "Apply to One",
                onClick = function(dialog)
                    -- Only apply to the original item
                    PlayerInventory.applyEnchantment(itemData, enchantId, false, nil)
                    dialog:Hide()
                end
            },
            {
                text = "Cancel",
                onClick = function(dialog) dialog:Hide() end
            }
        },
        width = 400,
        height = 250
    })
    
    PlayerInventory.closeContextMenu()
    dialog:Show()
end

-- Process batch enchantments with visual feedback
function PlayerInventory.processBatchEnchantments()
    if not PlayerInventory.selectedSpellForBatch then
        print("|cffff0000No enchantment selected for batch operation|r")
        return
    end
    
    local enchantId = PlayerInventory.selectedSpellForBatch.spellId
    local itemsToEnchant = {}
    
    -- Find all items that match the filter
    if PlayerInventory.originalInventoryData then
        for _, item in ipairs(PlayerInventory.originalInventoryData) do
            -- Check if item matches current search filter
            local matchesFilter = true
            if PlayerInventory.searchFilter and PlayerInventory.searchFilter ~= "" then
                local itemName = item.name or ""
                matchesFilter = string.find(string.lower(itemName), string.lower(PlayerInventory.searchFilter))
            end
            
            if matchesFilter then
                table.insert(itemsToEnchant, item)
            end
        end
    end
    
    -- Queue all matching items
    for _, item in ipairs(itemsToEnchant) do
        local slotKey = string.format("%d:%d", item.bag or 0, item.slot or 0)
        local slot = nil
        
        if PlayerInventory.currentModal and PlayerInventory.currentModal.invPanel then
            slot = PlayerInventory.currentModal.invPanel.slotMap[slotKey]
        end
        
        PlayerInventory.queueEnchantment(item, enchantId, false, slot)
    end
    
    local enchantName = PlayerInventory.ENCHANT_NAMES[enchantId] or string.format("Enchant %d", enchantId)
    print(string.format("|cff00ff00Batch enchanting %d items with %s|r", #itemsToEnchant, enchantName))
    
    -- Clear the selected spell
    PlayerInventory.selectedSpellForBatch = nil
end

-- Debug message
if GMConfig.config.debug then
    print("[PlayerInventory] Enchantments module loaded")
end