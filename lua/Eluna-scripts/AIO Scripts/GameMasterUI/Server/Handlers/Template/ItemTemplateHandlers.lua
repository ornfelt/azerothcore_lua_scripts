--[[
    GameMasterUI Item Template Handlers Module

    This module handles all Item template operations:
    - Get Item template data
    - Save Item template data (create/update)
    - Delete Item templates
    - Find next available Item entry
    - Create blank Item templates

    Extracted from GameMasterUI_TemplateHandlers.lua (2,393 lines) to improve maintainability
    and follow single responsibility principle.
]]--

local ItemTemplateHandlers = {}

-- Module dependencies (will be injected)
local Config, Utils, DatabaseHelper, TemplateValidation

-- =====================================================
-- Module Initialization
-- =====================================================

function ItemTemplateHandlers.Initialize(config, utils, dbHelper, validation)
    Config = config
    Utils = utils
    DatabaseHelper = dbHelper
    TemplateValidation = validation
end

-- =====================================================
-- Item Template Data Retrieval
-- =====================================================

-- Get Item template data
function ItemTemplateHandlers.getItemTemplateData(player, entry)
    entry = tonumber(entry)
    if not entry or entry <= 0 then
        Utils.sendMessage(player, "error", "Invalid item entry")
        return
    end

    -- Check GM permission
    if player:GetGMRank() < 2 then
        Utils.sendMessage(player, "error", "Insufficient permissions")
        return
    end

    local itemTemplateQuery = string.format([[
        SELECT
            entry, class, subclass, SoundOverrideSubclass, name, displayid, Quality, Flags, FlagsExtra,
            BuyCount, BuyPrice, SellPrice, InventoryType, AllowableClass, AllowableRace,
            ItemLevel, RequiredLevel, RequiredSkill, RequiredSkillRank, requiredspell,
            requiredhonorrank, RequiredCityRank, RequiredReputationFaction, RequiredReputationRank,
            maxcount, stackable, ContainerSlots, StatsCount, stat_type1, stat_value1, stat_type2, stat_value2,
            stat_type3, stat_value3, stat_type4, stat_value4, stat_type5, stat_value5,
            stat_type6, stat_value6, stat_type7, stat_value7, stat_type8, stat_value8,
            stat_type9, stat_value9, stat_type10, stat_value10, dmg_min1, dmg_max1, dmg_type1,
            dmg_min2, dmg_max2, dmg_type2, armor, holy_res, fire_res, nature_res, frost_res,
            shadow_res, arcane_res, delay, ammo_type, RangedModRange, spellid_1, spelltrigger_1,
            spellcharges_1, spellppmRate_1, spellcooldown_1, spellcategory_1, spellcategorycooldown_1,
            spellid_2, spelltrigger_2, spellcharges_2, spellppmRate_2, spellcooldown_2, spellcategory_2,
            spellcategorycooldown_2, spellid_3, spelltrigger_3, spellcharges_3, spellppmRate_3, spellcooldown_3,
            spellcategory_3, spellcategorycooldown_3, spellid_4, spelltrigger_4, spellcharges_4, spellppmRate_4,
            spellcooldown_4, spellcategory_4, spellcategorycooldown_4, spellid_5, spelltrigger_5,
            spellcharges_5, spellppmRate_5, spellcooldown_5, spellcategory_5, spellcategorycooldown_5,
            bonding, description, PageText, LanguageID, PageMaterial, startquest, lockid, Material, sheath, RandomProperty, RandomSuffix, block,
            itemset, MaxDurability, area, Map, BagFamily, TotemCategory, socketColor_1,
            socketContent_1, socketColor_2, socketContent_2, socketColor_3, socketContent_3,
            socketBonus, GemProperties, RequiredDisenchantSkill, ArmorDamageModifier,
            duration, ItemLimitCategory, HolidayId, ScriptName, DisenchantID, FoodType,
            minMoneyLoot, maxMoneyLoot, flagsCustom, VerifiedBuild, ScalingStatDistribution, ScalingStatValue
        FROM item_template
        WHERE entry = %d
    ]], entry)

    -- Debug logging
    if Config.debug then
        print("[ItemTemplateHandlers] Querying item template for entry: " .. entry)
    end

    -- Query item_template data with async support
    ExecuteWorldQuery(itemTemplateQuery, function(itemQuery)
        if not itemQuery then
            Utils.sendMessage(player, "error", "Item not found in database")
            if Config.debug then
                print("[ItemTemplateHandlers] ERROR: Item entry " .. entry .. " not found in database")
            end
            return
        end

        if Config.debug then
            print("[ItemTemplateHandlers] Successfully retrieved data for item entry: " .. entry)
        end

    -- Build data object with all fields
    local data = {
        entry = itemQuery:GetUInt32(0),
        class = itemQuery:GetUInt32(1),
        subclass = itemQuery:GetUInt32(2),
        SoundOverrideSubclass = itemQuery:GetInt32(3),
        name = itemQuery:GetString(4) or "",
        displayid = itemQuery:GetUInt32(5),
        Quality = itemQuery:GetUInt32(6),
        Flags = itemQuery:GetUInt32(7),
        FlagsExtra = itemQuery:GetUInt32(8),
        BuyCount = itemQuery:GetUInt32(9),
        BuyPrice = itemQuery:GetUInt32(10),
        SellPrice = itemQuery:GetUInt32(11),
        InventoryType = itemQuery:GetUInt32(12),
        AllowableClass = itemQuery:GetInt32(13),
        AllowableRace = itemQuery:GetInt32(14),
        ItemLevel = itemQuery:GetUInt32(15),
        RequiredLevel = itemQuery:GetUInt32(16),
        RequiredSkill = itemQuery:GetUInt32(17),
        RequiredSkillRank = itemQuery:GetUInt32(18),
        requiredspell = itemQuery:GetUInt32(19),
        requiredhonorrank = itemQuery:GetUInt32(20),
        RequiredCityRank = itemQuery:GetUInt32(21),
        RequiredReputationFaction = itemQuery:GetUInt32(22),
        RequiredReputationRank = itemQuery:GetUInt32(23),
        maxcount = itemQuery:GetUInt32(24),
        stackable = itemQuery:GetUInt32(25),
        ContainerSlots = itemQuery:GetUInt32(26),
        StatsCount = itemQuery:GetUInt32(27),

        -- Stats
        stat_type1 = itemQuery:GetUInt32(28),
        stat_value1 = itemQuery:GetInt32(29),
        stat_type2 = itemQuery:GetUInt32(30),
        stat_value2 = itemQuery:GetInt32(31),
        stat_type3 = itemQuery:GetUInt32(32),
        stat_value3 = itemQuery:GetInt32(33),
        stat_type4 = itemQuery:GetUInt32(34),
        stat_value4 = itemQuery:GetInt32(35),
        stat_type5 = itemQuery:GetUInt32(36),
        stat_value5 = itemQuery:GetInt32(37),
        stat_type6 = itemQuery:GetUInt32(38),
        stat_value6 = itemQuery:GetInt32(39),
        stat_type7 = itemQuery:GetUInt32(40),
        stat_value7 = itemQuery:GetInt32(41),
        stat_type8 = itemQuery:GetUInt32(42),
        stat_value8 = itemQuery:GetInt32(43),
        stat_type9 = itemQuery:GetUInt32(44),
        stat_value9 = itemQuery:GetInt32(45),
        stat_type10 = itemQuery:GetUInt32(46),
        stat_value10 = itemQuery:GetInt32(47),

        -- Damage
        dmg_min1 = itemQuery:GetFloat(48),
        dmg_max1 = itemQuery:GetFloat(49),
        dmg_type1 = itemQuery:GetUInt32(50),
        dmg_min2 = itemQuery:GetFloat(51),
        dmg_max2 = itemQuery:GetFloat(52),
        dmg_type2 = itemQuery:GetUInt32(53),
        armor = itemQuery:GetUInt32(54),
        holy_res = itemQuery:GetUInt32(55),
        fire_res = itemQuery:GetUInt32(56),
        nature_res = itemQuery:GetUInt32(57),
        frost_res = itemQuery:GetUInt32(58),
        shadow_res = itemQuery:GetUInt32(59),
        arcane_res = itemQuery:GetUInt32(60),
        delay = itemQuery:GetUInt32(61),
        ammo_type = itemQuery:GetUInt32(62),
        RangedModRange = itemQuery:GetFloat(63),

        -- Spells
        spellid_1 = itemQuery:GetUInt32(64),
        spelltrigger_1 = itemQuery:GetUInt32(65),
        spellcharges_1 = itemQuery:GetInt32(66),
        spellppmRate_1 = itemQuery:GetFloat(67),
        spellcooldown_1 = itemQuery:GetInt32(68),
        spellcategory_1 = itemQuery:GetUInt32(69),
        spellcategorycooldown_1 = itemQuery:GetInt32(70),
        spellid_2 = itemQuery:GetUInt32(71),
        spelltrigger_2 = itemQuery:GetUInt32(72),
        spellcharges_2 = itemQuery:GetInt32(73),
        spellppmRate_2 = itemQuery:GetFloat(74),
        spellcooldown_2 = itemQuery:GetInt32(75),
        spellcategory_2 = itemQuery:GetUInt32(76),
        spellcategorycooldown_2 = itemQuery:GetInt32(77),
        spellid_3 = itemQuery:GetUInt32(78),
        spelltrigger_3 = itemQuery:GetUInt32(79),
        spellcharges_3 = itemQuery:GetInt32(80),
        spellppmRate_3 = itemQuery:GetFloat(81),
        spellcooldown_3 = itemQuery:GetInt32(82),
        spellcategory_3 = itemQuery:GetUInt32(83),
        spellcategorycooldown_3 = itemQuery:GetInt32(84),
        spellid_4 = itemQuery:GetUInt32(85),
        spelltrigger_4 = itemQuery:GetUInt32(86),
        spellcharges_4 = itemQuery:GetInt32(87),
        spellppmRate_4 = itemQuery:GetFloat(88),
        spellcooldown_4 = itemQuery:GetInt32(89),
        spellcategory_4 = itemQuery:GetUInt32(90),
        spellcategorycooldown_4 = itemQuery:GetInt32(91),
        spellid_5 = itemQuery:GetUInt32(92),
        spelltrigger_5 = itemQuery:GetUInt32(93),
        spellcharges_5 = itemQuery:GetInt32(94),
        spellppmRate_5 = itemQuery:GetFloat(95),
        spellcooldown_5 = itemQuery:GetInt32(96),
        spellcategory_5 = itemQuery:GetUInt32(97),
        spellcategorycooldown_5 = itemQuery:GetInt32(98),

        -- Other fields
        bonding = itemQuery:GetUInt32(99),
        description = itemQuery:GetString(100) or "",
        PageText = itemQuery:GetUInt32(101),
        LanguageID = itemQuery:GetUInt32(102),
        PageMaterial = itemQuery:GetUInt32(103),
        startquest = itemQuery:GetUInt32(104),
        lockid = itemQuery:GetUInt32(105),
        Material = itemQuery:GetInt32(106),
        sheath = itemQuery:GetUInt32(107),
        RandomProperty = itemQuery:GetUInt32(108),
        RandomSuffix = itemQuery:GetUInt32(109),
        block = itemQuery:GetUInt32(110),
        itemset = itemQuery:GetUInt32(111),
        MaxDurability = itemQuery:GetUInt32(112),
        area = itemQuery:GetUInt32(113),
        Map = itemQuery:GetUInt32(114),
        BagFamily = itemQuery:GetUInt32(115),
        TotemCategory = itemQuery:GetUInt32(116),
        socketColor_1 = itemQuery:GetUInt32(117),
        socketContent_1 = itemQuery:GetUInt32(118),
        socketColor_2 = itemQuery:GetUInt32(119),
        socketContent_2 = itemQuery:GetUInt32(120),
        socketColor_3 = itemQuery:GetUInt32(121),
        socketContent_3 = itemQuery:GetUInt32(122),
        socketBonus = itemQuery:GetUInt32(123),
        GemProperties = itemQuery:GetUInt32(124),
        RequiredDisenchantSkill = itemQuery:GetInt32(125),
        ArmorDamageModifier = itemQuery:GetFloat(126),
        duration = itemQuery:GetUInt32(127),
        ItemLimitCategory = itemQuery:GetUInt32(128),
        HolidayId = itemQuery:GetUInt32(129),
        ScriptName = itemQuery:GetString(130) or "",
        DisenchantID = itemQuery:GetUInt32(131),
        FoodType = itemQuery:GetUInt32(132),
        minMoneyLoot = itemQuery:GetUInt32(133),
        maxMoneyLoot = itemQuery:GetUInt32(134),
        flagsCustom = itemQuery:GetUInt32(135),
        VerifiedBuild = itemQuery:GetUInt32(136),
        ScalingStatDistribution = itemQuery:GetUInt32(137),
        ScalingStatValue = itemQuery:GetUInt32(138)
        }

        -- Debug logging
        if Config.debug then
            -- Count fields first
            local count = 0
            for _ in pairs(data) do
                count = count + 1
            end

            print(string.format("[ItemTemplateHandlers] Sending item %d data to client (%d fields)", entry, count))
            -- Print sample of data being sent
            local sampleCount = 0
            for key, value in pairs(data) do
                sampleCount = sampleCount + 1
                if sampleCount <= 5 then
                    print(string.format("[ItemTemplateHandlers] %s = %s", key, tostring(value)))
                end
            end
            print(string.format("[ItemTemplateHandlers] Total fields: %d", count))
        end

        -- Send data to client
        AIO.Handle(player, "ItemTemplateEditor", "HandleItemTemplateData", data)
    end) -- End of ExecuteWorldQuery callback
