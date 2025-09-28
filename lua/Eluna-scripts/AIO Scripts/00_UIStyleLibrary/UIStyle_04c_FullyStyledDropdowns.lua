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
@return dropdownButton, menuFrame - The dropdown button and menu frame
]]
function CreateFullyStyledDropdown(parent, width, items, defaultValue, onSelect)
    -- Create main button
    local dropdownButton = CreateStyledButton(parent, defaultValue or "Select...", width, 26)
    dropdownButton.value = defaultValue
    
    -- Add dropdown arrow as text
    local arrow = dropdownButton:CreateFontString(nil, "OVERLAY", "GameFontNormalSmall")
    arrow:SetPoint("RIGHT", -8, 0)
    arrow:SetText("v")
    arrow:SetTextColor(UISTYLE_COLORS.TextGrey[1], UISTYLE_COLORS.TextGrey[2], UISTYLE_COLORS.TextGrey[3], 1)
    dropdownButton.arrow = arrow
    
    -- Adjust text to make room for arrow
    dropdownButton.text:ClearAllPoints()
    dropdownButton.text:SetPoint("LEFT", 8, 0)
    dropdownButton.text:SetPoint("RIGHT", arrow, "LEFT", -5, 0)
    dropdownButton.text:SetJustifyH("LEFT")
    
    -- Menu management variables
    local activeMenus = {}
    local menuLevel = 0
    
    -- Create menu frame function
    local function createMenuFrame(level)
        local menuFrame = CreateStyledFrame(UIParent, UISTYLE_COLORS.DarkGrey)
        
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
        
        -- Add shadow
        local shadow = menuFrame:CreateTexture(nil, "BACKGROUND")
        shadow:SetTexture("Interface\\Buttons\\WHITE8X8")
        shadow:SetVertexColor(0, 0, 0, 0.5)
        shadow:SetPoint("TOPLEFT", -3, 3)
        shadow:SetPoint("BOTTOMRIGHT", 3, -3)
        
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
        
        -- Set frame level to ensure proper rendering in nested menus
        menuItem:SetFrameLevel(parentMenu:GetFrameLevel() + 1)
        
        if index == 1 then
            menuItem:SetPoint("TOP", 0, -2)
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
            -- Regular item or submenu
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
                    
                    -- Close other submenus at this level
                    for level = parentMenu.level + 1, #activeMenus do
                        if activeMenus[level] then
                            activeMenus[level]:Hide()
                            activeMenus[level] = nil
                        end
                    end
                    
                    -- Show submenu
                    local submenu = activeMenus[parentMenu.level + 1] or createMenuFrame(parentMenu.level + 1)
                    
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
                        -- Would go off right edge, open to the left instead
                        anchorPoint = "TOPRIGHT"
                        relativePoint = "TOPLEFT"
                        xOffset = -2
                    elseif parentLeft - submenuWidth - edgeBuffer < 0 then
                        -- Would go off left edge, force open to the right
                        anchorPoint = "TOPLEFT"
                        relativePoint = "TOPRIGHT"
                        xOffset = 2
                    end
                    
                    -- Check vertical positioning
                    if parentTop - submenuHeight < edgeBuffer then
                        -- Would go off bottom, adjust vertical position
                        anchorPoint = anchorPoint:gsub("TOP", "BOTTOM")
                        relativePoint = relativePoint:gsub("TOP", "BOTTOM")
                        yOffset = math.min(0, edgeBuffer - (parentBottom - submenuHeight))
                    elseif parentTop > screenHeight - edgeBuffer then
                        -- Too close to top, adjust down
                        yOffset = -(parentTop - (screenHeight - edgeBuffer))
                    end
                    
                    submenu:SetPoint(anchorPoint, self, relativePoint, xOffset, yOffset)
                    
                    -- Ensure submenu has proper strata and level
                    submenu:SetFrameStrata("FULLSCREEN_DIALOG")
                    submenu:SetFrameLevel(parentMenu:GetFrameLevel() + 100)  -- Use larger increment for better separation
                    submenu:SetToplevel(true)  -- Ensure submenu stays on top
                    
                    submenu:Show()
                    submenu:Raise()  -- Ensure submenu appears on top
                    activeMenus[parentMenu.level + 1] = submenu
                    
                    -- Register with GlobalMenuManager
                    if GlobalMenuManager then
                        GlobalMenuManager:RegisterSubmenu(submenu, parentMenu.level + 1)
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
                            for level = parentMenu.level + 1, #activeMenus do
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
                    for level = parentMenu.level + 1, #activeMenus do
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
    
    -- Build main menu items
    for i, itemData in ipairs(items) do
        processMenuItem(itemData, mainMenu, i)
    end
    
    -- Calculate menu height
    local totalHeight = 4
    for _, item in ipairs(mainMenu.items) do
        totalHeight = totalHeight + item:GetHeight()
    end
    mainMenu:SetHeight(totalHeight)
    
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
    
    mainMenu:SetScript("OnShow", function()
        closeHandler:Show()
        closeHandler:SetFrameLevel(mainMenu:GetFrameLevel() - 1)
    end)
    
    mainMenu:SetScript("OnHide", function()
        closeHandler:Hide()
    end)
    
    -- Helper methods
    dropdownButton.GetValue = function(self)
        return self.value
    end
    
    dropdownButton.SetValue = function(self, value, text)
        self.value = value
        self.text:SetText(text or value)
    end
    
    -- Update items method
    dropdownButton.UpdateItems = function(self, newItems)
        items = newItems
        
        -- Clear existing items
        for _, item in ipairs(mainMenu.items) do
            item:Hide()
            item:SetParent(nil)
        end
        wipe(mainMenu.items)
        
        -- Create new items
        for i, itemData in ipairs(items) do
            processMenuItem(itemData, mainMenu, i)
        end
        
        -- Recalculate height
        local totalHeight = 4
        for _, item in ipairs(mainMenu.items) do
            totalHeight = totalHeight + item:GetHeight()
        end
        mainMenu:SetHeight(totalHeight)
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