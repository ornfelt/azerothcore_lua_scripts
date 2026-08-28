-- GameMaster UI - Teleport Dialog Functions
-- All modal dialogs for teleport context menu actions
-- Load order: after GMClient_TeleportContextMenu.lua (alphabetical)

local AIO = AIO or require("AIO")

if AIO.AddAddon() then
    return
end

if not GM_RequireNamespace() then return end
local GameMasterSystem = _G.GameMasterSystem

GameMasterSystem.Teleport = GameMasterSystem.Teleport or {}
local Teleport = GameMasterSystem.Teleport
local TeleportContextMenu = Teleport.ContextMenu or {}
local PlayerInventory = _G.PlayerInventory
local GMConfig = _G.GMConfig

-- ============================================================================
-- Full coordinate edit dialog
-- ============================================================================

function TeleportContextMenu.ShowEditDialog(location)
    local overlay = CreateFrame("Frame", nil, UIParent)
    overlay:SetFrameStrata("FULLSCREEN_DIALOG")
    overlay:SetFrameLevel(99)
    overlay:SetAllPoints(UIParent)
    overlay:EnableMouse(true)

    local bg = overlay:CreateTexture(nil, "BACKGROUND")
    bg:SetAllPoints()
    bg:SetTexture("Interface\\Buttons\\WHITE8X8")
    bg:SetVertexColor(0, 0, 0, 0.8)

    local dialog = CreateStyledFrame(overlay, UISTYLE_COLORS.DarkGrey)
    dialog:SetSize(420, 340)
    dialog:SetPoint("CENTER")

    local title = dialog:CreateFontString(nil, "OVERLAY", "GameFontNormalLarge")
    title:SetPoint("TOP", 0, -12)
    title:SetText("Edit Teleport Location")
    title:SetTextColor(UISTYLE_COLORS.Blue[1], UISTYLE_COLORS.Blue[2], UISTYLE_COLORS.Blue[3])

    overlay:SetScript("OnKeyDown", function(self, key)
        if key == "ESCAPE" then
            self:SetPropagateKeyboardInput(false)
            overlay:Hide()
        else
            self:SetPropagateKeyboardInput(true)
        end
    end)

    -- Helper: labeled edit box row
    local editBoxes = {}
    local function addField(labelText, defaultVal, yOffset, isNumeric)
        local lbl = dialog:CreateFontString(nil, "OVERLAY", "GameFontNormal")
        lbl:SetPoint("TOPLEFT", dialog, "TOPLEFT", 20, yOffset)
        lbl:SetText(labelText)
        lbl:SetWidth(50)
        lbl:SetJustifyH("RIGHT")

        local container = CreateStyledEditBox(dialog, 310, isNumeric)
        container:SetPoint("TOPLEFT", dialog, "TOPLEFT", 80, yOffset + 3)
        local eb = container.editBox
        eb:SetText(tostring(defaultVal or ""))
        return eb
    end

    editBoxes.name = addField("Name:", location.name, -40, false)
    editBoxes.x    = addField("X:", string.format("%.4f", location.position_x), -70, true)
    editBoxes.y    = addField("Y:", string.format("%.4f", location.position_y), -100, true)
    editBoxes.z    = addField("Z:", string.format("%.4f", location.position_z), -130, true)
    editBoxes.o    = addField("O:", string.format("%.4f", location.orientation), -160, true)

    -- Map ID (read-only label)
    local mapLabel = dialog:CreateFontString(nil, "OVERLAY", "GameFontNormal")
    mapLabel:SetPoint("TOPLEFT", dialog, "TOPLEFT", 20, -195)
    mapLabel:SetText("Map:")
    mapLabel:SetWidth(50)
    mapLabel:SetJustifyH("RIGHT")

    local mapValue = dialog:CreateFontString(nil, "OVERLAY", "GameFontHighlight")
    mapValue:SetPoint("TOPLEFT", dialog, "TOPLEFT", 80, -195)
    mapValue:SetText(tostring(location.map))

    local currentMapId = location.map

    -- "Use My Position" button
    local posBtn = CreateStyledButton(dialog, "Use My Position", 140, 24)
    posBtn:SetPoint("TOPLEFT", dialog, "TOPLEFT", 210, -190)
    posBtn:SetTooltip("Use My Position", "Fill coordinates from your current location")
    posBtn:SetScript("OnClick", function()
        AIO.Handle("GameMasterSystem", "GetMyPosition")
    end)

    -- Callback for server position response
    _G._TeleportEditPosCallback = function(_, x, y, z, o, mapId)
        editBoxes.x:SetText(string.format("%.4f", x))
        editBoxes.y:SetText(string.format("%.4f", y))
        editBoxes.z:SetText(string.format("%.4f", z))
        editBoxes.o:SetText(string.format("%.4f", o))
        currentMapId = mapId
        mapValue:SetText(tostring(mapId))
    end

    -- Save button
    local saveBtn = CreateStyledButton(dialog, "Save", 100, 28)
    saveBtn:SetPoint("BOTTOMRIGHT", dialog, "BOTTOM", -10, 15)
    saveBtn:SetScript("OnClick", function()
        local newName = editBoxes.name:GetText()
        local nx = tonumber(editBoxes.x:GetText())
        local ny = tonumber(editBoxes.y:GetText())
        local nz = tonumber(editBoxes.z:GetText())
        local no = tonumber(editBoxes.o:GetText())

        if not newName or newName == "" then
            CreateStyledToast("Name cannot be empty", 2, 0.5, "TOP")
            return
        end
        if not (nx and ny and nz and no) then
            CreateStyledToast("Invalid coordinate values", 2, 0.5, "TOP")
            return
        end

        AIO.Handle("GameMasterSystem", "UpdateTeleportLocationFull",
            location.id, newName, nx, ny, nz, no, currentMapId)
        overlay:Hide()
        if Teleport.RequestTeleportData then
            Teleport.RequestTeleportData()
        end
    end)

    local cancelBtn = CreateStyledButton(dialog, "Cancel", 100, 28)
    cancelBtn:SetPoint("BOTTOMLEFT", dialog, "BOTTOM", 10, 15)
    cancelBtn:SetScript("OnClick", function() overlay:Hide() end)

    overlay:Show()
    editBoxes.name:SetFocus()
