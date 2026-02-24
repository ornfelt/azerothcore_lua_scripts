--[[
    GameMasterUI Creature Template Handlers Module

    This module handles all creature template operations:
    - Get creature template data
    - Update creature template data
    - Duplicate creature templates
    - Find next available creature entry

    Extracted from GameMasterUI_TemplateHandlers.lua (2,393 lines) to improve maintainability
    and follow single responsibility principle.
]]--

local CreatureTemplateHandlers = {}

-- Module dependencies (will be injected)
local Config, Utils, DatabaseHelper, TemplateValidation

-- =====================================================
-- Module Initialization
-- =====================================================

function CreatureTemplateHandlers.Initialize(config, utils, dbHelper, validation)
    Config = config
    Utils = utils
    DatabaseHelper = dbHelper
    TemplateValidation = validation
end

-- =====================================================
-- Creature Template Data Retrieval
-- =====================================================

-- Get creature template data
function CreatureTemplateHandlers.getCreatureTemplateData(player, entry)
    entry = tonumber(entry)
    if not entry or entry <= 0 then
        Utils.sendMessage(player, "error", "Invalid creature entry")
        return
    end

    -- Query basic fields first (these should exist in all cores)
    local basicQuery = WorldDBQuery(string.format([[
        SELECT
            entry, name, subname, minlevel, maxlevel, faction
        FROM creature_template
        WHERE entry = %d
    ]], entry))

    if not basicQuery then
        Utils.sendMessage(player, "error", "Creature not found in database")
        return
    end

    -- Build basic data object with all fields initialized to defaults
    local data = {
        entry = basicQuery:GetUInt32(0),
        name = basicQuery:GetString(1) or "",
        subname = basicQuery:GetString(2) or "",
        minlevel = basicQuery:GetUInt32(3),
        maxlevel = basicQuery:GetUInt32(4),
        faction = basicQuery:GetUInt32(5),
        -- Default values for all other fields
        rank = 0,
        family = 0,
        type = 0,
        exp = 0,
        IconName = "",
        gossip_menu_id = 0,
        difficulty_entry_1 = 0,
        difficulty_entry_2 = 0,
        difficulty_entry_3 = 0,
        KillCredit1 = 0,
        KillCredit2 = 0,
        modelid1 = 0,
        modelid2 = 0,
        modelid3 = 0,
        modelid4 = 0,
        npcflag = 0,
        unit_flags = 0,
        unit_flags2 = 0,
        type_flags = 0,
        flags_extra = 0,
        dynamicflags = 0,
        dmgschool = 0,
        unit_class = 0,
        BaseAttackTime = 2000,
        RangeAttackTime = 2000,
        BaseVariance = 1.0,
        RangeVariance = 1.0,
        HealthModifier = 1.0,
        ManaModifier = 1.0,
        ArmorModifier = 1.0,
        DamageModifier = 1.0,
        ExperienceModifier = 1.0,
        speed_walk = 1.0,
        speed_run = 1.14286,
        scale = 1.0,
        HoverHeight = 1.0,
        MovementType = 0,
        movementId = 0,
        lootid = 0,
        pickpocketloot = 0,
        skinloot = 0,
        mingold = 0,
        maxgold = 0,
        PetSpellDataId = 0,
        VehicleId = 0,
        RacialLeader = 0,
        RegenHealth = 1,
        mechanic_immune_mask = 0,
        spell_school_immune_mask = 0,
        AIName = "",
        ScriptName = "",
        -- Addon fields defaults
        StandState = 0,
        AnimTier = 0,
        VisFlags = 0,
        SheathState = 1,
        PvPFlags = 0,
        emote = 0,
        visibilityDistanceType = 0,
        mount = 0,
        MountCreatureID = 0,
        path_id = 0,
        auras = "",
    }

    -- Query all available fields from the actual database schema
    local fullQuery = WorldDBQuery(string.format([[
        SELECT
            `rank`, family, type, npcflag, unit_flags, unit_flags2, dynamicflags,
            speed_walk, speed_run, scale, dmgschool, BaseAttackTime, RangeAttackTime,
            BaseVariance, RangeVariance, unit_class, type_flags,
            lootid, pickpocketloot, skinloot, mingold, maxgold,
            AIName, MovementType, HoverHeight,
            HealthModifier, ManaModifier, ArmorModifier, DamageModifier, ExperienceModifier,
            mechanic_immune_mask, spell_school_immune_mask, flags_extra,
            ScriptName, IconName, gossip_menu_id, exp,
            difficulty_entry_1, difficulty_entry_2, difficulty_entry_3,
            KillCredit1, KillCredit2,
            modelid1, modelid2, modelid3, modelid4,
            PetSpellDataId, VehicleId, RacialLeader, movementId, RegenHealth
        FROM creature_template
        WHERE entry = %d
    ]], entry))

    if fullQuery then
        -- Override defaults with actual values
        data.rank = fullQuery:GetUInt32(0)
        data.family = fullQuery:GetInt32(1)  -- tinyint signed
        data.type = fullQuery:GetUInt32(2)
        data.npcflag = fullQuery:GetUInt32(3)
        data.unit_flags = fullQuery:GetUInt32(4)
        data.unit_flags2 = fullQuery:GetUInt32(5)
        data.dynamicflags = fullQuery:GetUInt32(6)
        data.speed_walk = fullQuery:GetFloat(7)
        data.speed_run = fullQuery:GetFloat(8)
        data.scale = fullQuery:GetFloat(9)
        data.dmgschool = fullQuery:GetInt32(10)
        data.BaseAttackTime = fullQuery:GetUInt32(11)
        data.RangeAttackTime = fullQuery:GetUInt32(12)
        data.BaseVariance = fullQuery:GetFloat(13)
        data.RangeVariance = fullQuery:GetFloat(14)
        data.unit_class = fullQuery:GetUInt32(15)
        data.type_flags = fullQuery:GetUInt32(16)
        data.lootid = fullQuery:GetUInt32(17)
        data.pickpocketloot = fullQuery:GetUInt32(18)
        data.skinloot = fullQuery:GetUInt32(19)
        data.mingold = fullQuery:GetUInt32(20)
        data.maxgold = fullQuery:GetUInt32(21)
        data.AIName = fullQuery:GetString(22) or ""
        data.MovementType = fullQuery:GetUInt32(23)
        data.HoverHeight = fullQuery:GetFloat(24)
        data.HealthModifier = fullQuery:GetFloat(25)
        data.ManaModifier = fullQuery:GetFloat(26)
        data.ArmorModifier = fullQuery:GetFloat(27)
        data.DamageModifier = fullQuery:GetFloat(28)
        data.ExperienceModifier = fullQuery:GetFloat(29)
        data.mechanic_immune_mask = fullQuery:GetUInt32(30)
        data.spell_school_immune_mask = fullQuery:GetUInt32(31)
        data.flags_extra = fullQuery:GetUInt32(32)
        data.ScriptName = fullQuery:GetString(33) or ""
        data.IconName = fullQuery:GetString(34) or ""
        data.gossip_menu_id = fullQuery:GetUInt32(35)
        data.exp = fullQuery:GetInt32(36)
        data.difficulty_entry_1 = fullQuery:GetUInt32(37)
        data.difficulty_entry_2 = fullQuery:GetUInt32(38)
        data.difficulty_entry_3 = fullQuery:GetUInt32(39)
        data.KillCredit1 = fullQuery:GetUInt32(40)
        data.KillCredit2 = fullQuery:GetUInt32(41)
        data.modelid1 = fullQuery:GetUInt32(42)
        data.modelid2 = fullQuery:GetUInt32(43)
        data.modelid3 = fullQuery:GetUInt32(44)
        data.modelid4 = fullQuery:GetUInt32(45)
        data.PetSpellDataId = fullQuery:GetUInt32(46)
        data.VehicleId = fullQuery:GetUInt32(47)
        data.RacialLeader = fullQuery:GetUInt32(48)
        data.movementId = fullQuery:GetUInt32(49)
        data.RegenHealth = fullQuery:GetUInt32(50)
    end

    -- Query addon data from creature_template_addon
    local addonQuery = WorldDBQuery(string.format([[
        SELECT
            path_id, mount, MountCreatureID, StandState, AnimTier, VisFlags,
            SheathState, PvPFlags, emote, visibilityDistanceType, auras
        FROM creature_template_addon
        WHERE entry = %d
    ]], entry))

    if addonQuery then
        data.path_id = addonQuery:GetUInt32(0)
        data.mount = addonQuery:GetUInt32(1)
        data.MountCreatureID = addonQuery:GetUInt32(2)
        data.StandState = addonQuery:GetUInt32(3)
        data.AnimTier = addonQuery:GetUInt32(4)
        data.VisFlags = addonQuery:GetUInt32(5)
        data.SheathState = addonQuery:GetUInt32(6)
        data.PvPFlags = addonQuery:GetUInt32(7)
        data.emote = addonQuery:GetUInt32(8)
        data.visibilityDistanceType = addonQuery:GetUInt32(9)
        data.auras = addonQuery:GetString(10) or ""
    end

    -- Send data to client
    AIO.Handle(player, "CreatureTemplateEditor", "ReceiveTemplateData", data)
