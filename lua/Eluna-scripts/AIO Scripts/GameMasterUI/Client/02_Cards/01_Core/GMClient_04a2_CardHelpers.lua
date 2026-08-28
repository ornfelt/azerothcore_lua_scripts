local AIO = AIO or require("AIO")

if AIO.AddAddon() then
    return
end

if not GM_RequireNamespace() then return end

-- Get module references
local GMCards = _G.GMCards
local GMConfig = _G.GMConfig
local GMUtils = _G.GMUtils

-- ============================================================
-- Helper functions extracted from CardCore + new ID line helper
-- ============================================================

-- Truncate text to fit within a pixel width (approximate)
function GMCards.truncateText(text, maxWidth)
    if not text or text == "" then return "" end
    local maxChars = math.floor(maxWidth / 6.5)
    if #text <= maxChars then return text end
    return text:sub(1, maxChars - 2) .. ".."
end

-- Helper function to get quality colors
function GMCards.getQualityColor(quality)
    if not quality or type(quality) ~= "number" then
        quality = 1
    end

    quality = math.max(0, math.min(quality, 7))

    local r, g, b = GetItemQualityColor(quality)
    if not r or not g or not b then
        local fallbackColors = {
            [0] = { r = 0.5, g = 0.5, b = 0.5 },
            [1] = { r = 1.0, g = 1.0, b = 1.0 },
            [2] = { r = 0.3, g = 0.8, b = 0.3 },
            [3] = { r = 0.0, g = 0.4, b = 0.8 },
            [4] = { r = 0.7, g = 0.3, b = 1.0 },
            [5] = { r = 1.0, g = 0.5, b = 0.0 },
            [6] = { r = 1.0, g = 0.0, b = 0.0 },
            [7] = { r = 1.0, g = 0.8, b = 0.0 },
        }
        return fallbackColors[quality]
    end

    return { r = r, g = g, b = b }
end

