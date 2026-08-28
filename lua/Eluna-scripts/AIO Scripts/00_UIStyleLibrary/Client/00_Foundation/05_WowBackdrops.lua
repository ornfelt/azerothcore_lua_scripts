local AIO = AIO or require("AIO")

if AIO.AddAddon() then
    return
end

-- ===================================
-- WOW 3.3.5 NATIVE BACKDROP & TEMPLATE DATA
-- ===================================
-- Exact values from WoW 3.3.5 FrameXML (UIPanelTemplates.xml,
-- GameTooltip.xml, Constants.lua). Use these for authentic WotLK look.
-- For custom dark theme, use UISTYLE_BACKDROPS instead.

-- ===================================
-- NATIVE BACKDROP TEMPLATES
-- ===================================

WOW_BACKDROPS = {
    -- Standard tooltip backdrop (used by GameTooltip, item tooltips, etc.)
    Tooltip = {
        bgFile = "Interface\\Tooltips\\UI-Tooltip-Background",
        edgeFile = "Interface\\Tooltips\\UI-Tooltip-Border",
        tile = true,
        tileSize = 16,
        edgeSize = 16,
        insets = { left = 5, right = 5, top = 5, bottom = 5 },
    },

    -- Standard dialog backdrop (quest frames, trade windows, etc.)
    Dialog = {
        bgFile = "Interface\\DialogFrame\\UI-DialogBox-Background",
        edgeFile = "Interface\\DialogFrame\\UI-DialogBox-Border",
        tile = true,
        tileSize = 32,
        edgeSize = 32,
        insets = { left = 11, right = 12, top = 12, bottom = 11 },
    },

    -- Gold-bordered dialog (important/special dialogs)
    DialogGold = {
        bgFile = "Interface\\DialogFrame\\UI-DialogBox-Background",
        edgeFile = "Interface\\DialogFrame\\UI-DialogBox-Gold-Border",
        tile = true,
        tileSize = 32,
        edgeSize = 32,
        insets = { left = 11, right = 12, top = 12, bottom = 11 },
    },
}

-- ===================================
-- ADDITIONAL TEXTURE PATHS
-- ===================================
-- Extends the global TEX table from 01_Textures.lua

if TEX then
    -- Panel button state textures
    TEX.BTN_UP        = "Interface\\Buttons\\UI-Panel-Button-Up"
    TEX.BTN_DOWN      = "Interface\\Buttons\\UI-Panel-Button-Down"
    TEX.BTN_DISABLED  = "Interface\\Buttons\\UI-Panel-Button-Disabled"
    TEX.BTN_HIGHLIGHT = "Interface\\Buttons\\UI-Panel-Button-Highlight"
    TEX.BTN_TEXCOORDS = { 0, 0.625, 0, 0.6875 }

    -- Scrollbar disabled state textures (up/down normals already in TEX)
    TEX.SCROLL_UP_D      = "Interface\\Buttons\\UI-ScrollBar-ScrollUpButton-Disabled"
    TEX.SCROLL_DN_N      = "Interface\\Buttons\\UI-ScrollBar-ScrollDownButton-Up"
    TEX.SCROLL_DN_D      = "Interface\\Buttons\\UI-ScrollBar-ScrollDownButton-Disabled"
    TEX.SCROLL_BG        = "Interface\\Buttons\\UI-ScrollBar-Track"
    TEX.SCROLL_KNOB_COORDS = { 0.20, 0.80, 0, 1 }

    -- Checkbox textures (check mark already in TEX.CHECKBOX)
    TEX.CHECK_UP        = "Interface\\Buttons\\UI-CheckBox-Up"
    TEX.CHECK_HIGHLIGHT = "Interface\\Buttons\\UI-CheckBox-Highlight"

    -- Input box segmented border
    TEX.INPUT_BORDER    = "Interface\\Common\\Common-Input-Border"
end

-- ===================================
-- CLASS ICON ATLAS
-- ===================================
-- 4x4 grid texture with all class icons
-- Exact texcoords from Constants.lua CLASS_ICON_TCOORDS

WOW_CLASS_ICONS = {
    TEXTURE = "Interface\\Glues\\CharacterCreate\\UI-CharacterCreate-Classes",
    COORDS = {
        WARRIOR     = { 0, 0.25, 0, 0.25 },
        MAGE        = { 0.25, 0.49609375, 0, 0.25 },
        ROGUE       = { 0.49609375, 0.7421875, 0, 0.25 },
        DRUID       = { 0.7421875, 0.98828125, 0, 0.25 },
        HUNTER      = { 0, 0.25, 0.25, 0.5 },
        SHAMAN      = { 0.25, 0.49609375, 0.25, 0.5 },
        PRIEST      = { 0.49609375, 0.7421875, 0.25, 0.5 },
        WARLOCK     = { 0.7421875, 0.98828125, 0.25, 0.5 },
        PALADIN     = { 0, 0.25, 0.5, 0.75 },
        DEATHKNIGHT = { 0.25, 0.5, 0.5, 0.75 },
    },
}

--- Apply a class icon to a texture object.
--- @param texture userdata WoW texture object
--- @param className string uppercase class name (e.g. "WARRIOR")
function WOW_CLASS_ICONS.Apply(texture, className)
    local coords = WOW_CLASS_ICONS.COORDS[className]
    if not coords then return end
    texture:SetTexture(WOW_CLASS_ICONS.TEXTURE)
    texture:SetTexCoord(coords[1], coords[2], coords[3], coords[4])
end

-- ===================================
-- EQUIPMENT SLOT CONSTANTS
-- ===================================
-- Exact values from Constants.lua INVSLOT_*

WOW_EQUIP_SLOTS = {
    AMMO      = 0,
    HEAD      = 1,
    NECK      = 2,
    SHOULDER  = 3,
    BODY      = 4,  -- Shirt
    CHEST     = 5,
    WAIST     = 6,
    LEGS      = 7,
    FEET      = 8,
    WRIST     = 9,
    HAND      = 10,
    FINGER1   = 11,
    FINGER2   = 12,
    TRINKET1  = 13,
    TRINKET2  = 14,
    BACK      = 15,
    MAINHAND  = 16,
    OFFHAND   = 17,
    RANGED    = 18,
    TABARD    = 19,
    FIRST_EQUIPPED = 1,
    LAST_EQUIPPED  = 19,
}

-- ===================================
-- MODULE REGISTRATION
-- ===================================

if UISTYLE_LIBRARY_MODULES then
    UISTYLE_LIBRARY_MODULES["WowBackdrops"] = true
end

if UISTYLE_DEBUG then
    print("UIStyleLibrary: WowBackdrops module loaded")
end
