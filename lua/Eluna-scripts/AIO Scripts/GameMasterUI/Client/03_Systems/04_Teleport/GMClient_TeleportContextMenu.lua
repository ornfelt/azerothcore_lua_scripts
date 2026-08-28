-- GameMaster UI - Teleport Context Menu
-- Menu structure and copy/export utilities
-- Dialogs are in GMClient_TeleportDialogs.lua

local AIO = AIO or require("AIO")

if AIO.AddAddon() then
    return -- Exit if on server
end

if not GM_RequireNamespace() then return end
local GameMasterSystem = _G.GameMasterSystem

GameMasterSystem.Teleport = GameMasterSystem.Teleport or {}
local Teleport = GameMasterSystem.Teleport

local GMConfig = _G.GMConfig
local PlayerInventory = _G.PlayerInventory

-- Teleport Context Menu Module
local TeleportContextMenu = {}
Teleport.ContextMenu = TeleportContextMenu

local currentLocation = nil
local contextMenuFrame = nil

-- Create the context menu
function Teleport.ShowContextMenu(anchor, location)
    currentLocation = location

    if contextMenuFrame and contextMenuFrame:IsShown() then
        contextMenuFrame:Hide()
    end

    local menuItems = TeleportContextMenu.BuildMenuItems(location)

    if ShowStyledEasyMenu then
        ShowStyledEasyMenu(menuItems, "cursor")
    else
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
                text = "Teleport Here", notCheckable = true,
                func = function()
                    Teleport.TeleportToLocation(location)
                    CloseDropDownMenus()
                end
            },
            {
                text = "Teleport Player...", notCheckable = true,
                func = function()
                    CloseDropDownMenus()
                    TeleportContextMenu.ShowTeleportPlayerDialog(location)
                end
            },
            {
                text = "Port Party Here", notCheckable = true,
                func = function()
                    AIO.Handle("GameMasterSystem", "TeleportPartyToLocation", location.id)
                    CloseDropDownMenus()
                end
            },
            { text = "", disabled = true, notCheckable = true },
            {
                text = "Summon Player to Here", notCheckable = true,
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
                text = "Edit Location...", notCheckable = true,
                func = function()
                    CloseDropDownMenus()
                    TeleportContextMenu.ShowEditDialog(location)
                end
            },
            {
                text = "Duplicate...", notCheckable = true,
                func = function()
                    CloseDropDownMenus()
                    TeleportContextMenu.ShowDuplicateDialog(location)
                end
            },
            {
                text = "|cffff0000Delete|r", notCheckable = true,
                func = function()
                    CloseDropDownMenus()
                    TeleportContextMenu.ShowDeleteConfirmation(location)
                end
            },
            { text = "", disabled = true, notCheckable = true },
            {
                text = "Set as Favorite", notCheckable = true,
                func = function()
                    AIO.Handle("GameMasterSystem", "SetTeleportFavorite", location.id)
                    CloseDropDownMenus()
                end
            },
            {
                text = "Add to Quick Access", notCheckable = true,
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
                text = "Copy Coordinates", notCheckable = true,
                func = function()
                    TeleportContextMenu.CopyCoordinates(location)
                    CloseDropDownMenus()
                end
            },
            {
                text = "Copy Teleport Command", notCheckable = true,
                func = function()
                    TeleportContextMenu.CopyCommand(location)
                    CloseDropDownMenus()
                end
            },
            {
                text = "Copy GPS Command", notCheckable = true,
                func = function()
                    TeleportContextMenu.CopyGPSCommand(location)
                    CloseDropDownMenus()
                end
            },
            { text = "", disabled = true, notCheckable = true },
            {
                text = "Export as SQL", notCheckable = true,
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
                text = "View Details", notCheckable = true,
                func = function()
                    CloseDropDownMenus()
                    TeleportContextMenu.ShowDetailsDialog(location)
                end
            },
            {
                text = "Test Location (10 sec)", notCheckable = true,
                func = function()
                    AIO.Handle("GameMasterSystem", "TestTeleportLocation", location.id)
                    CloseDropDownMenus()
                end
            },
            {
                text = "Set as Home", notCheckable = true,
                func = function()
                    AIO.Handle("GameMasterSystem", "SetHomeLocation", location.id)
                    CloseDropDownMenus()
                end
            },
            { text = "", disabled = true, notCheckable = true },
            {
                text = "Add Current Position", notCheckable = true,
                func = function()
                    CloseDropDownMenus()
                    TeleportContextMenu.ShowAddCurrentPositionDialog()
                end
            }
        }
    })

    -- Separator + Cancel
    table.insert(menuItems, { text = "", disabled = true, notCheckable = true })
    table.insert(menuItems, {
        text = "Cancel", notCheckable = true,
        func = function() CloseDropDownMenus() end
    })

    return menuItems
end

-- ============================================================================
-- Copy / Export utilities
-- ============================================================================

local function createCopyEditBox(text)
    local editBox = CreateFrame("EditBox")
    editBox:SetText(text)
    editBox:HighlightText()
    editBox:SetScript("OnEscapePressed", function(self)
        self:ClearFocus()
        self:Hide()
    end)
    editBox:Show()
    editBox:SetFocus()
end

function TeleportContextMenu.CopyCoordinates(location)
    local coords = string.format("%.2f, %.2f, %.2f",
        location.position_x, location.position_y, location.position_z)
    createCopyEditBox(coords)
    print("|cff00ff00Coordinates copied:|r " .. coords)
    print("Press Ctrl+C to copy to clipboard")
end

function TeleportContextMenu.CopyCommand(location)
    local command = ".tele " .. location.name
    createCopyEditBox(command)
    print("|cff00ff00Command copied:|r " .. command)
    print("Press Ctrl+C to copy to clipboard")
end

function TeleportContextMenu.CopyGPSCommand(location)
    local command = string.format(".gps %.2f %.2f %.2f %d",
        location.position_x, location.position_y, location.position_z, location.map)
    createCopyEditBox(command)
    print("|cff00ff00GPS command copied:|r " .. command)
    print("Press Ctrl+C to copy to clipboard")
end

function TeleportContextMenu.ExportAsSQL(location)
    local sql = string.format(
        "INSERT INTO `game_tele` (`position_x`, `position_y`, `position_z`, `orientation`, `map`, `name`) "
        .. "VALUES (%.6f, %.6f, %.6f, %.6f, %d, '%s');",
        location.position_x, location.position_y, location.position_z,
        location.orientation, location.map, location.name:gsub("'", "''"))
    createCopyEditBox(sql)
    print("|cff00ff00SQL exported:|r Press Ctrl+C to copy")
end

if GMConfig and GMConfig.config and GMConfig.config.debug then
    print("[GameMasterUI] Teleport context menu module loaded")
end
