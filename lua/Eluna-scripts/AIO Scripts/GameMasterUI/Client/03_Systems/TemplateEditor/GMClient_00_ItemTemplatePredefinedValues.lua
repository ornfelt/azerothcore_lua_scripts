local AIO = AIO or require("AIO")

if AIO.AddAddon() then
    return -- Exit if on server
end

-- Initialize namespace for predefined values
_G.ItemTemplatePredefinedValues = _G.ItemTemplatePredefinedValues or {}
local ItemTemplatePredefinedValues = _G.ItemTemplatePredefinedValues

-- ====================
-- CORE ENUMERATIONS
-- ====================

-- Item Classes (already exists in GMClient_07_ItemTemplateFieldDefs.lua but included for completeness)
ItemTemplatePredefinedValues.ITEM_CLASSES = {
    {value = 0, text = "Consumable"},
    {value = 1, text = "Container"},
    {value = 2, text = "Weapon"},
    {value = 3, text = "Gem"},
    {value = 4, text = "Armor"},
    {value = 5, text = "Reagent"},
    {value = 6, text = "Projectile"},
    {value = 7, text = "Trade Goods"},
    {value = 8, text = "Generic (OBSOLETE)"},
    {value = 9, text = "Recipe"},
    {value = 10, text = "Money (OBSOLETE)"},
    {value = 11, text = "Quiver"},
    {value = 12, text = "Quest"},
    {value = 13, text = "Key"},
    {value = 14, text = "Permanent (OBSOLETE)"},
    {value = 15, text = "Miscellaneous"},
    {value = 16, text = "Glyph"}
}

-- Context-dependent subclass values based on item class
ItemTemplatePredefinedValues.ITEM_SUBCLASSES = {
    -- Class 0: Consumable
    [0] = {
        {value = 0, text = "Consumable"},
        {value = 1, text = "Potion"},
        {value = 2, text = "Elixir"},
        {value = 3, text = "Flask"},
        {value = 4, text = "Scroll"},
        {value = 5, text = "Food & Drink"},
        {value = 6, text = "Item Enhancement (Permanent)"},
        {value = 7, text = "Bandage"},
        {value = 8, text = "Other"}
    },
    -- Class 1: Container
    [1] = {
        {value = 0, text = "Bag"},
        {value = 1, text = "Soul Bag"},
        {value = 2, text = "Herb Bag"},
        {value = 3, text = "Enchanting Bag"},
        {value = 4, text = "Engineering Bag"},
        {value = 5, text = "Gem Bag"},
        {value = 6, text = "Mining Bag"},
        {value = 7, text = "Leatherworking Bag"},
        {value = 8, text = "Inscription Bag"}
    },
    -- Class 2: Weapon
    [2] = {
        {value = 0, text = "One-Handed Axes"},
        {value = 1, text = "Two-Handed Axes"},
        {value = 2, text = "Bows"},
        {value = 3, text = "Guns"},
        {value = 4, text = "One-Handed Maces"},
        {value = 5, text = "Two-Handed Maces"},
        {value = 6, text = "Polearms"},
        {value = 7, text = "One-Handed Swords"},
        {value = 8, text = "Two-Handed Swords"},
        {value = 9, text = "Obsolete"},
        {value = 10, text = "Staves"},
        {value = 11, text = "One-Handed Exotics"},
        {value = 12, text = "Two-Handed Exotics"},
        {value = 13, text = "Fist Weapons"},
        {value = 14, text = "Miscellaneous"},
        {value = 15, text = "Daggers"},
        {value = 16, text = "Thrown"},
        {value = 17, text = "Spears"},
        {value = 18, text = "Crossbows"},
        {value = 19, text = "Wands"},
        {value = 20, text = "Fishing Poles"}
    },
    -- Class 3: Gem
    [3] = {
        {value = 0, text = "Red"},
        {value = 1, text = "Blue"},
        {value = 2, text = "Yellow"},
        {value = 3, text = "Purple"},
        {value = 4, text = "Green"},
        {value = 5, text = "Orange"},
        {value = 6, text = "Meta"},
        {value = 7, text = "Simple"},
        {value = 8, text = "Prismatic"}
    },
    -- Class 4: Armor
    [4] = {
        {value = 0, text = "Miscellaneous"},
        {value = 1, text = "Cloth"},
        {value = 2, text = "Leather"},
        {value = 3, text = "Mail"},
        {value = 4, text = "Plate"},
        {value = 5, text = "Cosmetic"},
        {value = 6, text = "Shield"},
        {value = 7, text = "Libram"},
        {value = 8, text = "Idol"},
        {value = 9, text = "Totem"},
        {value = 10, text = "Sigil"}
    },
    -- Class 5: Reagent
    [5] = {
        {value = 0, text = "Reagent"}
    },
    -- Class 6: Projectile
    [6] = {
        {value = 2, text = "Arrow"},
        {value = 3, text = "Bullet"}
    },
    -- Class 7: Trade Goods
    [7] = {
        {value = 0, text = "Trade Goods"},
        {value = 1, text = "Parts"},
        {value = 2, text = "Explosives"},
        {value = 3, text = "Devices"},
        {value = 4, text = "Jewelcrafting"},
        {value = 5, text = "Cloth"},
        {value = 6, text = "Leather"},
        {value = 7, text = "Metal & Stone"},
        {value = 8, text = "Meat"},
        {value = 9, text = "Herb"},
        {value = 10, text = "Elemental"},
        {value = 11, text = "Other"},
        {value = 12, text = "Enchanting"},
        {value = 13, text = "Materials"},
        {value = 14, text = "Armor Enchantment"},
        {value = 15, text = "Weapon Enchantment"}
    },
    -- Class 8: Generic (OBSOLETE)
    [8] = {
        {value = 0, text = "Generic (OBSOLETE)"}
    },
    -- Class 9: Recipe
    [9] = {
        {value = 0, text = "Book"},
        {value = 1, text = "Leatherworking"},
        {value = 2, text = "Tailoring"},
        {value = 3, text = "Engineering"},
        {value = 4, text = "Blacksmithing"},
        {value = 5, text = "Cooking"},
        {value = 6, text = "Alchemy"},
        {value = 7, text = "First Aid"},
        {value = 8, text = "Enchanting"},
        {value = 9, text = "Fishing"},
        {value = 10, text = "Jewelcrafting"},
        {value = 11, text = "Inscription"}
    },
    -- Class 10: Money (OBSOLETE)
    [10] = {
        {value = 0, text = "Money (OBSOLETE)"}
    },
    -- Class 11: Quiver
    [11] = {
        {value = 0, text = "Quiver (OBSOLETE)"},
        {value = 1, text = "Bolt (OBSOLETE)"},
        {value = 2, text = "Quiver"},
        {value = 3, text = "Ammo Pouch"}
    },
    -- Class 12: Quest
    [12] = {
        {value = 0, text = "Quest"}
    },
    -- Class 13: Key
    [13] = {
        {value = 0, text = "Key"},
        {value = 1, text = "Lockpick"}
    },
    -- Class 14: Permanent (OBSOLETE)
    [14] = {
        {value = 0, text = "Permanent (OBSOLETE)"}
    },
    -- Class 15: Miscellaneous
    [15] = {
        {value = 0, text = "Junk"},
        {value = 1, text = "Reagent"},
        {value = 2, text = "Pet"},
        {value = 3, text = "Holiday"},
        {value = 4, text = "Other"},
        {value = 5, text = "Mount"}
    },
    -- Class 16: Glyph
    [16] = {
        {value = 1, text = "Warrior"},
        {value = 2, text = "Paladin"},
        {value = 3, text = "Hunter"},
        {value = 4, text = "Rogue"},
        {value = 5, text = "Priest"},
        {value = 6, text = "Death Knight"},
        {value = 7, text = "Shaman"},
        {value = 8, text = "Mage"},
        {value = 9, text = "Warlock"},
        {value = 11, text = "Druid"}
    }
}

