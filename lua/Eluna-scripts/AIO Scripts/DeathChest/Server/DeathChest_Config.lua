-- DeathChest_Config.lua
-- All configuration constants for the Death Chest system

local Config = {}

-- Creature settings
Config.OBJECT_ENTRY = 244606           -- GameObject entry (Iron Chest Template, type 3)
Config.DESPAWN_TIME = 300              -- Seconds before chest disappears (5 min)

-- What to drop on death
Config.DROP_EQUIPPED = true            -- Drop equipped gear (slots 0-18)
Config.DROP_BAG_ITEMS = true           -- Drop items in bags
Config.DROP_GOLD = true                -- Drop gold
Config.GOLD_PERCENT = 100              -- Percentage of gold to drop (0-100)

-- Drop mode: "ALL" = drop everything, "RANDOM" = each item has a chance
Config.DROP_MODE = "ALL"
Config.RANDOM_DROP_PERCENT = 50        -- Per-item drop chance when mode = "RANDOM"

-- Filters
Config.MIN_ITEM_QUALITY = 0            -- 0=Poor, 1=Common, 2=Uncommon, 3=Rare, 4=Epic
Config.BLACKLISTED_ITEMS = {
    [6948] = true,                     -- Hearthstone
}

-- Access control
Config.ANYONE_CAN_LOOT = false         -- true = PvP style, anyone can take items

-- Behavior
Config.MAX_CHESTS_PER_PLAYER = 1       -- Old chests cleaned up when player dies again
Config.ANNOUNCE_DEATH = true           -- Broadcast message to player on death
Config.INTERACTION_DISTANCE = 15      -- Yards; UI auto-closes beyond this

-- Equipment slot range
Config.EQUIP_SLOT_MIN = 0
Config.EQUIP_SLOT_MAX = 18

-- Backpack slot range (bag 255)
Config.BACKPACK_SLOT_MIN = 23
Config.BACKPACK_SLOT_MAX = 38

-- Equipped bag range
Config.BAG_SLOT_MIN = 19
Config.BAG_SLOT_MAX = 22

-- DB
Config.DB_NAME = "characters"
Config.TABLE_NAME = "custom_death_chest"

-- Make config globally accessible for this addon
DeathChestConfig = Config
return Config
