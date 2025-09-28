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

-- Create modal with loading state using UIStyleLibrary
function PlayerInventory.createInventoryModalWithLoading(playerName)
    local INVENTORY_CONFIG = PlayerInventory.INVENTORY_CONFIG

    -- Create modal overlay using helper function
    local modal = CreateModalOverlay()

    -- Create main dialog using UIStyleLibrary
    local dialog = CreateStyledFrame(modal, UISTYLE_COLORS.DarkGrey)
    dialog:SetSize(INVENTORY_CONFIG.MODAL_WIDTH, INVENTORY_CONFIG.MODAL_HEIGHT)
    dialog:SetPoint("CENTER")
    dialog:SetFrameStrata("FULLSCREEN_DIALOG")
    dialog:SetFrameLevel(10)

    -- Create global name for UISpecialFrames support
    local modalName = "GMPlayerInventoryModal_" .. math.floor(GetTime() * 1000)
    _G[modalName] = dialog

    -- Add to UISpecialFrames for ESC key support
    tinsert(UISpecialFrames, modalName)

    -- Title bar
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
    title:SetText(playerName .. "'s Inventory & Equipment")
    title:SetTextColor(UISTYLE_COLORS.Blue[1], UISTYLE_COLORS.Blue[2], UISTYLE_COLORS.Blue[3])
    title:SetShadowOffset(1, -1)
    title:SetShadowColor(0, 0, 0, 1)

    -- Refresh button
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
            scale2:SetScale(0.77, 0.77) -- 1/1.3 to return to normal
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
        self.text:SetTextColor(0, 1, 0) -- Green
        local colorTimer = CreateFrame("Frame")
        local elapsed = 0
        colorTimer:SetScript("OnUpdate", function(frame, delta)
            elapsed = elapsed + delta
            if elapsed >= 0.5 then
                frame:SetScript("OnUpdate", nil)
                self.text:SetTextColor(1, 1, 1) -- Back to white
            end
        end)
    end)
    refreshBtn:SetTooltip("Refresh Inventory (Ctrl+R)", "Reload all inventory data from server")

    -- Close button
    local closeBtn = CreateStyledButton(titleBar, "×", 26, 26)
    closeBtn:SetPoint("RIGHT", titleBar, "RIGHT", -4, 0)
    closeBtn:SetScript("OnClick", function()
        -- Defensive check for context menu function
        if PlayerInventory.closeContextMenu then
            PlayerInventory.closeContextMenu()
        end
        modal:Hide()
        PlayerInventory.currentModal = nil
    end)
    closeBtn:SetTooltip("Close", "Press ESC to close")

    -- Create loading display using UIStyleLibrary components
    local loadingFrame = CreateStyledFrame(dialog, UISTYLE_COLORS.OptionBg)
    loadingFrame:SetSize(400, 150)
    loadingFrame:SetPoint("CENTER", dialog, "CENTER")

    -- Loading icon with spinning animation
    local loadingIcon = loadingFrame:CreateTexture(nil, "ARTWORK")
    loadingIcon:SetSize(40, 40)
    loadingIcon:SetPoint("TOP", loadingFrame, "TOP", 0, -25)
    loadingIcon:SetTexture("Interface\\Icons\\INV_Misc_Bag_08")
    loadingIcon:SetVertexColor(UISTYLE_COLORS.Blue[1], UISTYLE_COLORS.Blue[2], UISTYLE_COLORS.Blue[3])

    -- Add spinning animation (WoW 3.3.5 compatible)
    local animTime = 0
    loadingFrame.animFrame = CreateFrame("Frame", nil, loadingFrame)
    loadingFrame.animFrame:SetScript("OnUpdate", function(self, elapsed)
        animTime = animTime + elapsed
        local rotation = animTime * 3 -- Rotate 3 radians per second
        -- Pulse effect
        local scale = 1 + math.sin(animTime * 4) * 0.05
        loadingIcon:SetSize(40 * scale, 40 * scale)
    end)

    -- Loading progress bar
    local progressBar = nil
    if CreateStyledLoadingBar then
        progressBar = CreateStyledLoadingBar(loadingFrame, 300, 20)
        progressBar:SetPoint("TOP", loadingIcon, "BOTTOM", 0, -15)
        progressBar:SetProgress(0.3) -- Show some progress
        progressBar:ShowPercentage(false)
    else
        -- Fallback: Create a simple progress bar
        local progressFrame = CreateStyledFrame(loadingFrame, UISTYLE_COLORS.DarkGrey)
        progressFrame:SetSize(300, 20)
        progressFrame:SetPoint("TOP", loadingIcon, "BOTTOM", 0, -15)

        local progressFill = progressFrame:CreateTexture(nil, "ARTWORK")
        progressFill:SetPoint("LEFT")
        progressFill:SetSize(90, 20) -- 30% progress
        progressFill:SetTexture("Interface\\TargetingFrame\\UI-StatusBar")
        progressFill:SetVertexColor(0, 1, 0, 0.8)

        progressBar = progressFrame
        progressBar.fill = progressFill
        progressBar.SetProgress = function(self, value)
            if self.fill then
                self.fill:SetWidth(300 * value)
            end
        end
        progressBar.ShowPercentage = function() end -- Dummy function
    end

    -- Main loading text
    local loadingText = loadingFrame:CreateFontString(nil, "OVERLAY", "GameFontNormalLarge")
    loadingText:SetPoint("TOP", progressBar, "BOTTOM", 0, -12)
    loadingText:SetText("Loading " .. playerName .. "'s Data...")
    loadingText:SetTextColor(UISTYLE_COLORS.Blue[1], UISTYLE_COLORS.Blue[2], UISTYLE_COLORS.Blue[3])
    loadingText:SetShadowOffset(1, -1)
    loadingText:SetShadowColor(0, 0, 0, 1)

    -- Subtitle
    local loadingSubText = loadingFrame:CreateFontString(nil, "OVERLAY", "GameFontNormal")
    loadingSubText:SetPoint("TOP", loadingText, "BOTTOM", 0, -8)
    loadingSubText:SetText("Fetching inventory and equipment...")
    loadingSubText:SetTextColor(UISTYLE_COLORS.TextGrey[1], UISTYLE_COLORS.TextGrey[2], UISTYLE_COLORS.TextGrey[3])

    -- Animate progress bar
    local animationStep = 0
    local animationFrame = CreateFrame("Frame")
    local elapsed = 0
    animationFrame:SetScript("OnUpdate", function(self, delta)
        elapsed = elapsed + delta
        if elapsed >= 0.1 then -- Update every 100ms
            elapsed = 0
            animationStep = animationStep + 0.05
            if animationStep > 1 then animationStep = 0.3 end
            progressBar:SetProgress(animationStep)

            -- Pulse the icon
            local alpha = 0.7 + (math.sin(GetTime() * 3) * 0.3)
            loadingIcon:SetAlpha(alpha)
        end
    end)

    -- Store animation frame for cleanup
    loadingFrame.animationFrame = animationFrame

    -- Track if mail dialog is open from this modal
    modal.isMailDialogOpen = false

    -- Click outside to close (only on background)
    modal:SetScript("OnMouseDown", function(self, button)
        if button == "LeftButton" then
            local focus = GetMouseFocus()
            -- Only close if clicking directly on the modal background AND mail dialog is not open
            if focus and focus == self and not modal.isMailDialogOpen then
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
            -- Defensive check for context menu function
            if PlayerInventory.closeContextMenu then
                PlayerInventory.closeContextMenu()
            end
            -- Bring this frame to front if mail dialog is open
            if modal.isMailDialogOpen then
                dialog:SetFrameLevel(dialog:GetFrameLevel() + 1)
            end
        end
    end)

    -- Create tab system (but hide it during loading)
    local tabs = {
        { text = "Equipment", tooltip = "View equipped items",  icon = "Interface\\Icons\\INV_Chest_Chain" },
        { text = "Inventory", tooltip = "View inventory items", icon = "Interface\\Icons\\INV_Misc_Bag_08" },
        { text = "Bank",      tooltip = "View bank items",      icon = "Interface\\Icons\\INV_Misc_Bag_10_Blue" }
    }

    local tabContainer, contentFrames, tabButtons = CreateStyledTabGroup(
        dialog,
        tabs,
        INVENTORY_CONFIG.MODAL_WIDTH - 6,
        INVENTORY_CONFIG.MODAL_HEIGHT - 42,
        "HORIZONTAL",
        function(tabIndex, tabData)
            -- Debug disabled due to format error
            -- if GMConfig.config.debug then
            --     print("[PlayerInventory] Switched to tab:", tabData.text)
            -- end
        end
    )
    tabContainer:SetPoint("TOPLEFT", titleBar, "BOTTOMLEFT", 3, -3)
    tabContainer:Hide() -- Hide during loading

    -- Don't create panels yet - wait until data arrives and tabs are visible

    -- Store references
    modal.dialog = dialog
    modal.titleBar = titleBar
    modal.loadingFrame = loadingFrame
    modal.playerName = playerName
    modal.tabContainer = tabContainer
    modal.contentFrames = contentFrames
    modal.tabButtons = tabButtons
    modal.refreshBtn = refreshBtn
    -- Panels will be created in updateModalWithData

    -- Add keyboard shortcuts
    dialog:EnableKeyboard(true)
    dialog:SetScript("OnKeyDown", function(self, key)
        if key == "F" and IsControlKeyDown() then
            -- Focus search box (Ctrl+F)
            local activeTab = tabContainer and tabContainer:GetActiveTab() and tabContainer:GetActiveTab()
            if activeTab == 2 and modal.invPanel and modal.invPanel.searchBox then
                -- Inventory tab
                if modal.invPanel.searchBox.editBox then
                    modal.invPanel.searchBox.editBox:SetFocus()
                    modal.invPanel.searchBox.editBox:HighlightText()
                end
            elseif activeTab == 3 and modal.bankPanel and modal.bankPanel.searchBox then
                -- Bank tab
                if modal.bankPanel.searchBox.editBox then
                    modal.bankPanel.searchBox.editBox:SetFocus()
                    modal.bankPanel.searchBox.editBox:HighlightText()
                end
            end
            -- Return true to indicate we handled this key
            return true
        elseif key == "R" and IsControlKeyDown() and not IsAltKeyDown() then
            -- Refresh inventory (Ctrl+R)
            if refreshBtn then
                refreshBtn:Click()
            end
        elseif key == "ESCAPE" then
            -- ESC to close
            modal:Hide()
            PlayerInventory.currentModal = nil
        end
    end)

    -- Store as current modal
    PlayerInventory.currentModal = modal
    modal:Show()

    return modal
