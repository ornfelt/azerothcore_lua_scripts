local AIO = AIO or require("AIO")

if AIO.AddAddon() then
    return
end

-- ===================================
-- UI STYLE LIBRARY TEXTURES MODULE
-- ===================================
-- Central catalog of WoW 3.3.5 texture paths, atlas helpers,
-- and shortcut functions for common texture operations.
-- Loads immediately after Core so all modules can use TEX.* constants.

-- ===================================
-- GLOBAL TEXTURE CATALOG
-- ===================================

TEX = {
    -- Solid / Utility
    WHITE           = "Interface\\Buttons\\WHITE8X8",

    -- Status Bars
    BAR_DEFAULT     = "Interface\\TargetingFrame\\UI-StatusBar",
    BAR_GLASS       = "Interface\\RaidFrame\\Raid-Bar-Hp-Fill",
    BAR_CASTING     = "Interface\\CastingBar\\UI-CastingBar-Flash",
    BAR_SPARK       = "Interface\\CastingBar\\UI-CastingBar-Spark",
    BAR_BG          = "Interface\\Tooltips\\UI-StatusBar-Background",
    BAR_XP          = "Interface\\PaperDollInfoFrame\\UI-Character-Skills-Bar",
    BAR_REP         = "Interface\\ReputationFrame\\UI-ReputationFrame-Bar",

    -- Backgrounds
    BG_ROCK         = "Interface\\FrameGeneral\\UI-Background-Rock",
    BG_TOOLTIP      = "Interface\\Tooltips\\UI-Tooltip-Background",
    BG_DIALOG       = "Interface\\DialogFrame\\UI-DialogBox-Background",
    BG_MARBLE       = "Interface\\FrameGeneral\\UI-Background-Marble",
    BG_PARCHMENT    = "Interface\\AchievementFrame\\UI-Achievement-Parchment",
    BG_QUEST        = "Interface\\QuestFrame\\QuestBG",
    BG_GUILD        = "Interface\\GuildBankFrame\\UI-GuildBankFrame-BackGround",
    BG_CHAR_INFO    = "Interface\\PaperDollInfoFrame\\UI-Character-CharacterTab-L1",
    BG_SPELLBOOK    = "Interface\\SpellBookFrame\\SpellBook-Page-1",

    -- Borders
    BORDER_TOOLTIP  = "Interface\\Tooltips\\UI-Tooltip-Border",
    BORDER_DIALOG   = "Interface\\DialogFrame\\UI-DialogBox-Border",
    BORDER_GOLD     = "Interface\\DialogFrame\\UI-DialogBox-Gold-Border",
    BORDER_ACHIEVE  = "Interface\\AchievementFrame\\UI-Achievement-WoodBorder",

    -- Highlights / Glows
    HIGHLIGHT       = "Interface\\Buttons\\UI-Common-MouseHilight",
    GLOW_OVERLAY    = "Interface\\Buttons\\UI-ActionButton-HoverGlow",
    GLOW_BORDER     = "Interface\\Buttons\\UI-ActionButton-Border",
    HIGHLIGHT_LIST  = "Interface\\QuestFrame\\UI-QuestTitleHighlight",
    HIGHLIGHT_BLUE  = "Interface\\Buttons\\UI-Listbox-Highlight2",
    HIGHLIGHT_CHECK = "Interface\\Buttons\\CheckButtonHilight",

    -- Buttons / Controls
    CLOSE_UP        = "Interface\\Buttons\\UI-Panel-MinimizeButton-Up",
    CLOSE_DOWN      = "Interface\\Buttons\\UI-Panel-MinimizeButton-Down",
    CLOSE_HIGH      = "Interface\\Buttons\\UI-Panel-MinimizeButton-Highlight",
    CHECKBOX        = "Interface\\Buttons\\UI-CheckBox-Check",
    CHECKBOX_DIS    = "Interface\\Buttons\\UI-CheckBox-Check-Disabled",
    RADIO           = "Interface\\Buttons\\UI-RadioButton",

    -- Arrows / Indicators
    SORT_ARROW      = "Interface\\Buttons\\UI-SortArrow",
    ARROW_UP        = "Interface\\Buttons\\Arrow-Up-Up",
    ARROW_DOWN      = "Interface\\Buttons\\Arrow-Down-Up",
    SCROLL_UP       = "Interface\\Buttons\\UI-ScrollBar-ScrollUpButton-Up",
    SCROLL_DOWN     = "Interface\\Buttons\\UI-ScrollBar-ScrollDownButton-Up",
    SCROLL_THUMB    = "Interface\\Buttons\\UI-ScrollBar-Knob",

    -- Lines / Dividers
    LINE_TAXI       = "Interface\\TaxiFrame\\UI-Taxi-Line",

    -- Status Icons
    ONLINE          = "Interface\\FriendsFrame\\StatusIcon-Online",
    OFFLINE         = "Interface\\FriendsFrame\\StatusIcon-Offline",
    AWAY            = "Interface\\FriendsFrame\\StatusIcon-Away",
    DND             = "Interface\\FriendsFrame\\StatusIcon-DnD",
    BROADCAST       = "Interface\\FriendsFrame\\BroadcastIcon",

    -- Chat / Social
    CHAT_BUBBLE     = "Interface\\ChatFrame\\ChatFrameBackground",
    CHAT_BORDER     = "Interface\\ChatFrame\\ChatFrameBorder",

    -- Minimap
    MINIMAP_MASK    = "Interface\\AddOns\\Blizzard_TimeManager\\TimeManagerClockButton",
    MINIMAP_BORDER  = "Interface\\Minimap\\MiniMap-TrackingBorder",
    MINIMAP_SQUARE  = "Interface\\Buttons\\WHITE8X8",

    -- Raid / Group
    RAID_TARGET     = "Interface\\TargetingFrame\\UI-RaidTargetingIcons",
    RAID_BAR        = "Interface\\RaidFrame\\Raid-Bar-Hp-Fill",
    READY_CHECK_OK  = "Interface\\RaidFrame\\ReadyCheck-Ready",
    READY_CHECK_NO  = "Interface\\RaidFrame\\ReadyCheck-NotReady",
    READY_CHECK_QUE = "Interface\\RaidFrame\\ReadyCheck-Waiting",

    -- PvP
    PVP_ALLIANCE    = "Interface\\PVPFrame\\PVP-Currency-Alliance",
    PVP_HORDE       = "Interface\\PVPFrame\\PVP-Currency-Horde",
    PVP_BANNER_A    = "Interface\\PVPFrame\\Icons\\PVP-Banner-Emblem-2",
    PVP_BANNER_H    = "Interface\\PVPFrame\\Icons\\PVP-Banner-Emblem-1",

    -- Casting
    CAST_BAR_FILL   = "Interface\\CastingBar\\UI-CastingBar-Flash",
    CAST_BAR_BORDER = "Interface\\CastingBar\\UI-CastingBar-Border",
    CAST_BAR_SHIELD = "Interface\\CastingBar\\UI-CastingBar-Small-Shield",

    -- Portraits / Character
    PORTRAIT_RING   = "Interface\\TargetingFrame\\UI-TargetingFrame-Portrait",
    PORTRAIT_MASK   = "Interface\\CharacterFrame\\TempPortrait",

    -- Talent / Glyph
    TALENT_BG       = "Interface\\TalentFrame\\TalentFrame-TopLeft",
    GLYPH_SLOT      = "Interface\\SpellBook\\UI-GlyphFrame-Glyph",

    -- Miscellaneous
    STAR            = "Interface\\TARGETINGFRAME\\UI-RaidTargetingIcon_1",
    CIRCLE          = "Interface\\TARGETINGFRAME\\UI-RaidTargetingIcon_2",
    DIAMOND         = "Interface\\TARGETINGFRAME\\UI-RaidTargetingIcon_3",
    SKULL           = "Interface\\TARGETINGFRAME\\UI-RaidTargetingIcon_8",
    SHIELD          = "Interface\\GossipFrame\\AvailableQuestIcon",
    EXCLAMATION     = "Interface\\GossipFrame\\ActiveQuestIcon",
    COIN_GOLD       = "Interface\\MoneyFrame\\UI-GoldIcon",
    COIN_SILVER     = "Interface\\MoneyFrame\\UI-SilverIcon",
    COIN_COPPER     = "Interface\\MoneyFrame\\UI-CopperIcon",
    MAIL            = "Interface\\Icons\\INV_Letter_15",
    LOCK            = "Interface\\PetBattles\\PetBattle-LockIcon",
}

