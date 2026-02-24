local AIO = AIO or require("AIO")

if AIO.AddAddon() then
    return -- Exit if on server
end

-- Initialize namespace
_G.TemplateUI = _G.TemplateUI or {}
local TemplateUI = _G.TemplateUI


-- Get UIStyleLibrary functions
local CreateStyledFrame = _G.CreateStyledFrame
local CreateStyledButton = _G.CreateStyledButton
local CreateStyledEditBox = _G.CreateStyledEditBox
local CreateFullyStyledDropdown = _G.CreateFullyStyledDropdown
local CreateScrollableFrame = _G.CreateScrollableFrame
local CreateStyledSliderWithRange = _G.CreateStyledSliderWithRange
local CreateStyledTabGroup = _G.CreateStyledTabGroup

-- Check if UIStyleLibrary is loaded
if not CreateStyledFrame then
    print("|cFFFF0000[TemplateUI] Error: UIStyleLibrary not loaded!|r")
    return
end

-- Create the main dialog frame
function TemplateUI.CreateDialog(CONFIG, onClose, onSave, onReset, onPreview, onTabChange, editor)
    -- Use styled frame instead of manual CreateFrame
    local frame = CreateStyledFrame(UIParent, UISTYLE_COLORS.DarkGrey)
    frame:SetSize(CONFIG.WINDOW_WIDTH, CONFIG.WINDOW_HEIGHT)
    frame:SetPoint("CENTER", 0, 0)
    frame:SetFrameStrata("DIALOG")
    frame:SetMovable(true)
    frame:EnableMouse(true)
    frame:RegisterForDrag("LeftButton")
    frame:SetScript("OnDragStart", frame.StartMoving)
    frame:SetScript("OnDragStop", frame.StopMovingOrSizing)
    frame:Hide()
    
    -- Title bar
    local titleBar = CreateFrame("Frame", nil, frame)
    titleBar:SetHeight(32)
    titleBar:SetPoint("TOPLEFT", 8, -8)
    titleBar:SetPoint("TOPRIGHT", -8, -8)
    
    local title = titleBar:CreateFontString(nil, "OVERLAY", "GameFontNormalLarge")
    title:SetPoint("CENTER")
    title:SetText("Creature Template Editor")
    title:SetTextColor(UISTYLE_COLORS.White[1], UISTYLE_COLORS.White[2], UISTYLE_COLORS.White[3], 1)
    frame.title = title
    
    -- Close button
    local closeBtn = CreateStyledButton(titleBar, "X", 24, 24)
    closeBtn:SetPoint("TOPRIGHT", titleBar, "TOPRIGHT", -5, -3)
    closeBtn:SetScript("OnClick", function()
        if onClose then onClose() end
    end)
    
    -- Entry ID display container (below title bar)
    local entryContainer = CreateFrame("Frame", nil, frame)
    entryContainer:SetHeight(30)
    entryContainer:SetPoint("TOPLEFT", titleBar, "BOTTOMLEFT", 0, -5)
    entryContainer:SetPoint("TOPRIGHT", titleBar, "BOTTOMRIGHT", 0, -5)
    frame.entryContainer = entryContainer
    
    -- Current entry label (for edit mode)
    local currentLabel = entryContainer:CreateFontString(nil, "OVERLAY", "GameFontNormal")
    currentLabel:SetPoint("LEFT", 10, 0)
    currentLabel:SetText("Current Entry ID: ")
    currentLabel:SetTextColor(UISTYLE_COLORS.White[1], UISTYLE_COLORS.White[2], UISTYLE_COLORS.White[3], 1)
    currentLabel:Hide()
    entryContainer.currentLabel = currentLabel
    
    -- Next available entry label (for duplicate mode)
    local nextLabel = entryContainer:CreateFontString(nil, "OVERLAY", "GameFontNormal")
    nextLabel:SetPoint("LEFT", 10, 0)
    nextLabel:SetText("Next Available Entry: Loading...")
    nextLabel:SetTextColor(UISTYLE_COLORS.Green[1], UISTYLE_COLORS.Green[2], UISTYLE_COLORS.Green[3], 1)
    nextLabel:Hide()
    entryContainer.nextLabel = nextLabel
    
    -- Custom entry label and input (for duplicate mode)
    local customLabel = entryContainer:CreateFontString(nil, "OVERLAY", "GameFontNormal")
    customLabel:SetPoint("LEFT", 250, 0)
    customLabel:SetText("Override Entry ID:")
    customLabel:SetTextColor(UISTYLE_COLORS.White[1], UISTYLE_COLORS.White[2], UISTYLE_COLORS.White[3], 1)
    customLabel:Hide()
    entryContainer.customLabel = customLabel
    
    -- CreateStyledEditBox(parent, width, numeric, maxLetters, multiLine)
    local customInput = CreateStyledEditBox(entryContainer, 80, true, 10, false)
    customInput:SetPoint("LEFT", customLabel, "RIGHT", 10, 0)
    customInput:SetHeight(25)
    -- The editBox is inside the container
    customInput.editBox:SetScript("OnTextChanged", function(self)
        if editor and editor.OnCustomEntryChanged then
            editor.OnCustomEntryChanged(self:GetText())
        end
    end)
    customInput:Hide()
    entryContainer.customInput = customInput
    
    -- Create styled tab group
    local tabData = {}
    for i, tabName in ipairs(CONFIG.TABS) do
        table.insert(tabData, {
            text = tabName,
            tooltip = "Configure " .. tabName .. " settings"
        })
    end
    
    local tabContainer, tabContentFrames, tabButtons = CreateStyledTabGroup(
        frame,
        tabData,
        CONFIG.WINDOW_WIDTH - 20,
        CONFIG.WINDOW_HEIGHT - 150, -- Leave room for title, entry display, and buttons
        "HORIZONTAL",
        function(tabIndex, tabInfo)
            -- Handle tab changes via external callback if needed
            if frame.onTabChange then
                frame.onTabChange(tabIndex)
            end
            -- Call the external tab change callback if provided
            if onTabChange then
                onTabChange(tabIndex)
            end
        end
    )
    tabContainer:SetPoint("TOPLEFT", 10, -75) -- Adjusted to account for entry container
    
    frame.tabs = tabButtons
    frame.tabContentFrames = tabContentFrames
    frame.tabContainer = tabContainer
    
    -- Store references to the active content frame for compatibility
    frame.content = nil -- Will be set when a tab is selected
    frame.scrollContainer = nil
    frame.updateScrollBar = nil
    
    -- Set up tab change callback to update content references
    frame.onTabChange = function(tabIndex)
        -- Clean up the previous tab's content if it exists
        if frame.content then
            TemplateUI.CleanupContent(frame.content)
        end
        
        local activeContentFrame = tabContentFrames[tabIndex]
        if activeContentFrame then
            -- Create scroll area in the active tab if it doesn't exist
            if not activeContentFrame.scrollContainer then
                local container, content, scrollBar, updateScrollBar = CreateScrollableFrame(
                    activeContentFrame, 
                    activeContentFrame:GetWidth() - 20, 
                    activeContentFrame:GetHeight() - 20
                )
                container:SetPoint("TOPLEFT", 10, -10)
                container:SetPoint("BOTTOMRIGHT", -10, 10)
                
                activeContentFrame.scrollContainer = container
                activeContentFrame.content = content
                activeContentFrame.updateScrollBar = updateScrollBar
                
                -- Initialize tracking tables for the new content
                content.fields = {}
                content.fieldLabels = {}
                content.checkboxes = {}
            else
                -- Clean up existing content when switching back to a tab
                TemplateUI.CleanupContent(activeContentFrame.content)
                -- Re-initialize tracking
                activeContentFrame.content.fields = {}
                activeContentFrame.content.fieldLabels = {}
                activeContentFrame.content.checkboxes = {}
            end
            
            -- Update frame references for compatibility
            frame.content = activeContentFrame.content
            frame.scrollContainer = activeContentFrame.scrollContainer
            frame.updateScrollBar = activeContentFrame.updateScrollBar
        end
    end
    
    -- Initialize the first tab's content area
    frame.onTabChange(1)
    
    -- Button container
    local buttonContainer = CreateFrame("Frame", nil, frame)
    buttonContainer:SetHeight(40)
    buttonContainer:SetPoint("BOTTOMLEFT", 10, 10)
    buttonContainer:SetPoint("BOTTOMRIGHT", -10, 10)
    
    -- Save button
    local saveBtn = CreateStyledButton(buttonContainer, "Save", 100, 30)
    saveBtn:SetPoint("RIGHT", buttonContainer, "CENTER", -10, 0)
    saveBtn:SetScript("OnClick", function()
        if onSave then onSave() end
    end)
    frame.saveBtn = saveBtn
    
    -- Cancel button
    local cancelBtn = CreateStyledButton(buttonContainer, "Cancel", 100, 30)
    cancelBtn:SetPoint("LEFT", buttonContainer, "CENTER", 10, 0)
    cancelBtn:SetScript("OnClick", function()
        if onClose then onClose() end
    end)
    
    -- Reset button
    local resetBtn = CreateStyledButton(buttonContainer, "Reset", 80, 25)
    resetBtn:SetPoint("LEFT", 10, 0)
    resetBtn:SetScript("OnClick", function()
        if onReset then onReset() end
    end)
    
    -- Preview button
    local previewBtn = CreateStyledButton(buttonContainer, "Preview", 80, 25)
    previewBtn:SetPoint("RIGHT", -10, 0)
    previewBtn:SetScript("OnClick", function()
        if onPreview then onPreview() end
    end)
    
    return frame