-- Item Qualities (already exists but included for completeness)
ItemTemplatePredefinedValues.ITEM_QUALITIES = {
    {value = 0, text = "Poor (Gray)"},
    {value = 1, text = "Common (White)"},
    {value = 2, text = "Uncommon (Green)"},
    {value = 3, text = "Rare (Blue)"},
    {value = 4, text = "Epic (Purple)"},
    {value = 5, text = "Legendary (Orange)"},
    {value = 6, text = "Artifact (Light Yellow)"},
    {value = 7, text = "Heirloom (Light Yellow)"}
}

-- Inventory Types (already exists but included for completeness)
ItemTemplatePredefinedValues.INVENTORY_TYPES = {
    {value = 0, text = "Non-equipable"},
    {value = 1, text = "Head"},
    {value = 2, text = "Neck"},
    {value = 3, text = "Shoulder"},
    {value = 4, text = "Body"},
    {value = 5, text = "Chest"},
    {value = 6, text = "Waist"},
    {value = 7, text = "Legs"},
    {value = 8, text = "Feet"},
    {value = 9, text = "Wrists"},
    {value = 10, text = "Hands"},
    {value = 11, text = "Finger"},
    {value = 12, text = "Trinket"},
    {value = 13, text = "One-Hand"},
    {value = 14, text = "Shield"},
    {value = 15, text = "Ranged (Right)"},
    {value = 16, text = "Back"},
    {value = 17, text = "Two-Hand"},
    {value = 18, text = "Bag"},
    {value = 19, text = "Tabard"},
    {value = 20, text = "Robe"},
    {value = 21, text = "Main Hand"},
    {value = 22, text = "Off Hand"},
    {value = 23, text = "Holdable (Tome)"},
    {value = 24, text = "Ammo"},
    {value = 25, text = "Thrown"},
    {value = 26, text = "Ranged (Right)"},
    {value = 28, text = "Relic"}
}

-- Bonding Types (already exists but included for completeness)
ItemTemplatePredefinedValues.BONDING_TYPES = {
    {value = 0, text = "No bounds"},
    {value = 1, text = "Binds when picked up"},
    {value = 2, text = "Binds when equipped"},
    {value = 3, text = "Binds when used"},
    {value = 4, text = "Quest item"},
    {value = 5, text = "Quest item (Party loot)"}
}

-- ====================
-- STAT TYPES (ItemModType)
-- ====================

