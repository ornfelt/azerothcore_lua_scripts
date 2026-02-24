local AIO = AIO or require("AIO")

if AIO.AddAddon() then
    return -- Exit if on server
end

-- Get module references
local GameMasterSystem = _G.GameMasterSystem
if not GameMasterSystem then
    print("[ERROR] GameMasterSystem namespace not found! Check load order.")
    return
end

-- Create Teleport namespace if it doesn't exist (in case this loads before TeleportList)
GameMasterSystem.Teleport = GameMasterSystem.Teleport or {}
local Teleport = GameMasterSystem.Teleport

local GMConfig = _G.GMConfig
local GMUtils = _G.GMUtils
local PlayerInventory = _G.PlayerInventory

-- Teleport Context Menu Module
local TeleportContextMenu = {}
Teleport.ContextMenu = TeleportContextMenu

-- Store reference to current location
local currentLocation = nil
local contextMenuFrame = nil

-- Create the context menu
function Teleport.ShowContextMenu(anchor, location)
    currentLocation = location
    
    -- Close any existing context menu
    if contextMenuFrame and contextMenuFrame:IsShown() then
        contextMenuFrame:Hide()
    end
    
    -- Build menu items
    local menuItems = TeleportContextMenu.BuildMenuItems(location)
    
    -- Show the menu using the styled easy menu system
    if ShowStyledEasyMenu then
        ShowStyledEasyMenu(menuItems, "cursor")
    else
        -- Fallback to creating custom menu
        TeleportContextMenu.CreateCustomMenu(menuItems, anchor)
    end
end

-- Build context menu items
function TeleportContextMenu.BuildMenuItems(location)
    local menuItems = {}
    
    -- Teleport submenu
    table.insert(menuItems, {
        text = "Teleport",
        hasArrow = true,
        notCheckable = true,
        menuList = {
            {
                text = "Teleport Here",
                notCheckable = true,
                func = function()
                    Teleport.TeleportToLocation(location)
                    CloseDropDownMenus()
                end
            },
            {
                text = "Teleport Player...",
                notCheckable = true,
                func = function()
                    CloseDropDownMenus()
                    TeleportContextMenu.ShowTeleportPlayerDialog(location)
                end
            },
            {
                text = "Port Party Here",
                notCheckable = true,
                func = function()
                    AIO.Handle("GameMasterSystem", "TeleportPartyToLocation", location.id)
                    CloseDropDownMenus()
                end
            },
            { text = "", disabled = true, notCheckable = true }, -- Separator
            {
                text = "Summon Player to Here",
                notCheckable = true,
                func = function()
                    CloseDropDownMenus()
                    TeleportContextMenu.ShowSummonPlayerDialog(location)
                end
            }
        }
    })
    
    -- Manage submenu
    table.insert(menuItems, {
        text = "Manage",
        hasArrow = true,
        notCheckable = true,
        menuList = {
            {
                text = "Edit Location...",
                notCheckable = true,
                func = function()
                    CloseDropDownMenus()
                    TeleportContextMenu.ShowEditDialog(location)
                end
            },
            {
                text = "Duplicate...",
                notCheckable = true,
                func = function()
                    CloseDropDownMenus()
                    TeleportContextMenu.ShowDuplicateDialog(location)
                end
            },
            {
                text = "|cffff0000Delete|r",
                notCheckable = true,
                func = function()
                    CloseDropDownMenus()
                    TeleportContextMenu.ShowDeleteConfirmation(location)
                end
            },
            { text = "", disabled = true, notCheckable = true }, -- Separator
            {
                text = "Set as Favorite",
                notCheckable = true,
                func = function()
                    AIO.Handle("GameMasterSystem", "SetTeleportFavorite", location.id)
                    CloseDropDownMenus()
                end
            },
            {
                text = "Add to Quick Access",
                notCheckable = true,
                func = function()
                    AIO.Handle("GameMasterSystem", "AddTeleportQuickAccess", location.id)
                    CloseDropDownMenus()
                end
            }
        }
    })
    
    -- Copy submenu
    table.insert(menuItems, {
        text = "Copy",
        hasArrow = true,
        notCheckable = true,
        menuList = {
            {
                text = "Copy Coordinates",
                notCheckable = true,
                func = function()
                    TeleportContextMenu.CopyCoordinates(location)
                    CloseDropDownMenus()
                end
            },
            {
                text = "Copy Teleport Command",
                notCheckable = true,
                func = function()
                    TeleportContextMenu.CopyCommand(location)
                    CloseDropDownMenus()
                end
            },
            {
                text = "Copy GPS Command",
                notCheckable = true,
                func = function()
                    TeleportContextMenu.CopyGPSCommand(location)
                    CloseDropDownMenus()
                end
            },
            { text = "", disabled = true, notCheckable = true }, -- Separator
            {
                text = "Export as SQL",
                notCheckable = true,
                func = function()
                    TeleportContextMenu.ExportAsSQL(location)
                    CloseDropDownMenus()
                end
            }
        }
    })
    
    -- Advanced submenu
    table.insert(menuItems, {
        text = "Advanced",
        hasArrow = true,
        notCheckable = true,
        menuList = {
            {
                text = "View Details",
                notCheckable = true,
                func = function()
                    CloseDropDownMenus()
                    TeleportContextMenu.ShowDetailsDialog(location)
                end
            },
            {
                text = "Test Location (10 sec)",
                notCheckable = true,
                func = function()
                    AIO.Handle("GameMasterSystem", "TestTeleportLocation", location.id)
                    CloseDropDownMenus()
                end
            },
            {
                text = "Set as Home",
                notCheckable = true,
                func = function()
                    AIO.Handle("GameMasterSystem", "SetHomeLocation", location.id)
                    CloseDropDownMenus()
                end
            },
            { text = "", disabled = true, notCheckable = true }, -- Separator
            {
                text = "Add Current Position",
                notCheckable = true,
                func = function()
                    CloseDropDownMenus()
                    TeleportContextMenu.ShowAddCurrentPositionDialog()
                end
            }
        }
    })
    
    -- Separator
    table.insert(menuItems, { text = "", disabled = true, notCheckable = true })
    
    -- Cancel
    table.insert(menuItems, {
        text = "Cancel",
        notCheckable = true,
        func = function()
            CloseDropDownMenus()
        end
    })
    
    return menuItems
