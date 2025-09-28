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

-- Toggle bag collapse state
function PlayerInventory.toggleBagCollapse(bagId)
    PlayerInventory.collapsedBags[bagId] = not PlayerInventory.collapsedBags[bagId]
    
    -- Refresh display with current data
    if PlayerInventory.currentModal then
        if PlayerInventory.currentModal.invPanel and PlayerInventory.originalInventoryData then
            PlayerInventory.updateInventoryDisplay(PlayerInventory.currentModal.invPanel, PlayerInventory.originalInventoryData)
        end
        if PlayerInventory.currentModal.bankPanel and PlayerInventory.originalBankData then
            PlayerInventory.updateBankDisplay(PlayerInventory.currentModal.bankPanel, PlayerInventory.originalBankData)
        end
    end
end

-- Collapse all bags
function PlayerInventory.collapseAllBags()
    -- Get all displayed bags and collapse them
    if PlayerInventory.dynamicBagMapping then
        for bagId, _ in pairs(PlayerInventory.dynamicBagMapping) do
            PlayerInventory.collapsedBags[bagId] = true
        end
    end
    -- Also collapse special bags
    PlayerInventory.collapsedBags[0] = true  -- Backpack
    PlayerInventory.collapsedBags[-1] = true  -- Main bank
    
    -- Refresh display
    if PlayerInventory.currentModal then
        if PlayerInventory.currentModal.invPanel and PlayerInventory.originalInventoryData then
            PlayerInventory.updateInventoryDisplay(PlayerInventory.currentModal.invPanel, PlayerInventory.originalInventoryData)
        end
        if PlayerInventory.currentModal.bankPanel and PlayerInventory.originalBankData then
            PlayerInventory.updateBankDisplay(PlayerInventory.currentModal.bankPanel, PlayerInventory.originalBankData)
        end
    end
end

-- Expand all bags
function PlayerInventory.expandAllBags()
    -- Clear collapsed state for all bags
    wipe(PlayerInventory.collapsedBags)
    
    -- Refresh display
    if PlayerInventory.currentModal then
        if PlayerInventory.currentModal.invPanel and PlayerInventory.originalInventoryData then
            PlayerInventory.updateInventoryDisplay(PlayerInventory.currentModal.invPanel, PlayerInventory.originalInventoryData)
        end
        if PlayerInventory.currentModal.bankPanel and PlayerInventory.originalBankData then
            PlayerInventory.updateBankDisplay(PlayerInventory.currentModal.bankPanel, PlayerInventory.originalBankData)
        end
    end
end