-- Complete list of stat types based on TrinityCore 3.3.5 ItemModType enum
ItemTemplatePredefinedValues.STAT_TYPES = {
    {value = 0, text = "Mana"},
    {value = 1, text = "Health"},
    {value = 3, text = "Agility"},
    {value = 4, text = "Strength"},
    {value = 5, text = "Intellect"},
    {value = 6, text = "Spirit"},
    {value = 7, text = "Stamina"},
    {value = 12, text = "Defense Skill Rating"},
    {value = 13, text = "Dodge Rating"},
    {value = 14, text = "Parry Rating"},
    {value = 15, text = "Block Rating"},
    {value = 16, text = "Hit Melee Rating"},
    {value = 17, text = "Hit Ranged Rating"},
    {value = 18, text = "Hit Spell Rating"},
    {value = 19, text = "Crit Melee Rating"},
    {value = 20, text = "Crit Ranged Rating"},
    {value = 21, text = "Crit Spell Rating"},
    {value = 22, text = "Hit Taken Melee Rating"},
    {value = 23, text = "Hit Taken Ranged Rating"},
    {value = 24, text = "Hit Taken Spell Rating"},
    {value = 25, text = "Crit Taken Melee Rating"},
    {value = 26, text = "Crit Taken Ranged Rating"},
    {value = 27, text = "Crit Taken Spell Rating"},
    {value = 28, text = "Haste Melee Rating"},
    {value = 29, text = "Haste Ranged Rating"},
    {value = 30, text = "Haste Spell Rating"},
    {value = 31, text = "Hit Rating"},
    {value = 32, text = "Crit Rating"},
    {value = 33, text = "Hit Taken Rating"},
    {value = 34, text = "Crit Taken Rating"},
    {value = 35, text = "Resilience Rating"},
    {value = 36, text = "Haste Rating"},
    {value = 37, text = "Expertise Rating"},
    {value = 38, text = "Attack Power"},
    {value = 39, text = "Ranged Attack Power"},
    {value = 40, text = "Feral Attack Power (Obsolete)"},
    {value = 41, text = "Spell Healing Done (Obsolete)"},
    {value = 42, text = "Spell Damage Done (Obsolete)"},
    {value = 43, text = "Mana Regeneration"},
    {value = 44, text = "Armor Penetration Rating"},
    {value = 45, text = "Spell Power"},
    {value = 46, text = "Health Regen"},
    {value = 47, text = "Spell Penetration"},
    {value = 48, text = "Block Value"}
}

-- ====================
-- SPELL TRIGGER TYPES
-- ====================

-- Spell trigger types for item spells
ItemTemplatePredefinedValues.SPELL_TRIGGERS = {
    {value = 0, text = "On Use"},
    {value = 1, text = "On Equip"},
    {value = 2, text = "Chance on Hit"},
    {value = 3, text = "Soulstone"},
    {value = 4, text = "On Use (No Delay)"},
    {value = 5, text = "Learn Spell ID"},
    {value = 6, text = "On Loot"}
}

-- ====================
-- MATERIAL TYPES
-- ====================

-- Material types for items (affects break sounds, etc)
ItemTemplatePredefinedValues.MATERIAL_TYPES = {
    {value = -1, text = "Consumables"},
    {value = 0, text = "Not Defined"},
    {value = 1, text = "Metal"},
    {value = 2, text = "Wood"},
    {value = 3, text = "Liquid"},
    {value = 4, text = "Jewelry"},
    {value = 5, text = "Chain"},
    {value = 6, text = "Plate"},
    {value = 7, text = "Cloth"},
    {value = 8, text = "Leather"}
}

-- ====================
-- SHEATH TYPES
-- ====================

-- How weapons are sheathed on character
ItemTemplatePredefinedValues.SHEATH_TYPES = {
    {value = 0, text = "None"},
    {value = 1, text = "Two Handed"},
    {value = 2, text = "Staff"},
    {value = 3, text = "One Handed"},
    {value = 4, text = "Shield"},
    {value = 5, text = "Enchanter's Rod"},
    {value = 6, text = "Off Hand"},
    {value = 7, text = "Fist Weapon"}
}

-- ====================
-- DAMAGE TYPES
-- ====================

-- Damage school types (already exists but included for completeness)
ItemTemplatePredefinedValues.DAMAGE_TYPES = {
    {value = 0, text = "Physical"},
    {value = 1, text = "Holy"},
    {value = 2, text = "Fire"},
    {value = 3, text = "Nature"},
    {value = 4, text = "Frost"},
    {value = 5, text = "Shadow"},
    {value = 6, text = "Arcane"}
}

-- ====================
-- BAG FAMILY (Bit Flags)
-- ====================

-- What items can be stored in bags (bit flags)
ItemTemplatePredefinedValues.BAG_FAMILY = {
    {value = 0, text = "None (Generic Bag)"},
    {value = 1, text = "Arrows"},
    {value = 2, text = "Bullets"},
    {value = 4, text = "Soul Shards"},
    {value = 8, text = "Leatherworking Supplies"},
    {value = 16, text = "Inscription Supplies"},
    {value = 32, text = "Herbs"},
    {value = 64, text = "Enchanting Supplies"},
    {value = 128, text = "Engineering Supplies"},
    {value = 256, text = "Keys"},
    {value = 512, text = "Gems"},
    {value = 1024, text = "Mining Supplies"},
    {value = 2048, text = "Soulbound Equipment"},
    {value = 4096, text = "Vanity Pets"},
    {value = 8192, text = "Currency Tokens"},
    {value = 16384, text = "Quest Items"}
}