-- ===================================
-- TEXCOORD PRESETS
-- ===================================

TEXCOORD = {
    ICON_TRIM   = { 0.08, 0.92, 0.08, 0.92 },
    FULL        = { 0, 1, 0, 1 },
    FLIP_V      = { 0, 1, 1, 0 },
    FLIP_H      = { 1, 0, 0, 1 },
    TIGHT_TRIM  = { 0.1, 0.9, 0.1, 0.9 },
}

-- ===================================
-- ATLAS / TEXCOORD HELPERS
-- ===================================

--- Extract UV coordinates for a sub-region from a texture grid.
--- @param row number 1-based row index
--- @param col number 1-based column index
--- @param rows number total rows in the grid
--- @param cols number total columns in the grid
--- @return number, number, number, number left, right, top, bottom
function AtlasCoords(row, col, rows, cols)
    local w, h = 1 / cols, 1 / rows
    return (col - 1) * w, col * w, (row - 1) * h, row * h
end

--- Set texture path and atlas coordinates in one call.
--- @param texture userdata WoW texture object
--- @param path string texture file path
--- @param row number 1-based row
--- @param col number 1-based column
--- @param rows number total rows
--- @param cols number total columns
function SetTextureAtlas(texture, path, row, col, rows, cols)
    texture:SetTexture(path)
    texture:SetTexCoord(AtlasCoords(row, col, rows, cols))
