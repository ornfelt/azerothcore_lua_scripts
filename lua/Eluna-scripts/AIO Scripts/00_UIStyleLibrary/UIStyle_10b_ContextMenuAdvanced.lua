local AIO = AIO or require("AIO")

if AIO.AddAddon() then
    return
end

-- ===================================
-- UI STYLE LIBRARY CONTEXT MENU ADVANCED MODULE
-- ===================================
-- Advanced context menu features with nested menus

--[[
Shows a fully custom styled context menu at the specified position
@param menuItems - Table of menu items
@param anchor - Anchor point (frame or "cursor") 
@param anchorPoint - Anchor point on the anchor frame (default "BOTTOMLEFT")
@param relativePoint - Relative point on the menu (default "TOPLEFT")
@param xOffset - X offset (default 0)
@param yOffset - Y offset (default 0)
@return menuFrame - The created menu frame
]]
function ShowFullyStyledContextMenu(menuItems, anchor, anchorPoint, relativePoint, xOffset, yOffset)
    -- Close any existing menus first
    if GlobalMenuManager then
        GlobalMenuManager:CloseAll()
    end
    
    -- Create unique frame name
    local menuName = "UIStyleContextMenu" .. math.random(100000, 999999)
    
    -- Menu management
    local activeMenus = {}
    local menuLevel = 0
    
    -- Create menu frame function
    local function createMenuFrame(level)
        local menuFrame = CreateStyledFrame(UIParent, UISTYLE_COLORS.DarkGrey)
        menuFrame:SetFrameStrata("FULLSCREEN_DIALOG")
        menuFrame:SetFrameLevel(9999 + level * 100)
        menuFrame:SetToplevel(true)
        menuFrame:SetWidth(200)
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
    
    -- Process menu item (copied from working dropdown implementation)
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
            local hasArrow = false
            local menuList = nil
            local icon = nil
            local isChecked = false
            local func = nil
            local disabled = false
            local notCheckable = false
            local tooltipTitle = nil
            local tooltipText = nil
            
            if type(itemData) == "string" then
                itemText = itemData
            elseif type(itemData) == "table" then
                itemText = itemData.text or ""
                hasArrow = itemData.hasArrow
                menuList = itemData.menuList
                icon = itemData.icon
                isChecked = itemData.checked
                func = itemData.func
                disabled = itemData.disabled
                notCheckable = itemData.notCheckable
                tooltipTitle = itemData.tooltipTitle
                tooltipText = itemData.tooltipText
            end
            
            -- Checkbox/radio button (only if not notCheckable)
            if type(itemData) == "table" and not notCheckable and (itemData.isRadio or isChecked ~= nil) then
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
            
            if disabled then
                text:SetTextColor(0.5, 0.5, 0.5, 1)
                menuItem:EnableMouse(false)
            else
                -- Highlight
                local highlight = menuItem:CreateTexture(nil, "HIGHLIGHT")
                highlight:SetTexture("Interface\\Buttons\\WHITE8X8")
                highlight:SetVertexColor(1, 1, 1, 0.1)
                highlight:SetPoint("LEFT", 1, 0)
                highlight:SetPoint("RIGHT", -1, 0)
                highlight:SetHeight(itemHeight - 2)
                
                -- Store data
                menuItem.data = itemData
                menuItem.hasSubmenu = hasArrow and menuList
                menuItem.menuList = menuList
                menuItem.func = func
                menuItem.tooltipTitle = tooltipTitle
                menuItem.tooltipText = tooltipText
                
                -- Click handler
                menuItem:SetScript("OnClick", function(self)
                    if not self.hasSubmenu then
                        -- Handle checkbox toggling
                        if type(self.data) == "table" and self.data.checked ~= nil and not self.data.notCheckable then
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
                        
                        -- Don't close if keepShownOnClick is set
                        if not (type(self.data) == "table" and self.data.keepShownOnClick) then
                            -- Close all menus
                            for _, menu in pairs(activeMenus) do
                                menu:Hide()
                            end
                            wipe(activeMenus)
                            GlobalMenuManager:CloseAll()
                        end
                    end
                end)
                
                -- Submenu handling
                if hasArrow and menuList then
                    local submenuTimer
                    
                    menuItem:SetScript("OnEnter", function(self)
                        self.text:SetTextColor(1, 1, 1, 1)
                        if self.arrow then
                            self.arrow:SetTextColor(1, 1, 1, 1)
                        end
                        
                        -- Show tooltip if available
                        if self.tooltipTitle or self.tooltipText then
                            GameTooltip:SetOwner(self, "ANCHOR_RIGHT")
                            if self.tooltipTitle then
                                GameTooltip:SetText(self.tooltipTitle, 1, 1, 1)
                            end
                            if self.tooltipText then
                                if self.tooltipTitle then
                                    GameTooltip:AddLine(self.tooltipText, NORMAL_FONT_COLOR.r, NORMAL_FONT_COLOR.g, NORMAL_FONT_COLOR.b, true)
                                else
                                    GameTooltip:SetText(self.tooltipText, NORMAL_FONT_COLOR.r, NORMAL_FONT_COLOR.g, NORMAL_FONT_COLOR.b, true)
                                end
                            end
                            GameTooltip:Show()
                        end
                        
                        -- Cancel any pending submenu close
                        if submenuTimer then
                            submenuTimer:SetScript("OnUpdate", nil)
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
                        submenu:SetFrameLevel(parentMenu:GetFrameLevel() + 100)
                        submenu:SetToplevel(true)
                        
                        submenu:Show()
                        submenu:Raise()
                        activeMenus[parentMenu.level + 1] = submenu
                        
                        -- Register with GlobalMenuManager
                        if GlobalMenuManager then
                            GlobalMenuManager:RegisterSubmenu(submenu, parentMenu.level + 1)
                        end
                    end)
                    
                    menuItem:SetScript("OnLeave", function(self)
                        self.text:SetTextColor(UISTYLE_COLORS.TextGrey[1], UISTYLE_COLORS.TextGrey[2], UISTYLE_COLORS.TextGrey[3], 1)
                        if self.arrow then
                            self.arrow:SetTextColor(UISTYLE_COLORS.TextGrey[1], UISTYLE_COLORS.TextGrey[2], UISTYLE_COLORS.TextGrey[3], 1)
                        end
                        GameTooltip:Hide()
                        
                        -- Delay submenu closing using OnUpdate
                        if not submenuTimer then
                            submenuTimer = CreateFrame("Frame")
                        end
                        submenuTimer.elapsed = 0
                        submenuTimer:SetScript("OnUpdate", function(self, elapsed)
                            self.elapsed = self.elapsed + elapsed
                            if self.elapsed >= 0.3 then
                                self:SetScript("OnUpdate", nil)
                                
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
                            end
                        end)
                    end)
                else
                    -- Regular item hover
                    menuItem:SetScript("OnEnter", function(self)
                        self.text:SetTextColor(1, 1, 1, 1)
                        
                        -- Show tooltip if available
                        if self.tooltipTitle or self.tooltipText then
                            GameTooltip:SetOwner(self, "ANCHOR_RIGHT")
                            if self.tooltipTitle then
                                GameTooltip:SetText(self.tooltipTitle, 1, 1, 1)
                            end
                            if self.tooltipText then
                                if self.tooltipTitle then
                                    GameTooltip:AddLine(self.tooltipText, NORMAL_FONT_COLOR.r, NORMAL_FONT_COLOR.g, NORMAL_FONT_COLOR.b, true)
                                else
                                    GameTooltip:SetText(self.tooltipText, NORMAL_FONT_COLOR.r, NORMAL_FONT_COLOR.g, NORMAL_FONT_COLOR.b, true)
                                end
                            end
                            GameTooltip:Show()
                        end
                        
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
                        GameTooltip:Hide()
                    end)
                end
            end
        end
        
        table.insert(parentMenu.items, menuItem)
        return menuItem
    end
    
    -- Build menu function
    local function buildMenu(items, parentMenu)
        local maxWidth = 150
        local totalHeight = 4
        
        for i, itemData in ipairs(items) do
            local menuItem = processMenuItem(itemData, parentMenu, i)
            
            -- Calculate width accounting for icons and checkboxes
            if menuItem.text then
                local leftOffset = 8
                if menuItem.check then leftOffset = leftOffset + 20 end
                if menuItem.icon then leftOffset = leftOffset + 20 end
                
                local textWidth = menuItem.text:GetStringWidth() + leftOffset + 16
                if menuItem.arrow then
                    textWidth = textWidth + 20
                end
                maxWidth = math.max(maxWidth, textWidth)
            end
            
            totalHeight = totalHeight + menuItem:GetHeight()
        end
        
        parentMenu:SetWidth(maxWidth)
        parentMenu:SetHeight(totalHeight)
    end
    
    -- Create main menu
    local mainMenu = createMenuFrame(0)
    activeMenus[0] = mainMenu
    
    -- Build the menu
    buildMenu(menuItems, mainMenu)
    
    -- Position the menu
    if anchor == "cursor" then
        local scale = UIParent:GetEffectiveScale()
        local x, y = GetCursorPosition()
        x = x / scale
        y = y / scale
        mainMenu:SetPoint("TOPLEFT", UIParent, "BOTTOMLEFT", x, y)
    else
        mainMenu:SetPoint(anchorPoint or "TOPLEFT", anchor, relativePoint or "BOTTOMLEFT", xOffset or 0, yOffset or 0)
    end
    
    -- Show the menu
    mainMenu:Show()
    
    -- Register with GlobalMenuManager
    if GlobalMenuManager then
        -- Get the shared close handler frame
        local closeHandler = GlobalMenuManager:GetCloseHandler()
        closeHandler:SetFrameLevel(mainMenu:GetFrameLevel() - 1)
        closeHandler:Show()
        
        -- Register the menu with the close handler frame
        GlobalMenuManager:RegisterMenu(mainMenu, closeHandler)
        
        -- Override the closeHandler's OnClick to handle local activeMenus
        closeHandler:SetScript("OnClick", function()
            for _, menu in pairs(activeMenus) do
                menu:Hide()
            end
            wipe(activeMenus)
            GlobalMenuManager:CloseAll()
        end)
    end
    
    return mainMenu
