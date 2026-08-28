local AIO = AIO or require("AIO")

if AIO.AddAddon() then
    return
end

-- ===================================
-- WOW 3.3.5 TEXTURE ATLAS SYSTEM
-- ===================================
-- WoW 3.3.5 has no built-in atlas API (SetAtlas was added in 6.0.2).
-- This module provides named coordinate lookups for common atlas textures
-- and helpers to compute grid-based coords on the fly.
--
-- Usage:
--   WOW_ATLAS.Apply(myTexture, WOW_ATLAS.RAID_TARGETS, "SKULL")
--   local coords = WOW_ATLAS.GridCoords(4, 4, 2, 3)

WOW_ATLAS = {}

-- ===================================
-- HELPER FUNCTIONS
-- ===================================

--- Apply an atlas sub-region to a texture in one call.
--- @param tex userdata WoW texture object
--- @param atlas table WOW_ATLAS entry with .texture and .coords
--- @param name string sub-region key (e.g. "STAR", "SKULL")
function WOW_ATLAS.Apply(tex, atlas, name)
    local coords = atlas.coords and atlas.coords[name]
    if not coords then return false end
    tex:SetTexture(atlas.texture)
    tex:SetTexCoord(coords[1], coords[2], coords[3], coords[4])
    return true
end

--- Compute texcoords for a grid cell (1-based row/col).
--- Works with any evenly-spaced grid texture sheet.
--- @param cols number total columns in grid
--- @param rows number total rows in grid
--- @param col number 1-based column (left to right)
--- @param row number 1-based row (top to bottom)
--- @return table {left, right, top, bottom}
function WOW_ATLAS.GridCoords(cols, rows, col, row)
    local w, h = 1 / cols, 1 / rows
    return { (col - 1) * w, col * w, (row - 1) * h, row * h }
end

--- Apply grid coords to a texture in one call.
--- @param tex userdata WoW texture object
--- @param texturePath string Interface path
--- @param cols number total columns
--- @param rows number total rows
--- @param col number 1-based column
--- @param row number 1-based row
function WOW_ATLAS.ApplyGrid(tex, texturePath, cols, rows, col, row)
    local c = WOW_ATLAS.GridCoords(cols, rows, col, row)
    tex:SetTexture(texturePath)
    tex:SetTexCoord(c[1], c[2], c[3], c[4])
end

-- ===================================
-- RAID TARGET ICONS (4x2 grid)
-- ===================================
-- Texture: Interface\TargetingFrame\UI-RaidTargetingIcons
-- 8 icons used for target marking in raids/groups

WOW_ATLAS.RAID_TARGETS = {
    texture = "Interface\\TargetingFrame\\UI-RaidTargetingIcons",
    coords = {
        STAR     = { 0,    0.25, 0,    0.25 },
        CIRCLE   = { 0.25, 0.5,  0,    0.25 },
        DIAMOND  = { 0.5,  0.75, 0,    0.25 },
        TRIANGLE = { 0.75, 1,    0,    0.25 },
        MOON     = { 0,    0.25, 0.25, 0.5 },
        SQUARE   = { 0.25, 0.5,  0.25, 0.5 },
        CROSS    = { 0.5,  0.75, 0.25, 0.5 },
        SKULL    = { 0.75, 1,    0.25, 0.5 },
    },
    -- Indexed by raid target ID (1-8, matches GetRaidTargetIndex)
    byIndex = {},
}

-- Build numeric index
local targetOrder = { "STAR", "CIRCLE", "DIAMOND", "TRIANGLE", "MOON", "SQUARE", "CROSS", "SKULL" }
for i, name in ipairs(targetOrder) do
    WOW_ATLAS.RAID_TARGETS.byIndex[i] = WOW_ATLAS.RAID_TARGETS.coords[name]
end

-- ===================================
-- CLASS ICONS (reference to WOW_CLASS_ICONS)
-- ===================================
-- Already defined in 05_WowBackdrops.lua, linked here for unified access

