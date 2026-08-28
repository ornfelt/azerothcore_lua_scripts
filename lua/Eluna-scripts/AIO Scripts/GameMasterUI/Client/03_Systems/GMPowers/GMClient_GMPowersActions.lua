-- GameMaster UI - GM Powers Action Buttons
-- Self Actions and Target Actions grids with dialogs
-- Load order: after GMClient_GMPowers.lua (alphabetical)

local AIO = AIO or require("AIO")

if AIO.AddAddon() then
    return
end

if not GM_RequireNamespace() then return end

local GMPowers = _G.GMPowers
local PlayerInventory = _G.PlayerInventory

-- ============================================================================
-- Helper: build a 3x2 button grid inside a section frame
-- ============================================================================

local function BuildButtonGrid(section, actions, sectionWidth, startY)
    local cols = 3
    local gap = 6
    local pad = 10
    local buttonWidth = (sectionWidth - (pad * 2) - (gap * (cols - 1))) / cols
    local buttonHeight = 18
    startY = startY or -20

    for _, action in ipairs(actions) do
        local btn = CreateStyledButton(section, action.text, buttonWidth, buttonHeight)
        btn:SetPoint("TOPLEFT", section, "TOPLEFT",
            pad + action.col * (buttonWidth + gap),
            startY - (action.row * (buttonHeight + gap)))
        btn:SetTooltip(action.text, action.tooltip)
        if action.rightClick then
            btn:RegisterForClicks("LeftButtonUp", "RightButtonUp")
        end
        btn:SetScript("OnClick", function(self, button)
            action.handler(button)
        end)
        GMPowers.frames["action_" .. action.id] = btn
        btn:Show()
    end
end

-- ============================================================================
-- Action execution helpers
-- ============================================================================

local function executeSimple(actionId)
    local targetName = ""
    local input = GMPowers.frames.targetNameInput
    if input and input.editBox then
        targetName = input.editBox:GetText() or ""
    end
    AIO.Handle("GameMasterSystem", "executeGMAction", actionId, targetName)
    CreateStyledToast("Executed: " .. actionId, 2, 0.5, "TOP")
end

local function openTeleportPicker()
    local StateMachine = _G.GMStateMachine
    if StateMachine and StateMachine.openTeleport then
        StateMachine.openTeleport()
    else
        CreateStyledToast("Teleport picker not available", 2, 0.5, "TOP")
    end
end

local function showSavePositionDialog()
    if not (PlayerInventory and PlayerInventory.CreateInputDialog) then return end
    local dialog = PlayerInventory.CreateInputDialog({
        title = "Save Current Position",
        message = "Enter a name for this teleport location:",
        placeholder = "Location name",
        width = 400,
        height = 180,
        buttons = {
            {
                text = "Save",
                onClick = function(frame, name)
                    if name and name ~= "" then
                        AIO.Handle("GameMasterSystem", "saveCurrentPosition", name)
                        frame:Hide()
                    end
                end
            },
            {
                text = "Cancel",
                onClick = function(frame) frame:Hide() end
            }
        }
    })
    dialog:Show()
end

local function showKickConfirmation()
    StaticPopupDialogs["GMPOWERS_CONFIRM_KICK"] = {
        text = "Are you sure you want to |cffff0000KICK|r the selected player?\n\nThis will disconnect them immediately.",
        button1 = "Kick",
        button2 = "Cancel",
        timeout = 0,
        whileDead = true,
        hideOnEscape = true,
        OnAccept = function()
            executeSimple("kickTarget")
        end,
    }
    StaticPopup_Show("GMPOWERS_CONFIRM_KICK")
end

local function showAnnounceDialog()
    if not (PlayerInventory and PlayerInventory.CreateInputDialog) then return end
    local dialog = PlayerInventory.CreateInputDialog({
        title = "Server Announcement",
        message = "Enter message to broadcast to all players:",
        placeholder = "Your announcement...",
        maxLetters = 200,
        width = 450,
        height = 180,
        buttons = {
            {
                text = "Send",
                onClick = function(frame, msg)
                    if msg and msg ~= "" then
                        AIO.Handle("GameMasterSystem", "announceMessage", msg)
                        frame:Hide()
                    end
                end
            },
            {
                text = "Cancel",
                onClick = function(frame) frame:Hide() end
            }
        }
    })
    dialog:Show()
end

-- ============================================================================
-- Autocomplete name input for Target Actions
-- ============================================================================

local MAX_DROPDOWN_ROWS = 6