end

-- ============================================================================
-- Simple input dialogs (duplicate, teleport player, summon, add position)
-- ============================================================================

function TeleportContextMenu.ShowDuplicateDialog(location)
    if not (PlayerInventory and PlayerInventory.CreateInputDialog) then return end
    local dialog = PlayerInventory.CreateInputDialog({
        title = "Duplicate Teleport Location",
        message = "Enter name for the duplicate:",
        placeholder = location.name .. " (Copy)",
        width = 400, height = 180,
        buttons = {
            {
                text = "Create",
                onClick = function(frame, newName)
                    if newName and newName ~= "" then
                        AIO.Handle("GameMasterSystem", "DuplicateTeleportLocation",
                            location.id, newName)
                        frame:Hide()
                        if Teleport.RequestTeleportData then Teleport.RequestTeleportData() end
                    end
                end
            },
            { text = "Cancel", onClick = function(frame) frame:Hide() end }
        }
    })
    dialog:Show()
end

function TeleportContextMenu.ShowDeleteConfirmation(location)
    StaticPopupDialogs["CONFIRM_DELETE_TELEPORT"] = {
        text = "Are you sure you want to delete the teleport location:\n\n|cffff0000"
            .. location.name .. "|r\n\nThis action cannot be undone!",
        button1 = "Delete", button2 = "Cancel",
        timeout = 0, whileDead = true, hideOnEscape = true,
        OnAccept = function()
            AIO.Handle("GameMasterSystem", "DeleteTeleportLocation", location.id)
            if Teleport.RequestTeleportData then Teleport.RequestTeleportData() end
        end,
    }
    StaticPopup_Show("CONFIRM_DELETE_TELEPORT")
end

function TeleportContextMenu.ShowTeleportPlayerDialog(location)
    if not (PlayerInventory and PlayerInventory.CreateInputDialog) then return end
    local dialog = PlayerInventory.CreateInputDialog({
        title = "Teleport Player to " .. location.name,
        message = "Enter player name:",
        placeholder = "Player name",
        width = 400, height = 180,
        buttons = {
            {
                text = "Teleport",
                onClick = function(frame, playerName)
                    if playerName and playerName ~= "" then
                        AIO.Handle("GameMasterSystem", "TeleportPlayerToLocation",
                            playerName, location.id)
                        frame:Hide()
                    end
                end
            },
            { text = "Cancel", onClick = function(frame) frame:Hide() end }
        }
    })
    dialog:Show()