end

-- Copy coordinates to clipboard
function TeleportContextMenu.CopyCoordinates(location)
    local coords = string.format("%.2f, %.2f, %.2f", 
        location.position_x, location.position_y, location.position_z)
    
    -- Create temporary EditBox for copying
    local editBox = CreateFrame("EditBox")
    editBox:SetText(coords)
    editBox:HighlightText()
    editBox:SetScript("OnEscapePressed", function(self)
        self:ClearFocus()
        self:Hide()
    end)
    editBox:Show()
    editBox:SetFocus()
    
    print("|cff00ff00Coordinates copied:|r " .. coords)
    print("Press Ctrl+C to copy to clipboard")
end

-- Copy teleport command
function TeleportContextMenu.CopyCommand(location)
    local command = ".tele " .. location.name
    
    local editBox = CreateFrame("EditBox")
    editBox:SetText(command)
    editBox:HighlightText()
    editBox:SetScript("OnEscapePressed", function(self)
        self:ClearFocus()
        self:Hide()
    end)
    editBox:Show()
    editBox:SetFocus()
    
    print("|cff00ff00Command copied:|r " .. command)
    print("Press Ctrl+C to copy to clipboard")
end

-- Copy GPS command
function TeleportContextMenu.CopyGPSCommand(location)
    local command = string.format(".gps %.2f %.2f %.2f %d", 
        location.position_x, location.position_y, location.position_z, location.map)
    
    local editBox = CreateFrame("EditBox")
    editBox:SetText(command)
    editBox:HighlightText()
    editBox:SetScript("OnEscapePressed", function(self)
        self:ClearFocus()
        self:Hide()
    end)
    editBox:Show()
    editBox:SetFocus()
    
    print("|cff00ff00GPS command copied:|r " .. command)
    print("Press Ctrl+C to copy to clipboard")