-- ====================
-- SOCKET COLORS
-- ====================

-- Gem socket colors
ItemTemplatePredefinedValues.SOCKET_COLORS = {
    {value = 0, text = "None"},
    {value = 1, text = "Meta"},
    {value = 2, text = "Red"},
    {value = 4, text = "Yellow"},
    {value = 8, text = "Blue"}
}

-- ====================
-- TOTEM CATEGORIES
-- ====================

-- Totem categories for shaman totems
ItemTemplatePredefinedValues.TOTEM_CATEGORIES = {
    {value = 0, text = "None"},
    {value = 1, text = "Skinning Knife (OLD)"},
    {value = 2, text = "Earth Totem"},
    {value = 3, text = "Air Totem"},
    {value = 4, text = "Fire Totem"},
    {value = 5, text = "Water Totem"},
    {value = 6, text = "Runed Copper Rod"},
    {value = 7, text = "Runed Silver Rod"},
    {value = 8, text = "Runed Golden Rod"},
    {value = 9, text = "Runed Truesilver Rod"},
    {value = 10, text = "Runed Arcanite Rod"},
    {value = 11, text = "Mining Pick (OLD)"},
    {value = 12, text = "Philosopher's Stone"},
    {value = 13, text = "Blacksmith Hammer (OLD)"},
    {value = 14, text = "Arclight Spanner"},
    {value = 15, text = "Gyromatic Micro-Adjustor"},
    {value = 21, text = "Master Totem"},
    {value = 41, text = "Runed Fel Iron Rod"},
    {value = 62, text = "Runed Adamantite Rod"},
    {value = 63, text = "Runed Eternium Rod"},
    {value = 81, text = "Hollow Quill"},
    {value = 101, text = "Runed Azurite Rod"},
    {value = 121, text = "Virtuoso Inking Set"},
    {value = 141, text = "Drums"},
    {value = 161, text = "Gnomish Army Knife"},
    {value = 162, text = "Blacksmith Hammer"},
    {value = 165, text = "Mining Pick"},
    {value = 166, text = "Skinning Knife"},
    {value = 167, text = "Hammer Pick"},
    {value = 168, text = "Bladed Pickaxe"},
    {value = 169, text = "Flint and Tinder"},
    {value = 189, text = "Runed Cobalt Rod"},
    {value = 190, text = "Runed Titanium Rod"}
}

-- ====================
-- FOOD TYPES
-- ====================

-- Pet food types
ItemTemplatePredefinedValues.FOOD_TYPES = {
    {value = 0, text = "None"},
    {value = 1, text = "Meat"},
    {value = 2, text = "Fish"},
    {value = 3, text = "Cheese"},
    {value = 4, text = "Bread"},
    {value = 5, text = "Fungus"},
    {value = 6, text = "Fruit"},
    {value = 7, text = "Raw Meat"},
    {value = 8, text = "Raw Fish"}
}

-- ====================
-- PAGE MATERIALS
-- ====================

-- Materials for readable items (books, etc)
ItemTemplatePredefinedValues.PAGE_MATERIALS = {
    {value = 0, text = "None"},
    {value = 1, text = "Parchment"},
    {value = 2, text = "Stone"},
    {value = 3, text = "Marble"},
    {value = 4, text = "Silver"},
    {value = 5, text = "Bronze"},
    {value = 6, text = "Valentine"},
    {value = 7, text = "Illidan"}
}

-- ====================
-- LANGUAGE IDs
-- ====================

-- Language IDs for text items
ItemTemplatePredefinedValues.LANGUAGE_IDS = {
    {value = 0, text = "Universal"},
    {value = 1, text = "Orcish"},
    {value = 2, text = "Darnassian"},
    {value = 3, text = "Taurahe"},
    {value = 6, text = "Dwarvish"},
    {value = 7, text = "Common"},
    {value = 8, text = "Demonic"},
    {value = 9, text = "Titan"},
    {value = 10, text = "Thalassian"},
    {value = 11, text = "Draconic"},
    {value = 12, text = "Kalimag"},
    {value = 13, text = "Gnomish"},
    {value = 14, text = "Troll"},
    {value = 33, text = "Gutterspeak"},
    {value = 35, text = "Draenei"},
    {value = 36, text = "Zombie"},
    {value = 37, text = "Gnomish Binary"},
    {value = 38, text = "Goblin Binary"}
}

-- ====================
-- COMMON ITEM FLAGS
-- ====================