end

function TeleportContextMenu.ShowSummonPlayerDialog(location)
    if not (PlayerInventory and PlayerInventory.CreateInputDialog) then return end
    local dialog = PlayerInventory.CreateInputDialog({
        title = "Summon Player to " .. location.name,
        message = "Enter player name to summon:",
        placeholder = "Player name",
        width = 400, height = 180,
        buttons = {
            {
                text = "Summon",
                onClick = function(frame, playerName)
                    if playerName and playerName ~= "" then
                        AIO.Handle("GameMasterSystem", "SummonPlayerToLocation",
                            playerName, location.id)
                        frame:Hide()
                    end
                end
            },
            { text = "Cancel", onClick = function(frame) frame:Hide() end }
        }
    })
    dialog:Show()
end

-- ============================================================================
-- Details dialog (read-only view)
-- ============================================================================

function TeleportContextMenu.ShowDetailsDialog(location)
    local dialog = CreateStyledFrame(UIParent, UISTYLE_COLORS.DarkGrey)
    dialog:SetSize(400, 300)
    dialog:SetPoint("CENTER")
    dialog:SetFrameStrata("DIALOG")
    dialog:SetFrameLevel(100)
    dialog:SetMovable(true)
    dialog:EnableMouse(true)
    dialog:RegisterForDrag("LeftButton")
    dialog:SetScript("OnDragStart", dialog.StartMoving)
    dialog:SetScript("OnDragStop", dialog.StopMovingOrSizing)

    local title = dialog:CreateFontString(nil, "OVERLAY", "GameFontNormalLarge")
    title:SetPoint("TOP", 0, -15)
    title:SetText("Location Details")
    title:SetTextColor(UISTYLE_COLORS.Blue[1], UISTYLE_COLORS.Blue[2], UISTYLE_COLORS.Blue[3])

    local closeBtn = CreateStyledButton(dialog, "X", 24, 24)
    closeBtn:SetPoint("TOPRIGHT", -5, -5)
    closeBtn:SetScript("OnClick", function() dialog:Hide() end)

    local details = dialog:CreateFontString(nil, "OVERLAY", "GameFontNormal")
    details:SetPoint("TOPLEFT", 20, -50)
    details:SetJustifyH("LEFT")
    details:SetWidth(360)
    details:SetText(string.format(
        "|cff00ff00Name:|r %s\n\n"
        .. "|cff00ff00ID:|r %d\n"
        .. "|cff00ff00Map:|r %d\n\n"
        .. "|cff00ff00Coordinates:|r\n"
        .. "  X: %.6f\n  Y: %.6f\n  Z: %.6f\n  O: %.6f",
        location.name, location.id, location.map,
        location.position_x, location.position_y,
        location.position_z, location.orientation))

    local okBtn = CreateStyledButton(dialog, "OK", 80, 30)
    okBtn:SetPoint("BOTTOM", 0, 20)
    okBtn:SetScript("OnClick", function() dialog:Hide() end)

    dialog:Show()
end

-- ============================================================================
-- Add current position dialog
-- ============================================================================

function TeleportContextMenu.ShowAddCurrentPositionDialog()
    if not (PlayerInventory and PlayerInventory.CreateInputDialog) then return end
    local dialog = PlayerInventory.CreateInputDialog({
        title = "Add Current Position",
        message = "Enter name for the new teleport location:",
        placeholder = "Location name",
        width = 400, height = 180,
        buttons = {
            {
                text = "Create",
                onClick = function(frame, name)
                    if name and name ~= "" then
                        AIO.Handle("GameMasterSystem", "CreateTeleportAtCurrentPosition", name)
                        frame:Hide()
                        if Teleport.RequestTeleportData then Teleport.RequestTeleportData() end
                    end
                end
            },
            { text = "Cancel", onClick = function(frame) frame:Hide() end }
        }
    })
    dialog:Show()
end

-- ============================================================================
-- AIO handler for "Use My Position" response
-- ============================================================================

function GameMasterSystem.ReceiveMyPosition(player, x, y, z, o, mapId)
    if _G._TeleportEditPosCallback then
        _G._TeleportEditPosCallback(player, x, y, z, o, mapId)
    end
end