end

-- =====================================================
-- Creature Template Data Updates
-- =====================================================

-- Update creature template
function CreatureTemplateHandlers.updateCreatureTemplate(player, data)
    if not data or not data.entry then
        Utils.sendMessage(player, "error", "Invalid update data")
        return
    end

    local entry = tonumber(data.entry)
    if not entry or entry <= 0 then
        Utils.sendMessage(player, "error", "Invalid creature entry")
        return
    end

    -- Check GM permission
    if player:GetGMRank() < 2 then
        Utils.sendMessage(player, "error", "Insufficient permissions")
        return
    end

    -- Handle entry ID change if custom entry is provided
    if data.customEntry then
        local newEntry = tonumber(data.customEntry)
        if not newEntry or newEntry <= 0 then
            Utils.sendMessage(player, "error", "Invalid custom entry ID")
            return
        end

        if newEntry ~= entry then
            -- Check if new entry already exists
            local existsQuery = WorldDBQuery("SELECT entry FROM creature_template WHERE entry = " .. newEntry)
            if existsQuery then
                Utils.sendMessage(player, "error",
                        string.format("Entry ID %d already exists. Please choose a different ID.", newEntry))
                return
            end

            -- Update the entry ID
            WorldDBExecute(string.format(
                    "UPDATE creature_template SET entry = %d WHERE entry = %d",
                    newEntry, entry
            ))

            -- Update related tables
            pcall(function()
                -- Update creature_equip_template
                local hasCreatureIDColumn = WorldDBQuery("SHOW COLUMNS FROM creature_equip_template LIKE 'CreatureID'")
                if hasCreatureIDColumn then
                    WorldDBExecute(string.format(
                            "UPDATE creature_equip_template SET CreatureID = %d WHERE CreatureID = %d",
                            newEntry, entry
                    ))
                else
                    WorldDBExecute(string.format(
                            "UPDATE creature_equip_template SET entry = %d WHERE entry = %d",
                            newEntry, entry
                    ))
                end

                -- Update creature_template_addon
                WorldDBExecute(string.format(
                        "UPDATE creature_template_addon SET entry = %d WHERE entry = %d",
                        newEntry, entry
                ))

                -- Update spawned creatures
                WorldDBExecute(string.format(
                        "UPDATE creature SET id = %d WHERE id = %d",
                        newEntry, entry
                ))
            end)

            -- Update entry for further processing
            entry = newEntry

            Utils.sendMessage(player, "info",
                    string.format("Entry ID changed to %d", newEntry))
        end
    end

    -- Validate all changes
    if data.changes then
        for fieldName, value in pairs(data.changes) do
            local valid, error = TemplateValidation.ValidateCreatureField(fieldName, value)
            if not valid then
                Utils.sendMessage(player, "error", error)
                return
            end
        end
    end

    -- Separate changes into template and addon fields
    local templateChanges = {}
    local addonChanges = {}
    local addonFields = {
        StandState = true, AnimTier = true, VisFlags = true, SheathState = true,
        PvPFlags = true, emote = true, visibilityDistanceType = true,
        mount = true, MountCreatureID = true, path_id = true, auras = true
    }

    -- Build UPDATE query if there are changes
    if data.changes and next(data.changes) then
        for fieldName, value in pairs(data.changes) do
            if addonFields[fieldName] then
                addonChanges[fieldName] = value
            else
                templateChanges[fieldName] = value
            end
        end

        local success = false

        -- Update creature_template
        if next(templateChanges) then
            local setParts = {}
            for fieldName, value in pairs(templateChanges) do
                if type(value) == "string" then
                    table.insert(setParts, string.format("`%s` = '%s'", fieldName, Utils.escapeString(value)))
                else
                    table.insert(setParts, string.format("`%s` = %s", fieldName, tostring(value)))
                end
            end

            local updateQuery = string.format(
                    "UPDATE creature_template SET %s WHERE entry = %d",
                    table.concat(setParts, ", "), entry
            )

            local result = WorldDBExecute(updateQuery)
            if result ~= nil then
                success = true
            else
                Utils.sendMessage(player, "error", "Failed to update creature template")
                return
            end
        end

        -- Update creature_template_addon
        if next(addonChanges) then
            -- Check if addon entry exists
            local addonExists = WorldDBQuery(string.format(
                    "SELECT entry FROM creature_template_addon WHERE entry = %d",
                    entry
            ))

            if addonExists then
                -- Update existing addon record
                local setParts = {}
                for fieldName, value in pairs(addonChanges) do
                    if type(value) == "string" then
                        table.insert(setParts, string.format("`%s` = '%s'", fieldName, Utils.escapeString(value)))
                    else
                        table.insert(setParts, string.format("`%s` = %s", fieldName, tostring(value)))
                    end
                end

                local updateQuery = string.format(
                        "UPDATE creature_template_addon SET %s WHERE entry = %d",
                        table.concat(setParts, ", "), entry
                )

                local result = WorldDBExecute(updateQuery)
                if result ~= nil then
                    success = true
                else
                    Utils.sendMessage(player, "error", "Failed to update creature template addon")
                    return
                end
            else
                -- Create new addon record with default values
                local defaultAddon = {
                    entry = entry,
                    path_id = 0,
                    mount = 0,
                    MountCreatureID = 0,
                    StandState = 0,
                    AnimTier = 0,
                    VisFlags = 0,
                    SheathState = 1,
                    PvPFlags = 0,
                    emote = 0,
                    visibilityDistanceType = 0,
                    auras = ""
                }

                -- Apply changes to defaults
                for fieldName, value in pairs(addonChanges) do
                    defaultAddon[fieldName] = value
                end

                local insertQuery = string.format([[
                    INSERT INTO creature_template_addon
                    (entry, path_id, mount, MountCreatureID, StandState, AnimTier, VisFlags,
                     SheathState, PvPFlags, emote, visibilityDistanceType, auras)
                    VALUES (%d, %d, %d, %d, %d, %d, %d, %d, %d, %d, %d, '%s')
                ]],
                        defaultAddon.entry, defaultAddon.path_id, defaultAddon.mount,
                        defaultAddon.MountCreatureID, defaultAddon.StandState, defaultAddon.AnimTier,
                        defaultAddon.VisFlags, defaultAddon.SheathState, defaultAddon.PvPFlags,
                        defaultAddon.emote, defaultAddon.visibilityDistanceType,
                        Utils.escapeString(defaultAddon.auras)
                )

                local result = WorldDBExecute(insertQuery)
                if result ~= nil then
                    success = true
                else
                    Utils.sendMessage(player, "error", "Failed to create creature template addon")
                    return
                end
            end
        elseif data.changes and next(data.changes) then
            -- Only template changes, success already set above
            success = true
        end

        if success then
            Utils.sendMessage(player, "success",
                    string.format("Successfully updated creature template %d", entry))

            -- Send updated data back to client
            CreatureTemplateHandlers.getCreatureTemplateData(player, entry)
        end
    else
        Utils.sendMessage(player, "info", "No changes to save")
    end
