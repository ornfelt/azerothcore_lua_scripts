local AIO = AIO or require("AIO")

if AIO.AddAddon() then
    return
end

-- ===================================
-- UI STYLE LIBRARY QUALITY WIDGETS MODULE
-- ===================================
-- Quality toggles and complex checkbox widgets

--[[
Creates a quality toggle button (colored square with outline/fill states)
@param parent - Parent frame
@param color - Quality color {r, g, b}
@param size - Optional size (defaults to 16)
@return Quality toggle button
]]
function CreateQualityToggle(parent, color, size)
    local button = CreateFrame("Button", nil, parent)
    button:SetSize(size or 16, size or 16)

    -- Store the quality color for later use
    button.qualityColor = color
    button.enabled = true -- Track enabled state

    -- Background with border
    button:SetBackdrop(UISTYLE_BACKDROPS.Frame)

    -- Set initial state (unchecked = colored border)
    button.checked = false
    button:SetBackdropColor(0, 0, 0, 0) -- Transparent background
    button:SetBackdropBorderColor(color[1], color[2], color[3], 1) -- Colored border

    -- Update visual state based on enabled and checked
    local function UpdateVisualState(self)
        local dimFactor = self.enabled and 1 or 0.3 -- Dim to 30% when disabled

        if self.checked then
            -- Filled state with quality color
            self:SetBackdropColor(
                    self.qualityColor[1] * dimFactor,
                    self.qualityColor[2] * dimFactor,
                    self.qualityColor[3] * dimFactor,
                    0.8  -- Slightly transparent when checked
            )
            self:SetBackdropBorderColor(
                    self.qualityColor[1] * dimFactor,
                    self.qualityColor[2] * dimFactor,
                    self.qualityColor[3] * dimFactor,
                    1
            )
        else
            -- Outline only with colored border
            self:SetBackdropColor(0, 0, 0, 0)
            self:SetBackdropBorderColor(
                    self.qualityColor[1] * dimFactor,
                    self.qualityColor[2] * dimFactor,
                    self.qualityColor[3] * dimFactor,
                    1
            )
        end
    end

    -- State management
    button.SetChecked = function(self, checked)
        self.checked = checked
        UpdateVisualState(self)
    end

    button.GetChecked = function(self)
        return self.checked
    end

    button.SetEnabled = function(self, enabled)
        self.enabled = enabled
        self:EnableMouse(enabled) -- Disable mouse interaction when disabled
        UpdateVisualState(self)
    end

    button.GetEnabled = function(self)
        return self.enabled
    end

    button.SetTooltip = function(self, text, subtext)
        self.tooltipText = text
        self.tooltipSubtext = subtext
    end

    -- Click handler
    button:SetScript("OnClick", function(self)
        if self.enabled then
            -- Only allow clicks when enabled
            self:SetChecked(not self:GetChecked())
        end
    end)

    -- Hover effect
    button:SetScript("OnEnter", function(self)
        -- Show tooltip if set
        if self.tooltipText then
            -- Check parent strata to determine if we need elevated tooltip
            local parent = self:GetParent()
            while parent and parent ~= UIParent do
                local strata = parent:GetFrameStrata()
                if strata == "TOOLTIP" or strata == "FULLSCREEN_DIALOG" then
                    -- Use elevated tooltip
                    GameTooltip:SetOwner(self, "ANCHOR_RIGHT")
                    GameTooltip:SetFrameStrata("TOOLTIP")
                    GameTooltip:SetFrameLevel(self:GetFrameLevel() + 10)
                    GameTooltip:SetText(self.tooltipText, 1, 1, 1, 1, true)
                    if self.tooltipSubtext then
                        GameTooltip:AddLine(self.tooltipSubtext, 0.7, 0.7, 0.7, true)
                    end
                    GameTooltip:Show()
                    break
                end
                parent = parent:GetParent()
            end
            
            -- If no high-level parent found, use normal tooltip
            if parent == UIParent then
                GameTooltip:SetOwner(self, "ANCHOR_RIGHT")
                GameTooltip:SetText(self.tooltipText, 1, 1, 1, 1, true)
                if self.tooltipSubtext then
                    GameTooltip:AddLine(self.tooltipSubtext, 0.7, 0.7, 0.7, true)
                end
                GameTooltip:Show()
            end
        end

        if self.enabled and not self:GetChecked() then
            -- Slightly transparent fill on hover (only when enabled)
            self:SetBackdropColor(self.qualityColor[1], self.qualityColor[2], self.qualityColor[3], 0.3)
        end
    end)

    button:SetScript("OnLeave", function(self)
        GameTooltip:Hide()

        if self.enabled and not self:GetChecked() then
            -- Back to transparent
            self:SetBackdropColor(0, 0, 0, 0)
        elseif not self.enabled then
            -- Ensure disabled state is maintained
            UpdateVisualState(self)
        end
    end)

    return button
