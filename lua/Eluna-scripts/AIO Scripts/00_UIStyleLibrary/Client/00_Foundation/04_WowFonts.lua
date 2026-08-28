local AIO = AIO or require("AIO")

if AIO.AddAddon() then
    return
end

-- ===================================
-- WOW 3.3.5 NATIVE FONT CONSTANTS
-- ===================================
-- Exact values from WoW 3.3.5 FrameXML (Fonts.xml).
-- Font paths for CreateFont/SetFont calls, size presets,
-- and names of built-in font objects the client already has.

WOW_FONTS = {}

-- ===================================
-- FONT FILE PATHS
-- ===================================

WOW_FONTS.PATH = {
    FRIZQT   = "Fonts\\FRIZQT__.TTF",    -- Main UI font (headers, labels, buttons)
    ARIAL    = "Fonts\\ARIALN.TTF",       -- Numbers, stats, compact text
    MORPHEUS = "Fonts\\MORPHEUS.ttf",     -- Quest titles, RP headers
    FRIENDS  = "Fonts\\FRIENDS.TTF",      -- Social/friends list text
    SKURRI   = "Fonts\\skurri.ttf",       -- Damage numbers, combat text
}

-- ===================================
-- FONT SIZE PRESETS
-- ===================================
-- Standard sizes used across the WoW UI

WOW_FONTS.SIZE = {
    TINY  = 9,
    SMALL = 10,
    MED1  = 12,
    MED2  = 13,
    MED3  = 14,
    LARGE = 16,
    HUGE1 = 20,
    HUGE2 = 22,
    HUGE3 = 25,
    HUGE4 = 26,
    WTF   = 62,  -- SystemFont_OutlineThick_WTF (largest built-in)
}

-- ===================================
-- FONT OUTLINE STYLES
-- ===================================

WOW_FONTS.OUTLINE = {
    NONE  = "",
    THIN  = "OUTLINE",
    THICK = "THICKOUTLINE",
    MONO  = "MONOCHROME",
}

-- ===================================
-- BUILT-IN FONT OBJECT NAMES
-- ===================================
-- These font objects exist natively in the 3.3.5 client.
-- Use with FontString:SetFontObject() or as inherits= in CreateFont.

WOW_FONTS.OBJECT = {
    -- Game fonts (FRIZQT) — gold/yellow tinted
    NORMAL       = "GameFontNormal",           -- 12px, gold
    NORMAL_SM    = "GameFontNormalSmall",       -- 10px, gold
    NORMAL_LG    = "GameFontNormalLarge",       -- 16px, gold
    NORMAL_HUGE  = "GameFontNormalHuge",        -- 20px, gold

    -- Highlight fonts — white
    HIGHLIGHT    = "GameFontHighlight",         -- 12px, white
    HIGHLIGHT_SM = "GameFontHighlightSmall",    -- 10px, white
    HIGHLIGHT_LG = "GameFontHighlightLarge",    -- 16px, white

    -- Disabled fonts — gray
    DISABLED     = "GameFontDisable",           -- 12px, gray
    DISABLED_SM  = "GameFontDisableSmall",      -- 10px, gray

    -- Colored fonts
    GREEN        = "GameFontGreen",             -- 12px, green
    GREEN_SM     = "GameFontGreenSmall",        -- 10px, green
    RED          = "GameFontRed",               -- 12px, red
    RED_SM       = "GameFontRedSmall",          -- 10px, red
    WHITE        = "GameFontWhite",             -- 12px, white

    -- Number fonts (ARIALN)
    NUMBER       = "NumberFontNormal",          -- 14px
    NUMBER_SM    = "NumberFontNormalSmall",      -- 12px
    NUMBER_LG    = "NumberFontNormalLarge",      -- 16px
    NUMBER_HUGE  = "NumberFont_OutlineThick_Mono_Small", -- 12px, thick outline

    -- Chat fonts
    CHAT         = "ChatFontNormal",            -- 14px

    -- Tooltip fonts
    TOOLTIP      = "GameTooltipText",           -- 12px
    TOOLTIP_SM   = "GameTooltipTextSmall",      -- 10px
    TOOLTIP_HDR  = "GameTooltipHeaderText",     -- 14px

    -- Quest fonts (MORPHEUS)
    QUEST_LG     = "QuestFont_Large",           -- 15px
    QUEST_HUGE   = "QuestFont_Shadow_Huge",     -- 18px, brown shadow

    -- Special
    MAIL         = "MailFont_Large",            -- 15px, MORPHEUS
}

-- ===================================
-- MODULE REGISTRATION
-- ===================================

if UISTYLE_LIBRARY_MODULES then
    UISTYLE_LIBRARY_MODULES["WowFonts"] = true
end

if UISTYLE_DEBUG then
    print("UIStyleLibrary: WowFonts module loaded")
end