end

-- ===================================
-- QUICK TEXTURE CREATION
-- ===================================

--- Create a solid colored rectangle texture.
--- @param parent userdata parent frame
--- @param r number red (0-1)
--- @param g number green (0-1)
--- @param b number blue (0-1)
--- @param a number alpha (0-1, default 1)
--- @param layer string draw layer (default "BACKGROUND")
--- @return userdata texture
function CreateColorTexture(parent, r, g, b, a, layer)
    local t = parent:CreateTexture(nil, layer or "BACKGROUND")
    t:SetTexture(TEX.WHITE)
    t:SetVertexColor(r, g, b, a or 1)
    return t
end

--- Create a horizontal or vertical line divider.
--- @param parent userdata parent frame
--- @param thickness number line thickness in pixels (default 1)
--- @param r number red (0-1)
--- @param g number green (0-1)
--- @param b number blue (0-1)
--- @param horizontal boolean true for horizontal, false for vertical
--- @return userdata texture
function CreateLine(parent, thickness, r, g, b, horizontal)
    local line = CreateColorTexture(parent, r, g, b, 1, "ARTWORK")
    if horizontal then
        line:SetHeight(thickness or 1)
    else
        line:SetWidth(thickness or 1)
    end
    return line
end

--- Apply a backdrop to a frame with less boilerplate.
--- @param frame userdata frame with SetBackdrop support
--- @param bg string background texture path (default TEX.WHITE)
--- @param edge string edge texture path (default TEX.WHITE)
--- @param edgeSize number edge thickness (default 1)
--- @param inset number inset distance (default edgeSize)
function QuickBackdrop(frame, bg, edge, edgeSize, inset)
    inset = inset or edgeSize or 1
    frame:SetBackdrop({
        bgFile = bg or TEX.WHITE,
        edgeFile = edge or TEX.WHITE,
        tile = false,
        edgeSize = edgeSize or 1,
        insets = { left = inset, right = inset, top = inset, bottom = inset },
    })
end

-- ===================================
-- MODULE REGISTRATION
-- ===================================

if UISTYLE_LIBRARY_MODULES then
    UISTYLE_LIBRARY_MODULES["Textures"] = true
end

if UISTYLE_DEBUG then
    print("UIStyleLibrary: Textures module loaded")
end