-- Common item flag combinations
ItemTemplatePredefinedValues.ITEM_FLAGS = {
    {value = 0, text = "None"},
    {value = 1, text = "No Pickup"},
    {value = 2, text = "Conjured"},
    {value = 4, text = "Has Loot"},
    {value = 8, text = "Heroic Tooltip"},
    {value = 16, text = "Deprecated"},
    {value = 32, text = "No User Destroy"},
    {value = 64, text = "Playercast"},
    {value = 128, text = "No Equip Cooldown"},
    {value = 256, text = "Multi Loot Quest"},
    {value = 512, text = "Is Wrapper"},
    {value = 1024, text = "Uses Resources"},
    {value = 2048, text = "Multi Drop"},
    {value = 4096, text = "Item Can Be Charged"},
    {value = 8192, text = "No Disenchant"},
    {value = 16384, text = "No Sell Price"},
    {value = 32768, text = "Not Disenchantable"},
    {value = 65536, text = "Real Time Duration"},
    {value = 131072, text = "No Creator"},
    {value = 262144, text = "Is Prospectable"},
    {value = 524288, text = "Unique Equippable"},
    {value = 1048576, text = "Ignore For Auras"},
    {value = 2097152, text = "Ignore Default Arena Restrictions"},
    {value = 4194304, text = "No Durability Loss"},
    {value = 8388608, text = "Use When Shapeshifted"},
    {value = 16777216, text = "Has Quest Glow"},
    {value = 33554432, text = "Hide Unusable Recipe"},
    {value = 67108864, text = "Not Useable in Arena"},
    {value = 134217728, text = "Is Bound to Account"},
    {value = 268435456, text = "No Reagent Cost"},
    {value = 536870912, text = "Is Millable"},
    {value = 1073741824, text = "Report to Guild News"},
    {value = 2147483648, text = "No Progressive Loot"}
}

-- ====================
-- EXTRA FLAGS
-- ====================

-- Extra server-side flags
ItemTemplatePredefinedValues.EXTRA_FLAGS = {
    {value = 0, text = "None"},
    {value = 1, text = "Horde Only"},
    {value = 2, text = "Alliance Only"},
    {value = 4, text = "Ext Cost Requires Gold"},
    {value = 8, text = "Neutral Disenchant"},
    {value = 16, text = "Real Time Duration"},
    {value = 32, text = "No Bind"},
    {value = 64, text = "Has Loot"},
    {value = 128, text = "Has Normal Price"},
    {value = 256, text = "Bnet Account Bound"},
    {value = 512, text = "Cannot Upgrade"},
    {value = 1024, text = "Cannot Disenchant"},
    {value = 2048, text = "Cannot Scout"},
    {value = 4096, text = "Cannot Roll Greed"}
}

-- ====================
-- REPUTATION RANKS
-- ====================

-- WoW 3.3.5 reputation levels
ItemTemplatePredefinedValues.REPUTATION_RANKS = {
    {value = 0, text = "Hated"},
    {value = 1, text = "Hostile"},
    {value = 2, text = "Unfriendly"},
    {value = 3, text = "Neutral"},
    {value = 4, text = "Friendly"},
    {value = 5, text = "Honored"},
    {value = 6, text = "Revered"},
    {value = 7, text = "Exalted"}
}

-- ====================
-- HONOR RANKS (Classic PvP)
-- ====================

-- Classic WoW PvP ranks
ItemTemplatePredefinedValues.HONOR_RANKS = {
    {value = 0, text = "No Rank"},
    {value = 1, text = "Private/Scout"},
    {value = 2, text = "Corporal/Grunt"},
    {value = 3, text = "Sergeant/Sergeant"},
    {value = 4, text = "Master Sergeant/Senior Sergeant"},
    {value = 5, text = "Sergeant Major/First Sergeant"},
    {value = 6, text = "Knight/Stone Guard"},
    {value = 7, text = "Knight-Lieutenant/Blood Guard"},
    {value = 8, text = "Knight-Captain/Legionnaire"},
    {value = 9, text = "Knight-Champion/Centurion"},
    {value = 10, text = "Lieutenant Commander/Champion"},
    {value = 11, text = "Commander/Lieutenant General"},
    {value = 12, text = "Marshal/General"},
    {value = 13, text = "Field Marshal/Warlord"},
    {value = 14, text = "Grand Marshal/High Warlord"}
}

-- ====================
-- MAJOR FACTIONS
-- ====================

-- Common WoW 3.3.5 factions
ItemTemplatePredefinedValues.MAJOR_FACTIONS = {
    {value = 0, text = "None"},
    -- Alliance Main Cities
    {value = 72, text = "Stormwind"},
    {value = 47, text = "Ironforge"},
    {value = 69, text = "Darnassus"},
    {value = 930, text = "Exodar"},
    -- Horde Main Cities
    {value = 76, text = "Orgrimmar"},
    {value = 68, text = "Undercity"},
    {value = 81, text = "Thunder Bluff"},
    {value = 911, text = "Silvermoon City"},
    -- Neutral Cities
    {value = 577, text = "The Violet Eye"},
    {value = 609, text = "Cenarion Expedition"},
    {value = 942, text = "Cenarion Expedition"},
    -- Major Outland Factions
    {value = 932, text = "The Aldor"},
    {value = 934, text = "The Scryers"},
    {value = 935, text = "The Sha'tar"},
    {value = 946, text = "Honor Hold"},
    {value = 947, text = "Thrallmar"},
    {value = 989, text = "Keepers of Time"},
    {value = 990, text = "The Scale of the Sands"},
    {value = 1011, text = "Lower City"},
    {value = 1012, text = "Ashtongue Deathsworn"},
    -- Major Northrend Factions
    {value = 1037, text = "Alliance Vanguard"},
    {value = 1052, text = "Horde Expedition"},
    {value = 1050, text = "Valiance Expedition"},
    {value = 1064, text = "The Taunka"},
    {value = 1067, text = "The Hand of Vengeance"},
    {value = 1068, text = "Explorers' League"},
    {value = 1073, text = "The Kalu'ak"},
    {value = 1090, text = "Kirin Tor"},
    {value = 1091, text = "The Wyrmrest Accord"},
    {value = 1094, text = "The Silver Covenant"},
    {value = 1098, text = "Knights of the Ebon Blade"},
    {value = 1104, text = "Frenzyheart Tribe"},
    {value = 1105, text = "The Oracles"},
    {value = 1106, text = "Argent Crusade"},
    {value = 1119, text = "The Sons of Hodir"},
    {value = 1124, text = "The Frostborn"},
    {value = 1126, text = "The Ashen Verdict"}
}

