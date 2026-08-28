local AIO = AIO or require("AIO")

if AIO.AddAddon() then
    return
end

-- ===================================
-- UI STYLE LIBRARY SEARCH BOX MODULE
-- ===================================
-- Search box with clear button

--[[
Creates a styled search box with clear button
@param parent - Parent frame
@param width - Search box width
@param placeholder - Placeholder text (defaults to "Search...")
@param onTextChanged - Callback function(text) when text changes
@return searchFrame, editBox
]]
function CreateStyledSearchBox(parent, width, placeholder, onTextChanged)
    local searchFrame = CreateStyledFrame(parent, UISTYLE_COLORS.ButtonBg)
    searchFrame:SetWidth(width)
    searchFrame:SetHeight(28)

    -- Search icon (optional)
    local searchIcon = searchFrame:CreateTexture(nil, "ARTWORK")
    searchIcon:SetSize(16, 16)
    searchIcon:SetPoint("LEFT", 8, 0)
    searchIcon:SetTexture("Interface\\Common\\UI-Searchbox-Icon")
    searchIcon:SetVertexColor(UISTYLE_COLORS.TextGrey[1], UISTYLE_COLORS.TextGrey[2], UISTYLE_COLORS.TextGrey[3], 1)

    -- Search input
    local editBox = CreateFrame("EditBox", nil, searchFrame)
    editBox:SetWidth(width - 55) -- Account for icon and larger clear button
    editBox:SetHeight(20)
    editBox:SetPoint("LEFT", searchIcon, "RIGHT", 4, 0)
    editBox:SetPoint("RIGHT", -30, 0)  -- More space for the larger clear button
    editBox:SetFontObject("GameFontHighlight")
    editBox:SetAutoFocus(false)
    editBox:SetTextColor(UISTYLE_COLORS.White[1], UISTYLE_COLORS.White[2], UISTYLE_COLORS.White[3], 1)

    -- Placeholder
    local placeholderText = editBox:CreateFontString(nil, "OVERLAY", "GameFontDisable")
    placeholderText:SetPoint("LEFT", editBox, "LEFT", 2, 0)
    placeholderText:SetText(placeholder or "Search...")
    placeholderText:SetTextColor(UISTYLE_COLORS.TextGrey[1], UISTYLE_COLORS.TextGrey[2], UISTYLE_COLORS.TextGrey[3], 0.7)

    -- Clear button (X)
    local clearButton = CreateFrame("Button", nil, searchFrame)
    clearButton:SetSize(24, 24)  -- Increased from 16x16 to 24x24 for easier clicking
    clearButton:SetPoint("RIGHT", -4, 0)  -- Adjusted position slightly
    clearButton:Hide()

    -- Add a subtle background to make the clickable area more visible
    clearButton:SetNormalTexture("Interface\\Buttons\\UI-Panel-MinimizeButton-Up")
    clearButton:SetPushedTexture("Interface\\Buttons\\UI-Panel-MinimizeButton-Down")
    clearButton:SetHighlightTexture("Interface\\Buttons\\UI-Panel-MinimizeButton-Highlight")
    clearButton:GetNormalTexture():SetAlpha(0.3)
    clearButton:GetPushedTexture():SetAlpha(0.5)

    local clearText = clearButton:CreateFontString(nil, "OVERLAY", "GameFontNormalLarge")  -- Changed to larger font
    clearText:SetPoint("CENTER", 0, 0)
    clearText:SetText("x")
    clearText:SetTextColor(UISTYLE_COLORS.TextGrey[1], UISTYLE_COLORS.TextGrey[2], UISTYLE_COLORS.TextGrey[3], 1)
    clearButton.text = clearText

    clearButton:SetScript("OnClick", function()
        editBox:SetText("")
        editBox:ClearFocus()
        -- Manually trigger the text changed callback since SetText doesn't trigger OnTextChanged
        if onTextChanged then
            onTextChanged("")
        end
    end)

    clearButton:SetScript("OnEnter", function(self)
        self.text:SetTextColor(1, 1, 1, 1)
    end)

    clearButton:SetScript("OnLeave", function(self)
        self.text:SetTextColor(UISTYLE_COLORS.TextGrey[1], UISTYLE_COLORS.TextGrey[2], UISTYLE_COLORS.TextGrey[3], 1)
    end)

    -- Edit box scripts
    editBox:SetScript("OnTextChanged", function(self)
        local text = self:GetText()
        if text == "" then
            placeholderText:Show()
            clearButton:Hide()
        else
            placeholderText:Hide()
            clearButton:Show()
        end

        if onTextChanged then
            onTextChanged(text)
        end
    end)

    editBox:SetScript("OnEnterPressed", function(self)
        self:ClearFocus()
    end)

    editBox:SetScript("OnEscapePressed", function(self)
        self:SetText("")
        self:ClearFocus()
    end)

    -- Focus effects
    editBox:SetScript("OnEditFocusGained", function(self)
        searchFrame:SetBackdropBorderColor(UISTYLE_COLORS.Blue[1], UISTYLE_COLORS.Blue[2], UISTYLE_COLORS.Blue[3], 1)
    end)

    editBox:SetScript("OnEditFocusLost", function(self)
        searchFrame:SetBackdropBorderColor(UISTYLE_COLORS.ButtonBorder[1], UISTYLE_COLORS.ButtonBorder[2], UISTYLE_COLORS.ButtonBorder[3], 1)
    end)

    -- Expose elements
    searchFrame.editBox = editBox
    searchFrame.placeholder = placeholderText
    searchFrame.clearButton = clearButton

    return searchFrame, editBox
end

-- Register this module
UISTYLE_LIBRARY_MODULES = UISTYLE_LIBRARY_MODULES or {}
UISTYLE_LIBRARY_MODULES["SearchBox"] = true

if UISTYLE_DEBUG then
    print("UIStyleLibrary: SearchBox module loaded")
end