end

-- Export location as SQL
function TeleportContextMenu.ExportAsSQL(location)
    local sql = string.format(
        "INSERT INTO `game_tele` (`position_x`, `position_y`, `position_z`, `orientation`, `map`, `name`) VALUES (%.6f, %.6f, %.6f, %.6f, %d, '%s');",
        location.position_x, location.position_y, location.position_z,
        location.orientation, location.map, location.name:gsub("'", "''")
    )
    
    local editBox = CreateFrame("EditBox")
    editBox:SetText(sql)
    editBox:HighlightText()
    editBox:SetScript("OnEscapePressed", function(self)
        self:ClearFocus()
        self:Hide()
    end)
    editBox:Show()
    editBox:SetFocus()
    
    print("|cff00ff00SQL exported:|r Press Ctrl+C to copy")
end

-- Show edit dialog
function TeleportContextMenu.ShowEditDialog(location)
    if PlayerInventory and PlayerInventory.CreateInputDialog then
        local dialog = PlayerInventory.CreateInputDialog({
            title = "Edit Teleport Location",
            message = "Enter new name for the location:",
            placeholder = location.name,
            width = 400,
            height = 180,
            buttons = {
                {
                    text = "Save",
                    onClick = function(frame, newName)
                        if newName and newName ~= "" then
                            AIO.Handle("GameMasterSystem", "UpdateTeleportLocation", 
                                location.id, newName)
                            frame:Hide()
                            -- Refresh the list
                            if Teleport.RequestTeleportData then
                                Teleport.RequestTeleportData()
                            end
                        end
                    end
                },
                {
                    text = "Cancel",
                    onClick = function(frame)
                        frame:Hide()
                    end
                }
            }
        })
        dialog:Show()
    end
end

-- Show duplicate dialog
function TeleportContextMenu.ShowDuplicateDialog(location)
    if PlayerInventory and PlayerInventory.CreateInputDialog then
        local dialog = PlayerInventory.CreateInputDialog({
            title = "Duplicate Teleport Location",
            message = "Enter name for the duplicate:",
            placeholder = location.name .. " (Copy)",
            width = 400,
            height = 180,
            buttons = {
                {
                    text = "Create",
                    onClick = function(frame, newName)
                        if newName and newName ~= "" then
                            AIO.Handle("GameMasterSystem", "DuplicateTeleportLocation", 
                                location.id, newName)
                            frame:Hide()
                            -- Refresh the list
                            if Teleport.RequestTeleportData then
                                Teleport.RequestTeleportData()
                            end
                        end
                    end
                },
                {
                    text = "Cancel",
                    onClick = function(frame)
                        frame:Hide()
                    end
                }
            }
        })
        dialog:Show()
    end
end

-- Show delete confirmation
function TeleportContextMenu.ShowDeleteConfirmation(location)
    StaticPopupDialogs["CONFIRM_DELETE_TELEPORT"] = {
        text = "Are you sure you want to delete the teleport location:\n\n|cffff0000" .. location.name .. "|r\n\nThis action cannot be undone!",
        button1 = "Delete",
        button2 = "Cancel",
        timeout = 0,
        whileDead = true,
        hideOnEscape = true,
        OnAccept = function()
            AIO.Handle("GameMasterSystem", "DeleteTeleportLocation", location.id)
            -- Refresh the list
            if Teleport.RequestTeleportData then
                Teleport.RequestTeleportData()
            end
        end,
    }
    StaticPopup_Show("CONFIRM_DELETE_TELEPORT")
end

-- Show teleport player dialog
function TeleportContextMenu.ShowTeleportPlayerDialog(location)
    if PlayerInventory and PlayerInventory.CreateInputDialog then
        local dialog = PlayerInventory.CreateInputDialog({
            title = "Teleport Player to " .. location.name,
            message = "Enter player name:",
            placeholder = "Player name",
            width = 400,
            height = 180,
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
                {
                    text = "Cancel",
                    onClick = function(frame)
                        frame:Hide()
                    end
                }
            }
        })
        dialog:Show()
    end
