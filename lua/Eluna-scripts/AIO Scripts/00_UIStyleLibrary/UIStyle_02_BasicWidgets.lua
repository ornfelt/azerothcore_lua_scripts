local AIO = AIO or require("AIO")

if AIO.AddAddon() then
    return
end

-- ===================================
-- UI STYLE LIBRARY BASIC WIDGETS MODULE
-- ===================================
-- Core widget functions: frames, buttons, checkboxes, section headers

-- ===================================
-- TOOLTIP HELPER
-- ===================================

--[[
Sets up a tooltip for a frame
@param frame - The frame to attach tooltip to
@param text - Main tooltip text
@param subtext - Optional secondary text (appears in different color)
]]
local function SetupTooltip(frame, text, subtext)
    if not text then
        return
    end

    frame:SetScript("OnEnter", function(self)
        GameTooltip:SetOwner(self, "ANCHOR_RIGHT")
        GameTooltip:SetText(text, 1, 1, 1, 1, true)
        if subtext then
            GameTooltip:AddLine(subtext, 0.7, 0.7, 0.7, true)
        end
        GameTooltip:Show()

        -- Call original OnEnter if it exists
        if self.originalOnEnter then
            self:originalOnEnter()
        end
    end)

    -- Store original OnLeave handler
    local originalOnLeave = frame:GetScript("OnLeave")
    frame:SetScript("OnLeave", function(self)
        GameTooltip:Hide()

        -- Call original OnLeave if it exists
        if originalOnLeave then
            originalOnLeave(self)
        end
    end)
end

-- Export to global
_G.SetupTooltip = SetupTooltip

-- ===================================
-- CORE WIDGET FUNCTIONS
-- ===================================

--[[
Creates a styled frame with dark theme and optional background color
@param parent - Parent frame
@param bgColor - Optional background color (defaults to DarkGrey)
@return Frame with dark styling applied
]]
function CreateStyledFrame(parent, bgColor)
    local frame = CreateFrame("Frame", nil, parent)
    frame:SetBackdrop(UISTYLE_BACKDROPS.Frame)

    local bg = bgColor or UISTYLE_COLORS.DarkGrey
    frame:SetBackdropColor(bg[1], bg[2], bg[3], 1)
    frame:SetBackdropBorderColor(0, 0, 0, 1)

    return frame
end

--[[
Creates a styled button with dark theme
@param parent - Parent frame
@param text - Button text
@param width - Optional width (defaults to auto-size)
@param height - Optional height (defaults to 22)
@return Styled button
]]
function CreateStyledButton(parent, text, width, height)
    local button = CreateFrame("Button", nil, parent)
    button:SetHeight(height or 22)
    if width then
        button:SetWidth(width)
    end

    -- Button backdrop
    button:SetBackdrop(UISTYLE_BACKDROPS.Frame)
    button:SetBackdropColor(UISTYLE_COLORS.SectionBg[1], UISTYLE_COLORS.SectionBg[2], UISTYLE_COLORS.SectionBg[3], 1)
    button:SetBackdropBorderColor(UISTYLE_COLORS.BorderGrey[1], UISTYLE_COLORS.BorderGrey[2], UISTYLE_COLORS.BorderGrey[3], 1)

    -- Button text
    local label = button:CreateFontString(nil, "OVERLAY", "GameFontNormalSmall")
    label:SetPoint("CENTER")
    label:SetText(text or "Button")
    label:SetTextColor(1, 1, 1, 1)
    button.text = label

    -- Auto-size if no width specified
    if not width then
        button:SetWidth(label:GetStringWidth() + 20)
    end

    -- Hover effects
    button:SetScript("OnEnter", function(self)
        self:SetBackdropColor(0.15, 0.15, 0.15, 1)
    end)

    button:SetScript("OnLeave", function(self)
        self:SetBackdropColor(UISTYLE_COLORS.SectionBg[1], UISTYLE_COLORS.SectionBg[2], UISTYLE_COLORS.SectionBg[3], 1)
    end)

    -- Click effect
    button:SetScript("OnMouseDown", function(self)
        self:SetBackdropColor(0.05, 0.05, 0.05, 1)
    end)

    button:SetScript("OnMouseUp", function(self)
        self:SetBackdropColor(0.15, 0.15, 0.15, 1)
    end)

    -- Add SetTooltip method
    button.SetTooltip = function(self, text, subtext)
        -- Store original handlers
        self.originalOnEnter = self:GetScript("OnEnter")
        self.originalOnLeave = self:GetScript("OnLeave")

        self:SetScript("OnEnter", function(self)
            -- Show tooltip
            GameTooltip:SetOwner(self, "ANCHOR_RIGHT")
            GameTooltip:SetText(text, 1, 1, 1, 1, true)
            if subtext then
                GameTooltip:AddLine(subtext, 0.7, 0.7, 0.7, true)
            end
            GameTooltip:Show()

            -- Call original hover effect
            if self.originalOnEnter then
                self:originalOnEnter()
            end
        end)

        self:SetScript("OnLeave", function(self)
            GameTooltip:Hide()

            -- Call original hover effect
            if self.originalOnLeave then
                self:originalOnLeave()
            end
        end)
    end

    return button
