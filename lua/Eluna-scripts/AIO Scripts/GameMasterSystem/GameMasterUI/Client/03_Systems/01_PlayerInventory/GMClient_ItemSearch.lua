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

-- Item categories for filtering
PlayerInventory.ITEM_CATEGORIES = {
    { value = "all", text = "All Items" },
    { value = "armor", text = "Armor" },
    { value = "weapon", text = "Weapons" },
    { value = "consumable", text = "Consumables" },
    { value = "trade", text = "Trade Goods" },
    { value = "reagent", text = "Reagents" },
    { value = "container", text = "Containers" },
    { value = "gem", text = "Gems" },
    { value = "glyph", text = "Glyphs" },
    { value = "misc", text = "Miscellaneous" },
    { value = "quest", text = "Quest Items" }
}

-- Item quality levels
PlayerInventory.ITEM_QUALITIES = {
    { value = -1, text = "Any Quality", color = {1, 1, 1} },
    { value = 0, text = "Poor", color = UISTYLE_COLORS.Poor },
    { value = 1, text = "Common", color = UISTYLE_COLORS.Common },
    { value = 2, text = "Uncommon", color = UISTYLE_COLORS.Uncommon },
    { value = 3, text = "Rare", color = UISTYLE_COLORS.Rare },
    { value = 4, text = "Epic", color = UISTYLE_COLORS.Epic },
    { value = 5, text = "Legendary", color = UISTYLE_COLORS.Legendary },
    { value = 6, text = "Artifact", color = UISTYLE_COLORS.Artifact or {1, 0.5, 0} }
}

-- Helper function to create modal overlay
local function CreateModalOverlay()
    local overlay = CreateFrame("Frame", nil, UIParent)
    overlay:SetFrameStrata("FULLSCREEN_DIALOG")
    overlay:SetFrameLevel(99)
    overlay:SetAllPoints(UIParent)
    overlay:EnableMouse(true)
    
    -- Semi-transparent background using WoW 3.3.5 compatible approach
    overlay.bg = overlay:CreateTexture(nil, "BACKGROUND")
    overlay.bg:SetAllPoints()
    overlay.bg:SetTexture("Interface\\Buttons\\WHITE8X8")  -- Use white texture
    overlay.bg:SetVertexColor(0, 0, 0, 0.8)  -- Tint it black with alpha
    
    return overlay
end

