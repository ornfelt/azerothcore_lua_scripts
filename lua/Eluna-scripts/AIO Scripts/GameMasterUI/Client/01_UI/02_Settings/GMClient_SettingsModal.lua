-- GameMaster UI System - Settings Modal
-- UI for adjusting panel settings (position, width, opacity, compact mode)

local AIO = AIO or require("AIO")

if AIO.AddAddon() then
    return
end

if not GM_RequireNamespace() then return end

_G.GMSettingsModal = {}

local GMSettingsModal = _G.GMSettingsModal
local GMSettings = _G.GMSettings
local GMData = _G.GMData
local GMConfig = _G.GMConfig

local MODAL_WIDTH = 300
local MODAL_HEIGHT = 390
local ROW_HEIGHT = 50
local PADDING = 12
local INNER_WIDTH = MODAL_WIDTH - PADDING * 2

local modal = nil
local posButtons = {}

-- Create the modal frame (lazy init)
local function EnsureModal()
    if modal then return modal end

    modal = CreateStyledFrame(UIParent, UISTYLE_COLORS.DarkGrey)
    modal:SetSize(MODAL_WIDTH, MODAL_HEIGHT)
    modal:SetPoint("CENTER", UIParent, "CENTER", 0, 0)
    modal:SetFrameStrata("HIGH")
    modal:EnableMouse(true)
    modal:SetMovable(true)
    modal:RegisterForDrag("LeftButton")
    modal:SetScript("OnDragStart", modal.StartMoving)
    modal:SetScript("OnDragStop", modal.StopMovingOrSizing)
    modal:Hide()

    -- Title
    local title = modal:CreateFontString(nil, "OVERLAY", "GameFontNormal")
    title:SetPoint("TOP", modal, "TOP", 0, -PADDING)
    title:SetText("Settings")
    title:SetTextColor(1, 1, 1, 1)

    local yOffset = -(PADDING + 24)

    -- Row 1: Position Toggle
    local posLabel = modal:CreateFontString(nil, "OVERLAY", "GameFontNormalSmall")
    posLabel:SetPoint("TOPLEFT", modal, "TOPLEFT", PADDING, yOffset)
    posLabel:SetText("Panel Position")
    posLabel:SetTextColor(UISTYLE_COLORS.TextGrey[1], UISTYLE_COLORS.TextGrey[2], UISTYLE_COLORS.TextGrey[3])

    local btnWidth = (INNER_WIDTH - 4) / 2
    local leftBtn = CreateStyledButton(modal, "Left", btnWidth, 24)
    leftBtn:SetPoint("TOPLEFT", modal, "TOPLEFT", PADDING, yOffset - 16)

    local rightBtn = CreateStyledButton(modal, "Right", btnWidth, 24)
    rightBtn:SetPoint("TOPLEFT", leftBtn, "TOPRIGHT", 4, 0)

    posButtons.LEFT = leftBtn
    posButtons.RIGHT = rightBtn

    local function UpdatePositionHighlight()
        local cur = GMSettings.current.position
        for side, btn in pairs(posButtons) do
            if side == cur then
                btn:SetBackdropColor(UISTYLE_COLORS.Green[1], UISTYLE_COLORS.Green[2], UISTYLE_COLORS.Green[3], 0.6)
            else
                btn:SetBackdropColor(UISTYLE_COLORS.ButtonBg[1], UISTYLE_COLORS.ButtonBg[2], UISTYLE_COLORS.ButtonBg[3], 1)
            end
        end
    end

    leftBtn:SetScript("OnClick", function()
        GMSettings.Set("position", "LEFT")
        UpdatePositionHighlight()
    end)

    rightBtn:SetScript("OnClick", function()
        GMSettings.Set("position", "RIGHT")
        UpdatePositionHighlight()
    end)

    yOffset = yOffset - ROW_HEIGHT - 10

    -- Row 2: Width Slider
    local wp = GMConfig.config.sidePanel.width
    local widthSlider = CreateStyledSlider(modal, INNER_WIDTH, 16, wp.min, wp.max, 10, GMSettings.current.width)
    widthSlider:SetLabel("Panel Width")
    widthSlider:SetPoint("TOPLEFT", modal, "TOPLEFT", PADDING, yOffset)
    widthSlider:SetOnValueChanged(function(value)
        GMSettings.Set("width", value)
    end)
    modal.widthSlider = widthSlider

    yOffset = yOffset - ROW_HEIGHT - 10

    -- Row 3: Opacity Slider
    local opacitySlider = CreateStyledSlider(modal, INNER_WIDTH, 16, 30, 100, 5, GMSettings.current.opacity * 100)
    opacitySlider:SetLabel("Panel Opacity")
    opacitySlider:SetPoint("TOPLEFT", modal, "TOPLEFT", PADDING, yOffset)
    opacitySlider:SetOnValueChanged(function(value)
        GMSettings.Set("opacity", value / 100)
    end)
    modal.opacitySlider = opacitySlider

    yOffset = yOffset - ROW_HEIGHT - 10

    -- Row 4: Compact Mode Checkbox
    local compactCheck = CreateStyledCheckbox(modal, "Compact Mode")
    compactCheck:SetPoint("TOPLEFT", modal, "TOPLEFT", PADDING, yOffset)
    compactCheck:SetPoint("RIGHT", modal, "RIGHT", -PADDING, 0)
    compactCheck:SetChecked(GMSettings.current.compactMode)

    local origOnClick = compactCheck:GetScript("OnClick")
    compactCheck:SetScript("OnClick", function(self)
        if origOnClick then origOnClick(self) end
        GMSettings.Toggle("compactMode")
    end)
    modal.compactCheck = compactCheck

    yOffset = yOffset - 40

    -- Row 5: Auto-Open Object Editor
    local autoOpenCheck = CreateStyledCheckbox(modal, "Auto-Open Object Editor")
    autoOpenCheck:SetPoint("TOPLEFT", modal, "TOPLEFT", PADDING, yOffset)
    autoOpenCheck:SetPoint("RIGHT", modal, "RIGHT", -PADDING, 0)
    autoOpenCheck:SetChecked(GMSettings.current.autoOpenObjectEditor)

    local origAutoClick = autoOpenCheck:GetScript("OnClick")
    autoOpenCheck:SetScript("OnClick", function(self)
        if origAutoClick then origAutoClick(self) end
        GMSettings.Toggle("autoOpenObjectEditor")
    end)
    modal.autoOpenCheck = autoOpenCheck

    yOffset = yOffset - 40

    -- Bottom buttons
    local resetBtn = CreateStyledButton(modal, "Reset to Defaults", INNER_WIDTH, 24)
    resetBtn:SetPoint("TOPLEFT", modal, "TOPLEFT", PADDING, yOffset)
    resetBtn:SetScript("OnClick", function()
        GMSettings.Reset()
        -- Refresh UI controls
        widthSlider:SetValue(GMSettings.current.width)
        opacitySlider:SetValue(GMSettings.current.opacity * 100)
        compactCheck:SetChecked(GMSettings.current.compactMode)
        autoOpenCheck:SetChecked(GMSettings.current.autoOpenObjectEditor)
        UpdatePositionHighlight()
    end)

    yOffset = yOffset - 30

    local closeBtn = CreateStyledButton(modal, "Close", INNER_WIDTH, 24)
    closeBtn:SetPoint("TOPLEFT", modal, "TOPLEFT", PADDING, yOffset)
    closeBtn:SetScript("OnClick", function()
        GMSettings.Save()
        modal:Hide()
    end)

    -- Store highlight updater for refresh on Show
    modal.UpdatePositionHighlight = UpdatePositionHighlight

    return modal
end

function GMSettingsModal.Show()
    local m = EnsureModal()
    -- Sync controls with current settings
    m.widthSlider:SetValue(GMSettings.current.width)
    m.opacitySlider:SetValue(GMSettings.current.opacity * 100)
    m.compactCheck:SetChecked(GMSettings.current.compactMode)
    m.autoOpenCheck:SetChecked(GMSettings.current.autoOpenObjectEditor)
    m.UpdatePositionHighlight()
    if _G.GMTransitions then
        _G.GMTransitions.popInModal(m)
    else
        m:Show()
    end
end

function GMSettingsModal.Hide()
    if modal then
        GMSettings.Save()
        if _G.GMTransitions then
            _G.GMTransitions.popOutModal(modal)
        else
            modal:Hide()
        end
    end
end

-- Settings Modal initialized