-- Helper function to add magnifier icon
function GMCards.addMagnifierIcon(card, entity, index, type)
    local VIEW_CONFIG = GMCards.VIEW_CONFIG or {}
    local ICONS = VIEW_CONFIG.ICONS or {}
    local SIZES = VIEW_CONFIG.SIZES or {}

    local iconSize = SIZES.ICON or 16
    local magnifierIcon = ICONS.MAGNIFIER or "Interface\\Icons\\INV_Misc_Spyglass_03"

    local button = card.magnifierBtn
    if not button then
        button = CreateStyledButton(card, "", iconSize, iconSize)
        button:SetPoint("TOPRIGHT", card, "TOPRIGHT", -5, -5)
        button:SetNormalTexture(magnifierIcon)
        button:SetHighlightTexture("Interface\\Buttons\\ButtonHilight-Square")
        button:GetHighlightTexture():SetBlendMode("ADD")
        card.magnifierBtn = button
    end
    button:Show()

    button:SetScript("OnClick", function()
        if not _G.GMModels or not _G.GMModels.createFullViewFrame then return end
        local GMModels = _G.GMModels
        local fullViewFrame = GMModels.createFullViewFrame(index)
        if _G.GMTransitions then _G.GMTransitions.popInModal(fullViewFrame) end

        local closeButton = CreateStyledButton(fullViewFrame, "X", 24, 24)
        closeButton:SetPoint("TOPRIGHT", fullViewFrame, "TOPRIGHT", -3, -3)
        closeButton:SetFrameLevel(fullViewFrame:GetFrameLevel() + 10)
        closeButton:SetScript("OnClick", function()
            local model = _G["FullModel" .. index]
            if model and model.iconFrame then
                model.iconFrame:Hide()
                model.iconFrame:SetParent(nil)
                model.iconFrame = nil
            end
            if model then
                model:SetScript("OnUpdate", nil)
            end
            if _G.GMTransitions then
                _G.GMTransitions.popOutModal(fullViewFrame)
            else
                fullViewFrame:Hide()
            end
        end)

        local resetButton = CreateStyledButton(fullViewFrame, "Reset", 50, 20)
        resetButton:SetPoint("TOPRIGHT", closeButton, "TOPLEFT", -3, 0)
        resetButton:SetFrameLevel(fullViewFrame:GetFrameLevel() + 10)
        resetButton:SetScript("OnClick", function()
            local model = _G["FullModel" .. index]
            if model and model.viewState and GMModels.resetModelState then
                GMModels.resetModelState(model, model.viewState)
            end
        end)
        resetButton:SetScript("OnEnter", function(self)
            GameTooltip:SetOwner(self, "ANCHOR_BOTTOM")
            GameTooltip:AddLine("Reset View", 1, 1, 1)
            GameTooltip:AddLine("Reset model position, rotation, and zoom", 0.7, 0.7, 0.7)
            GameTooltip:Show()
        end)
        resetButton:SetScript("OnLeave", function() GameTooltip:Hide() end)

        local helpButton = CreateStyledButton(fullViewFrame, "?", 20, 20)
        helpButton:SetPoint("TOPRIGHT", resetButton, "TOPLEFT", -3, 0)
        helpButton:SetFrameLevel(fullViewFrame:GetFrameLevel() + 10)
        helpButton:SetScript("OnClick", function()
            if fullViewFrame.instructionsPanel then
                if fullViewFrame.instructionsPanel:IsShown() then
                    fullViewFrame.instructionsPanel:Hide()
                else
                    fullViewFrame.instructionsPanel:Show()
                end
            end
        end)
        helpButton:SetScript("OnEnter", function(self)
            GameTooltip:SetOwner(self, "ANCHOR_BOTTOM")
            GameTooltip:AddLine("Help", 1, 1, 1)
            GameTooltip:AddLine("Toggle control instructions panel", 0.7, 0.7, 0.7)
            GameTooltip:AddLine(" ", 0.7, 0.7, 0.7)
            GameTooltip:AddLine("Keyboard Shortcuts:", 1, 0.82, 0)
            GameTooltip:AddLine("ESC - Close viewer", 0.7, 0.7, 0.7)
            GameTooltip:AddLine("R - Reset view", 0.7, 0.7, 0.7)
            GameTooltip:AddLine("+/- - Zoom in/out", 0.7, 0.7, 0.7)
            GameTooltip:AddLine("Arrow Keys - Rotate", 0.7, 0.7, 0.7)
            GameTooltip:Show()
        end)
        helpButton:SetScript("OnLeave", function() GameTooltip:Hide() end)

        if _G.GMMenus and _G.GMMenus.createInfoButton then
            _G.GMMenus.createInfoButton(fullViewFrame, entity, type)
        end

        if GMModels.createModelView then
            local model = GMModels.createModelView(fullViewFrame, entity, type, index)
            if model then
                _G["FullModel" .. index] = model
            end
        end
    end)

    return button
end

-- ============================================================
-- Copyable ID line: a clickable button at card bottom
-- Left-click opens an EditBox with the primary ID pre-selected
-- ============================================================

local ID_LINE_CONFIG = {
    HEIGHT = 14,
    FONT_SIZE = 9,
    LABEL_COLOR = { 0.5, 0.5, 0.5 },
    VALUE_COLOR = { 0.85, 0.85, 0.85 },
}

-- Create a single read-only EditBox for copying an ID value
local function createIdEditBox(parent, name)
    local box = CreateFrame("EditBox", nil, parent)
    box:SetHeight(ID_LINE_CONFIG.HEIGHT)
    box:SetFont("Fonts\\ARIALN.TTF", ID_LINE_CONFIG.FONT_SIZE)
    box:SetAutoFocus(false)
    box:EnableMouse(true)
    box:SetScript("OnEditFocusGained", function(self)
        self:HighlightText()
    end)
    box:SetScript("OnEditFocusLost", function(self)
        self:HighlightText(0, 0)
    end)
    box:SetScript("OnChar", function(self) self:SetText(self.entryValue or "") end)
    box:SetScript("OnEscapePressed", function(self) self:ClearFocus() end)
    box:SetScript("OnEnterPressed", function(self) self:ClearFocus() end)
    return box
