
local config = {
    debug = false,
    defaultPageSize = 100,
    removeFromWorld = true,
    REQUIRED_GM_LEVEL = 2,
    
    -- Log level constants
    LOG_LEVEL = {
        ERROR = 1,
        WARN = 2,
        INFO = 3,
        DEBUG = 4
    },
    
    -- Database configuration
    database = {
        -- Database names and prefix configuration
        -- This allows the addon to work with different database naming schemes
        -- 
        -- Each entry defines:
        -- - The key (world/char/auth) is used as the database type identifier in the code
        -- - The value is the prefix to prepend to table names (include the dot!)
        -- 
        -- EXAMPLES:
        -- For standard TrinityCore with no prefixes:
        --   world = "", char = "", auth = ""
        -- 
        -- For AzerothCore with database prefixes:
        --   world = "acore_world.", char = "acore_characters.", auth = "acore_auth."
        --
        -- For custom setups with different database names:
        --   world = "myserver_world.", char = "myserver_characters.", auth = "myserver_auth."
        -- 
        -- The prefix will be prepended to all table names in queries
        -- Example: "creature_template" becomes "ac_world.creature_template"
        -- 
        -- IMPORTANT: Include the dot (.) at the end of the prefix!
        prefixes = {
            world = "",  -- World database prefix
            char = "",   -- Character database prefix
            auth = "",   -- Auth database prefix
        },

        -- Optional tables that won't cause errors if missing
        optionalTables = {
            "gameobjectdisplayinfo",
            "spellvisualeffectname",
            "creature_template_model",
            "creature_equip_template",
            "creature_template_addon",
            "gameobject_template_addon",
            "item_enchantment_template",
            "item_loot_template"
        },

        -- Required tables that will show warnings if missing
        requiredTables = {
            "creature_template",
            "gameobject_template",
            "item_template",
            "spell"
        },

        -- Fallback behavior when tables are missing
        fallbackOnMissingTable = true,

        -- Check table existence on startup (recommended)
        checkTablesOnStartup = true,

        -- Cache table existence checks for performance
        cacheTableChecks = true,
    },
}

-- NPC type mappings
local npcTypes = {
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

-- GameObject type mappings
local gameObjectTypes = {
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


-- Merge all configuration into a single table for easier access
local module = {}
for k, v in pairs(config) do
    module[k] = v
end
module.npcTypes = npcTypes
module.gameObjectTypes = gameObjectTypes

return module
