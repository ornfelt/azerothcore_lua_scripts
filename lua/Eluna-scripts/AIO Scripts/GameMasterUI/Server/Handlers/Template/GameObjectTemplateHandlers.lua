--[[
    GameMasterUI GameObject Template Handlers Module

    This module handles all GameObject template operations:
    - Get GameObject template data
    - Update GameObject template data
    - Duplicate GameObject templates
    - Find next available GameObject entry

    Extracted from GameMasterUI_TemplateHandlers.lua (2,393 lines) to improve maintainability
    and follow single responsibility principle.
]]--

local GameObjectTemplateHandlers = {}

-- Module dependencies (will be injected)
local Config, Utils, DatabaseHelper, TemplateValidation

-- =====================================================
-- Module Initialization
-- =====================================================

function GameObjectTemplateHandlers.Initialize(config, utils, dbHelper, validation)
    Config = config
    Utils = utils
    DatabaseHelper = dbHelper
    TemplateValidation = validation
end

-- =====================================================
-- GameObject Template Data Retrieval
-- =====================================================

-- Get GameObject template data
function GameObjectTemplateHandlers.getGameObjectTemplateData(player, entry)
    entry = tonumber(entry)
    if not entry or entry <= 0 then
        Utils.sendMessage(player, "error", "Invalid gameobject entry")
        return
    end

    -- Query basic fields first
    local basicQuery = WorldDBQuery(string.format([[
        SELECT
            entry, name, type, displayId, size, IconName, castBarCaption, unk1
        FROM gameobject_template
        WHERE entry = %d
    ]], entry))

    if not basicQuery then
        Utils.sendMessage(player, "error", "GameObject not found in database")
        return
    end

    -- Build basic data object with all fields initialized to defaults
    local data = {
        entry = basicQuery:GetUInt32(0),
        name = basicQuery:GetString(1) or "",
        type = basicQuery:GetUInt32(2),
        displayId = basicQuery:GetUInt32(3),
        size = basicQuery:GetFloat(4),
        IconName = basicQuery:GetString(5) or "",
        castBarCaption = basicQuery:GetString(6) or "",
        unk1 = basicQuery:GetString(7) or "",
        -- Default values for all Data fields
        Data0 = 0, Data1 = 0, Data2 = 0, Data3 = 0, Data4 = 0, Data5 = 0,
        Data6 = 0, Data7 = 0, Data8 = 0, Data9 = 0, Data10 = 0, Data11 = 0,
        Data12 = 0, Data13 = 0, Data14 = 0, Data15 = 0, Data16 = 0, Data17 = 0,
        Data18 = 0, Data19 = 0, Data20 = 0, Data21 = 0, Data22 = 0, Data23 = 0,
        -- Script field defaults
        AIName = "",
        ScriptName = "",
        StringId = "",
        -- Addon field defaults
        faction = 0,
        flags = 0,
        mingold = 0,
        maxgold = 0,
        artkit0 = 0,
        artkit1 = 0,
        artkit2 = 0,
        artkit3 = 0,
    }

    -- Query all Data fields and script fields
    local fullQuery = WorldDBQuery(string.format([[
        SELECT
            Data0, Data1, Data2, Data3, Data4, Data5, Data6, Data7,
            Data8, Data9, Data10, Data11, Data12, Data13, Data14, Data15,
            Data16, Data17, Data18, Data19, Data20, Data21, Data22, Data23,
            AIName, ScriptName, StringId
        FROM gameobject_template
        WHERE entry = %d
    ]], entry))

    if fullQuery then
        -- Override defaults with actual values
        for i = 0, 23 do
            data["Data" .. i] = fullQuery:GetInt32(i)  -- Some Data fields can be negative
        end
        data.AIName = fullQuery:GetString(24) or ""
        data.ScriptName = fullQuery:GetString(25) or ""
        data.StringId = fullQuery:GetString(26) or ""
    end

    -- Query addon data from gameobject_template_addon
    local addonQuery = WorldDBQuery(string.format([[
        SELECT
            faction, flags, mingold, maxgold,
            artkit0, artkit1, artkit2, artkit3
        FROM gameobject_template_addon
        WHERE entry = %d
    ]], entry))

    if addonQuery then
        data.faction = addonQuery:GetUInt32(0)
        data.flags = addonQuery:GetUInt32(1)
        data.mingold = addonQuery:GetUInt32(2)
        data.maxgold = addonQuery:GetUInt32(3)
        data.artkit0 = addonQuery:GetInt32(4)
        data.artkit1 = addonQuery:GetInt32(5)
        data.artkit2 = addonQuery:GetInt32(6)
        data.artkit3 = addonQuery:GetInt32(7)
    end

    -- Send data to client
    AIO.Handle(player, "GameObjectTemplateEditor", "ReceiveTemplateData", data)
end

