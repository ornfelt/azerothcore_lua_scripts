local AIO = AIO or require("AIO")
if AIO.AddAddon() then return end

local DC = DeathChestUI
local ui = DC.ui
local W = DC.FRAME_WIDTH

-- Fixed frame dimensions
local toolbarBottom = DC.HEADER_HEIGHT + 6 + DC.TOOLBAR_HEIGHT + 4
local SCROLL_HEIGHT = DC.MAX_VISIBLE_ROWS * DC.ROW_HEIGHT
-- toolbar + scroll + footerLine + gold + quickTake + takeAll + padding
local FIXED_HEIGHT = toolbarBottom + SCROLL_HEIGHT + 6 + 28 + 30 + 30 + 14

-- Main Frame (UIPanelDialogTemplate for WotLK styling)
local mainFrame = CreateFrame("Frame", "DeathChestFrame", UIParent, "UIPanelDialogTemplate")
mainFrame:SetWidth(W)
mainFrame:SetHeight(FIXED_HEIGHT)
mainFrame:SetPoint("CENTER", UIParent, "CENTER", 0, 40)
mainFrame:SetMovable(true)
mainFrame:EnableMouse(true)
mainFrame:RegisterForDrag("LeftButton")
mainFrame:SetScript("OnDragStart", mainFrame.StartMoving)
mainFrame:SetScript("OnDragStop", mainFrame.StopMovingOrSizing)
mainFrame:SetClampedToScreen(true)
mainFrame:SetToplevel(true)
mainFrame:SetFrameStrata("DIALOG")
mainFrame:Hide()
mainFrame:SetScript("OnHide", function()
    if DC.CancelCastBar then DC.CancelCastBar() end
    AIO.Handle("DeathChest", "CloseUI")
end)
ui.mainFrame = mainFrame

-- Hide template title and create custom tight-width title with skulls
local templateTitle = mainFrame.title or DeathChestFrameTitle
if templateTitle then templateTitle:Hide() end

local customTitle = mainFrame:CreateFontString(nil, "OVERLAY", "GameFontNormal")
customTitle:SetText("Death Chest")
customTitle:SetPoint("TOP", mainFrame, "TOP", 0, -9)

local skullLeft = mainFrame:CreateTexture(nil, "OVERLAY")
skullLeft:SetTexture("Interface\\TARGETINGFRAME\\UI-RaidTargetingIcon_8")
skullLeft:SetSize(16, 16)
skullLeft:SetPoint("RIGHT", customTitle, "LEFT", -4, 0)

local skullRight = mainFrame:CreateTexture(nil, "OVERLAY")
skullRight:SetTexture("Interface\\TARGETINGFRAME\\UI-RaidTargetingIcon_8")
skullRight:SetSize(16, 16)
skullRight:SetPoint("LEFT", customTitle, "RIGHT", 4, 0)

-- Scrollable item area (below toolbar, fixed height)
local scrollFrame = CreateFrame("ScrollFrame", "DeathChestScrollFrame", mainFrame)
scrollFrame:SetPoint("TOPLEFT", mainFrame, "TOPLEFT", 12, -toolbarBottom)
scrollFrame:SetPoint("TOPRIGHT", mainFrame, "TOPRIGHT", -12, -toolbarBottom)
scrollFrame:SetHeight(SCROLL_HEIGHT)
ui.scrollFrame = scrollFrame

local content = CreateFrame("Frame", nil, mainFrame)
content:SetWidth(scrollFrame:GetWidth())
content:SetHeight(1)
scrollFrame:SetScrollChild(content)
scrollFrame:EnableMouseWheel(true)
scrollFrame:SetScript("OnMouseWheel", function(self, delta)
    local cur = self:GetVerticalScroll()
    local maxS = math.max(0, content:GetHeight() - self:GetHeight())
    self:SetVerticalScroll(math.max(0, math.min(maxS, cur - delta * DC.ROW_HEIGHT)))
end)
ui.content = content

-- Footer separator line
local footerLine = mainFrame:CreateTexture(nil, "OVERLAY")
footerLine:SetTexture("Interface\\Tooltips\\UI-Tooltip-Background")
footerLine:SetHeight(1)
footerLine:SetVertexColor(0.4, 0.4, 0.4, 0.5)
ui.footerLine = footerLine