end

-- Show summon player dialog
function TeleportContextMenu.ShowSummonPlayerDialog(location)
    if PlayerInventory and PlayerInventory.CreateInputDialog then
        local dialog = PlayerInventory.CreateInputDialog({
            title = "Summon Player to " .. location.name,
            message = "Enter player name to summon:",
            placeholder = "Player name",
            width = 400,
            height = 180,
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
                {
                    text = "Cancel",
                    onClick = function(frame)
                        frame:Hide()
                    end
                }
            }
        })
        dialog:Show()
    end
end

-- Show details dialog
function TeleportContextMenu.ShowDetailsDialog(location)
    -- Create a styled frame for details
    local dialog = CreateStyledFrame(UIParent, UISTYLE_COLORS.DarkGrey)
    dialog:SetSize(400, 300)
    dialog:SetPoint("CENTER")
    dialog:SetFrameStrata("DIALOG")
    dialog:SetFrameLevel(100)
    
    -- Make it movable
    dialog:SetMovable(true)
    dialog:EnableMouse(true)
    dialog:RegisterForDrag("LeftButton")
    dialog:SetScript("OnDragStart", dialog.StartMoving)
    dialog:SetScript("OnDragStop", dialog.StopMovingOrSizing)
    
    -- Title
    local title = dialog:CreateFontString(nil, "OVERLAY", "GameFontNormalLarge")
    title:SetPoint("TOP", 0, -15)
    title:SetText("Location Details")
    title:SetTextColor(UISTYLE_COLORS.Blue[1], UISTYLE_COLORS.Blue[2], UISTYLE_COLORS.Blue[3])
    
    -- Close button
    local closeBtn = CreateStyledButton(dialog, "X", 24, 24)
    closeBtn:SetPoint("TOPRIGHT", -5, -5)
    closeBtn:SetScript("OnClick", function()
        dialog:Hide()
    end)
    
    -- Details text
    local details = dialog:CreateFontString(nil, "OVERLAY", "GameFontNormal")
    details:SetPoint("TOPLEFT", 20, -50)
    details:SetJustifyH("LEFT")
    details:SetWidth(360)
    
    local detailText = string.format(
        "|cff00ff00Name:|r %s\n\n" ..
        "|cff00ff00ID:|r %d\n" ..
        "|cff00ff00Map:|r %d\n\n" ..
        "|cff00ff00Coordinates:|r\n" ..
        "  X: %.6f\n" ..
        "  Y: %.6f\n" ..
        "  Z: %.6f\n" ..
        "  O: %.6f",
        location.name,
        location.id,
        location.map,
        location.position_x,
        location.position_y,
        location.position_z,
        location.orientation
    )
    details:SetText(detailText)
    
    -- OK button
    local okBtn = CreateStyledButton(dialog, "OK", 80, 30)
    okBtn:SetPoint("BOTTOM", 0, 20)
    okBtn:SetScript("OnClick", function()
        dialog:Hide()
    end)
    
    dialog:Show()
end

-- Show add current position dialog
function TeleportContextMenu.ShowAddCurrentPositionDialog()
    if PlayerInventory and PlayerInventory.CreateInputDialog then
        local dialog = PlayerInventory.CreateInputDialog({
            title = "Add Current Position",
            message = "Enter name for the new teleport location:",
            placeholder = "Location name",
            width = 400,
            height = 180,
            buttons = {
                {
                    text = "Create",
                    onClick = function(frame, name)
                        if name and name ~= "" then
                            AIO.Handle("GameMasterSystem", "CreateTeleportAtCurrentPosition", name)
                            frame:Hide()
                            -- Refresh the list
                            if Teleport.RequestTeleportData then
                                Teleport.RequestTeleportData()
                            end
                        end
                    end
                },
                {
                    text = "Cancel",
                    onClick = function(frame)
                        frame:Hide()
                    end
                }
            }
        })
        dialog:Show()
    end
end

-- Debug message
if GMConfig and GMConfig.config and GMConfig.config.debug then
    print("[GameMasterUI] Teleport context menu module loaded")
end