-- =====================================================
-- GameObject Template Data Updates
-- =====================================================

-- Update GameObject template
function GameObjectTemplateHandlers.updateGameObjectTemplate(player, data)
    if not data or not data.entry then
        Utils.sendMessage(player, "error", "Invalid update data")
        return
    end

    local entry = tonumber(data.entry)
    if not entry or entry <= 0 then
        Utils.sendMessage(player, "error", "Invalid gameobject entry")
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
            local existsQuery = WorldDBQuery("SELECT entry FROM gameobject_template WHERE entry = " .. newEntry)
            if existsQuery then
                Utils.sendMessage(player, "error",
                    string.format("Entry ID %d already exists. Please choose a different ID.", newEntry))
                return
            end

            -- Update the entry ID
            WorldDBExecute(string.format(
                "UPDATE gameobject_template SET entry = %d WHERE entry = %d",
                newEntry, entry
            ))

            -- Update related tables
            pcall(function()
                -- Update gameobject_template_addon
                WorldDBExecute(string.format(
                    "UPDATE gameobject_template_addon SET entry = %d WHERE entry = %d",
                    newEntry, entry
                ))

                -- Update spawned gameobjects
                WorldDBExecute(string.format(
                    "UPDATE gameobject SET id = %d WHERE id = %d",
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
            local valid, error = TemplateValidation.ValidateGameObjectField(fieldName, value)
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
        faction = true, flags = true, mingold = true, maxgold = true,
        artkit0 = true, artkit1 = true, artkit2 = true, artkit3 = true
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

        -- Update gameobject_template
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
                "UPDATE gameobject_template SET %s WHERE entry = %d",
                table.concat(setParts, ", "), entry
            )

            local result = WorldDBExecute(updateQuery)
            if result ~= nil then
                success = true
            else
                Utils.sendMessage(player, "error", "Failed to update gameobject template")
                return
            end
        end

        -- Update gameobject_template_addon
        if next(addonChanges) then
            -- Check if addon entry exists
            local addonExists = WorldDBQuery(string.format(
                "SELECT entry FROM gameobject_template_addon WHERE entry = %d",
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
                    "UPDATE gameobject_template_addon SET %s WHERE entry = %d",
                    table.concat(setParts, ", "), entry
                )

                local result = WorldDBExecute(updateQuery)
                if result ~= nil then
                    success = true
                else
                    Utils.sendMessage(player, "error", "Failed to update gameobject template addon")
                    return
                end
            else
                -- Create new addon record with default values
                local defaultAddon = {
                    entry = entry,
                    faction = 0,
                    flags = 0,
                    mingold = 0,
                    maxgold = 0,
                    artkit0 = 0,
                    artkit1 = 0,
                    artkit2 = 0,
                    artkit3 = 0,
                }

                -- Apply changes to defaults
                for fieldName, value in pairs(addonChanges) do
                    defaultAddon[fieldName] = value
                end

                local insertQuery = string.format([[
                    INSERT INTO gameobject_template_addon
                    (entry, faction, flags, mingold, maxgold, artkit0, artkit1, artkit2, artkit3)
                    VALUES (%d, %d, %d, %d, %d, %d, %d, %d, %d)
                ]],
                    defaultAddon.entry, defaultAddon.faction, defaultAddon.flags,
                    defaultAddon.mingold, defaultAddon.maxgold, defaultAddon.artkit0,
                    defaultAddon.artkit1, defaultAddon.artkit2, defaultAddon.artkit3
                )

                local result = WorldDBExecute(insertQuery)
                if result ~= nil then
                    success = true
                else
                    Utils.sendMessage(player, "error", "Failed to create gameobject template addon")
                    return
                end
            end
        elseif data.changes and next(data.changes) then
            -- Only template changes, success already set above
            success = true
        end

        if success then
            Utils.sendMessage(player, "success",
                string.format("Successfully updated gameobject template %d", entry))

            -- Send updated data back to client
            GameObjectTemplateHandlers.getGameObjectTemplateData(player, entry)
        end
    else
        Utils.sendMessage(player, "info", "No changes to save")
    end
end

-- =====================================================
-- GameObject Template Duplication
-- =====================================================

-- Duplicate GameObject with template
function GameObjectTemplateHandlers.duplicateGameObjectWithTemplate(player, data)
    if not data or not data.sourceEntry then
        Utils.sendMessage(player, "error", "Invalid duplication data")
        return
    end

    local sourceEntry = tonumber(data.sourceEntry)
    if not sourceEntry or sourceEntry <= 0 then
        Utils.sendMessage(player, "error", "Invalid source gameobject entry")
        return
    end

    -- Check GM permission
    if player:GetGMRank() < 2 then
        Utils.sendMessage(player, "error", "Insufficient permissions")
        return
    end

    -- Find next available entry
    local newEntry = GameObjectTemplateHandlers.getNextAvailableGameObjectEntry()
    if not newEntry then
        Utils.sendMessage(player, "error", "Could not find available entry ID")
        return
    end

    -- Get source template data
    local sourceQuery = WorldDBQuery(string.format(
        "SELECT * FROM gameobject_template WHERE entry = %d",
        sourceEntry
    ))

    if not sourceQuery then
        Utils.sendMessage(player, "error", "Source gameobject template not found")
        return
    end

    -- Clone the gameobject template
    local cloneQuery = string.format([[
        INSERT INTO gameobject_template SELECT
        %d, name, type, displayId, size, Data0, Data1, Data2, Data3, Data4, Data5,
        Data6, Data7, Data8, Data9, Data10, Data11, Data12, Data13, Data14, Data15,
        Data16, Data17, Data18, Data19, Data20, Data21, Data22, Data23,
        IconName, castBarCaption, unk1, AIName, ScriptName, StringId
        FROM gameobject_template WHERE entry = %d
    ]], newEntry, sourceEntry)

    local success = WorldDBExecute(cloneQuery)
    if not success then
        Utils.sendMessage(player, "error", "Failed to clone gameobject template")
        return
    end

    -- Clone addon data if it exists
    local addonQuery = WorldDBQuery(string.format(
        "SELECT * FROM gameobject_template_addon WHERE entry = %d",
        sourceEntry
    ))

    if addonQuery then
        local cloneAddonQuery = string.format([[
            INSERT INTO gameobject_template_addon SELECT
            %d, faction, flags, mingold, maxgold, artkit0, artkit1, artkit2, artkit3
            FROM gameobject_template_addon WHERE entry = %d
        ]], newEntry, sourceEntry)

        WorldDBExecute(cloneAddonQuery)
    end

    -- Apply any changes from the data
    if data.changes and next(data.changes) then
        local updateData = {
            entry = newEntry,
            changes = data.changes
        }
        GameObjectTemplateHandlers.updateGameObjectTemplate(player, updateData)
    end

    Utils.sendMessage(player, "success",
        string.format("Successfully duplicated gameobject %d as %d", sourceEntry, newEntry))

    -- Send new template data to client
    GameObjectTemplateHandlers.getGameObjectTemplateData(player, newEntry)
end

-- =====================================================
-- Utility Functions
-- =====================================================

-- Get next available GameObject entry
function GameObjectTemplateHandlers.getNextAvailableGameObjectEntry(player)
    -- Start from a high number to avoid conflicts with official content
    local startEntry = 500000

    -- Find the highest existing custom entry
    local maxQuery = WorldDBQuery("SELECT MAX(entry) FROM gameobject_template WHERE entry >= " .. startEntry)
    if maxQuery then
        local maxEntry = maxQuery:GetUInt32(0)
        if maxEntry and maxEntry >= startEntry then
            startEntry = maxEntry + 1
        end
    end

    -- Find next available entry (check for gaps)
    for i = startEntry, startEntry + 1000 do
        local existsQuery = WorldDBQuery("SELECT entry FROM gameobject_template WHERE entry = " .. i)
        if not existsQuery then
            if player then
                AIO.Handle(player, "GameObjectTemplateEditor", "ReceiveNextEntry", i)
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

-- Create blank GameObject template
function GameObjectTemplateHandlers.createBlankGameObjectTemplate(player)
    -- Check GM permission
    if player:GetGMRank() < 2 then
        Utils.sendMessage(player, "error", "Insufficient permissions")
        return
    end

    local newEntry = GameObjectTemplateHandlers.getNextAvailableGameObjectEntry()
    if not newEntry then
        Utils.sendMessage(player, "error", "Could not find available entry ID")
        return
    end

    -- Create minimal gameobject template
    local insertQuery = string.format([[
        INSERT INTO gameobject_template
        (entry, name, type, displayId, size, Data0, Data1, Data2, Data3, Data4, Data5,
         Data6, Data7, Data8, Data9, Data10, Data11, Data12, Data13, Data14, Data15,
         Data16, Data17, Data18, Data19, Data20, Data21, Data22, Data23,
         IconName, castBarCaption, unk1, AIName, ScriptName, StringId)
        VALUES
        (%d, 'New GameObject', 0, 0, 1.0, 0, 0, 0, 0, 0, 0,
         0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
         0, 0, 0, 0, 0, 0, 0, 0,
         '', '', '', '', '', '')
    ]], newEntry)

    local success = WorldDBExecute(insertQuery)
    if success then
        Utils.sendMessage(player, "success",
            string.format("Created blank gameobject template with entry %d", newEntry))

        -- Send new template data to client
        GameObjectTemplateHandlers.getGameObjectTemplateData(player, newEntry)
    else
        Utils.sendMessage(player, "error", "Failed to create gameobject template")
    end
end

return GameObjectTemplateHandlers