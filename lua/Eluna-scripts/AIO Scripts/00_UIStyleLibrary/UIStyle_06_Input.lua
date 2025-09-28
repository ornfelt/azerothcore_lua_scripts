local AIO = AIO or require("AIO")

if AIO.AddAddon() then
    return
end

-- ===================================
-- UI STYLE LIBRARY INPUT MODULE
-- ===================================
-- Search boxes, edit boxes, and sliders

--[[
Creates a styled search box with clear button
@param parent - Parent frame
@param width - Search box width
@param placeholder - Placeholder text (defaults to "Search...")
@param onTextChanged - Callback function(text) when text changes
@return searchFrame, editBox
]]
function CreateStyledSearchBox(parent, width, placeholder, onTextChanged)
    local searchFrame = CreateStyledFrame(parent, UISTYLE_COLORS.OptionBg)
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
    clearText:SetText("×")
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
        searchFrame:SetBackdropBorderColor(0, 0, 0, 1)
    end)
    
    -- Expose elements
    searchFrame.editBox = editBox
    searchFrame.placeholder = placeholderText
    searchFrame.clearButton = clearButton
    
    return searchFrame, editBox
end

--[[
Creates a styled edit box with optional multi-line support
@param parent - Parent frame
@param width - Edit box width
@param numeric - Whether to accept only numbers
@param maxLetters - Maximum character limit
@param multiLine - Whether to support multiple lines
@return Container with editBox and helper methods
]]
function CreateStyledEditBox(parent, width, numeric, maxLetters, multiLine)
    local container = CreateStyledFrame(parent, UISTYLE_COLORS.OptionBg)
    container:SetHeight(multiLine and 60 or 24)
    container:SetWidth(width)
    
    local editBox
    if multiLine then
        -- Create scroll frame for multi-line
        local scrollFrame = CreateFrame("ScrollFrame", nil, container, "UIPanelScrollFrameTemplate")
        scrollFrame:SetPoint("TOPLEFT", 4, -4)
        scrollFrame:SetPoint("BOTTOMRIGHT", -24, 4)
        
        editBox = CreateFrame("EditBox", nil, scrollFrame)
        editBox:SetMultiLine(true)
        editBox:SetWidth(width - 28)
        editBox:SetHeight(200) -- Large height for multi-line
        scrollFrame:SetScrollChild(editBox)
        
        -- Style the scroll bar
        local scrollBar = _G[scrollFrame:GetName() .. "ScrollBar"]
        if scrollBar then
            scrollBar:SetWidth(16)
        end
    else
        editBox = CreateFrame("EditBox", nil, container)
        editBox:SetPoint("TOPLEFT", 4, -2)
        editBox:SetPoint("BOTTOMRIGHT", -4, 2)
    end
    
    editBox:SetFontObject("GameFontHighlight")
    editBox:SetTextColor(UISTYLE_COLORS.White[1], UISTYLE_COLORS.White[2], UISTYLE_COLORS.White[3], 1)
    editBox:SetAutoFocus(false)
    
    if numeric then
        editBox:SetNumeric(true)
    end
    
    if maxLetters then
        editBox:SetMaxLetters(maxLetters)
    end
    
    -- Focus indicator
    editBox:SetScript("OnEditFocusGained", function(self)
        container:SetBackdropBorderColor(UISTYLE_COLORS.Blue[1], UISTYLE_COLORS.Blue[2], UISTYLE_COLORS.Blue[3], 1)
    end)
    
    editBox:SetScript("OnEditFocusLost", function(self)
        container:SetBackdropBorderColor(0, 0, 0, 1)
    end)
    
    -- Clear focus on escape
    editBox:SetScript("OnEscapePressed", function(self)
        self:ClearFocus()
    end)
    
    -- Clear focus on enter for single-line
    if not multiLine then
        editBox:SetScript("OnEnterPressed", function(self)
            self:ClearFocus()
        end)
    end
    
    -- Expose the edit box
    container.editBox = editBox
    
    -- Helper methods
    container.GetText = function(self)
        return self.editBox:GetText()
    end
    
    container.SetText = function(self, text)
        self.editBox:SetText(text)
    end
    
    container.ClearFocus = function(self)
        self.editBox:ClearFocus()
    end
    
    container.SetFocus = function(self)
        self.editBox:SetFocus()
    end
    
    return container
end

