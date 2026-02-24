--[[
    GameMasterUI Template Validation Module

    Centralized validation functions for all template types:
    - Creature template field validation
    - GameObject template field validation
    - Item template field validation
    - Common validation utilities

    Extracted from GameMasterUI_TemplateHandlers.lua to improve maintainability
    and follow single responsibility principle.
]]--

local TemplateValidation = {}

-- =====================================================
-- Module Initialization
-- =====================================================

function TemplateValidation.Initialize(config, utils, databaseHelper)
    -- TemplateValidation is a stateless utility module that provides
    -- validation functions and field definitions. No initialization
    -- is required, but this function exists for consistency with
    -- the modular architecture pattern.
end

-- =====================================================
-- Creature Template Field Definitions & Validation
-- =====================================================

-- Template field definitions with validation rules (based on actual database schema)
local CREATURE_TEMPLATE_FIELDS = {
    -- Basic fields
    name = { type = "string", max_length = 100 },
    subname = { type = "string", max_length = 100, nullable = true },
    IconName = { type = "string", max_length = 100, nullable = true },
    minlevel = { type = "number", min = 1, max = 255 },
    maxlevel = { type = "number", min = 1, max = 255 },
    faction = { type = "number", min = 0, max = 65535 },
    rank = { type = "number", min = 0, max = 255 },
    family = { type = "number", min = -128, max = 127 },  -- tinyint signed
    type = { type = "number", min = 0, max = 255 },
    exp = { type = "number", min = -32768, max = 32767 },  -- smallint

    -- Model and display
    modelid1 = { type = "number", min = 0 },
    modelid2 = { type = "number", min = 0 },
    modelid3 = { type = "number", min = 0 },
    modelid4 = { type = "number", min = 0 },
    scale = { type = "decimal", min = 0.1, max = 10 },

    -- Difficulty and credits
    difficulty_entry_1 = { type = "number", min = 0 },
    difficulty_entry_2 = { type = "number", min = 0 },
    difficulty_entry_3 = { type = "number", min = 0 },
    KillCredit1 = { type = "number", min = 0 },
    KillCredit2 = { type = "number", min = 0 },

    -- Flag fields
    npcflag = { type = "number", min = 0 },
    unit_flags = { type = "number", min = 0 },
    unit_flags2 = { type = "number", min = 0 },
    type_flags = { type = "number", min = 0 },
    flags_extra = { type = "number", min = 0 },
    dynamicflags = { type = "number", min = 0 },

    -- Combat fields
    dmgschool = { type = "number", min = -128, max = 127 },  -- tinyint
    BaseAttackTime = { type = "number", min = 0 },
    RangeAttackTime = { type = "number", min = 0 },
    BaseVariance = { type = "decimal", min = 0, max = 10 },
    RangeVariance = { type = "decimal", min = 0, max = 10 },
    unit_class = { type = "number", min = 0, max = 255 },
    HealthModifier = { type = "decimal", min = 0.01, max = 1000 },
    ManaModifier = { type = "decimal", min = 0, max = 1000 },
    ArmorModifier = { type = "decimal", min = 0, max = 1000 },
    DamageModifier = { type = "decimal", min = 0, max = 1000 },
    ExperienceModifier = { type = "decimal", min = 0, max = 10 },

    -- Movement fields
    speed_walk = { type = "decimal", min = 0.1, max = 50 },
    speed_run = { type = "decimal", min = 0.1, max = 50 },
    HoverHeight = { type = "decimal", min = 0, max = 100 },
    MovementType = { type = "number", min = 0, max = 255 },
    movementId = { type = "number", min = 0 },

    -- Loot fields
    lootid = { type = "number", min = 0 },
    pickpocketloot = { type = "number", min = 0 },
    skinloot = { type = "number", min = 0 },
    mingold = { type = "number", min = 0 },
    maxgold = { type = "number", min = 0 },

    -- Special fields
    gossip_menu_id = { type = "number", min = 0 },
    PetSpellDataId = { type = "number", min = 0 },
    VehicleId = { type = "number", min = 0 },
    RacialLeader = { type = "number", min = 0, max = 255 },
    RegenHealth = { type = "number", min = 0, max = 255 },

    -- Immunity fields
    mechanic_immune_mask = { type = "number", min = 0 },
    spell_school_immune_mask = { type = "number", min = 0 },

    -- Script fields
    AIName = { type = "string", max_length = 64, nullable = true },
    ScriptName = { type = "string", max_length = 64, nullable = true },

    -- Addon fields (creature_template_addon)
    StandState = { type = "number", min = 0, max = 255 },
    AnimTier = { type = "number", min = 0, max = 255 },
    VisFlags = { type = "number", min = 0, max = 255 },
    SheathState = { type = "number", min = 0, max = 255 },
    PvPFlags = { type = "number", min = 0, max = 255 },
    emote = { type = "number", min = 0 },
    visibilityDistanceType = { type = "number", min = 0, max = 255 },
    mount = { type = "number", min = 0 },
    MountCreatureID = { type = "number", min = 0 },
    path_id = { type = "number", min = 0 },
    auras = { type = "string", max_length = 255, nullable = true },
}

