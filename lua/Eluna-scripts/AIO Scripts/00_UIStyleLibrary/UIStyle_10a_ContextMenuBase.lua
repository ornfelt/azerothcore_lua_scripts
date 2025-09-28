local AIO = AIO or require("AIO")

if AIO.AddAddon() then
    return
end

-- ===================================
-- UI STYLE LIBRARY CONTEXT MENU BASE MODULE
-- ===================================
-- Basic context menu functionality

--[[
Creates a styled context menu
@param items - Table of menu items, each with:
    - text: Display text
    - func: Click handler function
    - disabled: Boolean to disable item
    - separator: Boolean to show as separator
    - hasArrow: Boolean for submenu indicator
    - value: Optional value to pass to func
@param anchorFrame - Frame to anchor the menu to
@param anchorPoint - Anchor point (defaults to "TOPRIGHT")
@param relativePoint - Relative point (defaults to "TOPLEFT")
@param xOffset - X offset (defaults to 0)
@param yOffset - Y offset (defaults to 0)
@return Menu frame
]]
function CreateStyledContextMenu(items, anchorFrame, anchorPoint, relativePoint, xOffset, yOffset)
    -- Create menu frame
    local menu = CreateStyledFrame(UIParent, UISTYLE_COLORS.DarkGrey)
    menu:SetFrameStrata("FULLSCREEN_DIALOG")
    menu:SetFrameLevel(100)
    
    local menuItems = {}
    local currentY = -4
    local maxWidth = 100
    
    -- Create menu items
    for i, itemData in ipairs(items) do
        if itemData.separator then
            -- Separator
            local sep = menu:CreateTexture(nil, "OVERLAY")
            sep:SetHeight(1)
            sep:SetTexture("Interface\\Buttons\\WHITE8X8")
            sep:SetVertexColor(UISTYLE_COLORS.BorderGrey[1], UISTYLE_COLORS.BorderGrey[2], UISTYLE_COLORS.BorderGrey[3], 1)
            sep:SetPoint("LEFT", 4, 0)
            sep:SetPoint("RIGHT", -4, 0)
            sep:SetPoint("TOP", 0, currentY - 4)
            currentY = currentY - 9
        else
            -- Menu item
            local item = CreateFrame("Button", nil, menu)
            item:SetHeight(20)
            item:SetPoint("LEFT", 2, 0)
            item:SetPoint("RIGHT", -2, 0)
            item:SetPoint("TOP", 0, currentY)
            
            -- Text
            local text = item:CreateFontString(nil, "OVERLAY", "GameFontNormalSmall")
            text:SetPoint("LEFT", 8, 0)
            text:SetText(itemData.text)
            item.text = text
            
            -- Arrow for submenus
            if itemData.hasArrow then
                local arrow = item:CreateFontString(nil, "OVERLAY", "GameFontNormalSmall")
                arrow:SetPoint("RIGHT", -8, 0)
                arrow:SetText(">")
                arrow:SetTextColor(UISTYLE_COLORS.TextGrey[1], UISTYLE_COLORS.TextGrey[2], UISTYLE_COLORS.TextGrey[3], 1)
                item.arrow = arrow
            end
            
            -- Update max width
            local textWidth = text:GetStringWidth() + 20
            if itemData.hasArrow then
                textWidth = textWidth + 20
            end
            maxWidth = math.max(maxWidth, textWidth)
            
            -- Disabled state
            if itemData.disabled then
                text:SetTextColor(UISTYLE_COLORS.TextGrey[1], UISTYLE_COLORS.TextGrey[2], UISTYLE_COLORS.TextGrey[3], 0.5)
                item:EnableMouse(false)
            else
                text:SetTextColor(UISTYLE_COLORS.TextGrey[1], UISTYLE_COLORS.TextGrey[2], UISTYLE_COLORS.TextGrey[3], 1)
                
                -- Highlight
                local highlight = item:CreateTexture(nil, "HIGHLIGHT")
                highlight:SetTexture("Interface\\Buttons\\WHITE8X8")
                highlight:SetVertexColor(1, 1, 1, 0.1)
                highlight:SetAllPoints()
                
                -- Click handler
                item:SetScript("OnClick", function()
                    if itemData.func then
                        itemData.func(itemData.value)
                    end
                    menu:Hide()
                end)
                
                -- Hover effect
                item:SetScript("OnEnter", function(self)
                    self.text:SetTextColor(1, 1, 1, 1)
                end)
                
                item:SetScript("OnLeave", function(self)
                    self.text:SetTextColor(UISTYLE_COLORS.TextGrey[1], UISTYLE_COLORS.TextGrey[2], UISTYLE_COLORS.TextGrey[3], 1)
                end)
            end
            
            table.insert(menuItems, item)
            currentY = currentY - 20
        end
    end
    
    -- Set menu size
    menu:SetWidth(maxWidth + 4)
    menu:SetHeight(math.abs(currentY) + 4)
    
    -- Position menu
    menu:ClearAllPoints()
    menu:SetPoint(anchorPoint or "TOPRIGHT", anchorFrame, relativePoint or "TOPLEFT", xOffset or 0, yOffset or 0)
    
    -- Close on click outside
    local closeButton = CreateFrame("Button", nil, UIParent)
    closeButton:SetAllPoints(UIParent)
    closeButton:SetFrameStrata("FULLSCREEN")
    closeButton:SetFrameLevel(99)
    closeButton:Show()
    
    closeButton:SetScript("OnClick", function()
        menu:Hide()
        closeButton:Hide()
    end)
    
    menu:SetScript("OnHide", function()
        closeButton:Hide()
    end)
    
    menu.closeButton = closeButton
    menu.items = menuItems
    
    return menu
end

-- Register this module
UISTYLE_LIBRARY_MODULES = UISTYLE_LIBRARY_MODULES or {}
UISTYLE_LIBRARY_MODULES["ContextMenuBase"] = true

-- Debug print for module loading
if UISTYLE_DEBUG then
    print("UIStyleLibrary: ContextMenuBase module loaded")
end