end

-- =====================================================
-- Item Template Data Updates
-- =====================================================

-- Save item template
function ItemTemplateHandlers.saveItemTemplate(player, requestData)
    -- Handle both old and new data formats for backward compatibility
    local entry, data, isDuplicate, customEntry

    if type(requestData) == "table" and requestData.entry then
        -- New format: data structure with entry, changes, customEntry
        entry = tonumber(requestData.entry)
        data = requestData.changes or {}
        isDuplicate = requestData.isDuplicate or false
        customEntry = requestData.customEntry
    else
        -- Legacy format: assume old parameters (entry, data, isDuplicate)
        entry = tonumber(requestData)
        data = data or {}
        isDuplicate = isDuplicate or false
    end

    entry = tonumber(entry)
    if not entry or entry <= 0 then
        AIO.Handle(player, "ItemTemplateEditor", "HandleItemTemplateSaved", false, "Invalid entry ID")
        return
    end

    -- Check GM permission
    if player:GetGMRank() < 2 then
        AIO.Handle(player, "ItemTemplateEditor", "HandleItemTemplateSaved", false, "Insufficient permissions")
        return
    end

    -- Handle entry ID change if custom entry is provided
    if customEntry then
        local newEntry = tonumber(customEntry)
        if not newEntry or newEntry <= 0 then
            Utils.sendMessage(player, "error", "Invalid custom entry ID")
            return
        end

        if newEntry ~= entry then
            -- Check if new entry already exists
            local existsQuery = WorldDBQuery("SELECT entry FROM item_template WHERE entry = " .. newEntry)
            if existsQuery then
                Utils.sendMessage(player, "error",
                    string.format("Entry ID %d already exists. Please choose a different ID.", newEntry))
                return
            end
            entry = newEntry  -- Use the custom entry ID
        end
    end

    -- Validate required fields - only for new items (isDuplicate = true)
    if isDuplicate and (not data.name or data.name == "") then
        AIO.Handle(player, "ItemTemplateEditor", "HandleItemTemplateSaved", false, "Item name is required for new items")
        return
    end
    -- For updates (isDuplicate = false), we don't validate name since item already exists

    -- Filter out UI-only fields that don't exist in database and validate remaining fields
    local validData = {}
    for fieldName, value in pairs(data) do
        -- Skip UI-only fields that are not in the database schema
        if fieldName ~= "ScalingPreset" and
           fieldName ~= "StatModifier" and
           fieldName ~= "DamageModifier" and
           fieldName ~= "ArmorModifier" and
           fieldName ~= "RequiredLevelModifier" then

            local valid, error = TemplateValidation.ValidateItemField(fieldName, value)
            if not valid then
                AIO.Handle(player, "ItemTemplateEditor", "HandleItemTemplateSaved", false, error)
                return
            end
            validData[fieldName] = value
        end
    end

    if Config.debug then
        -- Count fields
        local fieldCount = 0
        for _ in pairs(validData) do
            fieldCount = fieldCount + 1
        end
        print(string.format("[ItemTemplateHandlers] Saving item template %d, isDuplicate: %s", entry, tostring(isDuplicate)))
        print(string.format("[ItemTemplateHandlers] Data fields: %d", fieldCount))
    end

    -- Handle entry validation with async query support
    local function proceedWithSave(finalEntry)
        local query = ""

        if isDuplicate then
            -- Build field lists for INSERT operation
            local fieldNames = {}
            local fieldValues = {}

            -- Include the entry field for new items
            table.insert(fieldNames, "`entry`")
            table.insert(fieldValues, tostring(finalEntry))

            -- Add all valid data fields
            for key, value in pairs(validData) do
                table.insert(fieldNames, "`" .. key .. "`")
                if type(value) == "string" then
                    table.insert(fieldValues, "'" .. value:gsub("'", "''") .. "'")
                elseif value == nil then
                    table.insert(fieldValues, "NULL")
                else
                    table.insert(fieldValues, tostring(value))
                end
            end

            -- Insert new entry
            query = string.format(
                "INSERT INTO item_template (%s) VALUES (%s)",
                table.concat(fieldNames, ", "),
                table.concat(fieldValues, ", ")
            )

            if Config.debug then
                print(string.format("[ItemTemplateHandlers] Executing INSERT query: %s", query))
            end

            -- Execute query - don't check return value as it's unreliable
            WorldDBExecute(query)
        else
            -- Build UPDATE query with proper field=value pairs
            local updatePairs = {}
            local fieldCount = 0

            for key, value in pairs(validData) do
                if key ~= "entry" then  -- Skip entry field for updates
                    local pair
                    if type(value) == "string" then
                        -- Escape single quotes in strings
                        local escapedValue = value:gsub("'", "''")
                        pair = string.format("`%s` = '%s'", key, escapedValue)
                    elseif value == nil then
                        pair = string.format("`%s` = NULL", key)
                    elseif type(value) == "number" then
                        -- Handle decimal fields properly
                        local fieldDef = ITEM_TEMPLATE_FIELDS and ITEM_TEMPLATE_FIELDS[key]
                        if fieldDef and fieldDef.type == "decimal" then
                            pair = string.format("`%s` = %.4f", key, tonumber(value))
                        else
                            pair = string.format("`%s` = %d", key, tonumber(value))
                        end
                    else
                        pair = string.format("`%s` = %s", key, tostring(value))
                    end
                    table.insert(updatePairs, pair)
                    fieldCount = fieldCount + 1
                end
            end

            if fieldCount == 0 then
                AIO.Handle(player, "ItemTemplateEditor", "HandleItemTemplateSaved", false, "No fields to update")
                return
            end

            -- Build and execute UPDATE query
            query = string.format(
                "UPDATE item_template SET %s WHERE entry = %d",
                table.concat(updatePairs, ", "),
                finalEntry
            )

            if Config.debug then
                print(string.format("[ItemTemplateHandlers] Executing UPDATE query with %d fields: %s", fieldCount, query))
            end

            -- Execute query - don't check return value as it's unreliable
            WorldDBExecute(query)
        end

        -- Always send success response - database will throw error if it actually fails
        local message = isDuplicate and
            string.format("Item template created successfully! New ID: %d", finalEntry) or
            "Item template updated successfully!"
        AIO.Handle(player, "ItemTemplateEditor", "HandleItemTemplateSaved", true, message, finalEntry)

        if Config.debug then
            print(string.format("[ItemTemplateHandlers] %s", message))
        end

        if Utils and Utils.sendMessage then
            Utils.sendMessage(player, "success", message)
        end
    end

    if isDuplicate then
        -- Get next available entry if duplicating
        ExecuteWorldQuery("SELECT MAX(entry) FROM item_template", function(maxEntryQuery)
            local nextEntry = 1
            if maxEntryQuery then
                nextEntry = maxEntryQuery:GetUInt32(0) + 1
            end

            if Config.debug then
                print(string.format("[ItemTemplateHandlers] Next available entry ID: %d", nextEntry))
            end

            proceedWithSave(nextEntry)
        end)
    else
        -- Check if entry exists for updates
        ExecuteWorldQuery(string.format("SELECT entry FROM item_template WHERE entry = %d", entry), function(existQuery)
            if not existQuery then
                AIO.Handle(player, "ItemTemplateEditor", "HandleItemTemplateSaved", false, "Item entry does not exist")
                return
            end
            proceedWithSave(entry)
        end)
    end
