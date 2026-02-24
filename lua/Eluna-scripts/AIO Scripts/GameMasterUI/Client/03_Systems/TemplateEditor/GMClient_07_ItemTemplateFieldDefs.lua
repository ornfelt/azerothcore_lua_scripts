local AIO = AIO or require("AIO")

if AIO.AddAddon() then
    return -- Exit if on server
end

-- Initialize namespace for item template field definitions
_G.ItemTemplateFieldDefs = _G.ItemTemplateFieldDefs or {}
local ItemTemplateFieldDefs = _G.ItemTemplateFieldDefs

-- Reference to predefined values (loaded by GMClient_00_ItemTemplatePredefinedValues.lua)
local PredefinedValues = _G.ItemTemplatePredefinedValues
if not PredefinedValues then
    print("|cFFFF0000[ItemTemplateFieldDefs] Error: ItemTemplatePredefinedValues not loaded! Make sure GMClient_00_ItemTemplatePredefinedValues.lua is loaded first.|r")
    return
end

-- Configuration for item template editor
ItemTemplateFieldDefs.CONFIG = {
    FIELD_HEIGHT = 22,
    WINDOW_WIDTH = 950,  -- Increased width for two columns
    WINDOW_HEIGHT = 700,
    CONTENT_WIDTH = 910,  -- Adjusted content width
    TAB_HEIGHT = 26,
    LABEL_WIDTH = 160,    -- Reduced label width for columns
    INPUT_WIDTH = 180,    -- Reduced input width for columns
    COLUMN_WIDTH = 380,   -- Width of each column
    COLUMN_SPACING = 20,  -- Space between columns
    USE_TWO_COLUMNS = {
        Basic = true,       -- Two columns with pairing
        Stats = true,       -- Two columns (many fields)
        Requirements = true, -- Two columns with pairing
        Damage = true,      -- Two columns (6 damage fields)
        Spells = true,      -- Two columns (many spell fields)
        Flags = true,       -- Two columns (many flag fields)
        Scaling = false     -- Single column (fewer fields)
    },
    TABS = {
        "Basic",
        "Stats", 
        "Requirements",
        "Damage",
        "Spells",
        "Flags",
        "Scaling"
    }
}

-- Use predefined values from the shared file (loaded dependencies)
local ITEM_CLASSES = PredefinedValues.ITEM_CLASSES or {}
local ITEM_QUALITIES = PredefinedValues.ITEM_QUALITIES or {}
local INVENTORY_TYPES = PredefinedValues.INVENTORY_TYPES or {}
local BONDING_TYPES = PredefinedValues.BONDING_TYPES or {}
local DAMAGE_TYPES = PredefinedValues.DAMAGE_TYPES or {}
local STAT_TYPES = PredefinedValues.STAT_TYPES or {}
local SPELL_TRIGGERS = PredefinedValues.SPELL_TRIGGERS or {}
local MATERIAL_TYPES = PredefinedValues.MATERIAL_TYPES or {}
local SHEATH_TYPES = PredefinedValues.SHEATH_TYPES or {}
local BAG_FAMILY = PredefinedValues.BAG_FAMILY or {}
local SOCKET_COLORS = PredefinedValues.SOCKET_COLORS or {}
local TOTEM_CATEGORIES = PredefinedValues.TOTEM_CATEGORIES or {}
local FOOD_TYPES = PredefinedValues.FOOD_TYPES or {}
local PAGE_MATERIALS = PredefinedValues.PAGE_MATERIALS or {}
local LANGUAGE_IDS = PredefinedValues.LANGUAGE_IDS or {}
local ITEM_FLAGS = PredefinedValues.ITEM_FLAGS or {}
local EXTRA_FLAGS = PredefinedValues.EXTRA_FLAGS or {}
local ITEM_SUBCLASSES = PredefinedValues.ITEM_SUBCLASSES or {}
local REPUTATION_RANKS = PredefinedValues.REPUTATION_RANKS or {}
local HONOR_RANKS = PredefinedValues.HONOR_RANKS or {}
local MAJOR_FACTIONS = PredefinedValues.MAJOR_FACTIONS or {}
local HOLIDAYS = PredefinedValues.HOLIDAYS or {}
local LOCK_TYPES = PredefinedValues.LOCK_TYPES or {}
local ITEM_SETS = PredefinedValues.ITEM_SETS or {}
local ALL_SUBCLASSES = PredefinedValues.ALL_SUBCLASSES or {}