end

-- Update modal with received data
function PlayerInventory.updateModalWithData(modal, inventoryData, equipmentData, playerName, bankData, playerStats)
    if not modal then
        if GMConfig.config.debug then
            print("[PlayerInventory] No modal to update")
        end
        return
    end

    -- Stop loading animation
    if modal.loadingFrame then
        if modal.loadingFrame.animationFrame then
            modal.loadingFrame.animationFrame:SetScript("OnUpdate", nil)
        end
        modal.loadingFrame:Hide()
    end

    -- Show tab container
    if modal.tabContainer then
        modal.tabContainer:Show()
    end

    -- Create panels if they don't exist yet (loading -> data received)
    if modal.contentFrames and not modal.equipPanel then
        -- Create equipment panel in first tab
        modal.equipPanel = PlayerInventory.createEquipmentPanel(modal.contentFrames[1])

        -- Create inventory panel in second tab
        modal.invPanel = PlayerInventory.createInventoryPanel(modal.contentFrames[2])

        -- Create bank panel in third tab
        modal.bankPanel = PlayerInventory.createBankPanel(modal.contentFrames[3])
    end

    -- Update player name in equipment panel
    if modal.equipPanel and modal.equipPanel.characterName then
        modal.equipPanel.characterName:SetText(playerName)
    end

    -- Update equipment display
    if modal.equipPanel and equipmentData then
        for slotId, itemData in pairs(equipmentData) do
            if modal.equipPanel.slots[slotId] then
                modal.equipPanel.slots[slotId]:UpdateSlot(itemData)
            end
        end
        -- Update stats display if available
        if playerStats and modal.equipPanel.updateStats then
            modal.equipPanel:updateStats(playerStats)
        end
    end

    -- Update inventory display
    if modal.invPanel and inventoryData then
        PlayerInventory.updateInventoryDisplay(modal.invPanel, inventoryData)
        if modal.invPanel.itemCountText then
            local itemCount = inventoryData and #inventoryData or 0
            modal.invPanel.itemCountText:SetText(string.format("Items: %d", tonumber(itemCount) or 0))
        end
    end

    -- Update bank display
    if modal.bankPanel and bankData then
        PlayerInventory.updateBankDisplay(modal.bankPanel, bankData)
        if modal.bankPanel.bankItemCountText then
            local bankItemCount = bankData and #bankData or 0
            modal.bankPanel.bankItemCountText:SetText(string.format("Bank Items: %d", tonumber(bankItemCount) or 0))
        end
    end
