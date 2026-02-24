local AIO = AIO or require("AIO")

if AIO.AddAddon() then
    return -- Exit if on server
end

-- Get the shared namespace
local GameMasterSystem = _G.GameMasterSystem
if not GameMasterSystem then
    print("[ERROR] GameMasterSystem namespace not found! Check load order.")
    return
end

-- Get references to other modules
local GMConfig = _G.GMConfig
local GMUtils = _G.GMUtils
local GMData = _G.GMData

-- Get configuration
local MENU_CONFIG = GMConfig.MENU_CONFIG

-- Module: Menu System Core
local GMMenus = {}
_G.GMMenus = GMMenus  -- Make it globally accessible
GameMasterSystem.Menus = GMMenus

-- Constants for button tooltips
local BUTTON_CONFIG = {
    TOOLTIP = {
        TEXT = "Right-click to open context menu\nYou can hold middle mouse to move and scroll",
    },
}

-- Helper function to get entity type display name
local function getEntityType(type)
    return MENU_CONFIG.TYPES[type:upper()] or type
end

-- Copy functions
local function copyToClipboard(value, label)
    local trimmedValue = GMUtils.trimSpaces(value)
    if trimmedValue and trimmedValue ~= "" then
        local editBox = CreateFrame("EditBox")
        editBox:SetText(trimmedValue)
        editBox:HighlightText()
        editBox:SetScript("OnEscapePressed", function(self)
            self:ClearFocus()
            self:Hide()
        end)
        editBox:SetScript("OnEnterPressed", function(self)
            self:ClearFocus()
            self:Hide()
        end)
        editBox:SetScript("OnEditFocusLost", function(self)
            self:Hide()
        end)
        editBox:Show()
        editBox:SetFocus()
        print("Ctrl+C to copy " .. (label or "the value"))
    else
        print("Invalid value")
    end
end

local function copyIcon(entity)
    local entry = tostring(entity.spellID):match("^%s*(.-)%s*$") -- Trim spaces
    local name, rank, icon = GetSpellInfo(entry)
    if icon then
        local editBox = CreateFrame("EditBox")
        editBox:SetText(tostring(icon))
        editBox:HighlightText()
        editBox:SetScript("OnEscapePressed", function(self)
            self:ClearFocus()
            self:Hide()
        end)
        editBox:SetScript("OnEnterPressed", function(self)
            self:ClearFocus()
            self:Hide()
        end)
        editBox:SetScript("OnEditFocusLost", function(self)
            self:Hide()
        end)
        editBox:Show()
        editBox:SetFocus()
        print("Ctrl+C to copy the path")
    end
end

-- Register static popup dialog for delete confirmation
StaticPopupDialogs["CONFIRM_DELETE_ENTITY"] = {
    text = "Are you sure you want to delete this %s with ID: %s?\nHold CTRL to skip this dialog next time.",
    button1 = "Yes",
    button2 = "No",
    timeout = MENU_CONFIG.CONFIRM_DIALOG.TIMEOUT,
    whileDead = 1,
    hideOnEscape = true,
    preferredIndex = MENU_CONFIG.CONFIRM_DIALOG.PREFERRED_INDEX,
    OnAccept = function(self, data)
        if not data or not data.type or not data.entry then
            return
        end

        local handlers = {
            npc = function(entry)
                AIO.Handle("GameMasterSystem", "deleteNpcEntity", entry)
            end,
            gameobject = function(entry)
                AIO.Handle("GameMasterSystem", "deleteGameObjectEntity", entry)
            end,
            spell = function(entry)
                AIO.Handle("GameMasterSystem", "deleteSpellEntity", entry)
            end,
            spellvisual = function(entry)
                AIO.Handle("GameMasterSystem", "deleteSpellVisualEntity", entry)
            end,
        }

        if handlers[data.type] then
            handlers[data.type](data.entry)
            -- Notify UI to refresh if available
            if GameMasterSystem.UI and GameMasterSystem.UI.RefreshCurrentView then
                GameMasterSystem.UI.RefreshCurrentView()
            end
        end
    end,
}

-- Helper function to show delete confirmation
local function showDeleteConfirmation(type, entry)
    if not type or not entry then
        return
    end

    local displayType = getEntityType(type):gsub("^%l", string.upper)
    StaticPopup_Show("CONFIRM_DELETE_ENTITY", displayType, entry, {
        type = type,
        entry = entry,
    })
end

-- Export functions for use by other menu modules
GMMenus.getEntityType = getEntityType
GMMenus.copyToClipboard = copyToClipboard
GMMenus.copyIcon = copyIcon
GMMenus.showDeleteConfirmation = showDeleteConfirmation
GMMenus.BUTTON_CONFIG = BUTTON_CONFIG

-- Public API
function GMMenus.Initialize()
    -- Menu system initialized
end

-- Show context menu (main entry point)
function GMMenus.ShowContextMenu(menuType, anchor, entity)
    -- This will be implemented by menu factory module
    if GMMenus.MenuFactory and GMMenus.MenuFactory.ShowMenu then
        GMMenus.MenuFactory.ShowMenu(menuType, anchor, entity)
    end
end

-- Create info button for context menu
function GMMenus.createInfoButton(parent, entity, type)
    if not parent or not entity or not type then
        return nil
    end

    local button = CreateFrame("Button", nil, parent)
    button:SetSize(16, 16)  -- Standard icon size
    button:SetPoint("TOPLEFT", parent, "TOPLEFT", 5, -5)
    button:SetNormalTexture("Interface\\Icons\\INV_Misc_Book_09")
    button:SetHighlightTexture("Interface\\Buttons\\ButtonHilight-Square")
    button:GetHighlightTexture():SetBlendMode("ADD")

    button:SetScript("OnMouseUp", function(self, mouseButton)
        if mouseButton == "RightButton" then
            GMMenus.ShowContextMenu(type:lower(), parent, entity)
        end
    end)

    -- Add tooltip
    button:SetScript("OnEnter", function(self)
        GMUtils.ShowTooltip(self, "ANCHOR_RIGHT", "Info", BUTTON_CONFIG.TOOLTIP.TEXT)
    end)
    
    button:SetScript("OnLeave", function(self)
        GMUtils.HideTooltip()
    end)

    return button
end

-- Export menu configuration for other modules
GMMenus.MENU_CONFIG = MENU_CONFIG

-- Core module loaded