-- Filter inventory items based on search text
function PlayerInventory.filterInventoryItems(searchText)
    -- Store the search filter
    PlayerInventory.searchFilter = searchText
    
    -- If we don't have inventory data, nothing to filter
    if not PlayerInventory.originalInventoryData then
        return
    end
    
    -- Filter the data
    local filteredData = {}
    if searchText and searchText ~= "" then
        local searchLower = string.lower(searchText)
        for _, item in ipairs(PlayerInventory.originalInventoryData) do
            local itemName = item.name or ""
            if string.find(string.lower(itemName), searchLower) then
                table.insert(filteredData, item)
            end
        end
    else
        -- No filter, show all items
        filteredData = PlayerInventory.originalInventoryData
    end
    
    -- Update the display with filtered data
    if PlayerInventory.currentModal and PlayerInventory.currentModal.invPanel then
        PlayerInventory.updateInventoryDisplay(PlayerInventory.currentModal.invPanel, filteredData)
        
        -- Update item count
        if PlayerInventory.currentModal.invPanel.itemCountText then
            PlayerInventory.currentModal.invPanel.itemCountText:SetText(
                string.format("Items: %d / %d", #filteredData, #PlayerInventory.originalInventoryData)
            )
        end
    end
end

-- Filter bank items based on search text
function PlayerInventory.filterBankItems(searchText)
    -- Store the bank search filter
    PlayerInventory.bankSearchFilter = searchText
    
    -- If we don't have bank data, nothing to filter
    if not PlayerInventory.originalBankData then
        return
    end
    
    -- Filter the data
    local filteredData = {}
    if searchText and searchText ~= "" then
        local searchLower = string.lower(searchText)
        for _, item in ipairs(PlayerInventory.originalBankData) do
            local itemName = item.name or ""
            if string.find(string.lower(itemName), searchLower) then
                table.insert(filteredData, item)
            end
        end
    else
        -- No filter, show all items
        filteredData = PlayerInventory.originalBankData
    end
    
    -- Update the display with filtered data
    if PlayerInventory.currentModal and PlayerInventory.currentModal.bankPanel then
        PlayerInventory.updateBankDisplay(PlayerInventory.currentModal.bankPanel, filteredData)
        
        -- Update item count
        if PlayerInventory.currentModal.bankPanel.bankItemCountText then
            PlayerInventory.currentModal.bankPanel.bankItemCountText:SetText(
                string.format("Bank Items: %d / %d", #filteredData, #PlayerInventory.originalBankData)
            )
        end
    end
end

-- Apply inventory filters
function PlayerInventory.applyInventoryFilters()
    -- Apply current search filter
    if PlayerInventory.searchFilter and PlayerInventory.searchFilter ~= "" then
        PlayerInventory.filterInventoryItems(PlayerInventory.searchFilter)
    else
        -- No filter, show all
        if PlayerInventory.currentModal and PlayerInventory.currentModal.invPanel then
            PlayerInventory.updateInventoryDisplay(PlayerInventory.currentModal.invPanel, PlayerInventory.originalInventoryData)
        end
    end
end

-- Define bag sizes for WoW 3.3.5
function PlayerInventory.getBagSize(bagId)
    -- Check dynamic mapping first
    if PlayerInventory.dynamicBagMapping and PlayerInventory.dynamicBagMapping[bagId] then
        local bagInfo = PlayerInventory.dynamicBagMapping[bagId]
        return bagInfo.size or 16
    end
    
    -- Check if we have actual bag size from server (legacy support)
    if PlayerInventory.bagSizes then
        -- Try original ID first (server sends sizes with original IDs)
        if PlayerInventory.bagSizes[bagId] then
            return PlayerInventory.bagSizes[bagId]
        end
    end
    
    -- Fallback for special bags
    if bagId == 0 then
        return 16  -- Backpack always has 16 slots
    elseif bagId == 255 then
        return 0  -- Equipment bag doesn't have slots
    else
        -- For unmapped bags, return a default size or 0
        return 16  -- Default to 16 slots for unknown bags
    end
end

-- Update inventory display with new data
function PlayerInventory.updateInventoryDisplay(invPanel, inventoryData, isBank)
    local INVENTORY_CONFIG = PlayerInventory.INVENTORY_CONFIG
    
    if not invPanel or not invPanel.content then
        if GMConfig.config.debug then
            print("[PlayerInventory] No inventory panel to update")
        end
        return
    end
    
    -- Handle bank display mode if specified
    local previousIncludeBank
    if isBank then
        previousIncludeBank = PlayerInventory.includeBank
        PlayerInventory.includeBank = true
    end
    
    if GMConfig.config.debug then
        print(string.format("[PlayerInventory] updateInventoryDisplay called with %d items", inventoryData and #inventoryData or 0))
        if PlayerInventory.dynamicBagMapping then
            local mappingCount = 0
            for _, _ in pairs(PlayerInventory.dynamicBagMapping) do
                mappingCount = mappingCount + 1
            end
            print(string.format("[PlayerInventory] Dynamic bag mapping has %d entries", mappingCount))
            for bagId, info in pairs(PlayerInventory.dynamicBagMapping) do
                print(string.format("  Bag %d: %s (type: %s, size: %d)", 
                    bagId, info.name, info.type, info.size))
            end
        else
            print("[PlayerInventory] No dynamic bag mapping available")
        end
        
        -- Debug: Show unique bag IDs in inventory data
        if inventoryData then
            local uniqueBags = {}
            for _, item in ipairs(inventoryData) do
                uniqueBags[item.bag] = (uniqueBags[item.bag] or 0) + 1
            end
            print("[PlayerInventory] Items per bag:")
            for bagId, count in pairs(uniqueBags) do
                print(string.format("  Bag %d: %d items", bagId, count))
            end
        end
    end
    
    -- Clear cache tracking when updating display
    PlayerInventory.cacheMissedItems = {}
    
    -- Track which slots are currently in use
    local usedSlots = {}
    
    -- Hide all existing slots first (they'll be shown if still needed)
    for _, slot in ipairs(invPanel.slots or {}) do
        if slot and slot:IsShown() then
            slot:Hide()
        end
    end
    
    -- Initialize slot storage if needed
    if not invPanel.slots then
        invPanel.slots = {}
    end
    if not invPanel.slotMap then
        invPanel.slotMap = {}
    end
    
    -- Create a map of filled slots for quick lookup
    local filledSlots = {}
    local bagGroups = {}
    local totalItems = 0
    local totalSlots = 0
    
    -- Process inventory data if available
    if inventoryData and #inventoryData > 0 then
        for _, item in ipairs(inventoryData) do
            local bag = item.bag or 0
            local slot = item.slot or 0
            
            -- Normalize bag ID if needed
            local originalBag = bag
            bag = PlayerInventory.normalizeBagId(bag)
            if originalBag ~= bag then
                if GMConfig.config.debug then
                    print(string.format("[PlayerInventory] Remapped bag %d to %d for item %s", 
                        originalBag, bag, item.name or "unknown"))
                end
                item.bag = bag  -- Update the item's bag ID
            end
            
            -- Process all bags based on settings
            -- Include bank bags if includeBank setting is true
            local includeBank = PlayerInventory.includeBank or false
            
            -- Special handling for bag 0 items when in bank view
            if bag == 0 and includeBank then
                -- In bank view, only include bank slots (39-66) from bag 0
                if slot >= 39 and slot <= 66 then
                    -- Map these to virtual bag -1 for display
                    if not bagGroups[-1] then
                        bagGroups[-1] = {}
                    end
                    filledSlots[string.format("%d:%d", 0, slot)] = item
                    totalItems = totalItems + 1
                end
                -- Skip regular backpack slots (0-38) in bank view
            elseif PlayerInventory.shouldShowBag(bag, includeBank) then
                if not bagGroups[bag] then
                    bagGroups[bag] = {}
                end
                
                -- Store item in its slot position
                filledSlots[string.format("%d:%d", bag, slot)] = item
                totalItems = totalItems + 1
                
                local bagType = PlayerInventory.getBagType(bag)
                if GMConfig.config.debug and bagType == "bank" then
                    print(string.format("[PlayerInventory] Including bank bag %d item: %s", 
                        bag, item.name or "unknown"))
                end
            elseif GMConfig.config.debug then
                print(string.format("[PlayerInventory] Skipping bag %d item: %s (type: %s)", 
                    bag, item.name or "unknown", PlayerInventory.getBagType(bag)))
            end
        end
    end
    
    -- Determine which bags to display
    local bagsToDisplay = {}
    local includeBank = PlayerInventory.includeBank or false
    
    -- Only show backpack in inventory view, not bank view
    if not includeBank then
        bagsToDisplay[0] = true
        if GMConfig.config.debug then
            print("[PlayerInventory] Adding bag 0 (backpack) to display")
        end
    end
    
    -- Show equipped bags from dynamic mapping (if available)
    if PlayerInventory.dynamicBagMapping then
        for bagId, bagInfo in pairs(PlayerInventory.dynamicBagMapping) do
            if bagInfo.type == "regular" and PlayerInventory.shouldShowBag(bagId, includeBank) then
                bagsToDisplay[bagId] = true
                if GMConfig.config.debug then
                    print(string.format("[PlayerInventory] Adding regular bag %d (%s) from mapping", bagId, bagInfo.name))
                end
            elseif (bagInfo.type == "bank" or bagInfo.type == "bank_main") and includeBank then
                bagsToDisplay[bagId] = true
                if GMConfig.config.debug then
                    print(string.format("[PlayerInventory] Adding bank bag %d (%s) from mapping", bagId, bagInfo.name))
                end
            end
        end
        
        -- Special handling for main bank slots when showing bank
        -- Main bank items are in bag 0, slots 39-66
        if includeBank then
            -- Add virtual bag -1 for main bank display
            bagsToDisplay[-1] = true  -- Use -1 as a virtual bag ID for main bank
            -- Make sure we DON'T add bag 0 (backpack) to bank view
            bagsToDisplay[0] = nil
            if GMConfig.config.debug then
                print("[PlayerInventory] Adding main bank slots (bag -1) for display")
            end
        end
    else
        -- Fallback: show the 4 equipped bag slots (19-22) even if empty
        for i = 19, 22 do
            bagsToDisplay[i] = true
        end
    end
    
    -- Add all bags that have items (in case there are unmapped bags with items)
    for bagId, _ in pairs(bagGroups) do
        -- Don't add backpack to bank view even if it has items
        if bagId == 0 and includeBank then
            -- Skip backpack in bank view
        elseif PlayerInventory.shouldShowBag(bagId, includeBank) then
            bagsToDisplay[bagId] = true
            local bagType = PlayerInventory.getBagType(bagId)
            if GMConfig.config.debug then
                print(string.format("[PlayerInventory] Adding %s bag %d to display (has items)", bagType, bagId))
            end
        end
    end
    
    -- Get sorted bag IDs with custom sorting
    local sortedBagIds = {}
    for bagId, _ in pairs(bagsToDisplay) do
        table.insert(sortedBagIds, bagId)
    end
    
    -- Custom sort to ensure proper display order:
    -- Backpack (0) -> Regular bags (19-22 or remapped) -> Bank bags (39-74)
    table.sort(sortedBagIds, function(a, b)
        local typeA = PlayerInventory.getBagType(a)
        local typeB = PlayerInventory.getBagType(b)
        
        -- Define sort priority
        local priority = {backpack = 1, regular = 2, bank_main = 3, bank = 4, unknown = 5}
        local priorityA = priority[typeA] or 5
        local priorityB = priority[typeB] or 5
        
        if priorityA ~= priorityB then
            return priorityA < priorityB
        else
            -- Within same type, sort by normalized ID to keep consistent order
            local normA = PlayerInventory.normalizeBagId(a)
            local normB = PlayerInventory.normalizeBagId(b)
            return normA < normB
        end
    end)
    
    -- Layout configuration - use fixed width to avoid negative dimensions
    local contentWidth = 550  -- Use a reasonable fixed width
    if invPanel.container and invPanel.container:GetWidth() > 0 then
        contentWidth = invPanel.container:GetWidth() - 20  -- Account for scrollbar
    end
    
    local slotSizeWithSpacing = INVENTORY_CONFIG.SLOT_SIZE + INVENTORY_CONFIG.SLOT_SPACING
    local slotsPerRow = math.floor((contentWidth - 40) / slotSizeWithSpacing) -- 20px margin on each side
    if slotsPerRow < 1 then slotsPerRow = 1 end
    
    
    local yOffset = -15
    local totalHeight = 0
    
    -- Initialize bag headers storage if not exists
    if not invPanel.bagHeaders then
        invPanel.bagHeaders = {}
    end
    
    -- Display each bag with all slots (empty and filled)
    for _, bagId in ipairs(sortedBagIds) do
        local bagSize = PlayerInventory.getBagSize(bagId)
        local bagItemCount = 0
        
        -- Special handling for main bank slots (virtual bag -1)
        if bagId == -1 then
            -- Main bank slots are in bag 0, slots 39-66
            bagSize = 28  -- Main bank has 28 slots
            for slotIndex = 39, 66 do
                local slotKey = string.format("%d:%d", 0, slotIndex)
                if filledSlots[slotKey] then
                    bagItemCount = bagItemCount + 1
                end
            end
        else
            -- Count items in this bag normally
            for slotIndex = 0, bagSize - 1 do
                local slotKey = string.format("%d:%d", bagId, slotIndex)
                if filledSlots[slotKey] then
                    bagItemCount = bagItemCount + 1
                end
            end
        end
        
        totalSlots = totalSlots + bagSize
        
        local headerKey = "bag_header_" .. bagId
        
        -- Reuse existing header or create new one
        local bagHeaderFrame = invPanel.bagHeaders[headerKey]
        if not bagHeaderFrame then
            bagHeaderFrame = CreateStyledFrame(invPanel.content, UISTYLE_COLORS.SectionBg)
            bagHeaderFrame:SetHeight(25)
            bagHeaderFrame:SetFrameLevel(invPanel.content:GetFrameLevel() + 1)
            
            -- Add bag icon (left side)
            local bagIcon = bagHeaderFrame:CreateTexture(nil, "ARTWORK")
            bagIcon:SetSize(20, 20)
            bagIcon:SetPoint("LEFT", bagHeaderFrame, "LEFT", 5, 0)
            bagHeaderFrame.bagIcon = bagIcon
            
            -- Add collapse/expand button
            local collapseBtn = CreateStyledButton(bagHeaderFrame, "-", 20, 20)
            collapseBtn:SetPoint("RIGHT", bagHeaderFrame, "RIGHT", -5, 0)
            collapseBtn:SetScript("OnClick", function()
                PlayerInventory.toggleBagCollapse(bagId)
            end)
            collapseBtn:SetTooltip("Collapse/Expand", "Click to toggle bag visibility")
            bagHeaderFrame.collapseBtn = collapseBtn
            
            -- Add fill percentage bar
            local fillBar = bagHeaderFrame:CreateTexture(nil, "ARTWORK")
            fillBar:SetHeight(2)
            fillBar:SetPoint("BOTTOMLEFT", bagHeaderFrame, "BOTTOMLEFT", 1, 1)
            fillBar:SetPoint("BOTTOMRIGHT", bagHeaderFrame, "BOTTOMRIGHT", -1, 1)
            fillBar:SetTexture("Interface\\TargetingFrame\\UI-StatusBar")
            fillBar:SetVertexColor(0.3, 0.6, 0.3, 0.8)  -- Green
            bagHeaderFrame.fillBar = fillBar
            
            -- Bag header text with user-friendly name
            local bagHeader = bagHeaderFrame:CreateFontString(nil, "OVERLAY", "GameFontNormal")
            bagHeader:SetPoint("LEFT", bagIcon, "RIGHT", 5, 0)
            bagHeader:SetTextColor(UISTYLE_COLORS.Blue[1], UISTYLE_COLORS.Blue[2], UISTYLE_COLORS.Blue[3])
            bagHeader:SetShadowOffset(1, -1)
            bagHeader:SetShadowColor(0, 0, 0, 1)
            
            bagHeaderFrame.text = bagHeader
            invPanel.bagHeaders[headerKey] = bagHeaderFrame
            table.insert(invPanel.slots, bagHeaderFrame)
        end
        
        -- Update header position and text with used/total count
        bagHeaderFrame:SetPoint("TOPLEFT", invPanel.content, "TOPLEFT", 10, yOffset)
        bagHeaderFrame:SetPoint("TOPRIGHT", invPanel.content, "TOPRIGHT", -10, yOffset)
        
        -- Add visual distinction for different bag types
        local bagType = PlayerInventory.getBagType(bagId)
        local displayName = PlayerInventory.getBagDisplayName(bagId)
        
        -- Set bag icon based on bag type and item entry
        if bagHeaderFrame.bagIcon then
            local iconTexture = "Interface\\Icons\\INV_Misc_Bag_07"  -- Default bag icon
            
            -- Get bag info from dynamic mapping if available
            if PlayerInventory.dynamicBagMapping and PlayerInventory.dynamicBagMapping[bagId] then
                local bagInfo = PlayerInventory.dynamicBagMapping[bagId]
                if bagInfo.entry then
                    -- Try to get icon from item cache first
                    local cachedItem = PlayerInventory.itemCache and PlayerInventory.itemCache[bagInfo.entry]
                    if cachedItem and cachedItem.icon then
                        iconTexture = cachedItem.icon
                    elseif GetItemIcon then
                        -- Use GetItemIcon if available (WoW 3.3.5+ API)
                        iconTexture = GetItemIcon(bagInfo.entry) or iconTexture
                    else
                        -- Fallback: request icon from cache (will be set later if available)
                        iconTexture = "Interface\\Icons\\INV_Misc_Bag_07"
                    end
                end
            end
            
            -- Special icons for special bags
            if bagId == 0 then
                iconTexture = "Interface\\Icons\\INV_Misc_Bag_08"  -- Backpack icon
            elseif bagId == -1 then
                iconTexture = "Interface\\Icons\\INV_Misc_Bag_10_Blue"  -- Bank icon
            end
            
            bagHeaderFrame.bagIcon:SetTexture(iconTexture)
        end
        
        -- Style headers by type with better visual hierarchy
        if bagType == "bank" or bagType == "bank_main" then
            -- Bank bags get distinct styling
            bagHeaderFrame:SetBackdropColor(0.15, 0.15, 0.05, 0.8)  -- Darker yellow background
            bagHeaderFrame.text:SetTextColor(1, 0.82, 0)  -- Gold text
        elseif bagId == 0 then
            -- Backpack gets special treatment
            bagHeaderFrame:SetBackdropColor(0.08, 0.08, 0.15, 0.8)  -- Slight blue tint
            bagHeaderFrame.text:SetTextColor(0.5, 0.8, 1)  -- Light blue
        else
            -- Regular bags
            bagHeaderFrame:SetBackdropColor(UISTYLE_COLORS.SectionBg[1], UISTYLE_COLORS.SectionBg[2], UISTYLE_COLORS.SectionBg[3], 0.8)
            bagHeaderFrame.text:SetTextColor(UISTYLE_COLORS.Blue[1], UISTYLE_COLORS.Blue[2], UISTYLE_COLORS.Blue[3])
        end
        
        bagHeaderFrame.text:SetText(string.format("%s (%d/%d slots used)", 
            displayName, bagItemCount, bagSize))
        
        -- Update collapse button text and fill bar
        local isCollapsed = PlayerInventory.collapsedBags[bagId]
        if bagHeaderFrame.collapseBtn then
            bagHeaderFrame.collapseBtn.text:SetText(isCollapsed and "+" or "-")
        end
        
        -- Update fill bar width based on usage
        if bagHeaderFrame.fillBar then
            local fillPercent = bagSize > 0 and (bagItemCount / bagSize) or 0
            local barWidth = math.max(1, (bagHeaderFrame:GetWidth() - 2) * fillPercent)
            bagHeaderFrame.fillBar:SetWidth(barWidth)
            
            -- Color based on fill percentage
            if fillPercent >= 0.9 then
                bagHeaderFrame.fillBar:SetVertexColor(0.8, 0.2, 0.2, 0.8)  -- Red when nearly full
            elseif fillPercent >= 0.7 then
                bagHeaderFrame.fillBar:SetVertexColor(0.8, 0.8, 0.2, 0.8)  -- Yellow
            else
                bagHeaderFrame.fillBar:SetVertexColor(0.3, 0.6, 0.3, 0.8)  -- Green
            end
        end
        
        bagHeaderFrame:Show()
        
        -- Mark header as used
        usedSlots[headerKey] = true
        
        yOffset = yOffset - 30
        
        -- Check if bag is collapsed - if so, skip slot creation
        if isCollapsed then
            -- Just account for the header space, don't create slots
            totalHeight = totalHeight + 30  -- Just the header height
            -- Skip to next bag
        else
            -- Bag is expanded, create slots
            -- Calculate grid layout
            local totalGridWidth = (slotsPerRow * slotSizeWithSpacing) - INVENTORY_CONFIG.SLOT_SPACING
            local startX = (contentWidth - totalGridWidth) / 2
            
            -- Ensure startX is never negative (items stay on screen)
            if startX < 20 then 
                startX = 20  -- Start at least 20px from left edge
            end
            
            local currentRow = 0
            local currentCol = 0
            
            -- Create slots for ALL positions in this bag
            -- NOTE: WoW uses 0-based indexing internally for slots (0 to bagSize-1)
            -- However, we display 1-based numbering to users for better readability
            local startSlot, endSlot, actualBagId
            if bagId == -1 then
                -- Special case for main bank (virtual bag -1)
                -- Main bank slots are 39-66 in bag 0
                startSlot = 39
                endSlot = 66
                actualBagId = 0
            elseif bagId == 0 then
                -- Special case for backpack
                -- Backpack slots are 23-38 in bag 0
                startSlot = 23
                endSlot = 38
                actualBagId = 0
            else
                startSlot = 0
                endSlot = bagSize - 1
                actualBagId = bagId
            end
            
            for slotIndex = startSlot, endSlot do
                local displayIndex = slotIndex - startSlot  -- For positioning calculation
                local x = startX + ((displayIndex % slotsPerRow) * slotSizeWithSpacing)
                local y = yOffset - (math.floor(displayIndex / slotsPerRow) * slotSizeWithSpacing)
                
                -- Create unique key for this slot
                local slotKey = string.format("%d:%d", actualBagId, slotIndex)
                
                -- Get item data if slot is filled, otherwise create empty slot data
                local itemData = filledSlots[slotKey]
                if not itemData then
                    -- Create empty slot data
                    itemData = {
                        bag = actualBagId,
                        slot = slotIndex,
                        entry = 0,  -- 0 indicates empty slot
                        count = 0,
                        name = nil
                    }
                end
                
                -- Debug logging for remapped bags
                if slotIndex == 0 and GMConfig.config.debug then
                    local normalizedId = PlayerInventory.normalizeBagId(bagId)
                    if bagId ~= normalizedId then
                        print(string.format("[PlayerInventory] Creating slots for bag %d (remapped to %d, displays as %s)",
                            bagId, normalizedId, PlayerInventory.getBagDisplayName(bagId)))
                    end
                end
                
                -- Reuse existing slot if available, otherwise create new
                local slot = invPanel.slotMap[slotKey]
                if not slot then
                    slot = PlayerInventory.createInventorySlot(invPanel.content, itemData, false)
                    invPanel.slotMap[slotKey] = slot
                    table.insert(invPanel.slots, slot)
                    
                    -- Store bag and slot info on the slot frame itself
                    slot.bagId = actualBagId
                    slot.slotId = slotIndex
                    
                    if GMConfig.config.debug then
                        print(string.format("[PlayerInventory] Created new slot for key: %s (empty: %s)", 
                            slotKey, tostring(itemData.entry == 0)))
                    end
                end
                
                -- Update slot data and position
                slot:UpdateSlot(itemData)
                slot:SetPoint("TOPLEFT", invPanel.content, "TOPLEFT", x, y)
                slot:Show()
                
                -- Mark slot as used
                usedSlots[slotKey] = true
            end
            
            -- Calculate space used by this bag
            local totalSlotsInBag = bagSize
            local rowsUsed = math.ceil(totalSlotsInBag / slotsPerRow)
            local bagSectionHeight = rowsUsed * slotSizeWithSpacing + 15 -- Extra padding
            yOffset = yOffset - bagSectionHeight
            
            totalHeight = totalHeight + 30 + bagSectionHeight -- Header + content
        end  -- End of if isCollapsed else block
    end
    
    -- Hide any slots that are no longer used
    for slotKey, slot in pairs(invPanel.slotMap) do
        if not usedSlots[slotKey] then
            slot:Hide()
            if GMConfig.config.debug then
                print(string.format("[PlayerInventory] Hiding unused slot: %s", slotKey))
            end
        end
    end
    
    -- Hide any bag headers that are no longer used
    for headerKey, header in pairs(invPanel.bagHeaders or {}) do
        if not usedSlots[headerKey] then
            header:Hide()
            if GMConfig.config.debug then
                print(string.format("[PlayerInventory] Hiding unused header: %s", headerKey))
            end
        end
    end
    
    -- Set content height with proper padding
    local finalHeight = math.max(math.abs(yOffset) + 30, 200)
    invPanel.content:SetHeight(finalHeight)
    invPanel.updateScrollBar()
    
    -- Update item count display with total slots
    if invPanel.itemCountText then
        invPanel.itemCountText:SetText(string.format("Items: %d / %d", totalItems, totalSlots))
    end
    
    -- Update cache status after display is complete
    PlayerInventory.updateCacheStatus()
    
    if GMConfig.config.debug then
        local cacheCount = PlayerInventory.getCacheMissedCount()
        print(string.format("[PlayerInventory] Updated display: %d/%d slots used across %d bags, height: %d, cache issues: %d", 
              totalItems, totalSlots, #sortedBagIds, finalHeight, cacheCount))
    end
    
    -- Restore previous includeBank setting if this was a bank display
    if isBank and previousIncludeBank ~= nil then
        PlayerInventory.includeBank = previousIncludeBank
    end
    
    -- Update bank-specific item count if this is a bank panel
    if isBank and invPanel.bankItemCountText then
        local totalItems = inventoryData and #inventoryData or 0
        local totalSlots = 28 + (12 * 16)  -- 28 main bank slots + 12 bags * ~16 slots each
        invPanel.bankItemCountText:SetText(string.format("Bank Items: %d / ~%d", totalItems, totalSlots))
    end
end

-- Create the main inventory modal using proper UIStyleLibrary
function PlayerInventory.createInventoryModal(playerName, inventoryData, equipmentData, bankData)
    local INVENTORY_CONFIG = PlayerInventory.INVENTORY_CONFIG
    
    -- Create modal background overlay
    local modal = CreateStyledFrame(UIParent, UISTYLE_COLORS.Black)
    modal:SetAllPoints()
    modal:SetFrameStrata("FULLSCREEN_DIALOG")
    modal:SetAlpha(0.8)
    modal:EnableMouse(true)
    
    -- Create main dialog with UIStyleLibrary
    local modalName = "GMPlayerInventoryModal_" .. math.floor(GetTime() * 1000)
    local dialog = CreateStyledFrame(modal, UISTYLE_COLORS.DarkGrey)
    dialog.modalName = modalName  -- Store name for later reference
    dialog:SetSize(INVENTORY_CONFIG.MODAL_WIDTH, INVENTORY_CONFIG.MODAL_HEIGHT)
    dialog:SetPoint("CENTER")
    dialog:SetFrameStrata("FULLSCREEN_DIALOG")
    dialog:SetFrameLevel(10)
    
    -- Add global name for UISpecialFrames support
    _G[modalName] = dialog
    
    -- Add to UISpecialFrames for ESC key support
    tinsert(UISpecialFrames, modalName)
    
    -- Create title bar
    local titleBar = CreateStyledFrame(dialog, UISTYLE_COLORS.SectionBg)
    titleBar:SetHeight(35)
    titleBar:SetPoint("TOPLEFT", 1, -1)
    titleBar:SetPoint("TOPRIGHT", -1, -1)
    
    -- Player icon
    local playerIcon = titleBar:CreateTexture(nil, "ARTWORK")
    playerIcon:SetSize(24, 24)
    playerIcon:SetPoint("LEFT", titleBar, "LEFT", 12, 0)
    playerIcon:SetTexture("Interface\\Icons\\Achievement_Character_Human_Male")
    playerIcon:SetVertexColor(UISTYLE_COLORS.Gold[1], UISTYLE_COLORS.Gold[2], UISTYLE_COLORS.Gold[3])
    
    -- Title text
    local title = titleBar:CreateFontString(nil, "OVERLAY", "GameFontNormalLarge")
    title:SetPoint("LEFT", playerIcon, "RIGHT", 8, 0)
    title:SetText(playerName .. "'s Inventory")
    title:SetTextColor(UISTYLE_COLORS.Blue[1], UISTYLE_COLORS.Blue[2], UISTYLE_COLORS.Blue[3])
    title:SetShadowOffset(1, -1)
    title:SetShadowColor(0, 0, 0, 1)
    
    -- Refresh button (in title bar)
    local refreshBtn = CreateStyledButton(titleBar, "R", 28, 28)
    refreshBtn:SetPoint("RIGHT", titleBar, "RIGHT", -36, 0)
    refreshBtn:SetScript("OnClick", function(self)
        -- Show visual feedback by pulsing the text
        if not self.pulseAnim then
            self.pulseAnim = self.text:CreateAnimationGroup()
            local scale1 = self.pulseAnim:CreateAnimation("Scale")
            scale1:SetScale(1.3, 1.3)
            scale1:SetDuration(0.2)
            scale1:SetOrder(1)
            local scale2 = self.pulseAnim:CreateAnimation("Scale")
            scale2:SetScale(0.77, 0.77)  -- 1/1.3 to return to normal
            scale2:SetDuration(0.2)
            scale2:SetOrder(2)
        end
        self.pulseAnim:Play()
        
        -- Show toast notification
        if CreateStyledToast then
            CreateStyledToast("Refreshing inventory...", 2, 0.5)
        end
        
        -- Request fresh data from server
        if PlayerInventory.currentPlayerName then
            AIO.Handle("GameMasterSystem", "getPlayerInventory", PlayerInventory.currentPlayerName)
        end
        
        -- Change text color briefly to show it's active
        self.text:SetTextColor(0, 1, 0)  -- Green
        local colorTimer = CreateFrame("Frame")
        local elapsed = 0
        colorTimer:SetScript("OnUpdate", function(frame, delta)
            elapsed = elapsed + delta
            if elapsed >= 0.5 then
                frame:SetScript("OnUpdate", nil)
                self.text:SetTextColor(1, 1, 1)  -- Back to white
            end
        end)
    end)
    refreshBtn:SetTooltip("Refresh Inventory (Ctrl+R)", "Reload all inventory data from server")
    
    -- Close button
    local closeBtn = CreateStyledButton(titleBar, "×", 26, 26)
    closeBtn:SetPoint("RIGHT", titleBar, "RIGHT", -4, 0)
    closeBtn:SetScript("OnClick", function()
        PlayerInventory.closeContextMenu()
        modal:Hide()
        PlayerInventory.currentModal = nil
    end)
    closeBtn:SetTooltip("Close", "Press ESC to close")
    
    -- Create tab system using UIStyleLibrary
    local tabs = {
        {text = "Equipment", tooltip = "View equipped items", icon = "Interface\\Icons\\INV_Chest_Chain"},
        {text = "Inventory", tooltip = "View inventory items", icon = "Interface\\Icons\\INV_Misc_Bag_08"},
        {text = "Bank", tooltip = "View bank items", icon = "Interface\\Icons\\INV_Misc_Bag_10_Blue"}
    }
    
    local tabContainer, contentFrames, tabButtons = CreateStyledTabGroup(
        dialog,
        tabs,
        INVENTORY_CONFIG.MODAL_WIDTH - 6,
        INVENTORY_CONFIG.MODAL_HEIGHT - 42,
        "HORIZONTAL",
        function(tabIndex, tabData)
            if GMConfig.config.debug then
                print("[PlayerInventory] Switched to tab:", tabData.text)
            end
        end
    )
    tabContainer:SetPoint("TOPLEFT", titleBar, "BOTTOMLEFT", 3, -3)
    
    -- Create equipment panel in first tab
    local equipPanel = PlayerInventory.createEquipmentPanel(contentFrames[1])
    
    -- Create inventory panel in second tab  
    local invPanel = PlayerInventory.createInventoryPanel(contentFrames[2])
    
    -- Create bank panel in third tab
    local bankPanel = PlayerInventory.createBankPanel(contentFrames[3])
    
    -- Add cache status as a slim bar above inventory content
    local cacheStatusBar = CreateStyledFrame(invPanel, UISTYLE_COLORS.Orange)
    cacheStatusBar:SetHeight(24)
    cacheStatusBar:SetPoint("TOPLEFT", invPanel, "TOPLEFT", 10, -40)
    cacheStatusBar:SetPoint("TOPRIGHT", invPanel, "TOPRIGHT", -10, -40)
    cacheStatusBar:SetAlpha(0.95)
    cacheStatusBar:Hide()  -- Initially hidden
    
    -- Warning icon
    local warningIcon = cacheStatusBar:CreateTexture(nil, "ARTWORK")
    warningIcon:SetSize(16, 16)
    warningIcon:SetPoint("LEFT", cacheStatusBar, "LEFT", 8, 0)
    warningIcon:SetTexture("Interface\\DialogFrame\\UI-Dialog-Icon-AlertNew")
    
    -- Cache status text
    local cacheStatusText = cacheStatusBar:CreateFontString(nil, "OVERLAY", "GameFontNormalSmall")
    cacheStatusText:SetPoint("LEFT", warningIcon, "RIGHT", 5, 0)
    cacheStatusText:SetTextColor(1, 1, 1)
    
    -- Refresh cache icon button (smaller, integrated)
    local refreshCacheBtn = CreateStyledButton(cacheStatusBar, nil, 20, 20)
    refreshCacheBtn:SetPoint("RIGHT", cacheStatusBar, "RIGHT", -5, 0)
    local refreshIcon = refreshCacheBtn:CreateTexture(nil, "ARTWORK")
    refreshIcon:SetAllPoints()
    refreshIcon:SetTexture("Interface\\Buttons\\UI-RefreshButton")
    refreshCacheBtn:SetScript("OnClick", function()
        -- Add spinning animation while refreshing
        PlayerInventory.retryCacheMissedItems()
    end)
    refreshCacheBtn:SetTooltip("Refresh Cache", "Try to reload uncached items")
    
    -- Store references on modal
    modal.cacheStatusBar = cacheStatusBar
    modal.cacheStatusText = cacheStatusText
    modal.refreshCacheBtn = refreshCacheBtn
    modal.cacheStatusFrame = cacheStatusBar  -- Keep old reference for compatibility
    
    -- Update equipment display
    if equipmentData then
        for slotId, itemData in pairs(equipmentData) do
            if equipPanel.slots[slotId] then
                equipPanel.slots[slotId]:UpdateSlot(itemData)
            end
        end
    end
    
    -- Update stats display if available  
    if PlayerInventory.currentPlayerStats and equipPanel.updateStats then
        equipPanel:updateStats(PlayerInventory.currentPlayerStats)
    end
    
    -- Update inventory display and item count
    PlayerInventory.updateInventoryDisplay(invPanel, inventoryData)
    if invPanel.itemCountText then
        local itemCount = inventoryData and #inventoryData or 0
        invPanel.itemCountText:SetText(string.format("Items: %d", itemCount))
    end
    
    -- Update bank display
    if bankData then
        PlayerInventory.updateBankDisplay(bankPanel, bankData)
        if bankPanel.bankItemCountText then
            local bankItemCount = bankData and #bankData or 0
            bankPanel.bankItemCountText:SetText(string.format("Bank Items: %d", bankItemCount))
        end
    end
    
    -- Click outside dialog to close (only on background)
    modal:SetScript("OnMouseDown", function(self, button)
        if button == "LeftButton" then
            local focus = GetMouseFocus()
            -- Only close if clicking directly on the modal background
            if focus and focus == self then
                modal:Hide()
                PlayerInventory.currentModal = nil
            end
        end
    end)
    
    -- Enable mouse on dialog to catch clicks
    dialog:EnableMouse(true)
    
    -- Close context menu when clicking anywhere on the dialog
    dialog:SetScript("OnMouseDown", function(self, button)
        if button == "LeftButton" then
            PlayerInventory.closeContextMenu()
        end
    end)
    
    -- Store references
    modal.dialog = dialog
    modal.titleBar = titleBar
    modal.tabContainer = tabContainer
    modal.equipPanel = equipPanel
    modal.invPanel = invPanel
    modal.bankPanel = bankPanel
    modal.playerName = playerName
    modal.refreshBtn = refreshBtn
    
    -- Add keyboard shortcuts
    dialog:EnableKeyboard(true)
    dialog:SetScript("OnKeyDown", function(self, key)
        if key == "F" and IsControlKeyDown() then
            -- Focus search box (Ctrl+F)
            if invPanel and invPanel.searchBar and invPanel.searchBar.editBox then
                -- Switch to inventory tab if needed
                if tabContainer.SetActiveTab and tabContainer:GetActiveTab() ~= 2 then
                    tabContainer:SetActiveTab(2)
                end
                invPanel.searchBar.editBox:SetFocus()
                invPanel.searchBar.editBox:HighlightText()
            end
            -- Return true to indicate we handled this key
            return true
        elseif key == "R" and IsControlKeyDown() and not IsAltKeyDown() then
            -- Refresh inventory (Ctrl+R)
            if refreshBtn then
                refreshBtn:Click()
            end
        elseif key == "B" and IsAltKeyDown() and not IsControlKeyDown() then
            -- Switch to Bank tab (Alt+B)
            if tabContainer.SetActiveTab then
                tabContainer:SetActiveTab(3)
            end
        elseif key == "TAB" and not IsControlKeyDown() then
            -- Tab between Equipment, Inventory, and Bank tabs
            if tabContainer.SetActiveTab then
                local currentTab = tabContainer:GetActiveTab()
                local nextTab = currentTab % 3 + 1  -- Cycle through 1, 2, 3
                tabContainer:SetActiveTab(nextTab)
            end
        elseif key == "ESCAPE" then
            -- ESC to close (handled by UISpecialFrames but adding for clarity)
            modal:Hide()
            PlayerInventory.currentModal = nil
        end
    end)
    
    -- Add help tooltip showing keyboard shortcuts
    local helpText = dialog:CreateFontString(nil, "OVERLAY", "GameFontNormalSmall")
    helpText:SetPoint("BOTTOMLEFT", dialog, "BOTTOMLEFT", 10, 10)
    helpText:SetText("Ctrl+F: Search | R: Refresh | Alt+B: Bank Tab | Tab: Switch View | ESC: Close")
    helpText:SetTextColor(0.5, 0.5, 0.5)
    
    return modal
end

-- Update bank display with bank data (simplified wrapper)
function PlayerInventory.updateBankDisplay(bankPanel, bankData)
    -- Simply call updateInventoryDisplay with the isBank flag set to true
    return PlayerInventory.updateInventoryDisplay(bankPanel, bankData, true)
end


-- Debug message
if GMConfig.config.debug then
    print("[PlayerInventory] Display module loaded")
end