end

--[[
Shows a styled EasyMenu context menu with dark theme
@param menuItems - Table of menu items (EasyMenu format)
@param anchor - Anchor point ("cursor" or frame reference)
@param x - X offset (defaults to 0)
@param y - Y offset (defaults to 0)
@param displayMode - Display mode ("MENU" for context menu style)
@param autoHideDelay - Auto hide delay in seconds (optional)
@param menuFrame - Optional menu frame (creates one if not provided)
@return menuFrame used
]]
function ShowStyledEasyMenu(menuItems, anchor, x, y, displayMode, autoHideDelay, menuFrame)
    -- Recursive function to convert menu items and their nested menuLists
    local function convertMenuItem(item)
        if type(item) == "string" then
            return item
        elseif type(item) == "table" then
            local converted = {}
            -- Copy all properties from the original item
            for k, v in pairs(item) do
                converted[k] = v
            end
            
            -- Recursively convert menuList if it exists
            if item.menuList and type(item.menuList) == "table" then
                local convertedList = {}
                for _, subItem in ipairs(item.menuList) do
                    table.insert(convertedList, convertMenuItem(subItem))
                end
                converted.menuList = convertedList
            end
            
            return converted
        end
        return item
    end
    
    -- Convert all menu items
    local convertedItems = {}
    for _, item in ipairs(menuItems) do
        table.insert(convertedItems, convertMenuItem(item))
    end
    
    return ShowFullyStyledContextMenu(convertedItems, anchor, "TOPLEFT", "TOPLEFT", x or 0, y or 0)
end

-- Register this module
UISTYLE_LIBRARY_MODULES = UISTYLE_LIBRARY_MODULES or {}
UISTYLE_LIBRARY_MODULES["ContextMenuAdvanced"] = true

-- Debug print for module loading
if UISTYLE_DEBUG then
    print("UIStyleLibrary: ContextMenuAdvanced module loaded")
end