if WOW_CLASS_ICONS then
    WOW_ATLAS.CLASS_ICONS = WOW_CLASS_ICONS
end

-- ===================================
-- LFG ROLE ICONS (4x1 grid)
-- ===================================
-- Texture: Interface\LFGFrame\UI-LFG-ICON-ROLES
-- Tank, Healer, DPS, Guide icons in a horizontal strip

WOW_ATLAS.LFG_ROLES = {
    texture = "Interface\\LFGFrame\\UI-LFG-ICON-ROLES",
    coords = {
        TANK   = { 0,    0.25, 0, 1 },
        HEALER = { 0.25, 0.5,  0, 1 },
        DPS    = { 0.5,  0.75, 0, 1 },
        GUIDE  = { 0.75, 1,    0, 1 },
    },
}

-- ===================================
-- BATTLEFIELD ICONS (2x2 grid)
-- ===================================
-- Texture: Interface\BattlefieldFrame\Battleground-Alliance (and -Horde)

WOW_ATLAS.CURRENCY_ICONS = {
    texture = "Interface\\Icons\\PVPCurrency-Honor-%s",
    ALLIANCE = "Interface\\PVPFrame\\PVP-Currency-Alliance",
    HORDE    = "Interface\\PVPFrame\\PVP-Currency-Horde",
}

-- ===================================
-- READY CHECK ICONS (individual textures)
-- ===================================
-- Not an atlas, but commonly needed together

WOW_ATLAS.READY_CHECK = {
    READY   = "Interface\\RaidFrame\\ReadyCheck-Ready",
    NOTREADY = "Interface\\RaidFrame\\ReadyCheck-NotReady",
    WAITING = "Interface\\RaidFrame\\ReadyCheck-Waiting",
}

-- ===================================
-- COIN/MONEY ICONS (individual textures)
-- ===================================

WOW_ATLAS.COINS = {
    GOLD   = "Interface\\MoneyFrame\\UI-GoldIcon",
    SILVER = "Interface\\MoneyFrame\\UI-SilverIcon",
    COPPER = "Interface\\MoneyFrame\\UI-CopperIcon",
}

-- ===================================
-- GOSSIP/QUEST ICONS (individual textures)
-- ===================================

WOW_ATLAS.GOSSIP = {
    AVAILABLE  = "Interface\\GossipFrame\\AvailableQuestIcon",
    ACTIVE     = "Interface\\GossipFrame\\ActiveQuestIcon",
    TRAINER    = "Interface\\GossipFrame\\TrainerGossipIcon",
    VENDOR     = "Interface\\GossipFrame\\VendorGossipIcon",
    TAXI       = "Interface\\GossipFrame\\TaxiGossipIcon",
    BANKER     = "Interface\\GossipFrame\\BankerGossipIcon",
    PETITION   = "Interface\\GossipFrame\\PetitionGossipIcon",
    TABARD     = "Interface\\GossipFrame\\TabardGossipIcon",
    BATTLE     = "Interface\\GossipFrame\\BattleMasterGossipIcon",
    GOSSIP     = "Interface\\GossipFrame\\GossipGossipIcon",
    BIND       = "Interface\\GossipFrame\\BinderGossipIcon",
}

-- ===================================
-- STATUS ICONS (individual textures)
-- ===================================

WOW_ATLAS.STATUS = {
    ONLINE    = "Interface\\FriendsFrame\\StatusIcon-Online",
    OFFLINE   = "Interface\\FriendsFrame\\StatusIcon-Offline",
    AWAY      = "Interface\\FriendsFrame\\StatusIcon-Away",
    DND       = "Interface\\FriendsFrame\\StatusIcon-DnD",
}

-- ===================================
-- MODULE REGISTRATION
-- ===================================

if UISTYLE_LIBRARY_MODULES then
    UISTYLE_LIBRARY_MODULES["WowAtlas"] = true
end

if UISTYLE_DEBUG then
    print("UIStyleLibrary: WowAtlas module loaded")
end