-- Main item search dialog
function PlayerInventory.showItemSearchDialog(slot, isEquipment)
    -- Close any existing context menu
    PlayerInventory.closeContextMenu()
    
    -- Create modal overlay
    local dialog = CreateModalOverlay()
    
    -- Main dialog frame
    local dialogFrame = CreateStyledFrame(dialog, UISTYLE_COLORS.DarkGrey)
    dialogFrame:SetSize(700, 650)
    dialogFrame:SetPoint("CENTER")
    dialogFrame:SetFrameStrata("FULLSCREEN_DIALOG")
    dialogFrame:SetFrameLevel(100)
    
    -- Title bar
    local titleBar = CreateStyledFrame(dialogFrame, UISTYLE_COLORS.SectionBg)
    titleBar:SetHeight(35)
    titleBar:SetPoint("TOPLEFT", 1, -1)
    titleBar:SetPoint("TOPRIGHT", -1, -1)
    
    -- Title text
    local title = titleBar:CreateFontString(nil, "OVERLAY", "GameFontNormalLarge")
    title:SetPoint("CENTER", titleBar, "CENTER", 0, 0)
    if isEquipment and slot.slotId then
        local slotName = PlayerInventory.INVENTORY_CONFIG.EQUIPMENT_SLOTS[slot.slotId] or "Equipment"
        title:SetText(string.format("Search Items for %s Slot", slotName))
    else
        title:SetText("Search Items")
    end
    title:SetTextColor(UISTYLE_COLORS.Blue[1], UISTYLE_COLORS.Blue[2], UISTYLE_COLORS.Blue[3])
    
    -- Close button
    local closeBtn = CreateStyledButton(titleBar, "×", 26, 26)
    closeBtn:SetPoint("RIGHT", titleBar, "RIGHT", -4, 0)
    closeBtn:SetScript("OnClick", function()
        dialog:Hide()
    end)
    
    -- Forward declare performSearch function so it can be used in dropdown callbacks
    local performSearch
    
    -- Search section
    local searchSection = CreateStyledFrame(dialogFrame, UISTYLE_COLORS.ContentBg)
    searchSection:SetHeight(100)
    searchSection:SetPoint("TOPLEFT", titleBar, "BOTTOMLEFT", 5, -5)
    searchSection:SetPoint("TOPRIGHT", titleBar, "BOTTOMRIGHT", -5, -5)
    
    -- Search box
    local searchBox = CreateStyledEditBox(searchSection, 400, false, 255)
    searchBox:SetPoint("TOP", searchSection, "TOP", 0, -15)
    
    -- Get the actual EditBox from the container
    local searchEditBox = searchBox.editBox
    searchEditBox:SetTextColor(1, 1, 1)
    
    -- Placeholder text handling
    local placeholderText = "Search by name or item ID..."
    searchEditBox:SetText(placeholderText)
    searchEditBox:SetTextColor(0.5, 0.5, 0.5)
    
    searchEditBox:SetScript("OnEditFocusGained", function(self)
        if self:GetText() == placeholderText then
            self:SetText("")
            self:SetTextColor(1, 1, 1)
        end
    end)
    
    searchEditBox:SetScript("OnEditFocusLost", function(self)
        if self:GetText() == "" then
            self:SetText(placeholderText)
            self:SetTextColor(0.5, 0.5, 0.5)
        end
    end)
    
    -- Filter containers (3 rows for better organization)
    -- Row 1: Category and Quality dropdowns
    local filterRow1 = CreateFrame("Frame", nil, searchSection)
    filterRow1:SetHeight(30)
    filterRow1:SetPoint("TOPLEFT", searchBox, "BOTTOMLEFT", -50, -10)
    filterRow1:SetPoint("TOPRIGHT", searchBox, "BOTTOMRIGHT", 50, -10)
    
    -- Category dropdown
    local categoryLabel = filterRow1:CreateFontString(nil, "OVERLAY", "GameFontNormalSmall")
    categoryLabel:SetPoint("LEFT", filterRow1, "LEFT", 0, 0)
    categoryLabel:SetText("Category:")
    categoryLabel:SetTextColor(0.8, 0.8, 0.8)
    
    local categoryDropdown, categoryMenu = CreateFullyStyledDropdown(filterRow1, 120, 
        PlayerInventory.ITEM_CATEGORIES, 
        "all",
        function(value)
            dialog.selectedCategory = value
            performSearch()
        end)
    categoryDropdown:SetPoint("LEFT", categoryLabel, "RIGHT", 5, 0)
    dialog.categoryDropdown = categoryDropdown
    dialog.selectedCategory = "all"
    
    -- Quality dropdown
    local qualityLabel = filterRow1:CreateFontString(nil, "OVERLAY", "GameFontNormalSmall")
    qualityLabel:SetPoint("LEFT", categoryDropdown, "RIGHT", 20, 0)
    qualityLabel:SetText("Quality:")
    qualityLabel:SetTextColor(0.8, 0.8, 0.8)
    
    -- Convert quality data for dropdown
    local qualityItems = {}
    for _, q in ipairs(PlayerInventory.ITEM_QUALITIES) do
        table.insert(qualityItems, {value = q.value, text = q.text})
    end
    
    local qualityDropdown, qualityMenu = CreateFullyStyledDropdown(filterRow1, 120,
        qualityItems,
        -1,
        function(value)
            dialog.selectedQuality = value
            performSearch()
        end)
    qualityDropdown:SetPoint("LEFT", qualityLabel, "RIGHT", 5, 0)
    dialog.qualityDropdown = qualityDropdown
    dialog.selectedQuality = -1
    
    -- Row 2: Level and Item Level ranges
    local filterRow2 = CreateFrame("Frame", nil, searchSection)
    filterRow2:SetHeight(30)
    filterRow2:SetPoint("TOPLEFT", filterRow1, "BOTTOMLEFT", 0, -5)
    filterRow2:SetPoint("TOPRIGHT", filterRow1, "BOTTOMRIGHT", 0, -5)
    
    -- Required Level range
    local levelLabel = filterRow2:CreateFontString(nil, "OVERLAY", "GameFontNormalSmall")
    levelLabel:SetPoint("LEFT", filterRow2, "LEFT", 0, 0)
    levelLabel:SetText("Level:")
    levelLabel:SetTextColor(0.8, 0.8, 0.8)
    
    local minLevelBox = CreateStyledEditBox(filterRow2, 40, true, 2)
    minLevelBox:SetPoint("LEFT", levelLabel, "RIGHT", 5, 0)
    local minLevelEdit = minLevelBox.editBox
    minLevelEdit:SetText("")
    minLevelEdit:SetTextColor(1, 1, 1)
    dialog.minLevelBox = minLevelEdit
    
    local levelDash = filterRow2:CreateFontString(nil, "OVERLAY", "GameFontNormalSmall")
    levelDash:SetPoint("LEFT", minLevelBox, "RIGHT", 3, 0)
    levelDash:SetText("-")
    levelDash:SetTextColor(0.8, 0.8, 0.8)
    
    local maxLevelBox = CreateStyledEditBox(filterRow2, 40, true, 2)
    maxLevelBox:SetPoint("LEFT", levelDash, "RIGHT", 3, 0)
    local maxLevelEdit = maxLevelBox.editBox
    maxLevelEdit:SetText("")
    maxLevelEdit:SetTextColor(1, 1, 1)
    dialog.maxLevelBox = maxLevelEdit
    
    -- Item Level range
    local iLevelLabel = filterRow2:CreateFontString(nil, "OVERLAY", "GameFontNormalSmall")
    iLevelLabel:SetPoint("LEFT", maxLevelBox, "RIGHT", 20, 0)
    iLevelLabel:SetText("iLvl:")
    iLevelLabel:SetTextColor(0.8, 0.8, 0.8)
    
    local minILevelBox = CreateStyledEditBox(filterRow2, 40, true, 3)
    minILevelBox:SetPoint("LEFT", iLevelLabel, "RIGHT", 5, 0)
    local minILevelEdit = minILevelBox.editBox
    minILevelEdit:SetText("")
    minILevelEdit:SetTextColor(1, 1, 1)
    dialog.minILevelBox = minILevelEdit
    
    local iLevelDash = filterRow2:CreateFontString(nil, "OVERLAY", "GameFontNormalSmall")
    iLevelDash:SetPoint("LEFT", minILevelBox, "RIGHT", 3, 0)
    iLevelDash:SetText("-")
    iLevelDash:SetTextColor(0.8, 0.8, 0.8)
    
    local maxILevelBox = CreateStyledEditBox(filterRow2, 40, true, 3)
    maxILevelBox:SetPoint("LEFT", iLevelDash, "RIGHT", 3, 0)
    local maxILevelEdit = maxILevelBox.editBox
    maxILevelEdit:SetText("")
    maxILevelEdit:SetTextColor(1, 1, 1)
    dialog.maxILevelBox = maxILevelEdit
    
    -- Row 3: Stackable checkbox and Sort options
    local filterRow3 = CreateFrame("Frame", nil, searchSection)
    filterRow3:SetHeight(30)
    filterRow3:SetPoint("TOPLEFT", filterRow2, "BOTTOMLEFT", 0, -5)
    filterRow3:SetPoint("TOPRIGHT", filterRow2, "BOTTOMRIGHT", 0, -5)
    
    -- Stackable checkbox
    local stackableCheck = CreateFrame("CheckButton", nil, filterRow3, "UICheckButtonTemplate")
    stackableCheck:SetPoint("LEFT", filterRow3, "LEFT", 0, 0)
    stackableCheck:SetSize(24, 24)
    stackableCheck:SetScript("OnClick", function(self)
        dialog.stackableOnly = self:GetChecked()
        performSearch()
    end)
    dialog.stackableCheck = stackableCheck
    
    local stackableLabel = filterRow3:CreateFontString(nil, "OVERLAY", "GameFontNormalSmall")
    stackableLabel:SetPoint("LEFT", stackableCheck, "RIGHT", 2, 0)
    stackableLabel:SetText("Stackable Only")
    stackableLabel:SetTextColor(0.8, 0.8, 0.8)
    
    -- Sort dropdown
    local sortLabel = filterRow3:CreateFontString(nil, "OVERLAY", "GameFontNormalSmall")
    sortLabel:SetPoint("LEFT", stackableLabel, "RIGHT", 20, 0)
    sortLabel:SetText("Sort:")
    sortLabel:SetTextColor(0.8, 0.8, 0.8)
    
    local sortOptions = {
        {value = "ItemLevel", text = "Item Level"},
        {value = "RequiredLevel", text = "Required Level"},
        {value = "name", text = "Name"},
        {value = "Quality", text = "Quality"}
    }
    
    local sortDropdown, sortMenu = CreateFullyStyledDropdown(filterRow3, 120,
        sortOptions,
        "ItemLevel",
        function(value)
            dialog.sortBy = value
            performSearch()
        end)
    sortDropdown:SetPoint("LEFT", sortLabel, "RIGHT", 5, 0)
    dialog.sortDropdown = sortDropdown
    dialog.sortBy = "ItemLevel"
    
    -- Sort order button (toggle between ASC/DESC)
    local sortOrderBtn = CreateStyledButton(filterRow3, "↓", 24, 24)
    sortOrderBtn:SetPoint("LEFT", sortDropdown, "RIGHT", 5, 0)
    sortOrderBtn:SetScript("OnClick", function(self)
        if dialog.sortOrder == "DESC" then
            dialog.sortOrder = "ASC"
            self:SetText("↑")
        else
            dialog.sortOrder = "DESC"
            self:SetText("↓")
        end
        performSearch()
    end)
    dialog.sortOrderBtn = sortOrderBtn
    dialog.sortOrder = "DESC"
    
    -- Adjust search section height for new rows
    searchSection:SetHeight(150)
    
    -- Results section
    local resultsSection = CreateStyledFrame(dialogFrame, UISTYLE_COLORS.ContentBg)
    resultsSection:SetPoint("TOPLEFT", searchSection, "BOTTOMLEFT", 0, -5)
    resultsSection:SetPoint("BOTTOMRIGHT", dialogFrame, "BOTTOMRIGHT", -5, 5)
    
    -- Results header
    local resultsHeader = CreateStyledFrame(resultsSection, UISTYLE_COLORS.SectionBg)
    resultsHeader:SetHeight(25)
    resultsHeader:SetPoint("TOPLEFT", 1, -1)
    resultsHeader:SetPoint("TOPRIGHT", -1, -1)
    
    local resultsText = resultsHeader:CreateFontString(nil, "OVERLAY", "GameFontNormal")
    resultsText:SetPoint("LEFT", resultsHeader, "LEFT", 10, 0)
    resultsText:SetText("Search Results (0)")
    resultsText:SetTextColor(UISTYLE_COLORS.Gold[1], UISTYLE_COLORS.Gold[2], UISTYLE_COLORS.Gold[3])
    dialog.resultsText = resultsText
    
    -- Create scrollable results area
    local scrollContainer = CreateFrame("Frame", nil, resultsSection)
    scrollContainer:SetPoint("TOPLEFT", resultsHeader, "BOTTOMLEFT", 5, -5)
    scrollContainer:SetPoint("BOTTOMRIGHT", resultsSection, "BOTTOMRIGHT", -25, 5)
    
    local scrollFrame = CreateFrame("ScrollFrame", nil, scrollContainer)
    scrollFrame:SetAllPoints()
    
    local content = CreateFrame("Frame", nil, scrollFrame)
    content:SetWidth(scrollContainer:GetWidth() - 20)
    content:SetHeight(1)
    scrollFrame:SetScrollChild(content)
    
    -- Scrollbar
    local scrollBar = CreateFrame("Slider", nil, scrollFrame, "UIPanelScrollBarTemplate")
    scrollBar:SetPoint("TOPLEFT", scrollFrame, "TOPRIGHT", 4, -16)
    scrollBar:SetPoint("BOTTOMLEFT", scrollFrame, "BOTTOMRIGHT", 4, 16)
    scrollBar:SetMinMaxValues(0, 0)
    scrollBar:SetValueStep(20)
    scrollBar:SetValue(0)
    scrollBar:SetWidth(16)
    
    local function updateScrollBar()
        local maxScroll = math.max(0, content:GetHeight() - scrollContainer:GetHeight())
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
    
    -- Store references
    dialog.content = content
    dialog.updateScrollBar = updateScrollBar
    dialog.searchResults = {}
    dialog.slot = slot
    dialog.isEquipment = isEquipment
    
    -- Define performSearch function (was forward declared earlier)
    performSearch = function()
        local searchText = searchEditBox:GetText()
        if searchText == placeholderText then
            searchText = ""
        end
        
        -- Clear existing results
        for _, result in ipairs(dialog.searchResults) do
            if result and result.Hide then
                result:Hide()
                -- Only set parent to nil for frames, not font strings
                if result.SetParent and result:GetObjectType() == "Frame" then
                    result:SetParent(nil)
                end
            end
        end
        dialog.searchResults = {}
        
        -- Collect all filter values with validation
        local minLevelText = dialog.minLevelBox:GetText()
        local maxLevelText = dialog.maxLevelBox:GetText()
        local minILevelText = dialog.minILevelBox:GetText()
        local maxILevelText = dialog.maxILevelBox:GetText()
        
        -- Validate and set defaults for empty or invalid inputs
        local minLevel = (minLevelText ~= "" and tonumber(minLevelText)) or 0
        local maxLevel = (maxLevelText ~= "" and tonumber(maxLevelText)) or 85
        local minILevel = (minILevelText ~= "" and tonumber(minILevelText)) or 0
        local maxILevel = (maxILevelText ~= "" and tonumber(maxILevelText)) or 999
        
        -- Ensure min is not greater than max
        if minLevel > maxLevel then
            minLevel, maxLevel = maxLevel, minLevel
        end
        if minILevel > maxILevel then
            minILevel, maxILevel = maxILevel, minILevel
        end
        local stackableOnly = dialog.stackableCheck:GetChecked() or false
        local sortBy = dialog.sortBy or "ItemLevel"
        local sortOrder = dialog.sortOrder or "DESC"
        
        -- Request search from server with all filters
        AIO.Handle("GameMasterSystem", "searchItems", 
                   searchText, 
                   dialog.selectedCategory, 
                   dialog.selectedQuality, 
                   (dialog.isEquipment and dialog.slot and dialog.slot.slotId) or nil,
                   minLevel, maxLevel,
                   minILevel, maxILevel,
                   stackableOnly,
                   sortBy, sortOrder)
        
        -- Update results text
        dialog.resultsText:SetText("Searching...")
    end
    
    -- Search on text change (with delay)
    local searchTimer = CreateFrame("Frame")
    local searchDelay = 0
    searchTimer:SetScript("OnUpdate", function(self, elapsed)
        searchDelay = searchDelay - elapsed
        if searchDelay <= 0 then
            self:Hide()
            performSearch()
        end
    end)
    searchTimer:Hide()
    
    -- Function to trigger delayed search
    local function triggerDelayedSearch()
        searchDelay = 0.5  -- 500ms delay
        searchTimer:Show()
    end
    
    -- Apply delayed search to all input fields
    searchEditBox:SetScript("OnTextChanged", function(self)
        if self:GetText() ~= placeholderText then
            triggerDelayedSearch()
        end
    end)
    
    minLevelEdit:SetScript("OnTextChanged", triggerDelayedSearch)
    maxLevelEdit:SetScript("OnTextChanged", triggerDelayedSearch)
    minILevelEdit:SetScript("OnTextChanged", triggerDelayedSearch)
    maxILevelEdit:SetScript("OnTextChanged", triggerDelayedSearch)
    
    -- Store dialog reference
    PlayerInventory.currentItemSearchDialog = dialog
    
    -- Initial search (show popular items)
    performSearch()
    
    -- Focus search box
    searchEditBox:SetFocus()
    
    dialog:Show()
    return dialog