-- =====================================================
-- GameObject Template Field Definitions
-- =====================================================

local GAMEOBJECT_TEMPLATE_FIELDS = {
    -- Basic fields
    name = { type = "string", max_length = 100 },
    type = { type = "number", min = 0, max = 255 },
    displayid = { type = "number", min = 0 },
    IconName = { type = "string", max_length = 100, nullable = true },
    castBarCaption = { type = "string", max_length = 100, nullable = true },
    unk1 = { type = "string", max_length = 100, nullable = true },
    faction = { type = "number", min = 0, max = 65535 },
    flags = { type = "number", min = 0 },
    ExtraFlags = { type = "number", min = 0 },
    size = { type = "decimal", min = 0.1, max = 50 },

    -- Data fields (0-23)
    data0 = { type = "number", min = 0 },
    data1 = { type = "number", min = 0 },
    data2 = { type = "number", min = 0 },
    data3 = { type = "number", min = 0 },
    data4 = { type = "number", min = 0 },
    data5 = { type = "number", min = 0 },
    data6 = { type = "number", min = 0 },
    data7 = { type = "number", min = 0 },
    data8 = { type = "number", min = 0 },
    data9 = { type = "number", min = 0 },
    data10 = { type = "number", min = 0 },
    data11 = { type = "number", min = 0 },
    data12 = { type = "number", min = 0 },
    data13 = { type = "number", min = 0 },
    data14 = { type = "number", min = 0 },
    data15 = { type = "number", min = 0 },
    data16 = { type = "number", min = 0 },
    data17 = { type = "number", min = 0 },
    data18 = { type = "number", min = 0 },
    data19 = { type = "number", min = 0 },
    data20 = { type = "number", min = 0 },
    data21 = { type = "number", min = 0 },
    data22 = { type = "number", min = 0 },
    data23 = { type = "number", min = 0 },

    -- AI and script fields
    AIName = { type = "string", max_length = 64, nullable = true },
    ScriptName = { type = "string", max_length = 64, nullable = true },
}

-- =====================================================
-- Item Template Field Definitions
-- =====================================================