--[[
Creates a styled slider with optional vertical orientation
@param parent - Parent frame
@param width - Slider width
@param height - Slider height
@param min - Minimum value
@param max - Maximum value
@param step - Value step
@param defaultValue - Initial value
@param orientation - "HORIZONTAL" (default) or "VERTICAL"
@return Slider container with methods
]]
function CreateStyledSlider(parent, width, height, min, max, step, defaultValue, orientation)
    local container = CreateFrame("Frame", nil, parent)
    local isVertical = orientation == "VERTICAL"
    
    -- Set container size based on orientation
    if isVertical then
        -- For vertical sliders, keep width reasonable, add extra height for text
        container:SetSize(math.max(60, width), height + 40) -- Min width 60 for text, extra height for label/value
    else
        container:SetSize(width, (height or 20) + 30) -- Extra height for label and value
    end
    
    -- Label
    local label = container:CreateFontString(nil, "OVERLAY", "GameFontNormalSmall")
    label:SetTextColor(1, 1, 1, 1)
    
    -- Value text
    local valueText = container:CreateFontString(nil, "OVERLAY", "GameFontNormalSmall")
    valueText:SetTextColor(UISTYLE_COLORS.TextGrey[1], UISTYLE_COLORS.TextGrey[2], UISTYLE_COLORS.TextGrey[3])
    
    -- Position label and value based on orientation
    if isVertical then
        -- Stack label and value vertically for vertical sliders
        label:SetPoint("TOP", container, "TOP", 0, 0)
        valueText:SetPoint("TOP", label, "BOTTOM", 0, -2)
    else
        -- Side by side for horizontal sliders
        label:SetPoint("TOPLEFT")
        valueText:SetPoint("TOPRIGHT")
    end
    
    -- Slider
    local slider = CreateFrame("Slider", nil, container)
    slider:SetOrientation(orientation or "HORIZONTAL")
    
    -- Position and size slider based on orientation
    if isVertical then
        slider:SetSize(width, height)
        slider:SetPoint("TOP", valueText, "BOTTOM", 0, -5)
    else
        slider:SetSize(width, height or 20)
        slider:SetPoint("TOPLEFT", container, "TOPLEFT", 0, -20)
        slider:SetPoint("TOPRIGHT", container, "TOPRIGHT", 0, -20)
    end
    slider:SetMinMaxValues(min or 0, max or 100)
    slider:SetValueStep(step or 1)
    
    -- Set initial value (inverted for vertical sliders)
    if isVertical and defaultValue then
        slider:SetValue(max - defaultValue + min)
    else
        slider:SetValue(defaultValue or min or 0)
    end
    
    -- Slider background
    slider:SetBackdrop({
        bgFile = "Interface\\Buttons\\WHITE8X8",
        edgeFile = "Interface\\Buttons\\WHITE8X8",
        tile = false,
        edgeSize = 1,
        insets = { left = 0, right = 0, top = 0, bottom = 0 }
    })
    slider:SetBackdropColor(UISTYLE_COLORS.DarkGrey[1], UISTYLE_COLORS.DarkGrey[2], UISTYLE_COLORS.DarkGrey[3], 1)
    slider:SetBackdropBorderColor(UISTYLE_COLORS.BorderGrey[1], UISTYLE_COLORS.BorderGrey[2], UISTYLE_COLORS.BorderGrey[3], 1)
    
    -- Thumb
    local thumb = slider:CreateTexture(nil, "OVERLAY")
    thumb:SetTexture("Interface\\Buttons\\WHITE8X8")
    thumb:SetVertexColor(0.6, 0.6, 0.6, 1)
    
    if isVertical then
        thumb:SetSize(width - 4, 10)
    else
        thumb:SetSize(10, (height or 20) - 4)
    end
    
    slider:SetThumbTexture(thumb)
    
    -- Value format
    local valueFormat = "%.0f"
    
    -- Get actual display value (inverted for vertical sliders)
    local function GetDisplayValue()
        local value = slider:GetValue()
        if isVertical then
            -- Invert value for vertical sliders (0 at bottom, max at top)
            return max - value + min
        end
        return value
    end
    
    -- Update value text
    local function UpdateValueText()
        valueText:SetText(string.format(valueFormat, GetDisplayValue()))
    end
    
    -- Slider events
    slider:SetScript("OnValueChanged", function(self, value)
        UpdateValueText()
        if container.onValueChanged then
            container.onValueChanged(GetDisplayValue())
        end
    end)
    
    -- Hover effects
    slider:SetScript("OnEnter", function(self)
        thumb:SetVertexColor(0.8, 0.8, 0.8, 1)
    end)
    
    slider:SetScript("OnLeave", function(self)
        thumb:SetVertexColor(0.6, 0.6, 0.6, 1)
    end)
    
    -- Container methods
    container.SetValue = function(self, value)
        if isVertical then
            -- Invert value when setting for vertical sliders
            slider:SetValue(max - value + min)
        else
            slider:SetValue(value)
        end
    end
    
    container.GetValue = function(self)
        return GetDisplayValue()
    end
    
    container.SetLabel = function(self, text)
        label:SetText(text)
    end
    
    container.SetValueText = function(self, format)
        valueFormat = format or "%.0f"
        UpdateValueText()
    end
    
    container.SetOnValueChanged = function(self, callback)
        self.onValueChanged = callback
    end
    
    container.SetMinMaxValues = function(self, newMin, newMax)
        min = newMin
        max = newMax
        slider:SetMinMaxValues(newMin, newMax)
    end
    
    container.SetValueStep = function(self, newStep)
        slider:SetValueStep(newStep)
    end
    
    container.slider = slider
    container.label = label
    container.valueText = valueText
    
    -- Initial update
    UpdateValueText()
    
    return container
end