-- ====================
-- HOLIDAYS
-- ====================

-- WoW 3.3.5 holiday events
ItemTemplatePredefinedValues.HOLIDAYS = {
    {value = 0, text = "None"},
    {value = 181, text = "Feast of Winter Veil"},
    {value = 201, text = "Love is in the Air"},
    {value = 283, text = "Noblegarden"},
    {value = 284, text = "Children's Week"},
    {value = 285, text = "Harvest Festival"},
    {value = 321, text = "Hallow's End"},
    {value = 327, text = "Midsummer Fire Festival"},
    {value = 341, text = "Brewfest"},
    {value = 353, text = "Darkmoon Faire (Elwynn Forest)"},
    {value = 354, text = "Darkmoon Faire (Mulgore)"},
    {value = 355, text = "Darkmoon Faire (Terokkar Forest)"},
    {value = 372, text = "Lunar Festival"},
    {value = 374, text = "Gurubashi Arena Booty Run"},
    {value = 375, text = "Stranglethorn Fishing Extravaganza"},
    {value = 376, text = "Call to Arms: Alterac Valley"},
    {value = 377, text = "Call to Arms: Warsong Gulch"},
    {value = 378, text = "Call to Arms: Arathi Basin"},
    {value = 379, text = "Call to Arms: Eye of the Storm"},
    {value = 380, text = "Call to Arms: Strand of the Ancients"},
    {value = 400, text = "Wotlk Launch"},
    {value = 404, text = "Pilgrim's Bounty"},
    {value = 409, text = "Day of the Dead"},
    {value = 423, text = "Pirates' Day"}
}

-- ====================
-- LOCK TYPES
-- ====================

-- Common lock mechanisms
ItemTemplatePredefinedValues.LOCK_TYPES = {
    {value = 0, text = "None"},
    {value = 1, text = "Requires Key"},
    {value = 2, text = "Requires Lockpicking"},
    {value = 3, text = "Requires Key or Lockpicking"},
    {value = 4, text = "Quest Item (No Key)"},
    {value = 36, text = "Scarlet Key"},
    {value = 1, text = "Simple Lock"},
    {value = 2, text = "Average Lock"},
    {value = 3, text = "Complex Lock"},
    {value = 4, text = "Intricate Lock"},
    {value = 5, text = "Master Lock"}
}

-- ====================
-- MAJOR ITEM SETS
-- ====================

-- WoW 3.3.5 major item sets
ItemTemplatePredefinedValues.ITEM_SETS = {
    {value = 0, text = "None"},
    -- Classic Dungeon Sets
    {value = 81, text = "The Defias Leather (Rogue T0)"},
    {value = 82, text = "Embrace of the Viper (Hunter T0)"},
    {value = 83, text = "Chain of the Scarlet Crusade (Shaman T0)"},
    {value = 121, text = "Lightforge Armor (Paladin T0)"},
    {value = 122, text = "The Postmaster (Mail)"},
    {value = 141, text = "Dal'Rend's Arms (Warrior)"},
    {value = 142, text = "Spider's Kiss (Hunter)"},
    {value = 143, text = "Necropile Raiment (Warlock)"},
    {value = 144, text = "Cadaverous Garb (Priest)"},
    {value = 145, text = "Devilsaur Armor (Leather)"},
    {value = 161, text = "Volcanic Armor (Shaman)"},
    {value = 162, text = "Stormshroud Armor (Leather)"},
    {value = 181, text = "Ironfeather Armor (Mail)"},
    {value = 182, text = "Imperial Plate (Plate)"},
    -- Tier 1 Sets (Molten Core)
    {value = 201, text = "Vestments of Prophecy (Priest T1)"},
    {value = 202, text = "Magister's Regalia (Mage T1)"},
    {value = 203, text = "Dreadmist Raiment (Warlock T1)"},
    {value = 204, text = "Shadowcraft Armor (Rogue T1)"},
    {value = 205, text = "Wildheart Raiment (Druid T1)"},
    {value = 206, text = "Beaststalker Armor (Hunter T1)"},
    {value = 207, text = "Earthfury Armor (Shaman T1)"},
    {value = 208, text = "Lawbringer Armor (Paladin T1)"},
    {value = 209, text = "Battlegear of Might (Warrior T1)"},
    -- Tier 2 Sets (Blackwing Lair)
    {value = 211, text = "Vestments of Transcendence (Priest T2)"},
    {value = 212, text = "Netherwind Regalia (Mage T2)"},
    {value = 213, text = "Nemesis Raiment (Warlock T2)"},
    {value = 214, text = "Bloodfang Armor (Rogue T2)"},
    {value = 215, text = "Stormrage Raiment (Druid T2)"},
    {value = 216, text = "Dragonstalker Armor (Hunter T2)"},
    {value = 217, text = "Ten Storms (Shaman T2)"},
    {value = 218, text = "Judgement Armor (Paladin T2)"},
    {value = 219, text = "Battlegear of Wrath (Warrior T2)"},
    -- Tier 3 Sets (Naxxramas)
    {value = 221, text = "Vestments of Faith (Priest T3)"},
    {value = 222, text = "Frostfire Regalia (Mage T3)"},
    {value = 223, text = "Plagueheart Raiment (Warlock T3)"},
    {value = 224, text = "Bonescythe Armor (Rogue T3)"},
    {value = 225, text = "Dreamwalker Raiment (Druid T3)"},
    {value = 226, text = "Cryptstalker Armor (Hunter T3)"},
    {value = 227, text = "Earthshatterer Garb (Shaman T3)"},
    {value = 228, text = "Redemption Armor (Paladin T3)"},
    {value = 229, text = "Dreadnaught's Battlegear (Warrior T3)"}
}