end

-- Receive inventory data from server
function PlayerInventory.receiveInventoryData(player, inventoryData, equipmentData, playerName, bagConfiguration, bankData, playerStats)
    if GMConfig.config.debug then
        print(string.format("[PlayerInventory] Received data for %s: %d inventory items, %d equipment slots, %d bank items",
            playerName, tonumber(inventoryData and #inventoryData or 0) or 0,
            tonumber(equipmentData and #equipmentData or 0) or 0,
            tonumber(bankData and #bankData or 0) or 0))

        -- Debug custom bags
        if inventoryData then
            local customBagItems = 0
            for _, item in ipairs(inventoryData) do
                if item.bag and item.bag >= 1500 then
                    customBagItems = customBagItems + 1
                end
            end
            if customBagItems > 0 then
                print(string.format("[PlayerInventory] Found %d items in custom bags", customBagItems))
            end
        end
    end

    -- Handle new bag configuration structure
    if bagConfiguration then
        -- Check if it's the new structure with bagMapping
        if bagConfiguration.bagMapping then
            PlayerInventory.dynamicBagMapping = bagConfiguration.bagMapping
            PlayerInventory.bagSizes = bagConfiguration.bagSizes or {}

            if GMConfig.config.debug then
                print("[PlayerInventory] Received dynamic bag mapping:")
                for bagId, info in pairs(bagConfiguration.bagMapping) do
                    print(string.format("  Bag %d: %s (%d slots, type: %s, entry: %s)",
                        bagId, info.name, info.size, info.type, tostring(info.entry)))
                end
            end
        else
            -- Legacy format - just bag sizes
            PlayerInventory.bagSizes = bagConfiguration
            if GMConfig.config.debug then
                print("[PlayerInventory] Received legacy bag sizes:")
                for bagId, size in pairs(bagConfiguration) do
                    if size > 0 then
                        print(string.format("  Bag %d: %d slots", bagId, size))
                    end
                end
            end
        end
    end

    -- Use the bank data from server if provided, otherwise separate from inventory data
    local inventoryItems = inventoryData
    local bankItems = bankData  -- Now we receive bank data separately from server
    
    -- If bankData wasn't provided (old server version), fall back to separation logic
    if not bankData then
        inventoryItems, bankItems = PlayerInventory.separateInventoryData(inventoryData)
    end

    -- Store the original data for filtering
    PlayerInventory.originalInventoryData = inventoryItems
    PlayerInventory.originalBankData = bankItems or {}
    PlayerInventory.originalEquipmentData = equipmentData
    PlayerInventory.currentPlayerStats = playerStats

    if GMConfig.config.debug then
        print(string.format("[PlayerInventory] Data storage: %d inventory, %d bank items",
            #inventoryItems, #(bankItems or {})))
        
        -- Debug: Show bag 0 items received
        local bag0Count = 0
        for _, item in ipairs(inventoryItems) do
            if item.bag == 0 then
                bag0Count = bag0Count + 1
                print(string.format("[PlayerInventory] Received bag 0 item: slot %d = %s", 
                    item.slot, item.name))
            end
        end
        print(string.format("[PlayerInventory] Total bag 0 items received: %d", bag0Count))
    end

    -- If we have a loading modal, update it with data
    if PlayerInventory.currentModal then
        if PlayerInventory.currentModal.loadingFrame then
            -- This is a loading modal, update it
            PlayerInventory.updateModalWithData(PlayerInventory.currentModal, inventoryItems, equipmentData, playerName,
                bankItems, playerStats)
        else
            -- This is an existing full modal, just update the panels
            if PlayerInventory.currentModal.equipPanel and equipmentData then
                for slotId, itemData in pairs(equipmentData) do
                    if PlayerInventory.currentModal.equipPanel.slots[slotId] then
                        PlayerInventory.currentModal.equipPanel.slots[slotId]:UpdateSlot(itemData)
                    end
                end
                -- Update stats display if available
                if playerStats and PlayerInventory.currentModal.equipPanel.updateStats then
                    PlayerInventory.currentModal.equipPanel:updateStats(playerStats)
                end
            end

            if PlayerInventory.currentModal.invPanel and inventoryItems then
                PlayerInventory.updateInventoryDisplay(PlayerInventory.currentModal.invPanel, inventoryItems)
                if PlayerInventory.currentModal.invPanel.itemCountText then
                    PlayerInventory.currentModal.invPanel.itemCountText:SetText(
                        string.format("Items: %d", tonumber(#inventoryItems) or 0)
                    )
                end
            end

            if PlayerInventory.currentModal.bankPanel and bankItems then
                PlayerInventory.updateBankDisplay(PlayerInventory.currentModal.bankPanel, bankItems)
                if PlayerInventory.currentModal.bankPanel.bankItemCountText then
                    PlayerInventory.currentModal.bankPanel.bankItemCountText:SetText(
                        string.format("Bank Items: %d", tonumber(#bankItems) or 0)
                    )
                end
            end
        end
    else
        -- No modal exists, create a loading modal first then update it
        if PlayerInventory.createInventoryModalWithLoading then
            local modal = PlayerInventory.createInventoryModalWithLoading(playerName)
            PlayerInventory.currentModal = modal
            -- Now update it with the data
            if modal then
                PlayerInventory.updateModalWithData(modal, inventoryItems, equipmentData, playerName, bankItems)
            end
        elseif PlayerInventory.createInventoryModal then
            -- Fallback to old method if available
            local modal = PlayerInventory.createInventoryModal(playerName, inventoryItems, equipmentData, bankItems)
            PlayerInventory.currentModal = modal
            modal:Show()
        else
            print("[ERROR] No modal creation function available!")
        end
    end
end

-- Register the receiveInventoryData handler now that the function is defined
GameMasterSystem.receiveInventoryData = function(...)
    return PlayerInventory.receiveInventoryData(...)
end

-- Create a debounce timer frame if it doesn't exist
if not PlayerInventory.refreshTimer then
    PlayerInventory.refreshTimer = CreateFrame("Frame")
    PlayerInventory.refreshTimer:Hide()
    PlayerInventory.refreshDelay = 0
    PlayerInventory.refreshTimer:SetScript("OnUpdate", function(self, elapsed)
        PlayerInventory.refreshDelay = PlayerInventory.refreshDelay - elapsed
        if PlayerInventory.refreshDelay <= 0 then
            self:Hide()
            -- Perform the actual refresh
            if PlayerInventory.currentModal and PlayerInventory.currentPlayerName then
                AIO.Handle("GameMasterSystem", "getPlayerInventory", PlayerInventory.currentPlayerName)
            end
        end
    end)
end

-- Handle inventory operation errors
function PlayerInventory.handleInventoryError(errorMessage)
    if GMConfig.config.debug then
        print(string.format("[PlayerInventory] Handling inventory error: %s", errorMessage))
    end

    -- Check for specific error messages
    if string.find(errorMessage, "Target slot is already occupied") or
        string.find(errorMessage, "already occupied") then
        -- Refresh the inventory to ensure correct state is shown
        if PlayerInventory.currentModal and PlayerInventory.currentPlayerName then
            -- Clear any loading states
            if PlayerInventory.currentModal.invPanel then
                for _, slot in pairs(PlayerInventory.currentModal.invPanel.slotMap or {}) do
                    if slot:IsShown() and slot.UpdateSlot then
                        slot:SetAlpha(1.0) -- Reset alpha
                    end
                end
            end

            -- Request fresh data from server after a brief delay
            -- This ensures the UI reflects the actual server state
            local refreshTimer = CreateFrame("Frame")
            local refreshDelay = 0.5
            refreshTimer:SetScript("OnUpdate", function(self, elapsed)
                refreshDelay = refreshDelay - elapsed
                if refreshDelay <= 0 then
                    self:SetScript("OnUpdate", nil)
                    AIO.Handle("GameMasterSystem", "getPlayerInventory", PlayerInventory.currentPlayerName)
                end
            end)
        end
    end
end

-- Refresh inventory display after changes
function PlayerInventory.refreshInventoryDisplay(player, skipFullReload)
    if GMConfig.config.debug then
        print(string.format("[PlayerInventory] Refreshing inventory display (skipFullReload: %s)",
            tostring(skipFullReload)))
    end

    -- If we're told to skip full reload and have pending enchantment, wait for specific update
    if skipFullReload and PlayerInventory.pendingEnchantment then
        if GMConfig.config.debug then
            print("[PlayerInventory] Skipping full reload, waiting for specific item update")
        end
        return
    end

    -- If we have a current modal open, debounce the refresh request
    if PlayerInventory.currentModal and PlayerInventory.currentPlayerName then
        -- Cancel any pending refresh and start a new delay
        PlayerInventory.refreshDelay = 0.3 -- 300ms delay to batch rapid updates
        PlayerInventory.refreshTimer:Show()

        -- Only show loading indicators if not doing optimistic update
        if not skipFullReload then
            -- Show a brief loading indicator for equipment slots
            if PlayerInventory.currentModal.equipPanel then
                for _, slot in pairs(PlayerInventory.currentModal.equipPanel.slots or {}) do
                    if slot.UpdateSlot then
                        slot:UpdateSlot(nil, true) -- Show loading state
                    end
                end
            end

            -- Show loading indicator for inventory slots
            if PlayerInventory.currentModal.invPanel and PlayerInventory.currentModal.invPanel.slotMap then
                for _, slot in pairs(PlayerInventory.currentModal.invPanel.slotMap) do
                    if slot:IsShown() and slot.UpdateSlot then
                        slot:UpdateSlot(nil, true) -- Show loading state
                    end
                end
            end
        end
    end
end

-- Update a specific inventory item (more efficient than full refresh)
function PlayerInventory.updateSpecificInventoryItem(bag, slot, newItemData)
    if GMConfig.config.debug then
        print(string.format("[PlayerInventory] Updating specific item at bag %d, slot %d", tonumber(bag) or 0,
            tonumber(slot) or 0))
        if newItemData and type(newItemData) == "table" and newItemData.enchantId then
            print(string.format("[PlayerInventory] Item has enchantId: %d", tonumber(newItemData.enchantId) or 0))
        end
    end

    -- Clear pending enchantment if this is the item we were waiting for
    if PlayerInventory.pendingEnchantment and
        PlayerInventory.pendingEnchantment.itemData.bag == bag and
        PlayerInventory.pendingEnchantment.itemData.slot == slot then
        -- Verify the enchantment was applied
        if newItemData and type(newItemData) == "table" and newItemData.enchantId == PlayerInventory.pendingEnchantment.enchantId then
            print("|cff00ff00Enchantment successfully applied!|r")
        end

        -- Clean up the visual slot
        if PlayerInventory.pendingEnchantment.slot then
            PlayerInventory.cleanupEnchantAnimation(PlayerInventory.pendingEnchantment.slot)
        end

        PlayerInventory.pendingEnchantment = nil
    end

    -- Update the stored original data
    local itemUpdated = false
    if PlayerInventory.originalInventoryData then
        for i, item in ipairs(PlayerInventory.originalInventoryData) do
            if item.bag == bag and item.slot == slot then
                if newItemData then
                    -- Update existing item
                    PlayerInventory.originalInventoryData[i] = newItemData
                    itemUpdated = true
                    if GMConfig.config.debug then
                        print(string.format("[PlayerInventory] Updated item data for bag %d, slot %d: enchantId=%d",
                            tonumber(bag) or 0, tonumber(slot) or 0,
                            tonumber(newItemData and type(newItemData) == "table" and newItemData.enchantId or 0) or 0))
                    end
                else
                    -- Remove item (was deleted)
                    table.remove(PlayerInventory.originalInventoryData, i)
                    itemUpdated = true
                end
                break
            end
        end
    end

    -- If item wasn't found in data but we have new data, add it
    if not itemUpdated and newItemData then
        table.insert(PlayerInventory.originalInventoryData, newItemData)
        if GMConfig.config.debug then
            print(string.format("[PlayerInventory] Added new item to data: bag %d, slot %d", tonumber(bag) or 0,
                tonumber(slot) or 0))
        end
    end

    -- Try to find and update the specific slot directly using O(1) lookup
    if PlayerInventory.currentModal and PlayerInventory.currentModal.invPanel then
        local slotKey = string.format("%d:%d", tonumber(bag) or 0, tonumber(slot) or 0)
        local slotFrame = nil

        -- First try to find slot using the efficient slotMap
        if PlayerInventory.currentModal.invPanel.slotMap then
            slotFrame = PlayerInventory.currentModal.invPanel.slotMap[slotKey]
        end

        if slotFrame then
            -- Found the slot, update it directly
            if slotFrame.UpdateSlot then
                slotFrame:UpdateSlot(newItemData)
                if GMConfig.config.debug then
                    print(string.format(
                        "[PlayerInventory] Directly updated slot visual for bag %d, slot %d using slotMap",
                        tonumber(bag) or 0, tonumber(slot) or 0))
                end
            end
        else
            -- Slot not in current view (might be filtered), just update the data
            if GMConfig.config.debug then
                print(string.format("[PlayerInventory] Slot %s not in current view, data updated only", slotKey))
            end
            -- No need for full refresh - the slot will be updated when it comes into view
        end
    else
        -- No modal open or no slots, just update the data
        if GMConfig.config.debug then
            print("[PlayerInventory] No modal/slots available, data updated only")
        end
    end
end

-- Update a specific equipment slot (more efficient than full refresh)
function PlayerInventory.updateSpecificEquipmentSlot(slotId, newItemData)
    if GMConfig.config.debug then
        print(string.format("[PlayerInventory] Updating specific equipment slot %d", tonumber(slotId) or 0))
        -- Debug: Show what type of data we received
        print(string.format("[PlayerInventory] newItemData type: %s", type(newItemData)))
        if type(newItemData) == "table" then
            print(string.format("[PlayerInventory] newItemData has %d fields", #newItemData))
            -- Try to show the actual enchantId if it exists
            if newItemData.enchantId then
                print(string.format("[PlayerInventory] Equipment has enchantId: %d", tonumber(newItemData.enchantId) or 0))
            elseif newItemData.enchant then
                print(string.format("[PlayerInventory] Equipment has enchant: %d", tonumber(newItemData.enchant) or 0))
            else
                print("[PlayerInventory] No enchantId or enchant field found in newItemData")
            end
        elseif type(newItemData) == "number" then
            print(string.format("[PlayerInventory] newItemData is number: %d", newItemData))
        end
    end

    -- Clear pending enchantment if this is for equipment
    if PlayerInventory.pendingEnchantment and
        PlayerInventory.pendingEnchantment.isEquipment and
        PlayerInventory.pendingEnchantment.slot and
        PlayerInventory.pendingEnchantment.slot.slotId == slotId then
        -- Verify the enchantment was applied
        if newItemData and type(newItemData) == "table" and newItemData.enchantId == PlayerInventory.pendingEnchantment.enchantId then
            print("|cff00ff00Equipment enchantment successfully applied!|r")
        end

        -- Clean up the visual slot animations
        if PlayerInventory.pendingEnchantment.slot then
            PlayerInventory.cleanupEnchantAnimation(PlayerInventory.pendingEnchantment.slot)
        end

        PlayerInventory.pendingEnchantment = nil
    end

    -- Update the stored original equipment data
    if PlayerInventory.originalEquipmentData then
        PlayerInventory.originalEquipmentData[slotId] = newItemData
        if GMConfig.config.debug then
            print(string.format("[PlayerInventory] Updated equipment data for slot %d: enchantId=%d",
                tonumber(slotId) or 0,
                tonumber(newItemData and type(newItemData) == "table" and newItemData.enchantId or 0) or 0))
        end
    end

    -- Update the equipment slot visual if modal is open
    if PlayerInventory.currentModal and PlayerInventory.currentModal.equipPanel then
        local equipSlot = PlayerInventory.currentModal.equipPanel.slots and
            PlayerInventory.currentModal.equipPanel.slots[slotId]

        if equipSlot then
            -- Clean up any existing animations first
            PlayerInventory.cleanupEnchantAnimation(equipSlot)

            -- Update the slot with new data
            if equipSlot.UpdateSlot then
                equipSlot:UpdateSlot(newItemData)
                if GMConfig.config.debug then
                    print(string.format("[PlayerInventory] Directly updated equipment slot %d visual",
                        tonumber(slotId) or 0))
                end
            end
        else
            if GMConfig.config.debug then
                print(string.format("[PlayerInventory] Equipment slot %d not found in current modal",
                    tonumber(slotId) or 0))
            end
        end
    else
        if GMConfig.config.debug then
            print("[PlayerInventory] No modal/equipment panel available, data updated only")
        end
    end
end

-- Debug message
if GMConfig.config.debug then
    print("[PlayerInventory] Modal module loaded")
end