--[[
Creates a styled slider with min/max labels at the ends (enhanced version)
@param parent - Parent frame  
@param width - Slider width
@param height - Slider height (defaults to 20)
@param min - Minimum value
@param max - Maximum value
@param step - Value step
@param defaultValue - Initial value
@param labelText - Optional label text (e.g. "Level")
@return Slider container with methods
]]
function CreateStyledSliderWithRange(parent, width, height, min, max, step, defaultValue, labelText)
    local container = CreateFrame("Frame", nil, parent)
    container:SetSize(width, 50) -- Extra height for labels
    
    -- Label (if provided)
    local label
    if labelText then
        label = container:CreateFontString(nil, "OVERLAY", "GameFontNormalSmall")
        label:SetPoint("TOPLEFT", 0, 0)
        label:SetText(labelText .. ":")
        label:SetTextColor(1, 1, 1, 1)
    end
    
    -- Current value display (centered above slider)
    local valueText = container:CreateFontString(nil, "OVERLAY", "GameFontNormalSmall")
    valueText:SetPoint("TOP", container, "TOP", 0, -5)  -- Moved up from -15 to -5
    valueText:SetTextColor(1, 1, 1, 1)
    
    -- Slider container for proper positioning
    local sliderFrame = CreateFrame("Frame", nil, container)
    sliderFrame:SetSize(width - 40, height or 20)
    sliderFrame:SetPoint("BOTTOM", container, "BOTTOM", 0, 15)
    
    -- Min value label
    local minLabel = container:CreateFontString(nil, "OVERLAY", "GameFontNormalSmall") 
    minLabel:SetPoint("BOTTOMLEFT", sliderFrame, "BOTTOMLEFT", -20, -15)
    minLabel:SetText(tostring(min))
    minLabel:SetTextColor(0.7, 0.7, 0.7, 1)
    
    -- Max value label
    local maxLabel = container:CreateFontString(nil, "OVERLAY", "GameFontNormalSmall")
    maxLabel:SetPoint("BOTTOMRIGHT", sliderFrame, "BOTTOMRIGHT", 20, -15)
    maxLabel:SetText(tostring(max))
    maxLabel:SetTextColor(0.7, 0.7, 0.7, 1)
    
    -- Create the actual slider
    local slider = CreateFrame("Slider", nil, sliderFrame)
    slider:SetAllPoints()
    slider:SetOrientation("HORIZONTAL")
    slider:SetMinMaxValues(min or 0, max or 100)
    slider:SetValueStep(step or 1)
    slider:SetValue(defaultValue or min or 0)
    slider:EnableMouse(true)  -- Ensure mouse is enabled
    
    -- Slider background track
    local bg = slider:CreateTexture(nil, "BACKGROUND")
    bg:SetTexture("Interface\\Buttons\\WHITE8X8")
    bg:SetVertexColor(0.1, 0.1, 0.1, 1)
    bg:SetHeight(4)
    bg:SetPoint("LEFT", slider, "LEFT", 0, 0)
    bg:SetPoint("RIGHT", slider, "RIGHT", 0, 0)
    
    -- Slider thumb (CRITICAL - without this, slider won't be draggable!)
    local thumb = slider:CreateTexture(nil, "OVERLAY")
    thumb:SetTexture("Interface\\Buttons\\WHITE8X8")
    thumb:SetVertexColor(0.8, 0.8, 0.8, 1)
    thumb:SetSize(12, 20)
    slider:SetThumbTexture(thumb)
    
    -- Update value text
    local function UpdateValue()
        local value = math.floor(slider:GetValue())
        valueText:SetText(tostring(value))
    end
    
    -- Value changed handler
    slider:SetScript("OnValueChanged", function(self, value)
        UpdateValue()
        if container.onValueChanged then
            container.onValueChanged(value)
        end
    end)
    
    -- Hover effects
    slider:SetScript("OnEnter", function(self)
        thumb:SetVertexColor(0.9, 0.9, 0.9, 1)
    end)
    
    slider:SetScript("OnLeave", function(self)
        if not self:IsMouseOver() then
            thumb:SetVertexColor(0.8, 0.8, 0.8, 1)
        end
    end)
    
    -- Initialize
    UpdateValue()
    
    -- Public methods
    container.GetValue = function(self)
        return math.floor(slider:GetValue())
    end
    
    container.SetValue = function(self, value)
        slider:SetValue(value)
    end
    
    container.SetLabel = function(self, text)
        if label then
            label:SetText(text .. ":")
        end
    end
    
    container.SetOnValueChanged = function(self, callback)
        self.onValueChanged = callback
    end
    
    -- Expose elements
    container.slider = slider
    container.label = label
    container.valueText = valueText
    container.minLabel = minLabel
    container.maxLabel = maxLabel
    
    return container
end

-- Register this module
UISTYLE_LIBRARY_MODULES = UISTYLE_LIBRARY_MODULES or {}
UISTYLE_LIBRARY_MODULES["Input"] = true

-- Debug print for module loading
if UISTYLE_DEBUG then
    print("UIStyleLibrary: Input module loaded")
end