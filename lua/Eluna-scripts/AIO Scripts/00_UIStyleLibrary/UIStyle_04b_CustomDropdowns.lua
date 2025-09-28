local AIO = AIO or require("AIO")

if AIO.AddAddon() then
    return
end

-- ===================================
-- UI STYLE LIBRARY CUSTOM DROPDOWNS MODULE
-- ===================================
-- Fully custom dropdown implementations without UIDropDownMenuTemplate

--[[
Creates a fully custom styled dropdown using a button instead of UIDropDownMenuTemplate
This gives complete control over appearance but requires more manual handling
@param parent - Parent frame
@param width - Width of the dropdown
@param items - Table of string options
@param defaultValue - Optional default selected value
@param onSelect - Callback function when selection changes
@return dropdown button frame, menu frame
]]
function CreateCustomStyledDropdown(parent, width, items, defaultValue, onSelect)
    -- Create main button
    local dropdownButton = CreateStyledButton(parent, defaultValue or "Select...", width, 26)
    dropdownButton.value = defaultValue

    -- Add dropdown arrow on the right
    local arrow = dropdownButton:CreateFontString(nil, "OVERLAY", "GameFontNormalSmall")
    arrow:SetPoint("RIGHT", -8, 0)
    arrow:SetText("v")
    arrow:SetTextColor(UISTYLE_COLORS.TextGrey[1], UISTYLE_COLORS.TextGrey[2], UISTYLE_COLORS.TextGrey[3], 1)

    -- Adjust text to make room for arrow
    dropdownButton.text:ClearAllPoints()
    dropdownButton.text:SetPoint("LEFT", 8, 0)
    dropdownButton.text:SetPoint("RIGHT", arrow, "LEFT", -5, 0)
    dropdownButton.text:SetJustifyH("LEFT")

    -- Create dropdown menu frame
    local menuFrame = CreateStyledFrame(UIParent, UISTYLE_COLORS.DarkGrey)
    menuFrame:SetFrameStrata("FULLSCREEN_DIALOG")
    menuFrame:SetWidth(width)
    menuFrame:Hide()

    -- Position menu below button
    menuFrame:SetPoint("TOPLEFT", dropdownButton, "BOTTOMLEFT", 0, -2)

    -- Create menu items
    local menuItems = {}
    local itemHeight = 22

    for i, itemText in ipairs(items) do
        local menuItem = CreateFrame("Button", nil, menuFrame)
        menuItem:SetHeight(itemHeight)
        menuItem:SetPoint("LEFT", 1, 0)
        menuItem:SetPoint("RIGHT", -1, 0)

        if i == 1 then
            menuItem:SetPoint("TOP", 0, -1)
        else
            menuItem:SetPoint("TOP", menuItems[i - 1], "BOTTOM", 0, 0)
        end

        -- Item text
        local text = menuItem:CreateFontString(nil, "OVERLAY", "GameFontNormalSmall")
        text:SetPoint("LEFT", 8, 0)
        text:SetText(itemText)
        text:SetTextColor(UISTYLE_COLORS.TextGrey[1], UISTYLE_COLORS.TextGrey[2], UISTYLE_COLORS.TextGrey[3], 1)
        menuItem.text = text

        -- Highlight texture
        local highlight = menuItem:CreateTexture(nil, "HIGHLIGHT")
        highlight:SetTexture("Interface\\Buttons\\WHITE8X8")
        highlight:SetVertexColor(1, 1, 1, 0.1)
        highlight:SetAllPoints()

        -- Click handler
        menuItem:SetScript("OnClick", function(self)
            dropdownButton.value = itemText
            dropdownButton.text:SetText(itemText)
            menuFrame:Hide()
            if onSelect then
                onSelect(itemText)
            end
        end)

        -- Hover effect
        menuItem:SetScript("OnEnter", function(self)
            self.text:SetTextColor(1, 1, 1, 1)
        end)

        menuItem:SetScript("OnLeave", function(self)
            self.text:SetTextColor(UISTYLE_COLORS.TextGrey[1], UISTYLE_COLORS.TextGrey[2], UISTYLE_COLORS.TextGrey[3], 1)
        end)

        table.insert(menuItems, menuItem)
    end

    -- Set menu frame height
    menuFrame:SetHeight((#items * itemHeight) + 2)

    -- Toggle menu on button click
    dropdownButton:SetScript("OnClick", function(self)
        if menuFrame:IsShown() then
            menuFrame:Hide()
        else
            menuFrame:Show()
            menuFrame:Raise()
        end
    end)

    -- Close menu when clicking elsewhere
    local closeHandler = CreateFrame("Button", nil, UIParent)
    closeHandler:SetAllPoints(UIParent)
    closeHandler:SetFrameStrata("FULLSCREEN")
    closeHandler:Hide()

    closeHandler:SetScript("OnClick", function()
        menuFrame:Hide()
        closeHandler:Hide()
    end)

    menuFrame:SetScript("OnShow", function()
        closeHandler:Show()
        closeHandler:SetFrameLevel(menuFrame:GetFrameLevel() - 1)
    end)

    menuFrame:SetScript("OnHide", function()
        closeHandler:Hide()
    end)

    -- Helper methods
    dropdownButton.GetValue = function(self)
        return self.value
    end

    dropdownButton.SetValue = function(self, value)
        self.value = value
        self.text:SetText(value)
    end

    dropdownButton.UpdateItems = function(self, newItems, newDefault)
        -- Clear existing items
        for _, item in ipairs(menuItems) do
            item:Hide()
            item:SetParent(nil)
        end
        wipe(menuItems)

        -- Create new items
        items = newItems
        for i, itemText in ipairs(items) do
            local menuItem = CreateFrame("Button", nil, menuFrame)
            menuItem:SetHeight(itemHeight)
            menuItem:SetPoint("LEFT", 1, 0)
            menuItem:SetPoint("RIGHT", -1, 0)

            if i == 1 then
                menuItem:SetPoint("TOP", 0, -1)
            else
                menuItem:SetPoint("TOP", menuItems[i - 1], "BOTTOM", 0, 0)
            end

            -- Item text
            local text = menuItem:CreateFontString(nil, "OVERLAY", "GameFontNormalSmall")
            text:SetPoint("LEFT", 8, 0)
            text:SetText(itemText)
            text:SetTextColor(UISTYLE_COLORS.TextGrey[1], UISTYLE_COLORS.TextGrey[2], UISTYLE_COLORS.TextGrey[3], 1)
            menuItem.text = text

            -- Highlight texture
            local highlight = menuItem:CreateTexture(nil, "HIGHLIGHT")
            highlight:SetTexture("Interface\\Buttons\\WHITE8X8")
            highlight:SetVertexColor(1, 1, 1, 0.1)
            highlight:SetAllPoints()

            -- Click handler
            menuItem:SetScript("OnClick", function(self)
                dropdownButton.value = itemText
                dropdownButton.text:SetText(itemText)
                menuFrame:Hide()
                if onSelect then
                    onSelect(itemText)
                end
            end)

            -- Hover effect
            menuItem:SetScript("OnEnter", function(self)
                self.text:SetTextColor(1, 1, 1, 1)
            end)

            menuItem:SetScript("OnLeave", function(self)
                self.text:SetTextColor(UISTYLE_COLORS.TextGrey[1], UISTYLE_COLORS.TextGrey[2], UISTYLE_COLORS.TextGrey[3], 1)
            end)

            table.insert(menuItems, menuItem)
        end

        -- Update menu frame height
        menuFrame:SetHeight((#items * itemHeight) + 2)

        -- Set new default if provided
        if newDefault then
            self:SetValue(newDefault)
        end
    end

    return dropdownButton, menuFrame
end

-- Register this module
UISTYLE_LIBRARY_MODULES = UISTYLE_LIBRARY_MODULES or {}
UISTYLE_LIBRARY_MODULES["CustomDropdowns"] = true

-- Debug print for module loading
if UISTYLE_DEBUG then
    print("UIStyleLibrary: CustomDropdowns module loaded")
end