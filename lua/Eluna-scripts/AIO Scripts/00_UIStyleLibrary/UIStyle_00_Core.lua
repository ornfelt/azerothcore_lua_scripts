local AIO = AIO or require("AIO")

if AIO.AddAddon() then
    return
end

-- ===================================
-- UI STYLE LIBRARY CORE MODULE
-- ===================================
-- Core colors, backdrops, and constants for the UI Style Library
-- This module must be loaded first as other modules depend on these definitions

-- ===================================
-- COLOR SYSTEM
-- ===================================

-- Define global color constants for consistency across addons
UISTYLE_COLORS = {
    -- Base colors
    Black = { 0, 0, 0 },
    DarkGrey = { 0.06, 0.06, 0.06 }, -- Main background
    SectionBg = { 0.12, 0.12, 0.12 }, -- Section header backgrounds
    OptionBg = { 0.08, 0.08, 0.08 }, -- Option area backgrounds
    BorderGrey = { 0.2, 0.2, 0.2 }, -- Borders
    TextGrey = { 0.7, 0.7, 0.7 }, -- Inactive text
    White = { 1, 1, 1 },

    -- Accent colors
    Blue = { 0.31, 0.69, 0.89 },
    Gold = { 1, 0.82, 0 },
    Green = { 0.31, 0.89, 0.31 },
    Red = { 0.89, 0.31, 0.31 },
    Orange = { 1, 0.5, 0 },
    Purple = { 0.64, 0.21, 0.93 },
    Yellow = { 1, 1, 0 },

    -- Item quality colors (WoW standard)
    Poor = { 0.62, 0.62, 0.62 }, -- Grey
    Common = { 1, 1, 1 }, -- White
    Uncommon = { 0.12, 1, 0 }, -- Green
    Rare = { 0, 0.44, 0.87 }, -- Blue
    Epic = { 0.64, 0.21, 0.93 }, -- Purple
    Legendary = { 1, 0.5, 0 }, -- Orange
}

-- ===================================
-- BACKDROP TEMPLATES
-- ===================================

UISTYLE_BACKDROPS = {
    Frame = {
        bgFile = "Interface\\Buttons\\WHITE8X8",
        edgeFile = "Interface\\Buttons\\WHITE8X8",
        tile = false,
        edgeSize = 1,
        insets = { left = 1, right = 1, top = 1, bottom = 1 }
    },
    Solid = {
        bgFile = "Interface\\Buttons\\WHITE8X8",
    },
}

-- ===================================
-- UI CONSTANTS
-- ===================================

UISTYLE_PADDING = 10
UISTYLE_SMALL_PADDING = 5
UISTYLE_SECTION_SPACING = 2

-- ===================================
-- ICON FALLBACKS
-- ===================================

-- Common fallback icon paths
ICON_FALLBACKS = {
    QUESTION_MARK = "Interface\\Icons\\INV_Misc_QuestionMark",
    SPELL_BOOK = "Interface\\Icons\\INV_Misc_Book_09",
    CURRENCY = "Interface\\Icons\\INV_Misc_Coin_01",
    EMPTY_SLOT = "Interface\\PaperDoll\\UI-Backpack-EmptySlot",
    GEAR = "Interface\\Icons\\Trade_Engineering",
    POTION = "Interface\\Icons\\INV_Potion_01",
    FOOD = "Interface\\Icons\\INV_Misc_Food_01",
    WEAPON = "Interface\\Icons\\INV_Sword_01",
    ARMOR = "Interface\\Icons\\INV_Chest_Chain",
}

-- ===================================
-- HELPER FUNCTIONS FOR 3.3.5 COMPATIBILITY
-- ===================================

-- Simple timer for backward compatibility (enhanced version in Utils)
function CreateTimer(delay, callback)
    if not delay or not callback then
        return nil
    end
    
    local frame = CreateFrame("Frame")
    local elapsed = 0
    
    frame:SetScript("OnUpdate", function(self, delta)
        elapsed = elapsed + delta
        if elapsed >= delay then
            self:SetScript("OnUpdate", nil)
            if callback then
                callback()
            end
        end
    end)
    
    return frame
end

-- ===================================
-- LIBRARY VERSION
-- ===================================

UISTYLE_LIBRARY_VERSION = "2.0.0"
UISTYLE_LIBRARY_MODULES = {}

-- Register this module
UISTYLE_LIBRARY_MODULES["Core"] = true

-- Debug print for module loading (can be removed in production)
if UISTYLE_DEBUG then
    print("UIStyleLibrary: Core module loaded (v" .. UISTYLE_LIBRARY_VERSION .. ")")
end