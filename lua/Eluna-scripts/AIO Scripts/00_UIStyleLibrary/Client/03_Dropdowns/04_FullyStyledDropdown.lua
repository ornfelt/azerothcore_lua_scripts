local AIO = AIO or require("AIO")

if AIO.AddAddon() then
    return
end

-- ===================================
-- UI STYLE LIBRARY FULLY STYLED DROPDOWNS MODULE
-- ===================================
-- Complete custom dropdown with nested menu support

--[[
Creates a fully custom styled dropdown with nested menu support
@param parent - Parent frame
@param width - Dropdown width
@param items - Table of menu items (can be nested)
@param defaultValue - Default selected value
@param onSelect - Callback function(value, item) when item is selected
@param enableSearch - Optional boolean, enables integrated search bar (default: false)
@param searchPlaceholder - Optional string, placeholder text for search box (default: "Search...")
@return dropdownButton, menuFrame - The dropdown button and menu frame
]]
function CreateFullyStyledDropdown(parent, width, items, defaultValue, onSelect, enableSearch, searchPlaceholder)
    -- Validate required parameters
    if not items or type(items) ~= "table" then
        items = {} -- Default to empty table if items is nil or not a table
    end

    -- Create main button
    local dropdownButton = CreateStyledButton(parent, defaultValue or "Select...", width, 26)
    dropdownButton.value = defaultValue

    -- Add dropdown arrow using shared helper
    CreateDropdownArrow(dropdownButton)

    -- Search configuration
    enableSearch = enableSearch or false
    searchPlaceholder = searchPlaceholder or "Search..."
    local originalItems = items -- Store original items for filtering
    local filteredItems = items -- Current filtered items
    local searchText = "" -- Current search text

    -- Menu management variables
    local activeMenus = {}
    local menuLevel = 0

    -- Configuration for scrollable menus
    local SEARCH_HEIGHT = 32 -- Height of search bar when enabled (increased for better spacing)
    local MAX_MENU_HEIGHT = 250  -- Maximum height before scrolling (increased for better visibility)
    local SCROLLBAR_WIDTH = 14 -- Slightly wider scrollbar for better usability

    -- Adjust max height if search is enabled
    if enableSearch then
        MAX_MENU_HEIGHT = MAX_MENU_HEIGHT + SEARCH_HEIGHT
    end

    -- Create menu frame function
    local function createMenuFrame(level)
        local menuFrame = CreateStyledFrame(UIParent, UISTYLE_COLORS.ButtonBg)

        -- Check parent's frame strata and set accordingly
        local parentStrata = parent:GetFrameStrata()
        if parentStrata == "TOOLTIP" then
            -- If parent is at TOOLTIP level, use TOOLTIP for dropdown too
            menuFrame:SetFrameStrata("TOOLTIP")
            menuFrame:SetFrameLevel(parent:GetFrameLevel() + 10 + level * 10)
        else
            -- Default behavior for normal dropdowns
            menuFrame:SetFrameStrata("FULLSCREEN_DIALOG")
            menuFrame:SetFrameLevel(100 + level * 10)
        end

        menuFrame:SetWidth(width)
        menuFrame:Hide()

        menuFrame.level = level
        menuFrame.items = {}

        return menuFrame
    end

    -- Process menu item (recursive for nested menus)
    local function processMenuItem(itemData, parentMenu, index)
        local itemHeight = 22
        local menuItem = CreateFrame("Button", nil, parentMenu)
        menuItem:SetHeight(itemHeight)
        menuItem:SetPoint("LEFT", 2, 0)
        menuItem:SetPoint("RIGHT", -2, 0)

        -- Initialize items table if it doesn't exist
        if not parentMenu.items then
            parentMenu.items = {}
        end

        -- Set frame level to ensure proper rendering in nested menus
        menuItem:SetFrameLevel(parentMenu:GetFrameLevel() + 1)

        if index == 1 then
            menuItem:SetPoint("TOP", 0, -4) -- More padding at top for first item
        else
            menuItem:SetPoint("TOP", parentMenu.items[index - 1], "BOTTOM", 0, 0)
        end

        -- Handle different item types
        if type(itemData) == "table" and itemData.isSeparator then
            -- Separator
            menuItem:SetHeight(7)
            local line = menuItem:CreateTexture(nil, "OVERLAY")
            line:SetTexture("Interface\\Buttons\\WHITE8X8")
            line:SetVertexColor(0.3, 0.3, 0.3, 0.5)
            line:SetHeight(1)
            line:SetPoint("LEFT", 10, 0)
            line:SetPoint("RIGHT", -10, 0)
            menuItem:EnableMouse(false)

        elseif type(itemData) == "table" and itemData.isTitle then
            -- Title
            menuItem:SetHeight(24)
            local titleText = menuItem:CreateFontString(nil, "OVERLAY", "GameFontNormal")
            titleText:SetPoint("CENTER")
            titleText:SetText(itemData.text or "")
            titleText:SetTextColor(1, 0.82, 0, 1)
            menuItem:EnableMouse(false)

        else
            -- Regular item or submenu - add background (use button styling for visibility)
            menuItem:SetBackdrop(UISTYLE_BACKDROPS.Solid)
            menuItem:SetBackdropColor(UISTYLE_COLORS.ButtonBg[1], UISTYLE_COLORS.ButtonBg[2], UISTYLE_COLORS.ButtonBg[3], 1)

            local itemText = ""
            local itemValue = ""
            local hasArrow = false
            local menuList = nil
            local icon = nil
            local isChecked = false
            local func = nil

            if type(itemData) == "string" then
                itemText = itemData
                itemValue = itemData
            elseif type(itemData) == "table" then
                itemText = itemData.text or ""
                itemValue = itemData.value or itemText
                hasArrow = itemData.hasArrow
                menuList = itemData.menuList
                icon = itemData.icon
                isChecked = itemData.checked
                func = itemData.func
            end

            -- Checkbox/radio button
            if type(itemData) == "table" and (itemData.isRadio or isChecked ~= nil) then
                local check = menuItem:CreateTexture(nil, "ARTWORK")
                check:SetSize(16, 16)
                check:SetPoint("LEFT", 4, 0)
                if isChecked then
                    if itemData.isRadio then
                        check:SetTexture("Interface\\Buttons\\UI-RadioButton")
                        check:SetTexCoord(0.25, 0.5, 0, 1)
                    else
                        check:SetTexture("Interface\\Buttons\\UI-CheckBox-Check")
                    end
                end
                menuItem.check = check
            end

            -- Icon
            if icon then
                local iconTexture = menuItem:CreateTexture(nil, "ARTWORK")
                iconTexture:SetSize(16, 16)
                iconTexture:SetPoint("LEFT", menuItem.check and 24 or 4, 0)
                iconTexture:SetTexture(icon)
                menuItem.icon = iconTexture
            end

            -- Text
            local text = menuItem:CreateFontString(nil, "OVERLAY", "GameFontNormalSmall")
            local leftOffset = 8
            if menuItem.check then leftOffset = leftOffset + 20 end
            if menuItem.icon then leftOffset = leftOffset + 20 end
            text:SetPoint("LEFT", leftOffset, 0)
            text:SetText(itemText)
            text:SetTextColor(UISTYLE_COLORS.TextGrey[1], UISTYLE_COLORS.TextGrey[2], UISTYLE_COLORS.TextGrey[3], 1)
            text:SetJustifyH("LEFT")
            menuItem.text = text

            -- Arrow for submenus
            if hasArrow and menuList then
                local arrowText = menuItem:CreateFontString(nil, "OVERLAY", "GameFontNormalSmall")
                arrowText:SetPoint("RIGHT", -8, 0)
                arrowText:SetText(">")
                arrowText:SetTextColor(UISTYLE_COLORS.TextGrey[1], UISTYLE_COLORS.TextGrey[2], UISTYLE_COLORS.TextGrey[3], 1)
                menuItem.arrow = arrowText

                -- Adjust text width for arrow
                text:SetPoint("RIGHT", arrowText, "LEFT", -5, 0)
            else
                text:SetPoint("RIGHT", -8, 0)
            end

            -- Highlight
            local highlight = menuItem:CreateTexture(nil, "HIGHLIGHT")
            highlight:SetTexture("Interface\\Buttons\\WHITE8X8")
            highlight:SetVertexColor(1, 1, 1, 0.1)
            highlight:SetPoint("LEFT", 1, 0)
            highlight:SetPoint("RIGHT", -1, 0)
            highlight:SetHeight(itemHeight - 2)

            -- Store data
            menuItem.data = itemData
            menuItem.value = itemValue
            menuItem.hasSubmenu = hasArrow and menuList
            menuItem.menuList = menuList
            menuItem.func = func

            -- Click handler
            menuItem:SetScript("OnClick", function(self)
                if not self.hasSubmenu then
                    -- Handle checkbox toggling
                    if type(self.data) == "table" and self.data.checked ~= nil then
                        -- Toggle the checked state
                        self.data.checked = not self.data.checked

                        -- Update checkbox texture
                        if self.check then
                            if self.data.checked then
                                if self.data.isRadio then
                                    self.check:SetTexture("Interface\\Buttons\\UI-RadioButton")
                                    self.check:SetTexCoord(0.25, 0.5, 0, 1)
                                else
                                    self.check:SetTexture("Interface\\Buttons\\UI-CheckBox-Check")
                                end
                                self.check:Show()
                            else
                                self.check:Hide()
                            end
                        end
                    end

                    -- Execute item function if exists
                    if self.func then
                        self.func()
                    end

                    -- Update dropdown value and text
                    if not (type(self.data) == "table" and self.data.notCheckable) then
                        dropdownButton.value = self.value
                        dropdownButton.text:SetText(itemText)
                    end

                    -- Close all menus
                    for _, menu in pairs(activeMenus) do
                        menu:Hide()
                    end
                    wipe(activeMenus)

                    -- Call selection callback
                    if onSelect and not (type(self.data) == "table" and self.data.notCheckable) then
                        onSelect(self.value, self.data)
                    end
                end
            end)

            -- Submenu handling
            if hasArrow and menuList then
                local submenuTimer

                menuItem:SetScript("OnEnter", function(self)
                    self.text:SetTextColor(1, 1, 1, 1)

                    -- Cancel any pending submenu close
                    if submenuTimer and submenuTimer.Cancel then
                        submenuTimer:Cancel()
                        submenuTimer = nil
                    end

                    -- Get parent level (default to 0 if not set)
                    local parentLevel = parentMenu.level or 0

                    -- Close other submenus at this level
                    for level = parentLevel + 1, #activeMenus do
                        if activeMenus[level] then
                            activeMenus[level]:Hide()
                            activeMenus[level] = nil
                        end
                    end

                    -- Show submenu
                    local submenu = activeMenus[parentLevel + 1] or createMenuFrame(parentLevel + 1)

                    -- Clear existing items
                    for _, item in ipairs(submenu.items) do
                        item:Hide()
                        item:SetParent(nil)
                    end
                    wipe(submenu.items)

                    -- Create submenu items
                    for i, subItemData in ipairs(self.menuList) do
                        processMenuItem(subItemData, submenu, i)
                    end

                    -- Calculate submenu height
                    local totalHeight = 4
                    for _, item in ipairs(submenu.items) do
                        totalHeight = totalHeight + item:GetHeight()
                    end
                    submenu:SetHeight(totalHeight)

                    -- Position submenu with improved boundary detection
                    submenu:ClearAllPoints()
                    local screenWidth = GetScreenWidth()
                    local screenHeight = GetScreenHeight()
                    local submenuWidth = submenu:GetWidth()
                    local submenuHeight = submenu:GetHeight()
                    local edgeBuffer = 10

                    -- Get parent menu item position
                    local parentLeft = self:GetLeft() or 0
                    local parentRight = self:GetRight() or 0
                    local parentTop = self:GetTop() or 0
                    local parentBottom = self:GetBottom() or 0

                    -- Default to opening on the right
                    local anchorPoint = "TOPLEFT"
                    local relativePoint = "TOPRIGHT"
                    local xOffset = 2
                    local yOffset = 0

                    -- Check horizontal positioning
                    if parentRight + submenuWidth + edgeBuffer > screenWidth then
                        anchorPoint = "TOPRIGHT"
                        relativePoint = "TOPLEFT"
                        xOffset = -2
                    elseif parentLeft - submenuWidth - edgeBuffer < 0 then
                        anchorPoint = "TOPLEFT"
                        relativePoint = "TOPRIGHT"
                        xOffset = 2
                    end

                    -- Check vertical positioning
                    if parentTop - submenuHeight < edgeBuffer then
                        anchorPoint = anchorPoint:gsub("TOP", "BOTTOM")
                        relativePoint = relativePoint:gsub("TOP", "BOTTOM")
                        yOffset = math.min(0, edgeBuffer - (parentBottom - submenuHeight))
                    elseif parentTop > screenHeight - edgeBuffer then
                        yOffset = -(parentTop - (screenHeight - edgeBuffer))
                    end

                    submenu:SetPoint(anchorPoint, self, relativePoint, xOffset, yOffset)

                    -- Ensure submenu has proper strata and level
                    submenu:SetFrameStrata("FULLSCREEN_DIALOG")
                    submenu:SetFrameLevel(parentMenu:GetFrameLevel() + 100)
                    submenu:SetToplevel(true)

                    submenu:Show()
                    submenu:Raise()
                    activeMenus[parentLevel + 1] = submenu

                    -- Register with GlobalMenuManager
                    if GlobalMenuManager then
                        GlobalMenuManager:RegisterSubmenu(submenu, parentLevel + 1)
                    end
                end)

                menuItem:SetScript("OnLeave", function(self)
                    self.text:SetTextColor(UISTYLE_COLORS.TextGrey[1], UISTYLE_COLORS.TextGrey[2], UISTYLE_COLORS.TextGrey[3], 1)

                    -- Delay submenu closing
                    submenuTimer = CreateTimer(0.3, function()
                        -- Check if mouse is over any active menu
                        local mouseOverAnyMenu = false

                        -- Check all active menus
                        for _, menu in pairs(activeMenus) do
                            if menu and menu:IsVisible() and menu:IsMouseOver() then
                                mouseOverAnyMenu = true
                                break
                            end
                        end

                        -- Also check if mouse is over any menu item
                        if not mouseOverAnyMenu then
                            for _, menu in pairs(activeMenus) do
                                if menu and menu.items then
                                    for _, item in ipairs(menu.items) do
                                        if item and item:IsVisible() and item:IsMouseOver() then
                                            mouseOverAnyMenu = true
                                            break
                                        end
                                    end
                                    if mouseOverAnyMenu then break end
                                end
                            end
                        end

                        -- Only close if mouse is not over any menu or menu item
                        if not mouseOverAnyMenu then
                            local parentLevel = parentMenu.level or 0
                            for level = parentLevel + 1, #activeMenus do
                                if activeMenus[level] then
                                    activeMenus[level]:Hide()
                                    activeMenus[level] = nil
                                end
                            end
                        end
                    end)
                end)
            else
                -- Regular item hover
                menuItem:SetScript("OnEnter", function(self)
                    self.text:SetTextColor(1, 1, 1, 1)

                    -- Close submenus if hovering over non-submenu item
                    local parentLevel = parentMenu.level or 0
                    for level = parentLevel + 1, #activeMenus do
                        if activeMenus[level] then
                            activeMenus[level]:Hide()
                            activeMenus[level] = nil
                        end
                    end
                end)

                menuItem:SetScript("OnLeave", function(self)
                    self.text:SetTextColor(UISTYLE_COLORS.TextGrey[1], UISTYLE_COLORS.TextGrey[2], UISTYLE_COLORS.TextGrey[3], 1)
                end)
            end
        end

        table.insert(parentMenu.items, menuItem)
        return menuItem
    end

    -- Create main menu
    local mainMenu = createMenuFrame(0)

    -- Create content frame that will hold items (for potential scrolling)
    local contentFrame = CreateFrame("Frame", nil, mainMenu)
    contentFrame:SetWidth(width - 4)
    contentFrame.items = {}  -- Initialize items table for contentFrame
    contentFrame.level = 0  -- Set level for contentFrame to match mainMenu
    mainMenu.contentFrame = contentFrame

    -- searchOffset is set later if search is enabled, default 0
    local searchOffset = 0

    -- Update filtered items function (accessible from both search and initial build)
    local function updateFilteredItems()
        local currentFilteredItems = DropdownSearchFilter.FilterItems(originalItems, searchText) or {}

        -- Clear existing items safely
        if contentFrame.items and type(contentFrame.items) == "table" then
            for _, item in ipairs(contentFrame.items) do
                if item and item.Hide then
                    item:Hide()
                end
                if item and item.SetParent then
                    item:SetParent(nil)
                end
            end
            wipe(contentFrame.items)
        else
            contentFrame.items = {}
        end

        -- Check if we have results
        if currentFilteredItems and #currentFilteredItems > 0 then
            -- Recreate items with filtered list
            for i, itemData in ipairs(currentFilteredItems) do
                processMenuItem(itemData, contentFrame, i)
            end
        else
            -- Show enhanced "No results found" message
            local noResultsItem = CreateFrame("Button", nil, contentFrame)
            noResultsItem:SetHeight(40) -- Taller for better presence
            noResultsItem:SetPoint("LEFT", 2, 0)
            noResultsItem:SetPoint("RIGHT", -2, 0)
            noResultsItem:SetPoint("TOP", 0, -2)
            noResultsItem:EnableMouse(false) -- Not clickable

            -- Main "No results" text
            local noResultsText = noResultsItem:CreateFontString(nil, "OVERLAY", "GameFontNormal")
            noResultsText:SetPoint("CENTER", 0, 4)
            noResultsText:SetText("No results found")
            noResultsText:SetTextColor(0.6, 0.6, 0.6, 1)

            -- Suggestion text
            local suggestionText = noResultsItem:CreateFontString(nil, "OVERLAY", "GameFontNormalSmall")
            suggestionText:SetPoint("CENTER", 0, -8)
            suggestionText:SetText("Try different keywords")
            suggestionText:SetTextColor(0.4, 0.4, 0.4, 1)

            table.insert(contentFrame.items, noResultsItem)
        end

        -- Update filteredItems for other code that might reference it
        filteredItems = currentFilteredItems

        -- Recalculate height and update scroll
        -- 8 pixels total padding: 4px top (first item offset) + 4px bottom
        local newHeight = 8 + searchOffset
        for _, item in ipairs(contentFrame.items) do
            if item and item.GetHeight then
                newHeight = newHeight + item:GetHeight()
            end
        end

        -- Update contentFrame positioning based on scroll state
        contentFrame:ClearAllPoints()

        -- Update scrolling if scroll elements exist
        if mainMenu.scrollFrame and mainMenu.scrollBar then
            -- When inside scrollFrame, position contentFrame at origin
            contentFrame:SetPoint("TOPLEFT", 0, 0)
            contentFrame:SetPoint("TOPRIGHT", 0, 0)

            -- Set contentFrame to actual content height
            contentFrame:SetHeight(newHeight - searchOffset)

            -- Update scrollbar range
            local availableHeight = MAX_MENU_HEIGHT - searchOffset
            local maxScroll = math.max(0, (newHeight - searchOffset) - availableHeight + 4)
            mainMenu.scrollBar:SetMinMaxValues(0, maxScroll)
            mainMenu.scrollBar:SetValue(0) -- Reset to top when filtering

            -- Update scroll child to reflect new content
            mainMenu.scrollFrame:SetScrollChild(contentFrame)
        else
            -- No scroll frame - position relative to main menu with search offset
            contentFrame:SetPoint("TOPLEFT", 2, -2 - searchOffset)
            contentFrame:SetHeight(newHeight - searchOffset)

            if mainMenu.SetHeight then
                mainMenu:SetHeight(newHeight)
            end

            -- Mark that we need scroll update after scroll creation
            mainMenu.needsScrollUpdate = {
                totalHeight = newHeight,
                contentHeight = newHeight - searchOffset
            }
        end
    end

    -- Create search box if enabled
    local searchBox = nil
    if enableSearch then
        -- Create search container frame with background
        local searchContainer = CreateFrame("Frame", nil, mainMenu)
        searchContainer:SetHeight(26)
        searchContainer:SetPoint("TOPLEFT", 4, -6)
        searchContainer:SetPoint("TOPRIGHT", -SCROLLBAR_WIDTH - 6, -6)

        -- Add search container background (use button styling for visibility)
        searchContainer:SetBackdrop(UISTYLE_BACKDROPS.Frame)
        searchContainer:SetBackdropColor(UISTYLE_COLORS.ButtonBg[1], UISTYLE_COLORS.ButtonBg[2], UISTYLE_COLORS.ButtonBg[3], 1)
        searchContainer:SetBackdropBorderColor(UISTYLE_COLORS.ButtonBorder[1], UISTYLE_COLORS.ButtonBorder[2], UISTYLE_COLORS.ButtonBorder[3], 0.8)

        -- Search container background
        local searchBg = searchContainer:CreateTexture(nil, "BACKGROUND")
        searchBg:SetAllPoints()
        searchBg:SetTexture("Interface\\Buttons\\WHITE8X8")
        searchBg:SetVertexColor(UISTYLE_COLORS.ButtonBg[1], UISTYLE_COLORS.ButtonBg[2], UISTYLE_COLORS.ButtonBg[3], 1)

        -- Search container border
        local searchBorder = CreateFrame("Frame", nil, searchContainer)
        searchBorder:SetAllPoints()
        searchBorder:SetBackdrop({
            edgeFile = "Interface\\Buttons\\WHITE8X8",
            edgeSize = 1,
            insets = {left = 0, right = 0, top = 0, bottom = 0}
        })
        searchBorder:SetBackdropBorderColor(UISTYLE_COLORS.ButtonBorder[1], UISTYLE_COLORS.ButtonBorder[2], UISTYLE_COLORS.ButtonBorder[3], 1)

        -- Magnifier glass icon
        local searchIcon = searchContainer:CreateTexture(nil, "ARTWORK")
        searchIcon:SetSize(14, 14)
        searchIcon:SetPoint("LEFT", 6, 0)
        searchIcon:SetTexture("Interface\\Common\\UI-Searchbox-Icon")
        searchIcon:SetVertexColor(UISTYLE_COLORS.TextGrey[1], UISTYLE_COLORS.TextGrey[2], UISTYLE_COLORS.TextGrey[3], 0.8)

        -- Search EditBox (clean, no backdrop - container provides styling)
        searchBox = CreateFrame("EditBox", nil, searchContainer)
        searchBox:SetHeight(18)
        searchBox:SetPoint("LEFT", searchIcon, "RIGHT", 6, 0)
        searchBox:SetPoint("RIGHT", -6, 0)
        searchBox:SetFontObject("GameFontNormalSmall")
        searchBox:SetTextColor(1, 1, 1, 1)
        searchBox:SetAutoFocus(false)
        searchBox:SetMaxLetters(50)

        -- Placeholder text
        local placeholder = searchBox:CreateFontString(nil, "OVERLAY", "GameFontNormalSmall")
        placeholder:SetPoint("LEFT", 2, 0)
        placeholder:SetText(searchPlaceholder)
        placeholder:SetTextColor(0.3, 0.3, 0.3, 1)
        searchBox.placeholder = placeholder

        -- Visual separator below search
        local separator = searchContainer:CreateTexture(nil, "ARTWORK")
        separator:SetHeight(1)
        separator:SetPoint("BOTTOMLEFT", searchContainer, "BOTTOMLEFT", 4, -4)
        separator:SetPoint("BOTTOMRIGHT", searchContainer, "BOTTOMRIGHT", -4, -4)
        separator:SetTexture("Interface\\Buttons\\WHITE8X8")
        separator:SetVertexColor(UISTYLE_COLORS.BorderGrey[1], UISTYLE_COLORS.BorderGrey[2], UISTYLE_COLORS.BorderGrey[3], 0.8)

        searchOffset = SEARCH_HEIGHT + 10 -- Add extra spacing for separator and padding
        mainMenu.searchBox = searchBox

        -- Search box event handlers
        searchBox:SetScript("OnTextChanged", function(self)
            local newText = self:GetText() or ""
            if newText ~= searchText then
                searchText = newText

                -- Show/hide placeholder
                if searchText == "" then
                    placeholder:Show()
                else
                    placeholder:Hide()
                end

                updateFilteredItems()
            end
        end)

        searchBox:SetScript("OnEditFocusGained", function(self)
            placeholder:Hide()
        end)

        searchBox:SetScript("OnEditFocusLost", function(self)
            if self:GetText() == "" then
                placeholder:Show()
            end
        end)

        searchBox:SetScript("OnEscapePressed", function(self)
            if self:GetText() ~= "" then
                self:SetText("")
                self:ClearFocus()
            else
                -- Close dropdown if search is empty
                mainMenu:Hide()
            end
        end)

        searchBox:SetScript("OnEnterPressed", function(self)
            self:ClearFocus()
        end)
    end

    -- Build main menu items using the updateFilteredItems function
    updateFilteredItems()

    -- Store items reference on mainMenu for compatibility
    mainMenu.items = contentFrame.items

    -- Calculate menu height including search offset
    -- 8 pixels total padding: 4px top (first item offset) + 4px bottom
    local totalHeight = 8 + searchOffset
    if contentFrame.items and type(contentFrame.items) == "table" then
        for _, item in ipairs(contentFrame.items) do
            if item and item.GetHeight then
                totalHeight = totalHeight + item:GetHeight()
            end
        end
    end

    -- Check if we need scrolling
    if totalHeight > MAX_MENU_HEIGHT then
        -- Menu needs scrolling
        local scrollHeight = MAX_MENU_HEIGHT
        mainMenu:SetHeight(scrollHeight)

        -- Create scroll frame
        local scrollFrame = CreateFrame("ScrollFrame", nil, mainMenu)
        scrollFrame:SetPoint("TOPLEFT", 2, -2 - searchOffset)
        scrollFrame:SetPoint("BOTTOMRIGHT", -SCROLLBAR_WIDTH - 2, 4)
        scrollFrame:SetScrollChild(contentFrame)

        -- Set content frame size and position
        contentFrame:ClearAllPoints()
        contentFrame:SetPoint("TOPLEFT", 0, 0)
        contentFrame:SetPoint("TOPRIGHT", 0, 0)
        contentFrame:SetHeight(totalHeight - searchOffset)
        contentFrame:SetWidth(width - SCROLLBAR_WIDTH - 8)

        -- Create styled scrollbar (positioned below search box)
        local scrollBar = CreateStyledScrollBar(mainMenu, SCROLLBAR_WIDTH, scrollHeight - searchOffset - 6)
        scrollBar:SetPoint("TOPRIGHT", -2, -2 - searchOffset)
        scrollBar:SetPoint("BOTTOMRIGHT", -2, 4)

        -- Remove scrollbar border to avoid visible lines inside the menu
        scrollBar:SetBackdrop(nil)

        -- Set scrollbar range (account for search offset)
        local maxScroll = (totalHeight - searchOffset) - (scrollHeight - searchOffset) + 4
        scrollBar:SetMinMaxValues(0, math.max(0, maxScroll))
        scrollBar:SetValue(0)

        -- Connect scrollbar to scroll frame
        scrollBar:SetScript("OnValueChanged", function(self, value)
            scrollFrame:SetVerticalScroll(value)
        end)

        -- Mouse wheel support
        scrollFrame:EnableMouseWheel(true)
        scrollFrame:SetScript("OnMouseWheel", function(self, delta)
            local current = scrollBar:GetValue()
            local min, max = scrollBar:GetMinMaxValues()
            local step = 40 -- Scroll speed (about 2 items)

            if delta > 0 then
                scrollBar:SetValue(math.max(min, current - step))
            else
                scrollBar:SetValue(math.min(max, current + step))
            end
        end)

        -- Also enable mouse wheel on menu items
        for _, item in ipairs(contentFrame.items) do
            item:EnableMouseWheel(true)
            item:SetScript("OnMouseWheel", function(self, delta)
                local current = scrollBar:GetValue()
                local min, max = scrollBar:GetMinMaxValues()
                local step = 40

                if delta > 0 then
                    scrollBar:SetValue(math.max(min, current - step))
                else
                    scrollBar:SetValue(math.min(max, current + step))
                end
            end)
        end

        mainMenu.scrollBar = scrollBar
        mainMenu.scrollFrame = scrollFrame
    else
        -- No scrolling needed
        mainMenu:SetHeight(totalHeight)
        contentFrame:SetHeight(totalHeight - searchOffset)
        contentFrame:SetPoint("TOPLEFT", 2, -2 - searchOffset)
        contentFrame:SetPoint("BOTTOMRIGHT", -2, 4)
    end

    -- Handle deferred scroll updates if needed (from updateFilteredItems calls during initial build)
    if mainMenu.needsScrollUpdate then
        local updateData = mainMenu.needsScrollUpdate
        if updateData.totalHeight > MAX_MENU_HEIGHT and mainMenu.scrollFrame and mainMenu.scrollBar then
            local availableHeight = MAX_MENU_HEIGHT - searchOffset
            contentFrame:SetHeight(math.max(updateData.contentHeight, availableHeight - 4))

            local maxScroll = math.max(0, updateData.contentHeight - availableHeight + 4)
            mainMenu.scrollBar:SetMinMaxValues(0, maxScroll)
            mainMenu.scrollBar:SetValue(0)
        end
        mainMenu.needsScrollUpdate = nil -- Clear the flag
    end

    -- Position main menu
    mainMenu:SetPoint("TOPLEFT", dropdownButton, "BOTTOMLEFT", 0, -2)

    -- Toggle menu on button click
    dropdownButton:SetScript("OnClick", function(self)
        if mainMenu:IsShown() then
            -- Close all menus
            for _, menu in pairs(activeMenus) do
                menu:Hide()
            end
            wipe(activeMenus)
            mainMenu:Hide()
        else
            mainMenu:Show()
            mainMenu:Raise()
            activeMenus[0] = mainMenu
        end
    end)

    -- Close handler
    local closeHandler = CreateFrame("Button", nil, UIParent)
    closeHandler:SetAllPoints(UIParent)
    closeHandler:SetFrameStrata("FULLSCREEN")
    closeHandler:Hide()

    closeHandler:SetScript("OnClick", function()
        for _, menu in pairs(activeMenus) do
            menu:Hide()
        end
        wipe(activeMenus)
        mainMenu:Hide()
        closeHandler:Hide()
    end)

    -- Auto-close timer: closes dropdown when mouse stays outside for too long
    local AUTO_CLOSE_DELAY = 1.5 -- seconds before auto-closing
    local autoCloseElapsed = 0
    local autoCloseFrame = CreateFrame("Frame")
    autoCloseFrame:Hide()

    autoCloseFrame:SetScript("OnUpdate", function(self, elapsed)
        -- Check if mouse is over the dropdown button or any active menu
        local mouseOverSomething = dropdownButton:IsMouseOver()

        if not mouseOverSomething and mainMenu:IsVisible() then
            mouseOverSomething = mainMenu:IsMouseOver()
        end

        if not mouseOverSomething then
            for _, menu in pairs(activeMenus) do
                if menu and menu:IsVisible() and menu:IsMouseOver() then
                    mouseOverSomething = true
                    break
                end
            end
        end

        if mouseOverSomething then
            autoCloseElapsed = 0
        else
            autoCloseElapsed = autoCloseElapsed + elapsed
            if autoCloseElapsed >= AUTO_CLOSE_DELAY then
                for _, menu in pairs(activeMenus) do
                    menu:Hide()
                end
                wipe(activeMenus)
                mainMenu:Hide()
                closeHandler:Hide()
                self:Hide()
            end
        end
    end)

    mainMenu:SetScript("OnShow", function()
        closeHandler:Show()
        closeHandler:SetFrameLevel(mainMenu:GetFrameLevel() - 1)
        autoCloseElapsed = 0
        autoCloseFrame:Show()
    end)

    mainMenu:SetScript("OnHide", function()
        closeHandler:Hide()
        autoCloseFrame:Hide()
    end)

    -- Helper methods
    dropdownButton.GetValue = function(self)
        return self.value
    end

    dropdownButton.SetValue = function(self, value, text)
        self.value = value
        self.text:SetText(text or value)
    end

    -- Update items method - properly integrates with search/scroll system
    dropdownButton.UpdateItems = function(self, newItems)
        -- Update the source items for filtering
        originalItems = newItems or {}

        -- Reset search state
        searchText = ""
        if mainMenu.searchBox then
            mainMenu.searchBox:SetText("")
            if mainMenu.searchBox.placeholder then
                mainMenu.searchBox.placeholder:Show()
            end
        end

        -- Use the existing updateFilteredItems function which handles:
        -- - Clearing old items from contentFrame
        -- - Processing new items with proper positioning
        -- - Scroll frame updates
        -- - Height calculations with searchOffset
        updateFilteredItems()

        -- Recreate scroll system if needed after items changed
        local updTotalHeight = 8 + searchOffset
        for _, item in ipairs(contentFrame.items or {}) do
            if item and item.GetHeight then
                updTotalHeight = updTotalHeight + item:GetHeight()
            end
        end

        -- Check if we now need scrolling
        if updTotalHeight > MAX_MENU_HEIGHT then
            if not mainMenu.scrollFrame then
                -- Need to create scroll system
                local scrollHeight = MAX_MENU_HEIGHT
                mainMenu:SetHeight(scrollHeight)

                local scrollFrame = CreateFrame("ScrollFrame", nil, mainMenu)
                scrollFrame:SetPoint("TOPLEFT", 2, -2 - searchOffset)
                scrollFrame:SetPoint("BOTTOMRIGHT", -SCROLLBAR_WIDTH - 2, 4)
                scrollFrame:SetScrollChild(contentFrame)

                contentFrame:ClearAllPoints()
                contentFrame:SetPoint("TOPLEFT", 0, 0)
                contentFrame:SetPoint("TOPRIGHT", 0, 0)
                contentFrame:SetHeight(updTotalHeight - searchOffset)
                contentFrame:SetWidth(width - SCROLLBAR_WIDTH - 8)

                local scrollBar = CreateStyledScrollBar(mainMenu, SCROLLBAR_WIDTH, scrollHeight - searchOffset - 6)
                scrollBar:SetPoint("TOPRIGHT", -2, -2 - searchOffset)
                scrollBar:SetPoint("BOTTOMRIGHT", -2, 4)

                -- Remove scrollbar border to avoid visible lines inside the menu
                scrollBar:SetBackdrop(nil)

                local maxScroll = (updTotalHeight - searchOffset) - (scrollHeight - searchOffset) + 4
                scrollBar:SetMinMaxValues(0, math.max(0, maxScroll))
                scrollBar:SetValue(0)

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

                -- Enable mouse wheel on items too
                for _, item in ipairs(contentFrame.items or {}) do
                    if item then
                        item:EnableMouseWheel(true)
                        item:SetScript("OnMouseWheel", function(self, delta)
                            local current = scrollBar:GetValue()
                            local min, max = scrollBar:GetMinMaxValues()
                            local step = 40
                            if delta > 0 then
                                scrollBar:SetValue(math.max(min, current - step))
                            else
                                scrollBar:SetValue(math.min(max, current + step))
                            end
                        end)
                    end
                end

                mainMenu.scrollBar = scrollBar
                mainMenu.scrollFrame = scrollFrame
            else
                -- Update existing scroll system
                contentFrame:SetHeight(updTotalHeight - searchOffset)
                local availableHeight = MAX_MENU_HEIGHT - searchOffset
                local maxScroll = math.max(0, (updTotalHeight - searchOffset) - availableHeight + 4)
                mainMenu.scrollBar:SetMinMaxValues(0, maxScroll)
                mainMenu.scrollBar:SetValue(0)
                mainMenu.scrollBar:Show()
                mainMenu.scrollFrame:Show()
            end
        else
            -- No scrolling needed
            mainMenu:SetHeight(updTotalHeight)
            if mainMenu.scrollFrame then
                mainMenu.scrollFrame:Hide()
                mainMenu.scrollBar:Hide()
            end
            contentFrame:ClearAllPoints()
            contentFrame:SetPoint("TOPLEFT", 2, -2 - searchOffset)
            contentFrame:SetHeight(updTotalHeight - searchOffset)
        end

        mainMenu.items = contentFrame.items
    end

    return dropdownButton, mainMenu
end

-- Register this module
UISTYLE_LIBRARY_MODULES = UISTYLE_LIBRARY_MODULES or {}
UISTYLE_LIBRARY_MODULES["FullyStyledDropdowns"] = true

-- Debug print for module loading
if UISTYLE_DEBUG then
    print("UIStyleLibrary: FullyStyledDropdowns module loaded")
end