local function BuildPlayerNameInput(section, sectionWidth)
    local inputWidth = sectionWidth - 20
    local container = CreateStyledEditBox(section, inputWidth, false, 30)
    container:SetPoint("TOPLEFT", section, "TOPLEFT", 10, -20)
    container.editBox:SetAutoFocus(false)
    container.editBox:SetText("")

    -- Placeholder text
    local placeholder = container.editBox:CreateFontString(nil, "OVERLAY", "GameFontNormalSmall")
    placeholder:SetPoint("LEFT", container.editBox, "LEFT", 2, 0)
    placeholder:SetText("Player name (or use target)")
    placeholder:SetTextColor(0.4, 0.4, 0.4)

    -- Dropdown frame (parented to UIParent to avoid scroll clipping)
    local dropdown = CreateStyledFrame(UIParent, UISTYLE_COLORS.DropdownBg)
    dropdown:SetFrameStrata("FULLSCREEN_DIALOG")
    dropdown:SetWidth(inputWidth)
    dropdown:Hide()
    dropdown.rows = {}

    -- Click-away overlay
    local overlay = CreateFrame("Button", nil, UIParent)
    overlay:SetAllPoints(UIParent)
    overlay:SetFrameStrata("FULLSCREEN")
    overlay:Hide()
    overlay:SetScript("OnClick", function()
        dropdown:Hide()
        overlay:Hide()
        container:ClearFocus()
    end)

    dropdown:SetScript("OnShow", function()
        overlay:Show()
        overlay:SetFrameLevel(dropdown:GetFrameLevel() - 1)
    end)
    dropdown:SetScript("OnHide", function()
        overlay:Hide()
    end)

    -- Build dropdown rows
    for i = 1, MAX_DROPDOWN_ROWS do
        local row = CreateFrame("Button", nil, dropdown)
        row:SetHeight(16)
        row:SetPoint("TOPLEFT", dropdown, "TOPLEFT", 1, -((i - 1) * 16) - 1)
        row:SetPoint("TOPRIGHT", dropdown, "TOPRIGHT", -1, -((i - 1) * 16) - 1)

        local rowBg = row:CreateTexture(nil, "BACKGROUND")
        rowBg:SetAllPoints()
        rowBg:SetTexture("Interface\\Buttons\\WHITE8X8")
        rowBg:SetVertexColor(0, 0, 0, 0)

        local label = row:CreateFontString(nil, "OVERLAY", "GameFontNormalSmall")
        label:SetPoint("LEFT", row, "LEFT", 6, 0)
        label:SetJustifyH("LEFT")
        label:SetTextColor(0.9, 0.9, 0.9)

        row:SetScript("OnEnter", function()
            rowBg:SetVertexColor(0.2, 0.4, 0.6, 0.6)
        end)
        row:SetScript("OnLeave", function()
            rowBg:SetVertexColor(0, 0, 0, 0)
        end)
        row:SetScript("OnClick", function()
            container:SetText(label:GetText())
            dropdown:Hide()
            container:ClearFocus()
        end)

        row.label = label
        dropdown.rows[i] = row
        row:Hide()
    end

    -- Filter and show dropdown
    local function UpdateDropdown()
        local text = container.editBox:GetText()
        if not text or text == "" then placeholder:Show() else placeholder:Hide() end

        if not text or text == "" then
            dropdown:Hide()
            return
        end

        local lowerText = text:lower()
        local matches = {}
        for _, name in ipairs(GMPowers.onlinePlayerNames) do
            if name:lower():find(lowerText, 1, true) then
                matches[#matches + 1] = name
                if #matches >= MAX_DROPDOWN_ROWS then break end
            end
        end

        if #matches == 0 then
            dropdown:Hide()
            return
        end

        -- Position dropdown below the editbox container
        dropdown:ClearAllPoints()
        dropdown:SetPoint("TOPLEFT", container, "BOTTOMLEFT", 0, -2)
        dropdown:SetPoint("TOPRIGHT", container, "BOTTOMRIGHT", 0, -2)
        dropdown:SetHeight(#matches * 16 + 2)

        for i = 1, MAX_DROPDOWN_ROWS do
            local row = dropdown.rows[i]
            if i <= #matches then
                row.label:SetText(matches[i])
                row:Show()
            else
                row:Hide()
            end
        end
        dropdown:Show()
    end

    container.editBox:SetScript("OnTextChanged", UpdateDropdown)
    container.editBox:SetScript("OnEnterPressed", function(self)
        self:ClearFocus()
        dropdown:Hide()
    end)
    container.editBox:SetScript("OnEscapePressed", function(self)
        self:ClearFocus()
        dropdown:Hide()
    end)

    -- Request online names from server
    AIO.Handle("GameMasterSystem", "requestOnlinePlayerNames")

    return container
end

-- ============================================================================
-- Create Self Actions section
-- ============================================================================

function GMPowers.CreateSelfActionsSection(parent)
    local section = CreateStyledFrame(parent, UISTYLE_COLORS.OptionBg)
    local sectionWidth = parent:GetWidth() - 30
    section:SetSize(sectionWidth, 65)
    section:SetPoint("TOP", GMPowers.frames.speedSection, "BOTTOM", 0, -4)
    section:Show()

    local title = section:CreateFontString(nil, "OVERLAY", "GameFontNormal")
    title:SetPoint("TOPLEFT", section, "TOPLEFT", 10, -4)
    title:SetText("Self Actions")
    title:SetTextColor(0.9, 0.9, 0.9)

    local selfActions = {
        {id = "resetCooldowns", text = "Reset CDs",   tooltip = "Reset all spell cooldowns",
            handler = function() executeSimple("resetCooldowns") end, row = 0, col = 0},
        {id = "fullHeal",       text = "Full Heal",   tooltip = "Restore health and mana to full",
            handler = function() executeSimple("fullHeal") end, row = 0, col = 1},
        {id = "openTeleport",   text = "Teleport...", tooltip = "Open the teleport location picker",
            handler = openTeleportPicker, row = 0, col = 2},
        {id = "savePosition",   text = "Save Pos",   tooltip = "Save current position as a game_tele entry",
            handler = showSavePositionDialog, row = 1, col = 0},
        {id = "reviveSelf",     text = "Revive Self", tooltip = "Resurrect yourself at full health",
            handler = function() executeSimple("reviveSelf") end, row = 1, col = 1},
        {id = "replenish",      text = "Replenish",   tooltip = "Full heal + mana + reset cooldowns",
            handler = function() executeSimple("replenish") end, row = 1, col = 2},
    }

    BuildButtonGrid(section, selfActions, sectionWidth)
    GMPowers.frames.selfActionsSection = section
end

-- ============================================================================
-- Create Target Actions section
-- ============================================================================

function GMPowers.CreateTargetActionsSection(parent)
    local section = CreateStyledFrame(parent, UISTYLE_COLORS.OptionBg)
    local sectionWidth = parent:GetWidth() - 30
    section:SetSize(sectionWidth, 95)
    section:SetPoint("TOP", GMPowers.frames.selfActionsSection, "BOTTOM", 0, -4)
    section:Show()

    local title = section:CreateFontString(nil, "OVERLAY", "GameFontNormal")
    title:SetPoint("TOPLEFT", section, "TOPLEFT", 10, -4)
    title:SetText("Target Actions")
    title:SetTextColor(0.9, 0.9, 0.9)

    -- Player name input with autocomplete
    local inputFrame = BuildPlayerNameInput(section, sectionWidth)
    GMPowers.frames.targetNameInput = inputFrame

    local targetActions = {
        {id = "appear",       text = "Go To",       tooltip = "Teleport to named/selected player",
            handler = function() executeSimple("appear") end, row = 0, col = 0},
        {id = "summon",       text = "Summon",       tooltip = "Summon named/selected player to you",
            handler = function() executeSimple("summon") end, row = 0, col = 1},
        {id = "freezeTarget", text = "Freeze",
            tooltip = "Left-click: Freeze | Right-click: Unfreeze",
            rightClick = true,
            handler = function(button)
                if button == "RightButton" then
                    executeSimple("unfreezeTarget")
                else
                    executeSimple("freezeTarget")
                end
            end, row = 0, col = 2},
        {id = "reviveTarget", text = "Revive",       tooltip = "Resurrect the named/selected player",
            handler = function() executeSimple("reviveTarget") end, row = 1, col = 0},
        {id = "kickTarget",   text = "|cffff4444Kick|r", tooltip = "Disconnect the named/selected player",
            handler = showKickConfirmation, row = 1, col = 1},
        {id = "announce",     text = "Announce...",  tooltip = "Broadcast a message to all online players",
            handler = showAnnounceDialog, row = 1, col = 2},
    }

    BuildButtonGrid(section, targetActions, sectionWidth, -48)
    GMPowers.frames.targetActionsSection = section
end

-- ============================================================================
-- Hook into panel creation (called after GMPowers.CreatePanel builds speeds)
-- ============================================================================

-- Extend the original CreatePanel to append action sections
local originalCreatePanel = GMPowers.CreatePanel
function GMPowers.CreatePanel(parent)
    local panel = originalCreatePanel(parent)
    local scrollContent = GMPowers.frames.scrollContent
    local updateScrollBar = GMPowers.frames.updateScrollBar

    GMPowers.CreateSelfActionsSection(scrollContent)
    GMPowers.CreateTargetActionsSection(scrollContent)

    -- Total: 4 + 65 (toggles) + 4 + 85 (speeds) + 4 + 65 (self) + 4 + 95 (target) + 10 pad
    scrollContent:SetHeight(336)
    if updateScrollBar then updateScrollBar() end

    return panel
end