end

-- =====================================================
-- Item Template Deletion
-- =====================================================

-- Delete item template
function ItemTemplateHandlers.deleteItemTemplate(player, entry)
    entry = tonumber(entry)
    if not entry or entry <= 0 then
        AIO.Handle(player, "ItemTemplateEditor", "HandleItemTemplateDeleted", false, "Invalid entry ID")
        return
    end

    -- Check GM permission
    if player:GetGMRank() < 2 then
        AIO.Handle(player, "ItemTemplateEditor", "HandleItemTemplateDeleted", false, "Insufficient permissions")
        return
    end

    if Config.debug then
        print(string.format("[ItemTemplateHandlers] Attempting to delete item template: %d", entry))
    end

    -- Check if entry exists before deletion
    ExecuteWorldQuery(string.format("SELECT entry, name FROM item_template WHERE entry = %d", entry), function(existQuery)
        if not existQuery then
            AIO.Handle(player, "ItemTemplateEditor", "HandleItemTemplateDeleted", false, "Item entry does not exist")
            return
        end

        local itemName = existQuery:GetString(1) or "Unknown Item"

        -- Perform the deletion
        local deleteQuery = string.format("DELETE FROM item_template WHERE entry = %d", entry)

        if Config.debug then
            print(string.format("[ItemTemplateHandlers] Executing DELETE query: %s", deleteQuery))
        end

        local success = WorldDBExecute(deleteQuery)

        if success then
            local message = string.format("Item template '%s' (ID: %d) deleted successfully!", itemName, entry)
            AIO.Handle(player, "ItemTemplateEditor", "HandleItemTemplateDeleted", true, message)

            if Config.debug then
                print(string.format("[ItemTemplateHandlers] %s", message))
            end

            if Utils and Utils.sendMessage then
                Utils.sendMessage(player, "success", message)
            end
        else
            local errorMsg = "Failed to delete item template from database"
            if Config.debug then
                print(string.format("[ItemTemplateHandlers] ERROR: %s", errorMsg))
            end

            AIO.Handle(player, "ItemTemplateEditor", "HandleItemTemplateDeleted", false, errorMsg)
            if Utils and Utils.sendMessage then
                Utils.sendMessage(player, "error", errorMsg)
            end
        end
    end)