-- Helper function to get subclass options based on item class
ItemTemplateFieldDefs.GetSubclassOptions = function(itemClass)
    return ITEM_SUBCLASSES[itemClass] or {{value = 0, text = "None"}}
end

-- Field definitions for each tab
ItemTemplateFieldDefs.FIELDS = {
    Basic = {
        -- BASIC PROPERTIES: Name & Description (paired)
        { key = "name", label = "Name:", type = "text", tooltip = "Item display name", maxLength = 255, pair = "description" },
        { key = "description", label = "Description:", type = "text", tooltip = "Item description text", maxLength = 255, groupEnd = true },
        
        -- CLASSIFICATION: Class & Subclass (paired)
        { key = "class", label = "Item Class:", type = "dropdown", options = ITEM_CLASSES, tooltip = "Main item category", pair = "subclass" },
        { key = "subclass", label = "Subclass:", type = "dropdown", options = ALL_SUBCLASSES, tooltip = "Item subclass - dynamically updated based on class", groupEnd = true },
        
        -- QUALITY & EQUIPMENT: Quality & Inventory Type (paired)
        { key = "Quality", label = "Quality:", type = "dropdown", options = ITEM_QUALITIES, tooltip = "Item rarity/quality level", pair = "InventoryType" },
        { key = "InventoryType", label = "Inventory Type:", type = "dropdown", options = INVENTORY_TYPES, tooltip = "Equipment slot or type", groupEnd = true },
        
        -- LEVEL REQUIREMENTS: Item Level & Required Level (paired)
        { key = "ItemLevel", label = "Item Level:", type = "number", min = 1, max = 1000, defaultValue = 1, tooltip = "Item level for scaling", pair = "RequiredLevel" },
        { key = "RequiredLevel", label = "Required Level:", type = "number", min = 0, max = 255, defaultValue = 1, tooltip = "Minimum level to use/equip", groupEnd = true },
        
        -- STACKING & LIMITS: Max Count & Stack Size (paired)
        { key = "maxcount", label = "Max Count:", type = "number", min = 0, max = 2147483647, defaultValue = 1, tooltip = "Max number player can have (0 = no limit)", pair = "stackable" },
        { key = "stackable", label = "Stack Size:", type = "number", min = 1, max = 1000, defaultValue = 1, tooltip = "Max items per stack", groupEnd = true },
        
        -- CONTAINER & BONDING: Container Slots & Bonding (paired)
        { key = "ContainerSlots", label = "Container Slots:", type = "number", min = 0, max = 255, defaultValue = 0, tooltip = "Number of slots for bags/containers (0 = not a container)", pair = "bonding" },
        { key = "bonding", label = "Bonding:", type = "dropdown", options = BONDING_TYPES, tooltip = "How the item binds to player", groupEnd = true },
        
        -- DISPLAY & SOUND: Display ID & Sound Override (paired)
        { key = "displayid", label = "Display ID:", type = "number", min = 0, tooltip = "Item model/icon display ID", pair = "SoundOverrideSubclass" },
        { key = "SoundOverrideSubclass", label = "Sound Override:", type = "number", min = -1, max = 127, defaultValue = -1, tooltip = "Sound override subclass" }
    },
    
    Stats = {
        -- PAIRED STATS: Left = Stats 1-5, Right = Stats 6-10
        { key = "stat_type1", label = "Stat 1 Type:", type = "dropdown", options = STAT_TYPES, defaultValue = 0, tooltip = "First stat type (0=disabled)", allowEdit = true, pair = "stat_type6" },
        { key = "stat_value1", label = "Stat 1 Value:", type = "number", min = -32768, max = 32767, defaultValue = 0, tooltip = "First stat value", pair = "stat_value6" },
        { key = "stat_type6", label = "Stat 6 Type:", type = "dropdown", options = STAT_TYPES, defaultValue = 0, tooltip = "Sixth stat type", allowEdit = true },
        { key = "stat_value6", label = "Stat 6 Value:", type = "number", min = -32768, max = 32767, defaultValue = 0, tooltip = "Sixth stat value" },
        
        { key = "stat_type2", label = "Stat 2 Type:", type = "dropdown", options = STAT_TYPES, defaultValue = 0, tooltip = "Second stat type", allowEdit = true, pair = "stat_type7" },
        { key = "stat_value2", label = "Stat 2 Value:", type = "number", min = -32768, max = 32767, defaultValue = 0, tooltip = "Second stat value", pair = "stat_value7" },
        { key = "stat_type7", label = "Stat 7 Type:", type = "dropdown", options = STAT_TYPES, defaultValue = 0, tooltip = "Seventh stat type", allowEdit = true },
        { key = "stat_value7", label = "Stat 7 Value:", type = "number", min = -32768, max = 32767, defaultValue = 0, tooltip = "Seventh stat value" },
        
        { key = "stat_type3", label = "Stat 3 Type:", type = "dropdown", options = STAT_TYPES, defaultValue = 0, tooltip = "Third stat type", allowEdit = true, pair = "stat_type8" },
        { key = "stat_value3", label = "Stat 3 Value:", type = "number", min = -32768, max = 32767, defaultValue = 0, tooltip = "Third stat value", pair = "stat_value8" },
        { key = "stat_type8", label = "Stat 8 Type:", type = "dropdown", options = STAT_TYPES, defaultValue = 0, tooltip = "Eighth stat type", allowEdit = true },
        { key = "stat_value8", label = "Stat 8 Value:", type = "number", min = -32768, max = 32767, defaultValue = 0, tooltip = "Eighth stat value" },
        
        { key = "stat_type4", label = "Stat 4 Type:", type = "dropdown", options = STAT_TYPES, defaultValue = 0, tooltip = "Fourth stat type", allowEdit = true, pair = "stat_type9" },
        { key = "stat_value4", label = "Stat 4 Value:", type = "number", min = -32768, max = 32767, defaultValue = 0, tooltip = "Fourth stat value", pair = "stat_value9" },
        { key = "stat_type9", label = "Stat 9 Type:", type = "dropdown", options = STAT_TYPES, defaultValue = 0, tooltip = "Ninth stat type", allowEdit = true },
        { key = "stat_value9", label = "Stat 9 Value:", type = "number", min = -32768, max = 32767, defaultValue = 0, tooltip = "Ninth stat value" },
        
        { key = "stat_type5", label = "Stat 5 Type:", type = "dropdown", options = STAT_TYPES, defaultValue = 0, tooltip = "Fifth stat type", allowEdit = true, pair = "stat_type10" },
        { key = "stat_value5", label = "Stat 5 Value:", type = "number", min = -32768, max = 32767, defaultValue = 0, tooltip = "Fifth stat value", pair = "stat_value10", groupEnd = true },
        { key = "stat_type10", label = "Stat 10 Type:", type = "dropdown", options = STAT_TYPES, defaultValue = 0, tooltip = "Tenth stat type", allowEdit = true },
        { key = "stat_value10", label = "Stat 10 Value:", type = "number", min = -32768, max = 32767, defaultValue = 0, tooltip = "Tenth stat value" },
        
        -- ARMOR & BLOCK VALUES
        { key = "armor", label = "Armor:", type = "number", min = 0, max = 65535, defaultValue = 0, tooltip = "Armor value for armor items", pair = "StatsCount" },
        { key = "block", label = "Block Value:", type = "number", min = 0, max = 65535, defaultValue = 0, tooltip = "Block value for shields", pair = "_empty", groupEnd = true },
        { key = "StatsCount", label = "Stats Count:", type = "number", min = 0, max = 10, defaultValue = 0, tooltip = "Number of stats this item has" },
        
        -- RESISTANCES: Left = Holy/Fire/Nature, Right = Frost/Shadow/Arcane
        { key = "holy_res", label = "Holy Resistance:", type = "number", min = 0, max = 255, defaultValue = 0, tooltip = "Holy resistance value", pair = "frost_res" },
        { key = "fire_res", label = "Fire Resistance:", type = "number", min = 0, max = 255, defaultValue = 0, tooltip = "Fire resistance value", pair = "shadow_res" },
        { key = "nature_res", label = "Nature Resistance:", type = "number", min = 0, max = 255, defaultValue = 0, tooltip = "Nature resistance value", pair = "arcane_res" },
        { key = "frost_res", label = "Frost Resistance:", type = "number", min = 0, max = 255, defaultValue = 0, tooltip = "Frost resistance value" },
        { key = "shadow_res", label = "Shadow Resistance:", type = "number", min = 0, max = 255, defaultValue = 0, tooltip = "Shadow resistance value" },
        { key = "arcane_res", label = "Arcane Resistance:", type = "number", min = 0, max = 255, defaultValue = 0, tooltip = "Arcane resistance value" }
    },
    
    Requirements = {
        -- SKILL REQUIREMENTS: Skill & Skill Rank (paired)
        { key = "RequiredSkill", label = "Required Skill:", type = "number", min = 0, max = 65535, defaultValue = 0, tooltip = "Skill ID required to use", pair = "RequiredSkillRank" },
        { key = "RequiredSkillRank", label = "Required Skill Rank:", type = "number", min = 0, max = 65535, defaultValue = 0, tooltip = "Minimum skill rank required", groupEnd = true },
        
        -- DISENCHANT SKILL: Required Disenchant Skill (single field)
        { key = "RequiredDisenchantSkill", label = "Disenchant Skill:", type = "number", min = 0, max = 65535, defaultValue = 0, tooltip = "Minimum enchanting skill to disenchant this item", pair = "_empty" },
        
        -- SPELL & REPUTATION: Required Spell & Rep Faction (paired)
        { key = "requiredspell", label = "Required Spell:", type = "number", min = 0, tooltip = "Spell ID player must know", pair = "RequiredReputationFaction" },
        { key = "RequiredReputationFaction", label = "Rep. Faction:", type = "dropdown", options = MAJOR_FACTIONS, defaultValue = 0, tooltip = "Faction ID for reputation requirement", allowEdit = true },
        
        -- RANKS: Rep Rank & City Rank (paired)
        { key = "RequiredReputationRank", label = "Rep. Rank:", type = "dropdown", options = REPUTATION_RANKS, defaultValue = 0, tooltip = "Minimum reputation rank", allowEdit = true, pair = "RequiredCityRank" },
        { key = "RequiredCityRank", label = "City Rank:", type = "number", min = 0, max = 255, defaultValue = 0, tooltip = "Required city rank", groupEnd = true },
        
        -- HONOR & ALLOWABLE: Honor Rank & Allowed Classes (paired)
        { key = "requiredhonorrank", label = "Honor Rank:", type = "dropdown", options = HONOR_RANKS, defaultValue = 0, tooltip = "Required honor rank", allowEdit = true, pair = "AllowableClass" },
        { key = "AllowableClass", label = "Allowed Classes:", type = "flags", tooltip = "Classes that can use this item (bitmask)" },
        
        -- RACE RESTRICTIONS: Allowed Races (single field)
        { key = "AllowableRace", label = "Allowed Races:", type = "flags", tooltip = "Races that can use this item (bitmask)", pair = "_empty" }
    },
    
    Damage = {
        -- DAMAGE TYPE 1 vs DAMAGE TYPE 2 (paired)
        { key = "dmg_min1", label = "Min Damage 1:", type = "decimal", min = 0, max = 10000, defaultValue = 0, step = 0.1, tooltip = "Minimum damage for first damage type", pair = "dmg_min2" },
        { key = "dmg_max1", label = "Max Damage 1:", type = "decimal", min = 0, max = 10000, defaultValue = 0, step = 0.1, tooltip = "Maximum damage for first damage type", pair = "dmg_max2" },
        { key = "dmg_type1", label = "Damage Type 1:", type = "dropdown", options = DAMAGE_TYPES, tooltip = "First damage type", pair = "dmg_type2", groupEnd = true },
        { key = "dmg_min2", label = "Min Damage 2:", type = "decimal", min = 0, max = 10000, defaultValue = 0, step = 0.1, tooltip = "Minimum damage for second damage type" },
        { key = "dmg_max2", label = "Max Damage 2:", type = "decimal", min = 0, max = 10000, defaultValue = 0, step = 0.1, tooltip = "Maximum damage for second damage type" },
        { key = "dmg_type2", label = "Damage Type 2:", type = "dropdown", options = DAMAGE_TYPES, tooltip = "Second damage type" },
        
        -- WEAPON PROPERTIES: Speed & Ammo vs Range (paired)
        { key = "delay", label = "Weapon Speed:", type = "number", min = 0, max = 10000, defaultValue = 2000, tooltip = "Weapon attack speed in milliseconds", pair = "RangedModRange" },
        { key = "ammo_type", label = "Ammo Type:", type = "number", min = 0, max = 255, defaultValue = 0, tooltip = "Required ammunition type", pair = "_empty" },
        { key = "RangedModRange", label = "Range Modifier:", type = "decimal", min = 0, max = 10, defaultValue = 0, step = 0.1, tooltip = "Ranged weapon range modifier" }
    },
    
    Spells = {
        -- SPELL 1 vs SPELL 2 (Side by side)
        { key = "spellid_1", label = "Spell 1 ID:", type = "number", min = 0, defaultValue = 0, tooltip = "First spell ID", pair = "spellid_2" },
        { key = "spelltrigger_1", label = "Spell 1 Trigger:", type = "dropdown", options = SPELL_TRIGGERS, defaultValue = 0, tooltip = "How spell 1 is triggered", allowEdit = true, pair = "spelltrigger_2" },
        { key = "spellcharges_1", label = "Spell 1 Charges:", type = "number", min = -1, max = 255, defaultValue = 0, tooltip = "Number of charges (-1=infinite)", pair = "spellcharges_2" },
        { key = "spellppmRate_1", label = "Spell 1 PPM Rate:", type = "decimal", min = 0, max = 1000, defaultValue = 0, step = 0.1, tooltip = "Procs per minute rate", pair = "spellppmRate_2" },
        { key = "spellcooldown_1", label = "Spell 1 Cooldown:", type = "number", min = -1, defaultValue = -1, tooltip = "Cooldown in milliseconds (-1=default)", pair = "spellcooldown_2" },
        { key = "spellcategory_1", label = "Spell 1 Category:", type = "number", min = 0, max = 65535, defaultValue = 0, tooltip = "Spell category for shared cooldowns", pair = "spellcategory_2" },
        { key = "spellcategorycooldown_1", label = "Spell 1 Cat. Cooldown:", type = "number", min = -1, defaultValue = -1, tooltip = "Category cooldown in milliseconds", pair = "spellcategorycooldown_2", groupEnd = true },
        { key = "spellid_2", label = "Spell 2 ID:", type = "number", min = 0, defaultValue = 0, tooltip = "Second spell ID" },
        { key = "spelltrigger_2", label = "Spell 2 Trigger:", type = "dropdown", options = SPELL_TRIGGERS, defaultValue = 0, tooltip = "How spell 2 is triggered", allowEdit = true },
        { key = "spellcharges_2", label = "Spell 2 Charges:", type = "number", min = -1, max = 255, defaultValue = 0, tooltip = "Number of charges" },
        { key = "spellppmRate_2", label = "Spell 2 PPM Rate:", type = "decimal", min = 0, max = 1000, defaultValue = 0, step = 0.1, tooltip = "Procs per minute rate" },
        { key = "spellcooldown_2", label = "Spell 2 Cooldown:", type = "number", min = -1, defaultValue = -1, tooltip = "Cooldown in milliseconds" },
        { key = "spellcategory_2", label = "Spell 2 Category:", type = "number", min = 0, max = 65535, defaultValue = 0, tooltip = "Spell category" },
        { key = "spellcategorycooldown_2", label = "Spell 2 Cat. Cooldown:", type = "number", min = -1, defaultValue = -1, tooltip = "Category cooldown" },
        
        -- SPELL 3 vs SPELL 4 (Side by side)
        { key = "spellid_3", label = "Spell 3 ID:", type = "number", min = 0, defaultValue = 0, tooltip = "Third spell ID", pair = "spellid_4" },
        { key = "spelltrigger_3", label = "Spell 3 Trigger:", type = "dropdown", options = SPELL_TRIGGERS, defaultValue = 0, tooltip = "How spell 3 is triggered", allowEdit = true, pair = "spelltrigger_4" },
        { key = "spellcharges_3", label = "Spell 3 Charges:", type = "number", min = -1, max = 255, defaultValue = 0, tooltip = "Number of charges", pair = "spellcharges_4" },
        { key = "spellppmRate_3", label = "Spell 3 PPM Rate:", type = "decimal", min = 0, max = 1000, defaultValue = 0, step = 0.1, tooltip = "Procs per minute rate", pair = "spellppmRate_4" },
        { key = "spellcooldown_3", label = "Spell 3 Cooldown:", type = "number", min = -1, defaultValue = -1, tooltip = "Cooldown in milliseconds", pair = "spellcooldown_4" },
        { key = "spellcategory_3", label = "Spell 3 Category:", type = "number", min = 0, max = 65535, defaultValue = 0, tooltip = "Spell category", pair = "spellcategory_4" },
        { key = "spellcategorycooldown_3", label = "Spell 3 Cat. Cooldown:", type = "number", min = -1, defaultValue = -1, tooltip = "Category cooldown", pair = "spellcategorycooldown_4", groupEnd = true },
        { key = "spellid_4", label = "Spell 4 ID:", type = "number", min = 0, defaultValue = 0, tooltip = "Fourth spell ID" },
        { key = "spelltrigger_4", label = "Spell 4 Trigger:", type = "dropdown", options = SPELL_TRIGGERS, defaultValue = 0, tooltip = "How spell 4 is triggered", allowEdit = true },
        { key = "spellcharges_4", label = "Spell 4 Charges:", type = "number", min = -1, max = 255, defaultValue = 0, tooltip = "Number of charges" },
        { key = "spellppmRate_4", label = "Spell 4 PPM Rate:", type = "decimal", min = 0, max = 1000, defaultValue = 0, step = 0.1, tooltip = "Procs per minute rate" },
        { key = "spellcooldown_4", label = "Spell 4 Cooldown:", type = "number", min = -1, defaultValue = -1, tooltip = "Cooldown in milliseconds" },
        { key = "spellcategory_4", label = "Spell 4 Category:", type = "number", min = 0, max = 65535, defaultValue = 0, tooltip = "Spell category" },
        { key = "spellcategorycooldown_4", label = "Spell 4 Cat. Cooldown:", type = "number", min = -1, defaultValue = -1, tooltip = "Category cooldown" },
        
        -- SPELL 5 (Left side only)
        { key = "spellid_5", label = "Spell 5 ID:", type = "number", min = 0, defaultValue = 0, tooltip = "Fifth spell ID", pair = "_empty" },
        { key = "spelltrigger_5", label = "Spell 5 Trigger:", type = "dropdown", options = SPELL_TRIGGERS, defaultValue = 0, tooltip = "How spell 5 is triggered", allowEdit = true, pair = "_empty" },
        { key = "spellcharges_5", label = "Spell 5 Charges:", type = "number", min = -1, max = 255, defaultValue = 0, tooltip = "Number of charges", pair = "_empty" },
        { key = "spellppmRate_5", label = "Spell 5 PPM Rate:", type = "decimal", min = 0, max = 1000, defaultValue = 0, step = 0.1, tooltip = "Procs per minute rate", pair = "_empty" },
        { key = "spellcooldown_5", label = "Spell 5 Cooldown:", type = "number", min = -1, defaultValue = -1, tooltip = "Cooldown in milliseconds", pair = "_empty" },
        { key = "spellcategory_5", label = "Spell 5 Category:", type = "number", min = 0, max = 65535, defaultValue = 0, tooltip = "Spell category", pair = "_empty" },
        { key = "spellcategorycooldown_5", label = "Spell 5 Cat. Cooldown:", type = "number", min = -1, defaultValue = -1, tooltip = "Category cooldown", pair = "_empty" }
    },
    
    Flags = {
        -- ITEM FLAGS: Basic flags vs Custom flags (paired)
        { key = "Flags", label = "Item Flags:", type = "flags", tooltip = "Item behavior flags", pair = "FlagsExtra" },
        { key = "flagsCustom", label = "Custom Flags:", type = "flags", tooltip = "Custom server flags", pair = "itemset", groupEnd = true },
        { key = "FlagsExtra", label = "Extra Flags:", type = "flags", tooltip = "Additional server-side flags" },
        { key = "itemset", label = "Item Set:", type = "dropdown", options = ITEM_SETS, defaultValue = 0, tooltip = "Item set ID", allowEdit = true },
        
        -- VENDOR PRICING: Buy Count & Buy Price vs Sell Price & Bag Family (paired)
        { key = "BuyCount", label = "Buy Count:", type = "number", min = 1, max = 1000, defaultValue = 1, tooltip = "How many bought at once from vendor", pair = "BuyPrice" },
        { key = "SellPrice", label = "Sell Price (copper):", type = "number", min = 0, defaultValue = 0, tooltip = "Vendor sell price in copper", pair = "BagFamily", groupEnd = true },
        { key = "BuyPrice", label = "Buy Price (copper):", type = "number", min = 0, defaultValue = 0, tooltip = "Vendor buy price in copper" },
        { key = "BagFamily", label = "Bag Family:", type = "flags", tooltip = "What item types this bag can hold" },
        
        -- MATERIAL & SHEATH: Material vs Totem Category (paired)
        { key = "Material", label = "Material:", type = "dropdown", options = MATERIAL_TYPES, defaultValue = -1, tooltip = "Item material type", allowEdit = true, pair = "TotemCategory" },
        { key = "sheath", label = "Sheath:", type = "dropdown", options = SHEATH_TYPES, defaultValue = 0, tooltip = "Weapon sheathing type", allowEdit = true, pair = "GemProperties", groupEnd = true },
        { key = "TotemCategory", label = "Totem Category:", type = "dropdown", options = TOTEM_CATEGORIES, defaultValue = 0, tooltip = "Totem category for totem items", allowEdit = true },
        { key = "GemProperties", label = "Gem Properties:", type = "number", min = 0, defaultValue = 0, tooltip = "Gem properties ID (for gems)" },
        
        -- DURABILITY & DURATION: Max Durability vs Armor Damage Modifier (paired)
        { key = "MaxDurability", label = "Max Durability:", type = "number", min = 0, max = 65535, defaultValue = 0, tooltip = "Maximum item durability", pair = "ArmorDamageModifier" },
        { key = "duration", label = "Duration (seconds):", type = "number", min = 0, defaultValue = 0, tooltip = "Item duration in seconds (0 = permanent)", pair = "ItemLimitCategory", groupEnd = true },
        { key = "ArmorDamageModifier", label = "Armor Damage Mod:", type = "decimal", min = 0, max = 10, defaultValue = 0, step = 0.1, tooltip = "Armor damage modifier" },
        { key = "ItemLimitCategory", label = "Limit Category:", type = "number", min = 0, defaultValue = 0, tooltip = "Item limit category ID" },
        
        -- LOCATION RESTRICTIONS: Zone ID vs Map ID (paired)
        { key = "area", label = "Zone ID:", type = "number", min = 0, max = 65535, defaultValue = 0, tooltip = "Zone restriction (0 = no restriction)", pair = "Map" },
        { key = "lockid", label = "Lock ID:", type = "dropdown", options = LOCK_TYPES, defaultValue = 0, tooltip = "Lock ID for locked items", allowEdit = true, pair = "HolidayId", groupEnd = true },
        { key = "Map", label = "Map ID:", type = "number", min = 0, max = 65535, defaultValue = 0, tooltip = "Map restriction (0 = no restriction)" },
        { key = "HolidayId", label = "Holiday ID:", type = "dropdown", options = HOLIDAYS, defaultValue = 0, tooltip = "Holiday requirement ID", allowEdit = true },
        
        -- RANDOM PROPERTIES: Random Property vs Random Suffix (paired)
        { key = "RandomProperty", label = "Random Property:", type = "number", min = 0, defaultValue = 0, tooltip = "Random property group ID", pair = "RandomSuffix" },
        { key = "DisenchantID", label = "Disenchant ID:", type = "number", min = 0, defaultValue = 0, tooltip = "Disenchant loot template ID", pair = "startquest", groupEnd = true },
        { key = "RandomSuffix", label = "Random Suffix:", type = "number", min = 0, defaultValue = 0, tooltip = "Random suffix group ID" },
        { key = "startquest", label = "Start Quest:", type = "number", min = 0, defaultValue = 0, tooltip = "Quest ID that this item starts" },
        
        -- SOCKET SYSTEM: Socket 1 Color & Content vs Socket 2 Color & Content (paired)
        { key = "socketColor_1", label = "Socket 1 Color:", type = "dropdown", options = SOCKET_COLORS, defaultValue = 0, tooltip = "First socket color", allowEdit = true, pair = "socketColor_2" },
        { key = "socketContent_1", label = "Socket 1 Content:", type = "number", min = 0, defaultValue = 0, tooltip = "Default gem for socket 1", pair = "socketContent_2" },
        { key = "socketColor_2", label = "Socket 2 Color:", type = "dropdown", options = SOCKET_COLORS, defaultValue = 0, tooltip = "Second socket color", allowEdit = true },
        { key = "socketContent_2", label = "Socket 2 Content:", type = "number", min = 0, defaultValue = 0, tooltip = "Default gem for socket 2" },
        
        -- SOCKET 3 & BONUS: Socket 3 Color & Content vs Socket Bonus (paired)
        { key = "socketColor_3", label = "Socket 3 Color:", type = "dropdown", options = SOCKET_COLORS, defaultValue = 0, tooltip = "Third socket color", allowEdit = true, pair = "socketBonus" },
        { key = "socketContent_3", label = "Socket 3 Content:", type = "number", min = 0, defaultValue = 0, tooltip = "Default gem for socket 3", pair = "_empty", groupEnd = true },
        { key = "socketBonus", label = "Socket Bonus:", type = "number", min = 0, defaultValue = 0, tooltip = "Enchantment applied when all sockets filled correctly" },
        
        -- TEXT & MATERIALS: Page Text vs Language ID (paired)
        { key = "PageText", label = "Page Text:", type = "number", min = 0, defaultValue = 0, tooltip = "Page text ID for readable items", pair = "LanguageID" },
        { key = "PageMaterial", label = "Page Material:", type = "dropdown", options = PAGE_MATERIALS, defaultValue = 0, tooltip = "Material type for readable items", allowEdit = true, pair = "FoodType", groupEnd = true },
        { key = "LanguageID", label = "Language ID:", type = "dropdown", options = LANGUAGE_IDS, defaultValue = 0, tooltip = "Language ID for text", allowEdit = true },
        { key = "FoodType", label = "Food Type:", type = "dropdown", options = FOOD_TYPES, defaultValue = 0, tooltip = "Pet food type", allowEdit = true },
        
        -- LOOT MONEY & SYSTEM: Min Money vs Max Money (paired)
        { key = "minMoneyLoot", label = "Min Money Loot:", type = "number", min = 0, defaultValue = 0, tooltip = "Minimum money from opening (copper)", pair = "maxMoneyLoot" },
        { key = "ScriptName", label = "Script Name:", type = "text", maxLength = 64, tooltip = "Server script name", pair = "VerifiedBuild" },
        { key = "maxMoneyLoot", label = "Max Money Loot:", type = "number", min = 0, defaultValue = 0, tooltip = "Maximum money from opening (copper)" },
        { key = "VerifiedBuild", label = "Verified Build:", type = "number", min = 0, defaultValue = 0, tooltip = "Build version verification" }
    },
    
    Scaling = {
        { key = "ScalingStatDistribution", label = "Stat Distribution:", type = "number", min = 0, defaultValue = 0, tooltip = "Scaling stat distribution ID" },
        { key = "ScalingStatValue", label = "Stat Value:", type = "number", min = 0, defaultValue = 0, tooltip = "Scaling stat value" },
        -- { key = "ScalingPreset", label = "Scaling Preset:", type = "dropdown", options = {
        --     {value = "", text = "None"},
        --     {value = "heroic_10", text = "Heroic +10%"},
        --     {value = "heroic_25", text = "Heroic +25%"},
        --     {value = "mythic_50", text = "Mythic +50%"},
        --     {value = "pvp_balanced", text = "PvP Balanced"},
        --     {value = "leveling", text = "Leveling Gear"},
        --     {value = "endgame", text = "Endgame Gear"},
        --     {value = "custom", text = "Custom"}
        -- }, tooltip = "Predefined scaling configurations" }, -- Field not in database
        -- Custom scaling fields - these don't exist in database, commenting out
        -- { key = "StatModifier", label = "Stat Modifier:", type = "decimal", min = 0.1, max = 10.0, defaultValue = 1.0, step = 0.1, tooltip = "Multiplier for all stat values" },
        -- { key = "DamageModifier", label = "Damage Modifier:", type = "decimal", min = 0.1, max = 10.0, defaultValue = 1.0, step = 0.1, tooltip = "Multiplier for damage values" }, -- Field not in database
        -- { key = "ArmorModifier", label = "Armor Modifier:", type = "decimal", min = 0.1, max = 10.0, defaultValue = 1.0, step = 0.1, tooltip = "Multiplier for armor value" },
        -- { key = "RequiredLevelModifier", label = "Level Req. Modifier:", type = "number", min = -80, max = 80, defaultValue = 0, tooltip = "Adjustment to required level" }
    }
}

-- Predefined scaling presets (DISABLED - scaling fields don't exist in database)
--[[ SCALING PRESETS REMOVED - These referenced non-existent database fields
ItemTemplateFieldDefs.SCALING_PRESETS = {
    heroic_10 = {
        StatModifier = 1.1,
        ArmorModifier = 1.1,
        RequiredLevelModifier = 0
    },
    heroic_25 = {
        StatModifier = 1.25,
        ArmorModifier = 1.25,
        RequiredLevelModifier = 2
    },
    mythic_50 = {
        StatModifier = 1.5,
        ArmorModifier = 1.5,
        RequiredLevelModifier = 5
    },
    pvp_balanced = {
        StatModifier = 1.2,
        ArmorModifier = 1.3,
        RequiredLevelModifier = 0
    },
    leveling = {
        StatModifier = 0.8,
        ArmorModifier = 0.8,
        RequiredLevelModifier = -5
    },
    endgame = {
        StatModifier = 1.3,
        ArmorModifier = 1.2,
        RequiredLevelModifier = 10
    }
}
--]]

-- Item Template Field Definitions module loaded