end

-- =====================================================
-- Creature Template Duplication
-- =====================================================

-- Duplicate creature with template
function CreatureTemplateHandlers.duplicateCreatureWithTemplate(player, data)
    if not data or not data.sourceEntry then
        Utils.sendMessage(player, "error", "Invalid duplication data")
        return
    end

    local sourceEntry = tonumber(data.sourceEntry)
    if not sourceEntry or sourceEntry <= 0 then
        Utils.sendMessage(player, "error", "Invalid source creature entry")
        return
    end

    -- Check GM permission
    if player:GetGMRank() < 2 then
        Utils.sendMessage(player, "error", "Insufficient permissions")
        return
    end

    -- Find next available entry
    local newEntry = CreatureTemplateHandlers.getNextAvailableEntry()
    if not newEntry then
        Utils.sendMessage(player, "error", "Could not find available entry ID")
        return
    end

    -- Get source template data
    local sourceQuery = WorldDBQuery(string.format(
            "SELECT * FROM creature_template WHERE entry = %d",
            sourceEntry
    ))

    if not sourceQuery then
        Utils.sendMessage(player, "error", "Source creature template not found")
        return
    end

    -- Clone the creature template
    local cloneQuery = string.format([[
        INSERT INTO creature_template SELECT
        %d, name, subname, IconName, gossip_menu_id, minlevel, maxlevel, exp, faction, npcflag, speed_walk, speed_run, scale, `rank`, dmgschool, BaseAttackTime, RangeAttackTime, BaseVariance, RangeVariance, unit_class, unit_flags, unit_flags2, dynamicflags, family, type, type_flags, lootid, pickpocketloot, skinloot, PetSpellDataId, VehicleId, mingold, maxgold, AIName, MovementType, HoverHeight, HealthModifier, ManaModifier, ArmorModifier, DamageModifier, ExperienceModifier, RacialLeader, movementId, RegenHealth, mechanic_immune_mask, spell_school_immune_mask, flags_extra, ScriptName, difficulty_entry_1, difficulty_entry_2, difficulty_entry_3, KillCredit1, KillCredit2, modelid1, modelid2, modelid3, modelid4
        FROM creature_template WHERE entry = %d
    ]], newEntry, sourceEntry)

    local success = WorldDBExecute(cloneQuery)
    if not success then
        Utils.sendMessage(player, "error", "Failed to clone creature template")
        return
    end

    -- Clone addon data if it exists
    local addonQuery = WorldDBQuery(string.format(
            "SELECT * FROM creature_template_addon WHERE entry = %d",
            sourceEntry
    ))

    if addonQuery then
        local cloneAddonQuery = string.format([[
            INSERT INTO creature_template_addon SELECT
            %d, path_id, mount, MountCreatureID, StandState, AnimTier, VisFlags, SheathState, PvPFlags, emote, visibilityDistanceType, auras
            FROM creature_template_addon WHERE entry = %d
        ]], newEntry, sourceEntry)

        WorldDBExecute(cloneAddonQuery)
    end

    -- Apply any changes from the data
    if data.changes and next(data.changes) then
        local updateData = {
            entry = newEntry,
            changes = data.changes
        }
        CreatureTemplateHandlers.updateCreatureTemplate(player, updateData)
    end

    Utils.sendMessage(player, "success",
            string.format("Successfully duplicated creature %d as %d", sourceEntry, newEntry))

    -- Send new template data to client
    CreatureTemplateHandlers.getCreatureTemplateData(player, newEntry)