-- ====================
-- ALLOWABLE CLASSES (Bitmasks)
-- ====================

-- WoW 3.3.5 classes for AllowableClass field (bitmasks)
ItemTemplatePredefinedValues.ALLOWABLE_CLASSES = {
    {value = 1, text = "Warrior", bit = 0},
    {value = 2, text = "Paladin", bit = 1},
    {value = 4, text = "Hunter", bit = 2},
    {value = 8, text = "Rogue", bit = 3},
    {value = 16, text = "Priest", bit = 4},
    {value = 32, text = "Death Knight", bit = 5},
    {value = 64, text = "Shaman", bit = 6},
    {value = 128, text = "Mage", bit = 7},
    {value = 256, text = "Warlock", bit = 8},
    {value = 512, text = "Druid", bit = 9}
}

-- ====================
-- ALLOWABLE RACES (Bitmasks)
-- ====================

-- WoW 3.3.5 races for AllowableRace field (bitmasks)
ItemTemplatePredefinedValues.ALLOWABLE_RACES = {
    {value = 1, text = "Human", bit = 0},
    {value = 2, text = "Orc", bit = 1},
    {value = 4, text = "Dwarf", bit = 2},
    {value = 8, text = "Night Elf", bit = 3},
    {value = 16, text = "Undead", bit = 4},
    {value = 32, text = "Tauren", bit = 5},
    {value = 64, text = "Gnome", bit = 6},
    {value = 128, text = "Troll", bit = 7},
    {value = 256, text = "Goblin", bit = 8},
    {value = 512, text = "Blood Elf", bit = 9},
    {value = 1024, text = "Draenei", bit = 10}
}

-- ====================
-- ALL SUBCLASSES (FLAT LIST)
-- ====================

