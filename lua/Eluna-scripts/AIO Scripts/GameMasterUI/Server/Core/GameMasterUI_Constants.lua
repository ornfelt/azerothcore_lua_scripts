--[[
    GameMasterUI Constants Module

    Contains WoW 3.3.5 game constants that should not be modified by users.
    These are reference data from the game's database structures.
]]--

local Constants = {}

-- =====================================================
-- Database Type Mappings
-- =====================================================

-- Maps internal database type identifiers to config keys
-- Internal code uses "char" (matching Eluna's CharDBQuery API)
-- Config uses "characters" (clearer for users)
Constants.DATABASE_TYPE_TO_CONFIG = {
    world = "world",
    char = "characters",  -- Maps "char" to config key "characters"
    auth = "auth"
}

-- Valid database types for internal use
Constants.VALID_DATABASE_TYPES = {
    world = true,
    char = true,
    auth = true
}

-- =====================================================
-- NPC Type Mappings (creature_template.type)
-- =====================================================

-- Maps NPC type names to their numeric IDs in the database
-- Source: creature_template.type field (WoW 3.3.5)
-- Used for filtering NPCs by type in search queries
Constants.NPC_TYPES = {
    ["none"] = 0,
    ["beast"] = 1,
    ["dragonkin"] = 2,
    ["demon"] = 3,
    ["elemental"] = 4,
    ["giant"] = 5,
    ["undead"] = 6,
    ["humanoid"] = 7,
    ["critter"] = 8,
    ["mechanical"] = 9,
    ["not specified"] = 10,
    ["totem"] = 11,
    ["non-combat pet"] = 12,
    ["gas cloud"] = 13,
    ["wild pet"] = 14,
    ["aberration"] = 15,
}

-- =====================================================
-- GameObject Type Mappings (gameobject_template.type)
-- =====================================================

-- Maps GameObject type names to their numeric IDs in the database
-- Source: gameobject_template.type field (WoW 3.3.5)
-- Used for filtering GameObjects by type in search queries
Constants.GAMEOBJECT_TYPES = {
    ["door"] = 0,
    ["button"] = 1,
    ["questgiver"] = 2,
    ["chest"] = 3,
    ["binder"] = 4,
    ["generic"] = 5,
    ["trap"] = 6,
    ["chair"] = 7,
    ["spell focus"] = 8,
    ["text"] = 9,
    ["goober"] = 10,
    ["transport"] = 11,
    ["areadamage"] = 12,
    ["camera"] = 13,
    ["map object"] = 14,
    ["mo transport"] = 15,
    ["duel arbiter"] = 16,
    ["fishingnode"] = 17,
    ["summoning ritual"] = 18,
    ["mailbox"] = 19,
    ["do not use"] = 20,
    ["guardpost"] = 21,
    ["spellcaster"] = 22,
    ["meetingstone"] = 23,
    ["flagstand"] = 24,
    ["fishinghole"] = 25,
    ["flagdrop"] = 26,
    ["mini game"] = 27,
    ["do not use 2"] = 28,
    ["capture point"] = 29,
    ["aura generator"] = 30,
    ["dungeon difficulty"] = 31,
    ["barber chair"] = 32,
    ["destructible_building"] = 33,
    ["guild bank"] = 34,
    ["trapdoor"] = 35,
}

-- =====================================================
-- Utility Functions
-- =====================================================

-- Validate if a database type is valid
function Constants.IsValidDatabaseType(databaseType)
    return Constants.VALID_DATABASE_TYPES[databaseType] == true
end

-- Convert internal database type to config key
function Constants.GetConfigKey(databaseType)
    return Constants.DATABASE_TYPE_TO_CONFIG[databaseType] or databaseType
end

return Constants