end

--[[
Creates a styled checkbox with clickable row
@param parent - Parent frame
@param text - Checkbox label text
@return Checkbox frame with check property
]]
function CreateStyledCheckbox(parent, text)
    -- Make the entire frame clickable
    local frame = CreateFrame("Button", nil, parent)
    frame:SetHeight(24)
    frame:EnableMouse(true)

    -- Add border around the entire clickable area
    frame:SetBackdrop(UISTYLE_BACKDROPS.Frame)
    frame:SetBackdropColor(0, 0, 0, 0) -- Transparent background
    frame:SetBackdropBorderColor(0.2, 0.2, 0.2, 0.5) -- Subtle border

    -- Create visual checkbox (not clickable)
    local check = CreateFrame("Frame", nil, frame)
    check:SetSize(14, 14) -- Slightly larger for better visibility
    check:SetPoint("LEFT", 6, 0)

    -- Custom checkbox appearance
    check:SetBackdrop(UISTYLE_BACKDROPS.Frame)
    check:SetBackdropColor(0.1, 0.1, 0.1, 1) -- Dark grey background instead of transparent
    check:SetBackdropBorderColor(0.4, 0.4, 0.4, 1) -- Lighter grey border

    -- Label
    local label = frame:CreateFontString(nil, "OVERLAY", "GameFontNormalSmall")
    label:SetPoint("LEFT", check, "RIGHT", UISTYLE_SMALL_PADDING, 0)
    label:SetText(text)
    label:SetTextColor(UISTYLE_COLORS.TextGrey[1], UISTYLE_COLORS.TextGrey[2], UISTYLE_COLORS.TextGrey[3])
    label:SetJustifyH("LEFT")

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
    end

    local function GetChecked(self)
        return checked
    end

    -- Click handler for entire frame
    frame:SetScript("OnClick", function(self)
        SetChecked(self, not GetChecked(self))
    end)

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

    -- Expose functions and elements
    frame.SetChecked = SetChecked
    frame.GetChecked = GetChecked
    frame.check = check
    frame.label = label
    frame.SetTooltip = function(self, text, subtext)
        SetupTooltip(self, text, subtext)
    end

    return frame
end

--[[
Creates a collapsible section header
@param parent - Parent frame
@param text - Header text
@param expanded - Initial expanded state
@return Section header button
]]
function CreateSectionHeader(parent, text, expanded)
    local header = CreateFrame("Button", nil, parent)
    header:SetHeight(22)
    header:SetBackdrop(UISTYLE_BACKDROPS.Frame)
    header:SetBackdropColor(UISTYLE_COLORS.SectionBg[1], UISTYLE_COLORS.SectionBg[2], UISTYLE_COLORS.SectionBg[3], 1)
    header:SetBackdropBorderColor(UISTYLE_COLORS.BorderGrey[1], UISTYLE_COLORS.BorderGrey[2], UISTYLE_COLORS.BorderGrey[3], 1)

    -- Expand/Collapse indicator
    local indicator = header:CreateFontString(nil, "OVERLAY", "GameFontNormalSmall")
    indicator:SetPoint("LEFT", 5, 0)
    indicator:SetText(expanded and "˅" or "˃")
    indicator:SetTextColor(UISTYLE_COLORS.TextGrey[1], UISTYLE_COLORS.TextGrey[2], UISTYLE_COLORS.TextGrey[3])
    header.indicator = indicator

    -- Section text
    local title = header:CreateFontString(nil, "OVERLAY", "GameFontNormalSmall")
    title:SetPoint("LEFT", indicator, "RIGHT", 3, 0)
    title:SetText(text)
    title:SetTextColor(1, 1, 1, 1)

    -- Expanded state
    header.expanded = expanded

    -- Toggle function
    header.SetExpanded = function(self, isExpanded)
        self.expanded = isExpanded
        indicator:SetText(isExpanded and "˅" or "˃")
    end

    -- Click handler
    header:SetScript("OnClick", function(self)
        self:SetExpanded(not self.expanded)
    end)

    -- Hover effect
    header:SetScript("OnEnter", function(self)
        self:SetBackdropColor(0.15, 0.15, 0.15, 1)
    end)

    header:SetScript("OnLeave", function(self)
        self:SetBackdropColor(UISTYLE_COLORS.SectionBg[1], UISTYLE_COLORS.SectionBg[2], UISTYLE_COLORS.SectionBg[3], 1)
    end)

    return header
end

-- Register this module
UISTYLE_LIBRARY_MODULES = UISTYLE_LIBRARY_MODULES or {}
UISTYLE_LIBRARY_MODULES["BasicWidgets"] = true

-- Debug print for module loading
if UISTYLE_DEBUG then
    print("UIStyleLibrary: BasicWidgets module loaded")
end