-- Complete flat list of all item subclasses for easy selection
ItemTemplatePredefinedValues.ALL_SUBCLASSES = {
    -- Class 0: Consumable
    {value = 0, text = "Consumable - Consumable"},
    {value = 1, text = "Consumable - Potion"},
    {value = 2, text = "Consumable - Elixir"},
    {value = 3, text = "Consumable - Flask"},
    {value = 4, text = "Consumable - Scroll"},
    {value = 5, text = "Consumable - Food & Drink"},
    {value = 6, text = "Consumable - Item Enhancement"},
    {value = 7, text = "Consumable - Bandage"},
    {value = 8, text = "Consumable - Other"},
    
    -- Class 1: Container
    {value = 0, text = "Container - Bag"},
    {value = 1, text = "Container - Soul Bag"},
    {value = 2, text = "Container - Herb Bag"},
    {value = 3, text = "Container - Enchanting Bag"},
    {value = 4, text = "Container - Engineering Bag"},
    {value = 5, text = "Container - Gem Bag"},
    {value = 6, text = "Container - Mining Bag"},
    {value = 7, text = "Container - Leatherworking Bag"},
    {value = 8, text = "Container - Inscription Bag"},
    
    -- Class 2: Weapon
    {value = 0, text = "Weapon - One-Handed Axes"},
    {value = 1, text = "Weapon - Two-Handed Axes"},
    {value = 2, text = "Weapon - Bows"},
    {value = 3, text = "Weapon - Guns"},
    {value = 4, text = "Weapon - One-Handed Maces"},
    {value = 5, text = "Weapon - Two-Handed Maces"},
    {value = 6, text = "Weapon - Polearms"},
    {value = 7, text = "Weapon - One-Handed Swords"},
    {value = 8, text = "Weapon - Two-Handed Swords"},
    {value = 9, text = "Weapon - Obsolete"},
    {value = 10, text = "Weapon - Staves"},
    {value = 11, text = "Weapon - One-Handed Exotics"},
    {value = 12, text = "Weapon - Two-Handed Exotics"},
    {value = 13, text = "Weapon - Fist Weapons"},
    {value = 14, text = "Weapon - Miscellaneous"},
    {value = 15, text = "Weapon - Daggers"},
    {value = 16, text = "Weapon - Thrown"},
    {value = 17, text = "Weapon - Spears"},
    {value = 18, text = "Weapon - Crossbows"},
    {value = 19, text = "Weapon - Wands"},
    {value = 20, text = "Weapon - Fishing Poles"},
    
    -- Class 3: Gem
    {value = 0, text = "Gem - Red"},
    {value = 1, text = "Gem - Blue"},
    {value = 2, text = "Gem - Yellow"},
    {value = 3, text = "Gem - Purple"},
    {value = 4, text = "Gem - Green"},
    {value = 5, text = "Gem - Orange"},
    {value = 6, text = "Gem - Meta"},
    {value = 7, text = "Gem - Simple"},
    {value = 8, text = "Gem - Prismatic"},
    
    -- Class 4: Armor
    {value = 0, text = "Armor - Miscellaneous"},
    {value = 1, text = "Armor - Cloth"},
    {value = 2, text = "Armor - Leather"},
    {value = 3, text = "Armor - Mail"},
    {value = 4, text = "Armor - Plate"},
    {value = 5, text = "Armor - Cosmetic"},
    {value = 6, text = "Armor - Shield"},
    {value = 7, text = "Armor - Libram"},
    {value = 8, text = "Armor - Idol"},
    {value = 9, text = "Armor - Totem"},
    {value = 10, text = "Armor - Sigil"},
    
    -- Class 5: Reagent
    {value = 0, text = "Reagent - Reagent"},
    
    -- Class 6: Projectile
    {value = 2, text = "Projectile - Arrow"},
    {value = 3, text = "Projectile - Bullet"},
    
    -- Class 7: Trade Goods
    {value = 0, text = "Trade Goods - Trade Goods"},
    {value = 1, text = "Trade Goods - Parts"},
    {value = 2, text = "Trade Goods - Explosives"},
    {value = 3, text = "Trade Goods - Devices"},
    {value = 4, text = "Trade Goods - Jewelcrafting"},
    {value = 5, text = "Trade Goods - Cloth"},
    {value = 6, text = "Trade Goods - Leather"},
    {value = 7, text = "Trade Goods - Metal & Stone"},
    {value = 8, text = "Trade Goods - Meat"},
    {value = 9, text = "Trade Goods - Herb"},
    {value = 10, text = "Trade Goods - Elemental"},
    {value = 11, text = "Trade Goods - Other"},
    {value = 12, text = "Trade Goods - Enchanting"},
    {value = 13, text = "Trade Goods - Materials"},
    {value = 14, text = "Trade Goods - Armor Enchantment"},
    {value = 15, text = "Trade Goods - Weapon Enchantment"},
    
    -- Class 8: Generic (OBSOLETE)
    {value = 0, text = "Generic - Generic (OBSOLETE)"},
    
    -- Class 9: Recipe
    {value = 0, text = "Recipe - Book"},
    {value = 1, text = "Recipe - Leatherworking"},
    {value = 2, text = "Recipe - Tailoring"},
    {value = 3, text = "Recipe - Engineering"},
    {value = 4, text = "Recipe - Blacksmithing"},
    {value = 5, text = "Recipe - Cooking"},
    {value = 6, text = "Recipe - Alchemy"},
    {value = 7, text = "Recipe - First Aid"},
    {value = 8, text = "Recipe - Enchanting"},
    {value = 9, text = "Recipe - Fishing"},
    {value = 10, text = "Recipe - Jewelcrafting"},
    {value = 11, text = "Recipe - Inscription"},
    
    -- Class 10: Money (OBSOLETE)
    {value = 0, text = "Money - Money (OBSOLETE)"},
    
    -- Class 11: Quiver
    {value = 0, text = "Quiver - Quiver (OBSOLETE)"},
    {value = 1, text = "Quiver - Bolt (OBSOLETE)"},
    {value = 2, text = "Quiver - Quiver"},
    {value = 3, text = "Quiver - Ammo Pouch"},
    
    -- Class 12: Quest
    {value = 0, text = "Quest - Quest"},
    
    -- Class 13: Key
    {value = 0, text = "Key - Key"},
    {value = 1, text = "Key - Lockpick"},
    
    -- Class 14: Permanent (OBSOLETE)
    {value = 0, text = "Permanent - Permanent (OBSOLETE)"},
    
    -- Class 15: Miscellaneous
    {value = 0, text = "Miscellaneous - Junk"},
    {value = 1, text = "Miscellaneous - Reagent"},
    {value = 2, text = "Miscellaneous - Pet"},
    {value = 3, text = "Miscellaneous - Holiday"},
    {value = 4, text = "Miscellaneous - Other"},
    {value = 5, text = "Miscellaneous - Mount"},
    
    -- Class 16: Glyph
    {value = 1, text = "Glyph - Warrior"},
    {value = 2, text = "Glyph - Paladin"},
    {value = 3, text = "Glyph - Hunter"},
    {value = 4, text = "Glyph - Rogue"},
    {value = 5, text = "Glyph - Priest"},
    {value = 6, text = "Glyph - Death Knight"},
    {value = 7, text = "Glyph - Shaman"},
    {value = 8, text = "Glyph - Mage"},
    {value = 9, text = "Glyph - Warlock"},
    {value = 11, text = "Glyph - Druid"}
}

-- Item Template Predefined Values module loaded