-- Gold display
local goldFrame = CreateFrame("Frame", nil, mainFrame)
goldFrame:SetSize(W - 28, 22)
goldFrame.dbId = 0

local goldIcon = goldFrame:CreateTexture(nil, "ARTWORK")
goldIcon:SetTexture("Interface\\Icons\\INV_Misc_Coin_01")
goldIcon:SetSize(16, 16)
goldIcon:SetPoint("LEFT", goldFrame, "LEFT", 2, 0)
goldIcon:SetTexCoord(0.08, 0.92, 0.08, 0.92)
goldFrame.icon = goldIcon

local goldText = goldFrame:CreateFontString(nil, "OVERLAY", "GameFontHighlight")
goldText:SetPoint("LEFT", goldIcon, "RIGHT", 6, 0)
goldFrame:Hide()

local goldHighlight = goldFrame:CreateTexture(nil, "HIGHLIGHT")
goldHighlight:SetAllPoints()
goldHighlight:SetTexture("Interface\\QuestFrame\\UI-QuestTitleHighlight")
goldHighlight:SetAlpha(0.2)

goldFrame:EnableMouse(true)
goldFrame:SetScript("OnMouseUp", function()
    if DC.state.casting then return end
    if goldFrame.dbId and goldFrame.dbId > 0 then
        local id = goldFrame.dbId
        DC.LootWithEffect(goldFrame, function()
            AIO.Handle("DeathChest", "TakeItem", id)
        end)
    end
end)
goldFrame:SetScript("OnEnter", function(self)
    GameTooltip:SetOwner(self, "ANCHOR_RIGHT")
    GameTooltip:SetText("Click to recover your gold", 1, 0.82, 0)
    GameTooltip:Show()
end)
goldFrame:SetScript("OnLeave", function() GameTooltip:Hide() end)
ui.goldFrame = goldFrame
ui.goldText = goldText

-- Take All button
local takeAllBtn = CreateFrame("Button", nil, mainFrame, "UIPanelButtonTemplate")
takeAllBtn:SetSize(200, 24)
takeAllBtn:SetText("Take All")
takeAllBtn:SetScript("OnClick", function()
    if DC.state.casting then return end
    if DC.state.chestGuid > 0 then
        local guid = DC.state.chestGuid
        DC.LootMultiEffect(function()
            AIO.Handle("DeathChest", "TakeAll", guid)
        end)
    end
end)
ui.takeAllBtn = takeAllBtn

-- Update gold display from state
function DeathChestUI.UpdateGoldDisplay()
    local state = DC.state
    if state.goldAmount > 0 then
        ui.goldText:SetText(FormatGoldCompact(state.goldAmount))
        ui.goldFrame.dbId = state.goldDbId
        ui.goldFrame:Show()
    else
        ui.goldFrame.dbId = 0
        ui.goldFrame:Hide()
    end
end

-- Footer positioning (frame size is fixed, only gold visibility changes anchors)
function DeathChestUI.UpdateLayout(itemCount)
    ui.footerLine:ClearAllPoints()
    ui.footerLine:SetPoint("TOPLEFT", ui.scrollFrame, "BOTTOMLEFT", 0, -3)
    ui.footerLine:SetPoint("TOPRIGHT", ui.scrollFrame, "BOTTOMRIGHT", 0, -3)

    -- Gold always anchored below footer line
    ui.goldFrame:ClearAllPoints()
    ui.goldFrame:SetPoint("TOPLEFT", ui.footerLine, "BOTTOMLEFT", 2, -4)

    -- Quick-take below gold area (reserve 28px for gold whether visible or not)
    if ui.quickTakeRow then
        ui.quickTakeRow:ClearAllPoints()
        ui.quickTakeRow:SetPoint("TOPLEFT", ui.footerLine, "BOTTOMLEFT", 0, -32)
    end

    -- Take All centered below quick-take
    ui.takeAllBtn:ClearAllPoints()
    local btnAnchor = ui.quickTakeRow or ui.footerLine
    ui.takeAllBtn:SetPoint("TOP", btnAnchor, "BOTTOM", 0, -4)
end
