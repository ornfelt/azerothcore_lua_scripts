local AIO = AIO or require("AIO")

if AIO.AddAddon() then
    return
end

-- ===================================
-- WOW 3.3.5 NATIVE COLOR CONSTANTS
-- ===================================
-- Exact values from WoW 3.3.5 FrameXML (Constants.lua, UnitFrame.lua).
-- Use these for authentic WotLK-styled UI elements.
-- For custom dark theme colors, use UISTYLE_COLORS instead.

WOW_COLORS = {}

-- ===================================
-- CLASS COLORS (RAID_CLASS_COLORS)
-- ===================================
-- Exact values from Constants.lua RAID_CLASS_COLORS

WOW_COLORS.CLASS = {
    WARRIOR     = { r = 0.78, g = 0.61, b = 0.43, hex = "C79C6E" },
    PALADIN     = { r = 0.96, g = 0.55, b = 0.73, hex = "F58CBA" },
    HUNTER      = { r = 0.67, g = 0.83, b = 0.45, hex = "ABD473" },
    ROGUE       = { r = 1.0,  g = 0.96, b = 0.41, hex = "FFF569" },
    PRIEST      = { r = 1.0,  g = 1.0,  b = 1.0,  hex = "FFFFFF" },
    DEATHKNIGHT = { r = 0.77, g = 0.12, b = 0.23, hex = "C41F3B" },
    SHAMAN      = { r = 0.0,  g = 0.44, b = 0.87, hex = "0070DE" },
    MAGE        = { r = 0.41, g = 0.8,  b = 0.94, hex = "69CCF0" },
    WARLOCK     = { r = 0.58, g = 0.51, b = 0.79, hex = "9482C9" },
    DRUID       = { r = 1.0,  g = 0.49, b = 0.04, hex = "FF7D0A" },
}

-- Indexed by class ID (matches GetClass() numeric return)
WOW_COLORS.CLASS_BY_ID = {
    [1]  = WOW_COLORS.CLASS.WARRIOR,
    [2]  = WOW_COLORS.CLASS.PALADIN,
    [3]  = WOW_COLORS.CLASS.HUNTER,
    [4]  = WOW_COLORS.CLASS.ROGUE,
    [5]  = WOW_COLORS.CLASS.PRIEST,
    [6]  = WOW_COLORS.CLASS.DEATHKNIGHT,
    [7]  = WOW_COLORS.CLASS.SHAMAN,
    [8]  = WOW_COLORS.CLASS.MAGE,
    [9]  = WOW_COLORS.CLASS.WARLOCK,
    [11] = WOW_COLORS.CLASS.DRUID,
}

-- ===================================
-- STANDARD FONT COLORS
-- ===================================
-- Exact values from Constants.lua

WOW_COLORS.FONT = {
    NORMAL      = { r = 1.0, g = 0.82, b = 0.0 },   -- Gold (quest titles, headers)
    HIGHLIGHT   = { r = 1.0, g = 1.0,  b = 1.0 },   -- White (selected/hovered)
    RED         = { r = 1.0, g = 0.1,  b = 0.1 },   -- Error/negative
    GREEN       = { r = 0.1, g = 1.0,  b = 0.1 },   -- Success/positive
    GRAY        = { r = 0.5, g = 0.5,  b = 0.5 },   -- Disabled/inactive
    YELLOW      = { r = 1.0, g = 1.0,  b = 0.0 },   -- Warnings
    LIGHTYELLOW = { r = 1.0, g = 1.0,  b = 0.6 },
    ORANGE      = { r = 1.0, g = 0.5,  b = 0.25 },
}

-- ===================================
-- HEX COLOR CODES (for inline text)
-- ===================================
-- Usage: WOW_COLORS.HEX.RED .. "Error!" .. WOW_COLORS.HEX.CLOSE

WOW_COLORS.HEX = {
    NORMAL      = "|cffffd200",
    HIGHLIGHT   = "|cffffffff",
    RED         = "|cffff2020",
    GREEN       = "|cff20ff20",
    GRAY        = "|cff808080",
    YELLOW      = "|cffffff00",
    LIGHTYELLOW = "|cffffff9a",
    ORANGE      = "|cffff7f3f",
    CLOSE       = "|r",
}

-- ===================================
-- POWER BAR COLORS
-- ===================================
-- Exact values from UnitFrame.lua PowerBarColor

WOW_COLORS.POWER = {
    MANA        = { r = 0.00, g = 0.00, b = 1.00 },
    RAGE        = { r = 1.00, g = 0.00, b = 0.00 },
    FOCUS       = { r = 1.00, g = 0.50, b = 0.25 },
    ENERGY      = { r = 1.00, g = 1.00, b = 0.00 },
    HAPPINESS   = { r = 0.00, g = 1.00, b = 1.00 },
    RUNES       = { r = 0.50, g = 0.50, b = 0.50 },
    RUNIC_POWER = { r = 0.00, g = 0.82, b = 1.00 },
}

-- Indexed by power type ID (matches UnitPowerType return)
WOW_COLORS.POWER_BY_ID = {
    [0] = WOW_COLORS.POWER.MANA,
    [1] = WOW_COLORS.POWER.RAGE,
    [2] = WOW_COLORS.POWER.FOCUS,
    [3] = WOW_COLORS.POWER.ENERGY,
    [4] = WOW_COLORS.POWER.HAPPINESS,
    [5] = WOW_COLORS.POWER.RUNES,
    [6] = WOW_COLORS.POWER.RUNIC_POWER,
}

-- ===================================
-- MATERIAL TEXT COLORS
-- ===================================
-- Used by quest frames, dialog backgrounds with different materials

WOW_COLORS.MATERIAL_TEXT = {
    Default   = { 0.18, 0.12, 0.06 },
    Stone     = { 1.0, 1.0, 1.0 },
    Parchment = { 0.18, 0.12, 0.06 },
    Marble    = { 0, 0, 0 },
    Silver    = { 0.12, 0.12, 0.12 },
    Bronze    = { 0.18, 0.12, 0.06 },
}

WOW_COLORS.MATERIAL_TITLE = {
    Default   = { 0, 0, 0 },
    Stone     = { 0.93, 0.82, 0 },
    Parchment = { 0, 0, 0 },
    Marble    = { 0.93, 0.82, 0 },
    Silver    = { 0.93, 0.82, 0 },
    Bronze    = { 0.93, 0.82, 0 },
}

-- ===================================
-- HELPER FUNCTIONS
-- ===================================

--- Unpack a {r, g, b} color table for API calls.
--- @param color table with r, g, b fields
--- @return number, number, number
function WOW_COLORS.Unpack(color)
    return color.r, color.g, color.b
end

--- Wrap text in a hex color code.
--- @param hexCode string from WOW_COLORS.HEX (e.g. WOW_COLORS.HEX.RED)
--- @param text string the text to colorize
--- @return string colored text with closing tag
function WOW_COLORS.WrapHex(hexCode, text)
    return hexCode .. text .. "|r"
end

--- Get class color hex-wrapped text.
--- @param className string uppercase class name (e.g. "WARRIOR")
--- @param text string the text to colorize
--- @return string colored text, or plain text if class not found
function WOW_COLORS.ClassText(className, text)
    local class = WOW_COLORS.CLASS[className]
    if not class then return text end
    return "|cff" .. class.hex .. text .. "|r"
end

-- ===================================
-- MODULE REGISTRATION
-- ===================================

if UISTYLE_LIBRARY_MODULES then
    UISTYLE_LIBRARY_MODULES["WowColors"] = true
end

if UISTYLE_DEBUG then
    print("UIStyleLibrary: WowColors module loaded")
end