end

-- =====================================================
-- Utility Functions
-- =====================================================

-- Get next available creature entry
function CreatureTemplateHandlers.getNextAvailableEntry(player)
    -- Start from a high number to avoid conflicts with official content
    local startEntry = 500000

    -- Find the highest existing custom entry
    local maxQuery = WorldDBQuery("SELECT MAX(entry) FROM creature_template WHERE entry >= " .. startEntry)
    if maxQuery then
        local maxEntry = maxQuery:GetUInt32(0)
        if maxEntry and maxEntry >= startEntry then
            startEntry = maxEntry + 1
        end
    end

    -- Find next available entry (check for gaps)
    for i = startEntry, startEntry + 1000 do
        local existsQuery = WorldDBQuery("SELECT entry FROM creature_template WHERE entry = " .. i)
        if not existsQuery then
            if player then
                AIO.Handle(player, "CreatureTemplateEditor", "ReceiveNextEntry", i)
            end
            return i
        end
    end

    -- If we get here, couldn't find an available entry
    if player then
        Utils.sendMessage(player, "error", "Could not find available entry ID")
    end
    return nil
end

-- Create blank creature template
function CreatureTemplateHandlers.createBlankCreatureTemplate(player)
    -- Check GM permission
    if player:GetGMRank() < 2 then
        Utils.sendMessage(player, "error", "Insufficient permissions")
        return
    end

    local newEntry = CreatureTemplateHandlers.getNextAvailableEntry()
    if not newEntry then
        Utils.sendMessage(player, "error", "Could not find available entry ID")
        return
    end

    -- Create minimal creature template
    local insertQuery = string.format([[
        INSERT INTO creature_template
        (entry, name, subname, minlevel, maxlevel, faction, npcflag, speed_walk, speed_run, scale, `rank`,
         dmgschool, BaseAttackTime, RangeAttackTime, BaseVariance, RangeVariance, unit_class, unit_flags,
         unit_flags2, dynamicflags, family, type, type_flags, lootid, pickpocketloot, skinloot,
         mingold, maxgold, AIName, MovementType, HoverHeight, HealthModifier, ManaModifier,
         ArmorModifier, DamageModifier, ExperienceModifier, RacialLeader, RegenHealth,
         mechanic_immune_mask, spell_school_immune_mask, flags_extra, modelid1, modelid2, modelid3, modelid4)
        VALUES
        (%d, 'New Creature', '', 1, 1, 35, 0, 1.0, 1.14286, 1.0, 0,
         0, 2000, 2000, 1.0, 1.0, 0, 0,
         0, 0, 0, 0, 0, 0, 0, 0,
         0, 0, '', 0, 1.0, 1.0, 1.0,
         1.0, 1.0, 1.0, 0, 1,
         0, 0, 0, 0, 0, 0, 0)
    ]], newEntry)

    local success = WorldDBExecute(insertQuery)
    if success then
        Utils.sendMessage(player, "success",
                string.format("Created blank creature template with entry %d", newEntry))

        -- Send new template data to client
        CreatureTemplateHandlers.getCreatureTemplateData(player, newEntry)
    else
        Utils.sendMessage(player, "error", "Failed to create creature template")
    end
end

return CreatureTemplateHandlers