end

-- Create input field based on type
function TemplateUI.CreateField(parent, field, CONFIG, onFieldChanged)
    local container = CreateFrame("Frame", nil, parent)
    local containerHeight = CONFIG.FIELD_HEIGHT
    if field.type == "decimal" and field.key:match("Modifier") then
        containerHeight = CONFIG.FIELD_HEIGHT + 15
    end
    container:SetHeight(containerHeight)
    container:SetPoint("TOPLEFT", 0, 0)
    container:SetPoint("TOPRIGHT", 0, 0)
    
    -- Label
    local label = container:CreateFontString(nil, "OVERLAY", "GameFontNormal")
    label:SetPoint("LEFT", 5, 0)
    label:SetWidth(CONFIG.LABEL_WIDTH)
    label:SetJustifyH("RIGHT")
    label:SetText(field.label)
    label:SetTextColor(UISTYLE_COLORS.White[1], UISTYLE_COLORS.White[2], UISTYLE_COLORS.White[3], 1)
    
    -- Store label reference for cleanup (parent should have fieldLabels table)
    if parent.fieldLabels then
        table.insert(parent.fieldLabels, label)
    end
    
    -- Create appropriate input control
    local input
    if field.type == "text" then
        input = CreateStyledEditBox(container, CONFIG.INPUT_WIDTH, false)
        input:SetPoint("LEFT", label, "RIGHT", 10, 0)
        
        local editBox = input.editBox or input
        editBox.field = field
        editBox.lastValue = ""  -- Track last saved value
        
        -- Store initial value when gaining focus
        editBox:SetScript("OnEditFocusGained", function(self)
            self.lastValue = self:GetText() or ""
        end)
        
        editBox:SetScript("OnEscapePressed", function(self) 
            self:SetText(self.lastValue or "")  -- Restore on escape
            self:ClearFocus() 
        end)
        
        editBox:SetScript("OnEnterPressed", function(self) 
            self:ClearFocus() 
        end)
        
        editBox:SetScript("OnTabPressed", function(self)
            self:ClearFocus()
            -- Could implement tab navigation here if needed
        end)
        
        editBox:SetScript("OnEditFocusLost", function(self)
            local text = self:GetText() or ""
            
            -- Trim whitespace
            text = text:gsub("^%s*(.-)%s*$", "%1")
            
            -- Limit length
            if string.len(text) > 255 then
                text = string.sub(text, 1, 255)
                self:SetText(text)
            end
            
            -- Only trigger change if value actually changed
            if text ~= self.lastValue then
                if onFieldChanged then
                    onFieldChanged(self.field.key, text)
                end
                self.lastValue = text
            end
        end)
        
    elseif field.type == "number" or field.type == "decimal" then
        local useSlider = field.type == "decimal" and (
            field.key:match("Modifier") or 
            field.key == "scale" or 
            field.key:match("speed_") or 
            field.key == "HoverHeight" or
            field.key == "BaseVariance"
        )
        
        if useSlider and field.min and field.max then
            input = CreateStyledSliderWithRange(container, CONFIG.INPUT_WIDTH, 20, 
                field.min, field.max, field.step or 0.1, field.defaultValue or 1, nil)
            input:SetPoint("LEFT", label, "RIGHT", 10, -5)
            
            input:SetOnValueChanged(function(value)
                if onFieldChanged then
                    onFieldChanged(field.key, value)
                end
            end)
        else
            input = CreateStyledEditBox(container, CONFIG.INPUT_WIDTH, true)
            input:SetPoint("LEFT", label, "RIGHT", 10, 0)
            
            local editBox = input.editBox or input
            editBox.field = field
            editBox.fieldType = field.type
            editBox.lastValue = ""  -- Track last saved value
            
            -- Store initial value when gaining focus
            editBox:SetScript("OnEditFocusGained", function(self)
                self.lastValue = self:GetText() or ""
            end)
            
            editBox:SetScript("OnEscapePressed", function(self) 
                self:SetText(self.lastValue or "")  -- Restore on escape
                self:ClearFocus() 
            end)
            
            editBox:SetScript("OnEnterPressed", function(self) 
                self:ClearFocus() 
            end)
            
            editBox:SetScript("OnTabPressed", function(self)
                self:ClearFocus()
            end)
            
            editBox:SetScript("OnEditFocusLost", function(self)
                local text = self:GetText() or ""
                local value
                
                if self.fieldType == "number" then
                    local cleaned = text:gsub("[^0-9-]", "")
                    if cleaned ~= text then
                        self:SetText(cleaned)
                        text = cleaned
                    end
                    value = tonumber(text) or 0
                else
                    local cleaned = text:gsub("[^0-9.-]", "")
                    if cleaned ~= text then
                        self:SetText(cleaned)
                        text = cleaned
                    end
                    value = tonumber(text) or 0.0
                end
                
                -- Only trigger change if value actually changed
                local currentValueStr = tostring(value)
                if currentValueStr ~= self.lastValue then
                    if onFieldChanged then
                        onFieldChanged(self.field.key, value)
                    end
                    self.lastValue = currentValueStr
                end
            end)
        end
        
    elseif field.type == "dropdown" then
        local items = {}
        local valueMap = {}
        for _, option in ipairs(field.options) do
            table.insert(items, {
                text = option.text,
                value = option.value
            })
            valueMap[option.value] = option.text
        end
        
        local defaultText = field.options[1] and field.options[1].text or "Select..."
        local dropdownWidth = field.allowEdit and (CONFIG.INPUT_WIDTH - 30) or CONFIG.INPUT_WIDTH
        
        -- Enable search for dropdowns with many options (>10) or if explicitly requested
        local enableSearch = field.enableSearch or (#items > 10)
        local searchPlaceholder = field.searchPlaceholder or "Search options..."
        
        input = CreateFullyStyledDropdown(container, dropdownWidth, items, defaultText, 
            function(value, item)
                if onFieldChanged then
                    onFieldChanged(field.key, value)
                end
                
            end,
            enableSearch,
            searchPlaceholder
        )
        input:SetPoint("LEFT", label, "RIGHT", 10, 0)
        input.valueMap = valueMap
        
        
        -- Add edit button for manual input if allowEdit is true
        if field.allowEdit then
            local editBtn = CreateStyledButton(container, "E", 24, 24)
            editBtn:SetPoint("LEFT", input, "RIGHT", 5, 0)
            editBtn:SetScript("OnClick", function()
                TemplateUI.ToggleDropdownEdit(input, field, onFieldChanged, CONFIG)
            end)
            -- Add tooltip for edit button
            editBtn:SetScript("OnEnter", function(self)
                GameTooltip:SetOwner(self, "ANCHOR_RIGHT")
                GameTooltip:SetText("Edit Mode", UISTYLE_COLORS.White[1], UISTYLE_COLORS.White[2], UISTYLE_COLORS.White[3])
                GameTooltip:AddLine("Click to switch to manual numeric input", UISTYLE_COLORS.TextGrey[1], UISTYLE_COLORS.TextGrey[2], UISTYLE_COLORS.TextGrey[3], true)
                GameTooltip:Show()
            end)
            editBtn:SetScript("OnLeave", function()
                GameTooltip:Hide()
            end)
            input.editButton = editBtn
        end
        
    elseif field.type == "flags" then
        input = CreateStyledEditBox(parent, CONFIG.INPUT_WIDTH - 60, true)
        input:SetPoint("LEFT", label, "RIGHT", 10, 0)
        
        local editBox = input.editBox or input
        editBox.field = field
        
        -- Edit button for flag editor
        local editBtn = CreateStyledButton(parent, "Edit", 50, 20)
        editBtn:SetPoint("LEFT", input, "RIGHT", 5, 0)
        editBtn.field = field
        editBtn.inputContainer = input
        editBtn.editBox = editBox
        editBtn:SetScript("OnClick", function(self)
            local FlagEditor = _G.FlagEditor
            if FlagEditor and FlagEditor.Open then
                local currentValue = tonumber(self.editBox:GetText()) or 0
                FlagEditor.Open(self.field.key, currentValue, function(newValue)
                    self.editBox:SetText(tostring(newValue))
                    if onFieldChanged then
                        onFieldChanged(self.field.key, newValue)
                    end
                end)
            else
                print("|cFFFF0000Flag editor not available. Make sure GMClient_FlagEditor.lua is loaded.|r")
                print("|cFFFFFF00Try reloading the UI with /reload|r")
            end
        end)
        
        -- Enhanced tooltip for edit button
        editBtn:SetScript("OnEnter", function(self)
            GameTooltip:SetOwner(self, "ANCHOR_RIGHT")
            GameTooltip:SetText("Edit " .. self.field.label, 1, 1, 1)
            local currentValue = tonumber(self.editBox:GetText()) or 0
            GameTooltip:AddLine(string.format("Current value: %d (0x%X)", currentValue, currentValue), 0.8, 0.8, 0.8)
            GameTooltip:AddLine("Click to open flag editor with checkboxes", 0.6, 0.6, 0.6)
            GameTooltip:Show()
        end)
        editBtn:SetScript("OnLeave", function()
            GameTooltip:Hide()
        end)
        
        editBox.lastValue = ""  -- Track last saved value
        
        -- Store initial value when gaining focus
        editBox:SetScript("OnEditFocusGained", function(self)
            self.lastValue = self:GetText() or ""
        end)
        
        editBox:SetScript("OnEscapePressed", function(self) 
            self:SetText(self.lastValue or "")  -- Restore on escape
            self:ClearFocus() 
        end)
        
        editBox:SetScript("OnEnterPressed", function(self) 
            self:ClearFocus() 
        end)
        
        editBox:SetScript("OnTabPressed", function(self)
            self:ClearFocus()
        end)
        
        editBox:SetScript("OnEditFocusLost", function(self)
            local text = self:GetText() or ""
            local cleaned = text:gsub("[^0-9-]", "")
            if cleaned ~= text then
                self:SetText(cleaned)
                text = cleaned
            end
            local value = tonumber(text) or 0
            
            -- Only trigger change if value actually changed
            local currentValueStr = tostring(value)
            if currentValueStr ~= self.lastValue then
                if onFieldChanged then
                    onFieldChanged(self.field.key, value)
                end
                self.lastValue = currentValueStr
            end
        end)
    end
    
    -- Tooltip for container
    if field.tooltip and input then
        container:SetScript("OnEnter", function(self)
            GameTooltip:SetOwner(self, "ANCHOR_RIGHT")
            GameTooltip:SetText(field.label, UISTYLE_COLORS.White[1], UISTYLE_COLORS.White[2], UISTYLE_COLORS.White[3])
            GameTooltip:AddLine(field.tooltip, UISTYLE_COLORS.TextGrey[1], UISTYLE_COLORS.TextGrey[2], UISTYLE_COLORS.TextGrey[3], true)
            if field.min or field.max then
                local rangeText = string.format("Range: %s - %s", 
                    field.min or "unlimited",
                    field.max or "unlimited")
                GameTooltip:AddLine(rangeText, UISTYLE_COLORS.TextGrey[1], UISTYLE_COLORS.TextGrey[2], UISTYLE_COLORS.TextGrey[3])
            end
            GameTooltip:Show()
        end)
        container:SetScript("OnLeave", function()
            GameTooltip:Hide()
        end)
    end
    
    container.input = input
    container.field = field
    return container
end

-- Toggle between dropdown and manual input
function TemplateUI.ToggleDropdownEdit(dropdown, field, onFieldChanged, CONFIG)
    local parent = dropdown:GetParent()
    
    if not parent.editMode then
        -- Switch to edit mode
        parent.editMode = true
        
        -- Hide dropdown
        dropdown:Hide()
        if dropdown.editButton then dropdown.editButton:Hide() end
        
        -- Create edit box
        local editBox = CreateStyledEditBox(parent, CONFIG.INPUT_WIDTH - 30, true)
        editBox:SetPoint("LEFT", parent:GetChildren(), "RIGHT", 10, 0) -- Align with label
        
        -- Set current dropdown value
        local currentValue = dropdown.selectedValue or 0
        editBox.editBox:SetText(tostring(currentValue))
        editBox.editBox.field = field
        editBox.editBox.lastValue = tostring(currentValue)
        
        -- Edit box scripts
        editBox.editBox:SetScript("OnEditFocusLost", function(self)
            local text = self:GetText() or ""
            local cleaned = text:gsub("[^0-9-]", "")
            if cleaned ~= text then
                self:SetText(cleaned)
                text = cleaned
            end
            local value = tonumber(text) or 0
            
            if tostring(value) ~= self.lastValue then
                if onFieldChanged then
                    onFieldChanged(field.key, value)
                end
                self.lastValue = tostring(value)
            end
        end)
        
        editBox.editBox:SetScript("OnEnterPressed", function(self) self:ClearFocus() end)
        editBox.editBox:SetScript("OnEscapePressed", function(self) 
            self:SetText(self.lastValue or "")
            self:ClearFocus() 
        end)
        
        -- Create back button
        local backBtn = CreateStyledButton(parent, "<", 24, 24)
        backBtn:SetPoint("LEFT", editBox, "RIGHT", 5, 0)
        backBtn:SetScript("OnClick", function()
            -- Switch back to dropdown mode
            parent.editMode = false
            editBox:Hide()
            backBtn:Hide()
            dropdown:Show()
            if dropdown.editButton then dropdown.editButton:Show() end
        end)
        -- Add tooltip for back button
        backBtn:SetScript("OnEnter", function(self)
            GameTooltip:SetOwner(self, "ANCHOR_RIGHT")
            GameTooltip:SetText("Back to Dropdown", UISTYLE_COLORS.White[1], UISTYLE_COLORS.White[2], UISTYLE_COLORS.White[3])
            GameTooltip:AddLine("Click to return to dropdown selection mode", UISTYLE_COLORS.TextGrey[1], UISTYLE_COLORS.TextGrey[2], UISTYLE_COLORS.TextGrey[3], true)
            GameTooltip:Show()
        end)
        backBtn:SetScript("OnLeave", function()
            GameTooltip:Hide()
        end)
        
        parent.tempEditBox = editBox
        parent.tempBackBtn = backBtn
        
    else
        -- Switch back to dropdown mode
        parent.editMode = false
        if parent.tempEditBox then parent.tempEditBox:Hide() end
        if parent.tempBackBtn then parent.tempBackBtn:Hide() end
        dropdown:Show()
        if dropdown.editButton then dropdown.editButton:Show() end
    end
end

-- Set field value
function TemplateUI.SetFieldValue(fieldFrame, value)
    local field = fieldFrame.field
    local input = fieldFrame.input
    
    if not input then return end
    
    if field.type == "text" then
        local editBox = input.editBox or input
        if editBox.SetText then
            editBox:SetText(value or "")
            -- Update lastValue to prevent false change detection
            if editBox.lastValue ~= nil then
                editBox.lastValue = value or ""
            end
        end
    elseif field.type == "number" or field.type == "flags" then
        local editBox = input.editBox or input
        if editBox.SetText then
            editBox:SetText(tostring(value or 0))
            -- Update lastValue to prevent false change detection
            if editBox.lastValue ~= nil then
                editBox.lastValue = tostring(value or 0)
            end
        end
    elseif field.type == "decimal" then
        if input.SetValue then
            input:SetValue(value or 0)
        else
            local editBox = input.editBox or input
            if editBox.SetText then
                editBox:SetText(tostring(value or 0))
                -- Update lastValue to prevent false change detection
                if editBox.lastValue ~= nil then
                    editBox.lastValue = tostring(value or 0)
                end
            end
        end
    elseif field.type == "dropdown" then
        local parent = fieldFrame
        if parent.editMode and parent.tempEditBox then
            -- Set value in edit mode
            local editBox = parent.tempEditBox.editBox
            if editBox and editBox.SetText then
                editBox:SetText(tostring(value or 0))
                editBox.lastValue = tostring(value or 0)
            end
        elseif input.SetValue and input.valueMap then
            -- Set value in dropdown mode  
            local textToSet = input.valueMap[value]
            if textToSet then
                input:SetValue(value, textToSet)
                input.selectedValue = value -- Store selected value for edit mode
            else
                -- If value not in map, just set it directly
                input:SetValue(value, tostring(value))
            end
        end
    end
end

-- Cleanup function to properly remove all FontStrings and frames
function TemplateUI.CleanupContent(content)
    if not content then return end
    
    -- Clean up stored FontString references
    if content.fieldLabels then
        for _, label in ipairs(content.fieldLabels) do
            if label and label.SetText then
                label:SetText("")
                label:Hide()
                -- Don't call SetParent(nil) on FontStrings
            end
        end
        content.fieldLabels = {}
    end
    
    -- Clean up header text if it exists
    if content.headerText then
        content.headerText:SetText("")
        content.headerText:Hide()
        -- Don't call SetParent(nil) on FontStrings
        content.headerText = nil
    end
    
    -- Clean up any tooltip FontStrings that might be attached
    if content.tooltipTexts then
        for _, text in ipairs(content.tooltipTexts) do
            if text and text.SetText then
                text:SetText("")
                text:Hide()
                -- Don't call SetParent(nil) on FontStrings
            end
        end
        content.tooltipTexts = {}
    end
    
    -- Clean up child frames
    for _, child in ipairs({content:GetChildren()}) do
        -- Recursively clean up child content if it has the same structure
        if child.fieldLabels or child.headerText or child.tooltipTexts then
            TemplateUI.CleanupContent(child)
        end
        child:Hide()
        child:ClearAllPoints()
        -- Move off-screen to prevent visual overlap
        child:SetPoint("TOPLEFT", UIParent, "TOPLEFT", -5000, 5000)
    end
    
    -- Clear field references
    if content.fields then
        content.fields = {}
    end
    if content.checkboxes then
        content.checkboxes = {}
    end
end


-- print("|cFF00FF00[TemplateUI] Module loaded|r")