end

--[[
Creates a checkbox with quality toggles arranged in two rows
@param parent - Parent frame
@param text - Checkbox label text
@param hasValue - Whether to show an editable value
@param value - Default value (if hasValue is true)
@param hasQualityToggles - Whether to show quality toggle buttons
@return Complex checkbox frame with quality toggles
]]
function CreateCheckboxWithQualityToggles(parent, text, hasValue, value, hasQualityToggles)
    -- Make the entire frame clickable
    local frame = CreateFrame("Button", nil, parent)
    -- Increase height to accommodate two rows when quality toggles are present
    frame:SetHeight(hasQualityToggles and 40 or 24)
    frame:EnableMouse(true)

    -- Add border around the entire clickable area
    frame:SetBackdrop(UISTYLE_BACKDROPS.Frame)
    frame:SetBackdropColor(0, 0, 0, 0) -- Transparent background
    frame:SetBackdropBorderColor(0.2, 0.2, 0.2, 0.5) -- Subtle border

    -- Create visual checkbox (not clickable)
    local check = CreateFrame("Frame", nil, frame)
    check:SetSize(14, 14) -- Match simple checkbox size
    -- Position checkbox vertically centered if no quality toggles, otherwise align to top
    local checkYOffset = hasQualityToggles and 8 or 0
    check:SetPoint("LEFT", 6, checkYOffset)

    -- Custom checkbox appearance
    check:SetBackdrop(UISTYLE_BACKDROPS.Frame)
    check:SetBackdropColor(0.1, 0.1, 0.1, 1) -- Dark grey background to match simple checkbox
    check:SetBackdropBorderColor(0.4, 0.4, 0.4, 1) -- Lighter grey border

    -- Label
    local labelText = text
    if hasValue and value then
        labelText = text .. " (" .. value .. ")"
    end

    local label = frame:CreateFontString(nil, "OVERLAY", "GameFontNormalSmall")
    -- Adjust label position based on checkbox position
    label:SetPoint("LEFT", check, "RIGHT", UISTYLE_SMALL_PADDING, 0)
    label:SetText(labelText)
    label:SetTextColor(UISTYLE_COLORS.TextGrey[1], UISTYLE_COLORS.TextGrey[2], UISTYLE_COLORS.TextGrey[3])
    label:SetJustifyH("LEFT")

    -- Edit box for value (if needed)
    local editBox, valueStart, valueEnd
    if hasValue then
        -- Find the position of the value in the label
        valueStart = string.find(labelText, "%(")
        valueEnd = string.find(labelText, "%)")

        editBox = CreateFrame("EditBox", nil, frame)
        editBox:SetSize(50, 16)
        editBox:SetBackdrop(UISTYLE_BACKDROPS.Frame)
        editBox:SetBackdropColor(0.1, 0.1, 0.1, 1)
        editBox:SetBackdropBorderColor(UISTYLE_COLORS.Blue[1], UISTYLE_COLORS.Blue[2], UISTYLE_COLORS.Blue[3], 1)
        editBox:SetFontObject("GameFontNormalSmall")
        editBox:SetTextColor(1, 1, 1, 1)
        editBox:SetAutoFocus(false)
        editBox:SetNumeric(true)
        editBox:SetMaxLetters(4)
        editBox:Hide()

        -- Position it over the value text
        editBox:SetPoint("LEFT", label, "LEFT", label:GetStringWidth() - 50, 0)
    end

    -- Quality toggles (if needed)
    local qualityToggles = {}
    if hasQualityToggles then
        local qualities = {
            { name = "Poor", color = UISTYLE_COLORS.Poor },
            { name = "Common", color = UISTYLE_COLORS.Common },
            { name = "Uncommon", color = UISTYLE_COLORS.Uncommon },
            { name = "Rare", color = UISTYLE_COLORS.Rare },
            { name = "Epic", color = UISTYLE_COLORS.Epic },
        }

        -- Position quality toggles below the checkbox/text on second row
        local toggleStartX = 25  -- Align with text start position (checkbox width + padding)

        for i, quality in ipairs(qualities) do
            local toggle = CreateQualityToggle(frame, quality.color, 14)

            -- Position from left to right, below the checkbox
            local xOffset = toggleStartX + ((i - 1) * 17)  -- 14px width + 3px spacing
            toggle:SetPoint("TOPLEFT", frame, "TOPLEFT", xOffset, -20)

            -- Stop propagation of clicks on quality toggles
            toggle:SetScript("OnClick", function(self)
                self:SetChecked(not self:GetChecked())
            end)

            table.insert(qualityToggles, toggle)
        end
    end

    -- Extend clickable area to full width with some padding
    frame:SetPoint("RIGHT", parent, "RIGHT", -2, 0)

    -- Highlight texture for hover
    local highlight = frame:CreateTexture(nil, "HIGHLIGHT")
    highlight:SetTexture("Interface\\Buttons\\WHITE8X8")
    highlight:SetVertexColor(1, 1, 1, 0.03)
    highlight:SetPoint("TOPLEFT", 1, -1)
    highlight:SetPoint("BOTTOMRIGHT", -1, 1)

    -- Checked state
    local checked = false

    -- Custom SetChecked function
    local function SetChecked(self, isChecked)
        checked = isChecked
        if checked then
            check:SetBackdropColor(0.9, 0.9, 0.9, 1) -- Bright white/grey fill when checked
            check:SetBackdropBorderColor(0.7, 0.7, 0.7, 1)
            label:SetTextColor(1, 1, 1, 1)
        else
            check:SetBackdropColor(0.1, 0.1, 0.1, 1) -- Dark grey when unchecked
            check:SetBackdropBorderColor(0.4, 0.4, 0.4, 1)
            label:SetTextColor(UISTYLE_COLORS.TextGrey[1], UISTYLE_COLORS.TextGrey[2], UISTYLE_COLORS.TextGrey[3])
        end

        -- Update quality toggles enabled state if they exist
        if hasQualityToggles and #qualityToggles > 0 then
            for _, toggle in ipairs(qualityToggles) do
                toggle:SetEnabled(checked)
            end
        end
    end

    local function GetChecked(self)
        return checked
    end

    -- Click handler for main checkbox area (avoid quality toggles)
    frame:SetScript("OnClick", function(self)
        SetChecked(self, not GetChecked(self))
    end)

    -- Right-click handler for value editing
    if hasValue then
        frame:RegisterForClicks("LeftButtonUp", "RightButtonUp")
        frame:SetScript("OnClick", function(self, button)
            if button == "RightButton" and hasValue then
                -- Show edit box for value editing
                editBox:SetText(tostring(value))
                editBox:Show()
                editBox:SetFocus()
                editBox:HighlightText()

                -- Hide edit box when done
                editBox:SetScript("OnEnterPressed", function(self)
                    local newValue = tonumber(self:GetText()) or value
                    value = newValue
                    labelText = text .. " (" .. value .. ")"
                    label:SetText(labelText)
                    self:Hide()
                end)

                editBox:SetScript("OnEscapePressed", function(self)
                    self:Hide()
                end)
            else
                SetChecked(self, not GetChecked(self))
            end
        end)
    end

    -- Hover effect
    frame:SetScript("OnEnter", function(self)
        if checked then
            check:SetBackdropBorderColor(0.9, 0.9, 0.9, 1)
        else
            check:SetBackdropBorderColor(0.6, 0.6, 0.6, 1)
        end
    end)

    frame:SetScript("OnLeave", function(self)
        if checked then
            check:SetBackdropBorderColor(0.7, 0.7, 0.7, 1)
        else
            check:SetBackdropBorderColor(0.4, 0.4, 0.4, 1)
        end
    end)

    -- Initialize quality toggles to disabled state if checkbox starts unchecked
    if hasQualityToggles and #qualityToggles > 0 and not checked then
        for _, toggle in ipairs(qualityToggles) do
            toggle:SetEnabled(false)
        end
    end

    -- Expose functions and elements
    frame.SetChecked = SetChecked
    frame.GetChecked = GetChecked
    frame.check = check
    frame.label = label
    frame.qualityToggles = qualityToggles
    frame.editBox = editBox
    frame.SetTooltip = function(self, text, subtext)
        SetupTooltip(self, text, subtext)
    end

    return frame
end

-- Register this module
UISTYLE_LIBRARY_MODULES = UISTYLE_LIBRARY_MODULES or {}
UISTYLE_LIBRARY_MODULES["QualityWidgets"] = true

-- Debug print for module loading
if UISTYLE_DEBUG then
    print("UIStyleLibrary: QualityWidgets module loaded")
end