end

-- Handle search results from server
function PlayerInventory.receiveItemSearchResults(player, results)
    local dialog = PlayerInventory.currentItemSearchDialog
    if not dialog or not dialog:IsShown() then
        return
    end
    
    -- Clear existing results
    for _, result in ipairs(dialog.searchResults) do
        if result and result.Hide then
            result:Hide()
            -- Only set parent to nil for frames, not font strings
            if result.SetParent and result:GetObjectType() == "Frame" then
                result:SetParent(nil)
            end
        end
    end
    dialog.searchResults = {}
    
    -- Update results count
    dialog.resultsText:SetText(string.format("Search Results (%d)", #results))
    
    -- Create result entries
    local yOffset = -5
    for i, item in ipairs(results) do
        -- Create result frame
        local resultFrame = CreateStyledFrame(dialog.content, UISTYLE_COLORS.OptionBg)
        resultFrame:SetHeight(50)
        resultFrame:SetPoint("TOPLEFT", 5, yOffset)
        resultFrame:SetPoint("TOPRIGHT", -5, yOffset)
        resultFrame:EnableMouse(true)
        
        -- Item icon
        local icon = resultFrame:CreateTexture(nil, "ARTWORK")
        icon:SetSize(40, 40)
        icon:SetPoint("LEFT", 5, 0)
        icon:SetTexture(item.icon or "Interface\\Icons\\INV_Misc_QuestionMark")
        
        -- Quality border for icon
        local border = resultFrame:CreateTexture(nil, "OVERLAY")
        border:SetSize(42, 42)
        border:SetPoint("CENTER", icon, "CENTER")
        border:SetTexture("Interface\\Common\\WhiteIconFrame")
        local qualityColor = PlayerInventory.getItemQualityColor(item.quality or 1)
        border:SetVertexColor(qualityColor[1], qualityColor[2], qualityColor[3])
        
        -- Item name
        local nameText = resultFrame:CreateFontString(nil, "OVERLAY", "GameFontNormal")
        nameText:SetPoint("LEFT", icon, "RIGHT", 10, 10)
        nameText:SetText(item.name or "Unknown Item")
        nameText:SetTextColor(qualityColor[1], qualityColor[2], qualityColor[3])
        
        -- Item info
        local infoText = resultFrame:CreateFontString(nil, "OVERLAY", "GameFontNormalSmall")
        infoText:SetPoint("LEFT", icon, "RIGHT", 10, -10)
        local reqLvl = item.requiredLevel or 0
        local iLvl = item.level or 0
        infoText:SetText(string.format("ID: %d | Req Lvl: %d | iLvl: %d | %s", 
            item.entry or 0, reqLvl, iLvl, item.type or "Unknown"))
        infoText:SetTextColor(0.7, 0.7, 0.7)
        
        -- Add button
        local addBtn = CreateStyledButton(resultFrame, "Add", 60, 30)
        addBtn:SetPoint("RIGHT", resultFrame, "RIGHT", -10, 0)
        
        -- Quantity selector for stackable items
        local quantityBox = nil
        local quantityEditBox = nil
        if item.stackable then
            quantityBox = CreateStyledEditBox(resultFrame, 50, true, 4)
            quantityBox:SetPoint("RIGHT", addBtn, "LEFT", -5, 0)
            quantityEditBox = quantityBox.editBox
            quantityEditBox:SetText("1")
            quantityEditBox:SetTextColor(1, 1, 1)
            
            local qtyLabel = resultFrame:CreateFontString(nil, "OVERLAY", "GameFontNormalSmall")
            qtyLabel:SetPoint("RIGHT", quantityBox, "LEFT", -5, 0)
            qtyLabel:SetText("Qty:")
            qtyLabel:SetTextColor(0.8, 0.8, 0.8)
        end
        
        -- Add button click handler
        addBtn:SetScript("OnClick", function()
            local quantity = 1
            if quantityEditBox then
                quantity = tonumber(quantityEditBox:GetText()) or 1
                -- Validate quantity
                if quantity <= 0 then
                    print("Invalid quantity. Please enter a positive number.")
                    return
                end
                if quantity > 1000 then
                    print("Quantity too large. Maximum is 1000.")
                    return
                end
            end
            
            -- Validate slot exists
            if not dialog.slot then
                print("Error: No slot selected for this item.")
                return
            end
            
            if dialog.isEquipment then
                -- For equipment slots, equip the item
                AIO.Handle("GameMasterSystem", "equipItemById",
                    PlayerInventory.currentPlayerName, item.entry, dialog.slot.slotId)
                print(string.format("Attempting to equip %s...", item.name))
            else
                -- For inventory slots, add to specific bag/slot
                AIO.Handle("GameMasterSystem", "addItemToSpecificSlot",
                    PlayerInventory.currentPlayerName, item.entry, quantity,
                    dialog.slot.bagId or 0, dialog.slot.slotId or 0)
                -- Display slot as 1-based for user (internal is 0-based)
                print(string.format("Adding %dx %s to inventory...",
                    quantity, item.name))
            end
            
            -- Update button to show it's processing
            addBtn:SetText("Adding...")
            addBtn:Disable()
            
            -- Set flag to indicate we're waiting for update
            dialog.waitingForUpdate = true
            
            -- Add a small delay before closing to prevent rapid clicking
            local closeTimer = CreateFrame("Frame")
            local closeDelay = 0.5
            closeTimer:SetScript("OnUpdate", function(self, elapsed)
                closeDelay = closeDelay - elapsed
                if closeDelay <= 0 then
                    self:SetScript("OnUpdate", nil)
                    if dialog and dialog:IsShown() then
                        dialog:Hide()
                    end
                end
            end)
            
            -- The server will send refreshInventoryDisplay which will update the UI
        end)
        
        -- Hover effect
        resultFrame:SetScript("OnEnter", function(self)
            self:SetBackdropColor(0.3, 0.3, 0.3, 1)
            
            -- Show tooltip
            GameTooltip:SetOwner(self, "ANCHOR_RIGHT")
            GameTooltip:SetHyperlink(string.format("item:%d:0:0:0:0:0:0:0", item.entry))
            GameTooltip:Show()
        end)
        
        resultFrame:SetScript("OnLeave", function(self)
            self:SetBackdropColor(UISTYLE_COLORS.OptionBg[1], UISTYLE_COLORS.OptionBg[2], 
                                   UISTYLE_COLORS.OptionBg[3], 1)
            GameTooltip:Hide()
        end)
        
        table.insert(dialog.searchResults, resultFrame)
        yOffset = yOffset - 55
    end
    
    -- Update content height
    dialog.content:SetHeight(math.max(400, #results * 55 + 10))
    dialog.updateScrollBar()
    
    -- Show message if no results
    if #results == 0 then
        local noResultsText = dialog.content:CreateFontString(nil, "OVERLAY", "GameFontNormal")
        noResultsText:SetPoint("CENTER", dialog.content, "CENTER", 0, 0)
        noResultsText:SetText("No items found matching your search criteria")
        noResultsText:SetTextColor(0.5, 0.5, 0.5)
        table.insert(dialog.searchResults, noResultsText)
    end
end

-- Sample items for testing when server doesn't provide search
function PlayerInventory.getSampleItems(searchText, category, quality, slotId)
    local sampleItems = {
        -- Weapons
        { entry = 49623, name = "Shadowmourne", icon = "Interface\\Icons\\INV_Axe_113", quality = 5, level = 284, type = "Weapon", stackable = false },
        { entry = 46017, name = "Val'anyr, Hammer of Ancient Kings", icon = "Interface\\Icons\\INV_Mace_99", quality = 5, level = 245, type = "Weapon", stackable = false },
        { entry = 19019, name = "Thunderfury, Blessed Blade of the Windseeker", icon = "Interface\\Icons\\INV_Sword_39", quality = 5, level = 80, type = "Weapon", stackable = false },
        { entry = 47834, name = "Fordragon Blades", icon = "Interface\\Icons\\INV_Sword_163", quality = 4, level = 258, type = "Weapon", stackable = false },
        
        -- Armor
        { entry = 51227, name = "Sanctified Ymirjar Lord's Battleplate", icon = "Interface\\Icons\\INV_Chest_Plate_25", quality = 4, level = 277, type = "Armor", stackable = false },
        { entry = 51226, name = "Sanctified Ymirjar Lord's Helmet", icon = "Interface\\Icons\\INV_Helmet_96", quality = 4, level = 277, type = "Armor", stackable = false },
        { entry = 51200, name = "Sanctified Frost Witch's Tunic", icon = "Interface\\Icons\\INV_Chest_Mail_11", quality = 4, level = 277, type = "Armor", stackable = false },
        { entry = 50733, name = "Fal'inrush, Defender of Quel'thalas", icon = "Interface\\Icons\\INV_Misc_Cape_16", quality = 4, level = 277, type = "Armor", stackable = false },
        
        -- Consumables
        { entry = 46377, name = "Flask of Endless Rage", icon = "Interface\\Icons\\INV_Alchemy_EndlessFlask_04", quality = 1, level = 80, type = "Consumable", stackable = true },
        { entry = 46379, name = "Flask of Stoneblood", icon = "Interface\\Icons\\INV_Alchemy_EndlessFlask_05", quality = 1, level = 80, type = "Consumable", stackable = true },
        { entry = 40211, name = "Potion of Speed", icon = "Interface\\Icons\\INV_Alchemy_Elixir_04", quality = 1, level = 70, type = "Consumable", stackable = true },
        { entry = 43015, name = "Fish Feast", icon = "Interface\\Icons\\INV_Misc_Fish_52", quality = 1, level = 80, type = "Consumable", stackable = true },
        { entry = 34722, name = "Heavy Frostweave Bandage", icon = "Interface\\Icons\\INV_Misc_Bandage_Frostweave_Heavy", quality = 1, level = 75, type = "Consumable", stackable = true },
        
        -- Gems
        { entry = 40119, name = "Solid Majestic Zircon", icon = "Interface\\Icons\\INV_Jewelcrafting_Gem_42", quality = 4, level = 80, type = "Gem", stackable = true },
        { entry = 40125, name = "Rigid King's Amber", icon = "Interface\\Icons\\INV_Jewelcrafting_Gem_38", quality = 4, level = 80, type = "Gem", stackable = true },
        { entry = 40133, name = "Purified Dreadstone", icon = "Interface\\Icons\\INV_Jewelcrafting_Gem_40", quality = 4, level = 80, type = "Gem", stackable = true },
        
        -- Materials
        { entry = 36913, name = "Saronite Bar", icon = "Interface\\Icons\\INV_Ingot_Yoggthorite", quality = 1, level = 75, type = "Trade Goods", stackable = true },
        { entry = 35622, name = "Eternal Water", icon = "Interface\\Icons\\INV_Elemental_Eternal_Water", quality = 2, level = 80, type = "Trade Goods", stackable = true },
        { entry = 35623, name = "Eternal Air", icon = "Interface\\Icons\\INV_Elemental_Eternal_Air", quality = 2, level = 80, type = "Trade Goods", stackable = true },
    }
    
    -- Filter by search text
    local filtered = {}
    local searchLower = string.lower(searchText or "")
    
    for _, item in ipairs(sampleItems) do
        local matchesSearch = searchText == "" or 
                             string.find(string.lower(item.name), searchLower) or
                             tostring(item.entry) == searchText
        
        local matchesCategory = category == "all" or 
                               (category == "weapon" and item.type == "Weapon") or
                               (category == "armor" and item.type == "Armor") or
                               (category == "consumable" and item.type == "Consumable") or
                               (category == "gem" and item.type == "Gem") or
                               (category == "trade" and item.type == "Trade Goods")
        
        local matchesQuality = quality == -1 or item.quality == quality
        
        -- For equipment slots, filter by appropriate items
        local matchesSlot = true
        if slotId then
            if slotId == 15 or slotId == 16 or slotId == 17 then
                -- Weapon slots
                matchesSlot = item.type == "Weapon"
            elseif slotId == 0 then
                -- Head slot
                matchesSlot = string.find(string.lower(item.name), "helmet") or 
                             string.find(string.lower(item.name), "helm") or
                             string.find(string.lower(item.name), "hood")
            elseif slotId == 4 then
                -- Chest slot
                matchesSlot = string.find(string.lower(item.name), "chest") or
                             string.find(string.lower(item.name), "tunic") or
                             string.find(string.lower(item.name), "battleplate") or
                             string.find(string.lower(item.name), "robe")
            end
        end
        
        if matchesSearch and matchesCategory and matchesQuality and matchesSlot then
            table.insert(filtered, item)
        end
    end
    
    -- Limit results for performance
    local results = {}
    for i = 1, math.min(50, #filtered) do
        table.insert(results, filtered[i])
    end
    
    return results
end

-- Register handler with GameMasterSystem
GameMasterSystem.receiveItemSearchResults = PlayerInventory.receiveItemSearchResults

-- Debug message
if GMConfig and GMConfig.config and GMConfig.config.debug then
    print("[PlayerInventory] Item search module loaded")
end