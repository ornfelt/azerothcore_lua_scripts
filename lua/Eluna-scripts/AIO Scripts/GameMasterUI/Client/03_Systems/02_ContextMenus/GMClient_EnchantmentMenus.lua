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
-- ENCHANTMENT MENU FUNCTIONS
-- This module provides enchantment-related menu functionality including:
-- - Enchantment menu creation
-- - Enchantment search dialogs
-- - Batch enchanting
-- - Scrollable enchant menus
-- ================================================================================

-- Create enchantment menu for items
function PlayerInventory.createEnchantmentMenu(itemData, isEquipment, slot)
    local menuList = {}
    
    -- Custom Enchant ID option
    table.insert(menuList, {
        text = "Custom Enchant ID",
        icon = "Interface\\Icons\\INV_Misc_Note_01",
        func = function()
            PlayerInventory.showCustomEnchantDialog(itemData, isEquipment, slot)
        end
    })
    
    -- Remove Enchants option (if item is enchanted)
    if itemData.enchantId and itemData.enchantId > 0 then
        table.insert(menuList, { text = "", disabled = true, notCheckable = true }) -- Separator
        
        table.insert(menuList, {
            text = "|cffff0000Remove Enchantments|r",
            icon = "Interface\\Icons\\INV_Enchant_Disenchant",
            func = function()
                PlayerInventory.removeEnchantments(itemData, isEquipment, slot)
            end
        })
    end
    
    -- Popular enchants with nested categories and search
    table.insert(menuList, { text = "", disabled = true, notCheckable = true }) -- Separator
    local popularEnchantsMenu = PlayerInventory.createPopularEnchantsNestedMenu(itemData, isEquipment, slot)
    table.insert(menuList, {
        text = "Popular Enchants",
        icon = "Interface\\Icons\\INV_Enchant_EssenceMagicLarge",
        hasArrow = true,
        menuList = popularEnchantsMenu
    })
    
    -- Search and view all enchants option
    table.insert(menuList, {
        text = "Search/View All Enchants...",
        icon = "Interface\\Icons\\INV_Misc_Spyglass_03",
        func = function()
            -- Try to use the advanced selection dialog if available
            if PlayerInventory.showAdvancedEnchantSelectionDialog then
                PlayerInventory.showAdvancedEnchantSelectionDialog(itemData, isEquipment, slot)
            else
                -- Fallback to search dialog
                PlayerInventory.showEnchantSearchDialog(itemData, isEquipment, slot)
            end
        end
    })
    
    -- Batch enchanting for multiple items of same type
    if not isEquipment and itemData.count and itemData.count > 1 then
        table.insert(menuList, { text = "", disabled = true, notCheckable = true }) -- Separator
        table.insert(menuList, {
            text = "Batch Enchant All",
            icon = "Interface\\Icons\\INV_Enchant_FormulaSuperior_01",
            func = function()
                -- Open batch enchant dialog
                PlayerInventory.showBatchEnchantSelectionDialog(itemData)
            end,
            tooltipTitle = "Batch Enchant",
            tooltipText = "Apply the same enchant to all items of this type in inventory"
        })
    end
    
    return menuList
end