local ITEM_TEMPLATE_FIELDS = {
    -- Basic fields
    name = { type = "string", max_length = 255 },
    description = { type = "string", max_length = 255, nullable = true },
    displayid = { type = "number", min = 0 },
    Quality = { type = "number", min = 0, max = 7 },
    Flags = { type = "number", min = 0 },
    FlagsExtra = { type = "number", min = 0 },
    BuyPrice = { type = "number", min = 0 },
    SellPrice = { type = "number", min = 0 },
    InventoryType = { type = "number", min = 0, max = 255 },
    AllowableClass = { type = "number", min = -1 },
    AllowableRace = { type = "number", min = -1 },
    ItemLevel = { type = "number", min = 1, max = 1000 },
    RequiredLevel = { type = "number", min = 0, max = 255 },
    RequiredSkill = { type = "number", min = 0 },
    RequiredSkillRank = { type = "number", min = 0 },
    requiredspell = { type = "number", min = 0 },
    requiredhonorrank = { type = "number", min = 0 },
    RequiredCityRank = { type = "number", min = 0 },
    RequiredReputationFaction = { type = "number", min = 0 },
    RequiredReputationRank = { type = "number", min = 0 },
    maxcount = { type = "number", min = 0, max = 255 },
    stackable = { type = "number", min = 1, max = 255 },
    ContainerSlots = { type = "number", min = 0, max = 255 },
    class = { type = "number", min = 0, max = 255 },
    subclass = { type = "number", min = 0, max = 255 },

    -- Stats (1-10)
    stat_type1 = { type = "number", min = -128, max = 127 },
    stat_value1 = { type = "number", min = -32768, max = 32767 },
    stat_type2 = { type = "number", min = -128, max = 127 },
    stat_value2 = { type = "number", min = -32768, max = 32767 },
    stat_type3 = { type = "number", min = -128, max = 127 },
    stat_value3 = { type = "number", min = -32768, max = 32767 },
    stat_type4 = { type = "number", min = -128, max = 127 },
    stat_value4 = { type = "number", min = -32768, max = 32767 },
    stat_type5 = { type = "number", min = -128, max = 127 },
    stat_value5 = { type = "number", min = -32768, max = 32767 },
    stat_type6 = { type = "number", min = -128, max = 127 },
    stat_value6 = { type = "number", min = -32768, max = 32767 },
    stat_type7 = { type = "number", min = -128, max = 127 },
    stat_value7 = { type = "number", min = -32768, max = 32767 },
    stat_type8 = { type = "number", min = -128, max = 127 },
    stat_value8 = { type = "number", min = -32768, max = 32767 },
    stat_type9 = { type = "number", min = -128, max = 127 },
    stat_value9 = { type = "number", min = -32768, max = 32767 },
    stat_type10 = { type = "number", min = -128, max = 127 },
    stat_value10 = { type = "number", min = -32768, max = 32767 },

    -- Damage fields
    dmg_min1 = { type = "decimal", min = 0 },
    dmg_max1 = { type = "decimal", min = 0 },
    dmg_type1 = { type = "number", min = 0, max = 255 },
    dmg_min2 = { type = "decimal", min = 0 },
    dmg_max2 = { type = "decimal", min = 0 },
    dmg_type2 = { type = "number", min = 0, max = 255 },

    -- Resistance fields
    armor = { type = "number", min = 0 },
    holy_res = { type = "number", min = 0 },
    fire_res = { type = "number", min = 0 },
    nature_res = { type = "number", min = 0 },
    frost_res = { type = "number", min = 0 },
    shadow_res = { type = "number", min = 0 },
    arcane_res = { type = "number", min = 0 },

    -- Other fields
    delay = { type = "number", min = 0 },
    ammo_type = { type = "number", min = 0 },
    RangedModRange = { type = "decimal", min = 0 },
    bonding = { type = "number", min = 0, max = 255 },
    PageText = { type = "number", min = 0 },
    LanguageID = { type = "number", min = 0 },
    PageMaterial = { type = "number", min = 0 },
    startquest = { type = "number", min = 0 },
    lockid = { type = "number", min = 0 },
    Material = { type = "number", min = -128, max = 127 },
    sheath = { type = "number", min = 0, max = 255 },
    RandomProperty = { type = "number", min = 0 },
    RandomSuffix = { type = "number", min = 0 },
    block = { type = "number", min = 0 },
    itemset = { type = "number", min = 0 },
    MaxDurability = { type = "number", min = 0 },
    area = { type = "number", min = 0 },
    Map = { type = "number", min = 0 },
    BagFamily = { type = "number", min = 0 },
    TotemCategory = { type = "number", min = 0 },
    duration = { type = "number", min = 0 },
    ItemLimitCategory = { type = "number", min = 0 },
    HolidayId = { type = "number", min = 0 },
}