end

-- =====================================================
-- Utility Functions
-- =====================================================

-- Get next available item entry ID
function ItemTemplateHandlers.getNextAvailableItemEntry(player)
    -- Check GM permission
    if player:GetGMRank() < 2 then
        Utils.sendMessage(player, "error", "Insufficient permissions")
        return
    end

    -- Query for the maximum entry ID with async support
    ExecuteWorldQuery("SELECT MAX(entry) FROM item_template", function(maxEntryQuery)
        local nextEntry = 1

        if maxEntryQuery then
            local maxEntry = maxEntryQuery:GetUInt32(0)
            if maxEntry then
                nextEntry = maxEntry + 1
            end
        end

        -- Send the next available entry to the client
        AIO.Handle(player, "ItemTemplateEditor", "HandleNextAvailableItemEntry", nextEntry)
    end)
end

-- Create new blank item template
function ItemTemplateHandlers.createBlankItemTemplate(player)
    -- Check GM permission
    if player:GetGMRank() < 2 then
        AIO.Handle(player, "ItemTemplateEditor", "HandleItemTemplateData", nil)
        return
    end

    if Config.debug then
        print("[ItemTemplateHandlers] Creating blank item template")
    end

    -- Get next available entry for the blank template
    ExecuteWorldQuery("SELECT MAX(entry) FROM item_template", function(maxEntryQuery)
        local nextEntry = 1
        if maxEntryQuery then
            nextEntry = maxEntryQuery:GetUInt32(0) + 1
        end

        if Config.debug then
            print(string.format("[ItemTemplateHandlers] Next entry for blank template: %d", nextEntry))
        end

        -- Create a minimal template with default values
        local blankData = {
            entry = nextEntry,
            name = "New Item",
            description = "",
            displayid = 1,
            Quality = 1,
            Flags = 0,
            FlagsExtra = 0,
            BuyCount = 1,
            BuyPrice = 0,
            SellPrice = 0,
            InventoryType = 0,
            AllowableClass = -1,
            AllowableRace = -1,
            ItemLevel = 1,
            RequiredLevel = 1,
            RequiredSkill = 0,
            RequiredSkillRank = 0,
            requiredspell = 0,
            requiredhonorrank = 0,
            RequiredCityRank = 0,
            RequiredReputationFaction = 0,
            RequiredReputationRank = 0,
            maxcount = 0,
            stackable = 1,
            ContainerSlots = 0,
            StatsCount = 0,
            bonding = 0,
            class = 0,
            subclass = 0,
            Material = 0,
            sheath = 0,
            RandomProperty = 0,
            RandomSuffix = 0,
            block = 0,
            itemset = 0,
            MaxDurability = 0,
            area = 0,
            Map = 0,
            BagFamily = 0,
            TotemCategory = 0,
            ArmorDamageModifier = 0,
            duration = 0,
            ItemLimitCategory = 0,
            HolidayId = 0,
            ScriptName = "",
            DisenchantID = 0,
            FoodType = 0,
            minMoneyLoot = 0,
            maxMoneyLoot = 0,
            flagsCustom = 0,
            VerifiedBuild = 0
        }

        -- Send the blank template to the client
        AIO.Handle(player, "ItemTemplateEditor", "HandleItemTemplateData", blankData)

        -- Also send the next available entry
        AIO.Handle(player, "ItemTemplateEditor", "HandleNextAvailableItemEntry", nextEntry)
    end)
end

return ItemTemplateHandlers