-- Create nested menu structure for popular enchants
function PlayerInventory.createPopularEnchantsNestedMenu(itemData, isEquipment, slot)
    local menuItems = {}
    
    -- Determine item type for categorization
    local itemSlotType = PlayerInventory.determineItemSlotTypeForMenu(itemData, isEquipment, slot)
    
    -- Get categorized enchants
    local enchantCategories = PlayerInventory.getEnchantCategoriesForItem(itemSlotType, itemData, isEquipment, slot)
    
    -- Create nested menu structure
    for _, category in ipairs(enchantCategories) do
        if category.enchants and #category.enchants > 0 then
            -- If category has many enchants, create a submenu
            if #category.enchants > 5 then
                local submenuItems = {}
                for _, enchant in ipairs(category.enchants) do
                    table.insert(submenuItems, {
                        text = enchant.name,
                        icon = enchant.icon,
                        value = enchant.id,
                        func = function()
                            PlayerInventory.applyEnchantment(itemData, enchant.id, isEquipment, slot)
                            PlayerInventory.closeContextMenu()
                        end
                    })
                end
                
                table.insert(menuItems, {
                    text = category.name,
                    icon = category.icon,
                    hasArrow = true,
                    menuList = submenuItems
                })
            else
                -- For small categories, add enchants directly
                table.insert(menuItems, { text = category.name, isTitle = true })
                for _, enchant in ipairs(category.enchants) do
                    table.insert(menuItems, {
                        text = "  " .. enchant.name,
                        icon = enchant.icon,
                        value = enchant.id,
                        func = function()
                            PlayerInventory.applyEnchantment(itemData, enchant.id, isEquipment, slot)
                            PlayerInventory.closeContextMenu()
                        end
                    })
                end
            end
            
            if category ~= enchantCategories[#enchantCategories] then
                table.insert(menuItems, { isSeparator = true })
            end
        end
    end
    
    return menuItems
end

-- Show enchant search dialog with real-time filtering
function PlayerInventory.showEnchantSearchDialog(itemData, isEquipment, slot)
    -- Create modal overlay using helper function
    local dialog = CreateModalOverlay()
    
    local dialogFrame = CreateStyledFrame(dialog, UISTYLE_COLORS.DarkGrey)
    dialogFrame:SetSize(500, 600)
    dialogFrame:SetPoint("CENTER")
    dialogFrame:SetFrameStrata("FULLSCREEN_DIALOG")
    dialogFrame:SetFrameLevel(100)
    
    -- Title
    local title = dialogFrame:CreateFontString(nil, "OVERLAY", "GameFontNormalLarge")
    title:SetPoint("TOP", 0, -15)
    title:SetText("Search Enchants")
    title:SetTextColor(UISTYLE_COLORS.Blue[1], UISTYLE_COLORS.Blue[2], UISTYLE_COLORS.Blue[3])
    
    -- Close button
    local closeBtn = CreateStyledButton(dialogFrame, "X", 24, 24)
    closeBtn:SetPoint("TOPRIGHT", -5, -5)
    closeBtn:SetScript("OnClick", function()
        dialog:Hide()
    end)
    
    -- Search box with auto-focus
    local searchBox = CreateStyledSearchBox(dialogFrame, 380, "Type enchant name or ID...", function(text)
        PlayerInventory.filterEnchantSearchResults(dialog, text, itemData, isEquipment, slot)
    end)
    searchBox:SetPoint("TOP", title, "BOTTOM", 0, -20)
    
    -- Result count label next to search box
    local resultCount = dialogFrame:CreateFontString(nil, "OVERLAY", "GameFontNormalSmall")
    resultCount:SetPoint("LEFT", searchBox, "RIGHT", 10, 0)
    resultCount:SetTextColor(0.7, 0.7, 0.7)
    resultCount:SetText("0 found")
    dialog.resultCountLabel = resultCount
    
    -- Create scrollable content area
    local container, content, scrollBar, updateScrollBar = CreateScrollableFrame(dialogFrame, 460, 480)
    container:SetPoint("TOP", searchBox, "BOTTOM", 0, -10)
    
    -- Store references
    dialog.content = content
    dialog.updateScrollBar = updateScrollBar
    dialog.searchResults = {}
    
    -- Populate with all available enchants initially
    PlayerInventory.populateEnchantSearchResults(dialog, "", itemData, isEquipment, slot)
    
    -- Auto-focus search box
    searchBox.editBox:SetFocus()
    
    -- Keyboard shortcuts
    dialog:SetScript("OnKeyDown", function(self, key)
        if key == "ESCAPE" then
            dialog:Hide()
        end
    end)
    dialog:EnableKeyboard(true)
    
    -- Close context menu if open
    PlayerInventory.closeContextMenu()
    
    dialog:Show()
    return dialog
end

-- Filter enchant search results
function PlayerInventory.filterEnchantSearchResults(dialog, searchText, itemData, isEquipment, slot)
    PlayerInventory.populateEnchantSearchResults(dialog, searchText, itemData, isEquipment, slot)
end

-- Populate enchant search results
function PlayerInventory.populateEnchantSearchResults(dialog, searchText, itemData, isEquipment, slot)
    -- Clear existing results
    if dialog.searchResults then
        for _, btn in ipairs(dialog.searchResults) do
            btn:Hide()
            btn:SetParent(nil)
        end
    end
    dialog.searchResults = {}
    
    local searchLower = string.lower(searchText or "")
    local allEnchants = {}
    
    -- Collect all enchants from database or predefined list
    for enchantId, enchantName in pairs(PlayerInventory.ENCHANT_NAMES) do
        local nameLower = string.lower(enchantName)
        local idStr = tostring(enchantId)
        
        -- Filter by search text
        if searchText == "" or 
           string.find(nameLower, searchLower) or 
           string.find(idStr, searchLower) then
            table.insert(allEnchants, {
                id = enchantId,
                name = enchantName,
                icon = PlayerInventory.getEnchantIcon(enchantId, enchantName)
            })
        end
    end
    
    -- Sort alphabetically
    table.sort(allEnchants, function(a, b) return a.name < b.name end)
    
    -- Create result buttons
    local yOffset = -5
    for i, enchant in ipairs(allEnchants) do
        local enchantBtn = CreateStyledButton(dialog.content, enchant.name, 440, 28)
        enchantBtn:SetPoint("TOPLEFT", 10, yOffset)
        
        -- Add icon
        local icon = enchantBtn:CreateTexture(nil, "ARTWORK")
        icon:SetSize(20, 20)
        icon:SetPoint("LEFT", 5, 0)
        icon:SetTexture(enchant.icon)
        
        -- Adjust text position
        enchantBtn.text:SetPoint("LEFT", icon, "RIGHT", 5, 0)
        
        -- Add ID text
        local idText = enchantBtn:CreateFontString(nil, "OVERLAY", "GameFontNormalSmall")
        idText:SetPoint("RIGHT", -10, 0)
        idText:SetText(string.format("ID: %d", enchant.id))
        idText:SetTextColor(0.6, 0.6, 0.6)
        
        -- Click handler
        enchantBtn:SetScript("OnClick", function()
            PlayerInventory.applyEnchantment(itemData, enchant.id, isEquipment, slot)
            dialog:Hide()
        end)
        
        -- Tooltip
        enchantBtn:SetScript("OnEnter", function(self)
            GameTooltip:SetOwner(self, "ANCHOR_RIGHT")
            GameTooltip:SetText(enchant.name, 1, 1, 1)
            GameTooltip:AddLine(string.format("Enchant ID: %d", enchant.id), 0.6, 0.6, 0.6)
            GameTooltip:AddLine(" ")
            GameTooltip:AddLine("Click to apply this enchant", 0, 1, 0)
            GameTooltip:Show()
        end)
        
        enchantBtn:SetScript("OnLeave", function()
            GameTooltip:Hide()
        end)
        
        table.insert(dialog.searchResults, enchantBtn)
        yOffset = yOffset - 30
    end
    
    -- Update content height
    dialog.content:SetHeight(math.max(480, #allEnchants * 30 + 10))
    dialog.updateScrollBar()
    
    -- Update result count label
    if dialog.resultCountLabel then
        dialog.resultCountLabel:SetText(string.format("%d found", #allEnchants))
        -- Change color based on search active
        if searchText and searchText ~= "" then
            dialog.resultCountLabel:SetTextColor(0, 1, 0)  -- Green when searching
        else
            dialog.resultCountLabel:SetTextColor(0.7, 0.7, 0.7)  -- Gray normally
        end
    end
end

-- Show batch enchant selection dialog
function PlayerInventory.showBatchEnchantSelectionDialog(itemData)
    local popularEnchants = PlayerInventory.getPopularEnchantsForSlot(itemData, false, nil)
    
    local buttons = {}
    for _, enchant in ipairs(popularEnchants) do
        table.insert(buttons, {
            text = enchant.name,
            onClick = function(dialog)
                PlayerInventory.showBatchEnchantDialog(itemData, enchant.id, enchant.name)
                dialog:Hide()
            end
        })
    end
    
    table.insert(buttons, {
        text = "Custom ID",
        onClick = function(dialog)
            dialog:Hide()
            PlayerInventory.showCustomBatchEnchantDialog(itemData)
        end
    })
    
    table.insert(buttons, {
        text = "Cancel",
        onClick = function(dialog) dialog:Hide() end
    })
    
    local dialog = CreateStyledDialog({
        title = "Batch Enchant Selection",
        message = string.format("Select enchant to apply to all %s:", itemData.name or "items"),
        buttons = buttons,
        width = 400,
        height = 250 + (#popularEnchants * 30)
    })
    
    PlayerInventory.closeContextMenu()
    dialog:Show()
end

-- Show custom batch enchant dialog
function PlayerInventory.showCustomBatchEnchantDialog(itemData)
    local dialog = PlayerInventory.CreateInputDialog({
        title = "Custom Batch Enchant",
        message = string.format("Enter enchant ID to apply to all %s:", itemData.name or "items"),
        placeholder = "Enter enchant ID...",
        numeric = true,
        buttons = {
            {
                text = "Apply",
                onClick = function(dialog, inputText)
                    local enchantId = tonumber(inputText)
                    if enchantId and enchantId > 0 then
                        local enchantName = PlayerInventory.ENCHANT_NAMES[enchantId] or string.format("Enchant %d", enchantId)
                        PlayerInventory.showBatchEnchantDialog(itemData, enchantId, enchantName)
                        dialog:Hide()
                    else
                        print("|cffff0000Invalid enchant ID!|r")
                    end
                end
            },
            {
                text = "Cancel",
                onClick = function(dialog) dialog:Hide() end
            }
        }
    })
    
    PlayerInventory.closeContextMenu()
    dialog:Show()
end

-- Show scrollable popular enchants menu
function PlayerInventory.showScrollablePopularEnchantsMenu(itemData, isEquipment, slot)
    local popularEnchants = PlayerInventory.getPopularEnchantsForSlot(itemData, isEquipment, slot)
    
    -- Calculate menu dimensions
    local menuWidth = 280
    local itemHeight = 24
    local maxVisibleItems = 12  -- Maximum items to show without scrolling
    local menuHeight = math.min(#popularEnchants * itemHeight + 10, maxVisibleItems * itemHeight + 10)
    
    -- Create scrollable menu frame
    local menuFrame = CreateStyledFrame(UIParent, UISTYLE_COLORS.DarkGrey)
    menuFrame:SetSize(menuWidth, menuHeight)
    menuFrame:SetFrameStrata("TOOLTIP")
    menuFrame:SetFrameLevel(1000)
    menuFrame:EnableMouse(true)
    
    -- Position menu near cursor with smart positioning
    local x, y = GetCursorPosition()
    local scale = UIParent:GetEffectiveScale()
    x = x / scale
    y = y / scale
    
    -- Smart positioning to avoid screen edges
    local screenWidth = GetScreenWidth()
    local screenHeight = GetScreenHeight()
    
    if x + menuWidth > screenWidth then
        x = screenWidth - menuWidth - 10
    end
    if y - menuHeight < 0 then
        y = menuHeight + 10
    end
    
    menuFrame:SetPoint("BOTTOMLEFT", UIParent, "BOTTOMLEFT", x + 10, y - 10)
    
    -- Create scrollable content
    local container, content, scrollBar, updateScrollBar = CreateScrollableFrame(menuFrame, menuWidth - 10, menuHeight - 10)
    container:SetPoint("TOPLEFT", 5, -5)
    
    -- Add enchant buttons to scrollable content
    local yOffset = -5
    for i, enchant in ipairs(popularEnchants) do
        local enchantBtn = CreateStyledButton(content, enchant.name, menuWidth - 30, itemHeight - 2)
        enchantBtn:SetPoint("TOPLEFT", 5, yOffset)
        
        -- Add enchant icon
        if enchant.icon then
            local icon = enchantBtn:CreateTexture(nil, "ARTWORK")
            icon:SetSize(16, 16)
            icon:SetPoint("LEFT", 5, 0)
            icon:SetTexture(enchant.icon)
            
            -- Adjust text position to account for icon
            enchantBtn.text:SetPoint("LEFT", icon, "RIGHT", 5, 0)
        end
        
        -- Set up click handler
        enchantBtn:SetScript("OnClick", function()
            PlayerInventory.applyEnchantment(itemData, enchant.id, isEquipment, slot)
            menuFrame:Hide()
            PlayerInventory.closeContextMenu()
        end)
        
        -- Add tooltip
        enchantBtn:SetScript("OnEnter", function(self)
            GameTooltip:SetOwner(self, "ANCHOR_RIGHT")
            GameTooltip:SetText(enchant.name, 1, 1, 1)
            if enchant.description then
                GameTooltip:AddLine(enchant.description, 0.8, 0.8, 0.8, true)
            end
            GameTooltip:Show()
        end)
        
        enchantBtn:SetScript("OnLeave", function()
            GameTooltip:Hide()
        end)
        
        yOffset = yOffset - itemHeight
    end
    
    -- Set content height for scrolling
    content:SetHeight(math.max(#popularEnchants * itemHeight + 10, menuHeight - 10))
    updateScrollBar()
    
    -- Auto-hide functionality
    local hideTimer = CreateFrame("Frame")
    local mouseOverMenu = false
    
    menuFrame:SetScript("OnEnter", function() mouseOverMenu = true end)
    menuFrame:SetScript("OnLeave", function() 
        mouseOverMenu = false
        hideTimer:Show()
    end)
    
    local elapsed = 0
    hideTimer:SetScript("OnUpdate", function(self, delta)
        if not mouseOverMenu then
            elapsed = elapsed + delta
            if elapsed >= 0.5 then
                menuFrame:Hide()
                self:Hide()
            end
        else
            elapsed = 0
        end
    end)
    
    -- Close on escape
    menuFrame:SetScript("OnKeyDown", function(self, key)
        if key == "ESCAPE" then
            menuFrame:Hide()
        end
    end)
    menuFrame:EnableKeyboard(true)
    
    -- Store reference for cleanup
    PlayerInventory.currentScrollableMenu = menuFrame
    
    menuFrame:Show()
    return menuFrame
end

-- Forward declarations for functions defined in later-loading file
-- These will be replaced by the actual implementations when GMClient_07e_InventoryDialogs.lua loads
if not PlayerInventory.showAdvancedEnchantSelectionDialog then
    PlayerInventory.showAdvancedEnchantSelectionDialog = function(itemData, isEquipment, slot)
        -- Temporary fallback until the real function loads
        print("|cffff0000Advanced enchant dialog loading...|r")
        -- Try to use the search dialog as fallback
        if PlayerInventory.showEnchantSearchDialog then
            PlayerInventory.showEnchantSearchDialog(itemData, isEquipment, slot)
        else
            print("|cffff0000No enchant dialog available|r")
        end
    end
end

-- Debug message
if GMConfig and GMConfig.config and GMConfig.config.debug then
    print("[PlayerInventory] Enchantment menus module loaded")
end