-- =====================================================
-- Core Validation Functions
-- =====================================================

-- Validate a single field value
local function validateFieldCore(fieldName, value, fieldDefinitions)
    local fieldDef = fieldDefinitions[fieldName]
    if not fieldDef then
        return false, "Unknown field: " .. fieldName
    end

    -- Check nullable
    if value == nil or value == "" then
        if fieldDef.nullable then
            return true
        else
            return false, fieldName .. " cannot be empty"
        end
    end

    -- Type validation
    if fieldDef.type == "string" then
        if type(value) ~= "string" then
            return false, fieldName .. " must be a string"
        end
        if fieldDef.max_length and #value > fieldDef.max_length then
            return false, fieldName .. " exceeds maximum length of " .. fieldDef.max_length
        end
    elseif fieldDef.type == "number" then
        value = tonumber(value)
        if not value then
            return false, fieldName .. " must be a number"
        end
        if fieldDef.min and value < fieldDef.min then
            return false, fieldName .. " cannot be less than " .. fieldDef.min
        end
        if fieldDef.max and value > fieldDef.max then
            return false, fieldName .. " cannot be greater than " .. fieldDef.max
        end
    elseif fieldDef.type == "decimal" then
        value = tonumber(value)
        if not value then
            return false, fieldName .. " must be a decimal number"
        end
        if fieldDef.min and value < fieldDef.min then
            return false, fieldName .. " cannot be less than " .. fieldDef.min
        end
        if fieldDef.max and value > fieldDef.max then
            return false, fieldName .. " cannot be greater than " .. fieldDef.max
        end
    end

    return true
end

-- =====================================================
-- Public Validation Functions
-- =====================================================

-- Validate creature template field
function TemplateValidation.ValidateCreatureField(fieldName, value)
    return validateFieldCore(fieldName, value, CREATURE_TEMPLATE_FIELDS)
end

-- Validate GameObject template field
function TemplateValidation.ValidateGameObjectField(fieldName, value)
    return validateFieldCore(fieldName, value, GAMEOBJECT_TEMPLATE_FIELDS)
end

-- Validate item template field
function TemplateValidation.ValidateItemField(fieldName, value)
    return validateFieldCore(fieldName, value, ITEM_TEMPLATE_FIELDS)
end

-- Validate all fields in a creature template data object
function TemplateValidation.ValidateCreatureTemplate(data)
    local errors = {}

    for fieldName, value in pairs(data) do
        if fieldName ~= "entry" then -- Skip entry field as it's handled separately
            local isValid, errorMsg = TemplateValidation.ValidateCreatureField(fieldName, value)
            if not isValid then
                table.insert(errors, errorMsg)
            end
        end
    end

    return #errors == 0, errors
end

-- Validate all fields in a GameObject template data object
function TemplateValidation.ValidateGameObjectTemplate(data)
    local errors = {}

    for fieldName, value in pairs(data) do
        if fieldName ~= "entry" then -- Skip entry field as it's handled separately
            local isValid, errorMsg = TemplateValidation.ValidateGameObjectField(fieldName, value)
            if not isValid then
                table.insert(errors, errorMsg)
            end
        end
    end

    return #errors == 0, errors
end

-- Validate all fields in an item template data object
function TemplateValidation.ValidateItemTemplate(data)
    local errors = {}

    for fieldName, value in pairs(data) do
        if fieldName ~= "entry" then -- Skip entry field as it's handled separately
            local isValid, errorMsg = TemplateValidation.ValidateItemField(fieldName, value)
            if not isValid then
                table.insert(errors, errorMsg)
            end
        end
    end

    return #errors == 0, errors
end

-- Get field definitions (for external use)
function TemplateValidation.GetCreatureFields()
    return CREATURE_TEMPLATE_FIELDS
end

function TemplateValidation.GetGameObjectFields()
    return GAMEOBJECT_TEMPLATE_FIELDS
end

function TemplateValidation.GetItemFields()
    return ITEM_TEMPLATE_FIELDS
end

return TemplateValidation