end

-- Two side-by-side copyable ID fields on one row at card bottom
-- e.g. "Entry: [43294]  Model: [25605]" — click either to select & Ctrl+C
function GMCards.createCopyableIdLine(card, leftLabel, leftValue, rightLabel, rightValue)
    local cardW = card:GetWidth()
    local halfW = (cardW - 14) / 2  -- 5px margin each side + 4px gap

    -- Left label
    if not card.idLabelL then
        card.idLabelL = card:CreateFontString(nil, "OVERLAY")
        card.idLabelL:SetFont("Fonts\\ARIALN.TTF", ID_LINE_CONFIG.FONT_SIZE)
        card.idLabelL:SetJustifyH("RIGHT")
        card.idLabelL:SetWordWrap(false)
    end
    card.idLabelL:ClearAllPoints()
    card.idLabelL:SetPoint("BOTTOMLEFT", card, "BOTTOMLEFT", 5, 4)
    card.idLabelL:SetText(leftLabel .. ":")
    card.idLabelL:SetTextColor(unpack(ID_LINE_CONFIG.LABEL_COLOR))
    card.idLabelL:Show()

    -- Left EditBox
    if not card.idBoxL then
        card.idBoxL = createIdEditBox(card, "L")
    end
    local boxL = card.idBoxL
    boxL:SetWidth(halfW - boxL:GetParent().idLabelL:GetStringWidth() - 2)
    boxL:ClearAllPoints()
    boxL:SetPoint("LEFT", card.idLabelL, "RIGHT", 2, 0)
    boxL:SetFrameLevel(card:GetFrameLevel() + 5)
    boxL:SetJustifyH("LEFT")
    boxL.entryValue = tostring(leftValue)
    boxL:SetText(tostring(leftValue))
    boxL:SetTextColor(unpack(ID_LINE_CONFIG.VALUE_COLOR))
    boxL:SetCursorPosition(0)
    boxL:Show()

    if rightLabel and rightValue then
        -- Right label
        if not card.idLabelR then
            card.idLabelR = card:CreateFontString(nil, "OVERLAY")
            card.idLabelR:SetFont("Fonts\\ARIALN.TTF", ID_LINE_CONFIG.FONT_SIZE)
            card.idLabelR:SetJustifyH("RIGHT")
            card.idLabelR:SetWordWrap(false)
        end
        card.idLabelR:ClearAllPoints()
        card.idLabelR:SetPoint("LEFT", card, "LEFT", 5 + halfW + 4, 0)
        card.idLabelR:SetPoint("BOTTOM", card, "BOTTOM", 0, 4)
        card.idLabelR:SetText(rightLabel .. ":")
        card.idLabelR:SetTextColor(unpack(ID_LINE_CONFIG.LABEL_COLOR))
        card.idLabelR:Show()

        -- Right EditBox
        if not card.idBoxR then
            card.idBoxR = createIdEditBox(card, "R")
        end
        local boxR = card.idBoxR
        boxR:SetWidth(halfW - card.idLabelR:GetStringWidth() - 2)
        boxR:ClearAllPoints()
        boxR:SetPoint("LEFT", card.idLabelR, "RIGHT", 2, 0)
        boxR:SetFrameLevel(card:GetFrameLevel() + 5)
        boxR:SetJustifyH("LEFT")
        boxR.entryValue = tostring(rightValue)
        boxR:SetText(tostring(rightValue))
        boxR:SetTextColor(unpack(ID_LINE_CONFIG.VALUE_COLOR))
        boxR:SetCursorPosition(0)
        boxR:Show()
    else
        -- Single value — hide right side
        if card.idLabelR then card.idLabelR:Hide() end
        if card.idBoxR then card.idBoxR:Hide() end
    end
end

-- Card Helpers module loaded
