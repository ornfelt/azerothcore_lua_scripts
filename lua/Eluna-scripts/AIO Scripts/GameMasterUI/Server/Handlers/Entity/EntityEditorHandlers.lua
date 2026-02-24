--[[
    GameMasterUI Entity Editor Handlers Module

    This module handles combined entity operations that work with both
    GameObjects and Creatures:
    - Get nearby entities (GameObjects and Creatures combined)
    - Unified entity search and discovery
    - Cross-entity type operations

    Extracted from GameMasterUI_ObjectEditorHandlers.lua (1,751 lines) to improve
    maintainability and follow single responsibility principle.
]]--

local EntityEditorHandlers = {}

-- Module dependencies (will be injected)
local Config, Utils, Database, DatabaseHelper
local ObjectEditorUtils, GameObjectEditorHandlers, CreatureEditorHandlers

-- =====================================================
-- Module Initialization
-- =====================================================

function EntityEditorHandlers.Initialize(config, utils, database, databaseHelper, editorUtils, gobHandlers, creatureHandlers)
    Config = config
    Utils = utils
    Database = database
    DatabaseHelper = databaseHelper
    ObjectEditorUtils = editorUtils
    GameObjectEditorHandlers = gobHandlers
    CreatureEditorHandlers = creatureHandlers
end

-- =====================================================
-- Combined Entity Operations
-- =====================================================

-- Get both nearby GameObjects and Creatures combined
function EntityEditorHandlers.getNearbyEntities(player, range)
    range = range or 30 -- Default 30 yard range

    local entities = {}
    local seenGuids = {} -- Track GUIDs to prevent duplicates

    -- Debug log
    if ObjectEditorUtils.IsDebugEnabled() then
        print(string.format("[ObjectEditor] Getting nearby entities within %d yards for player %s", range, player:GetName()))
    end

    -- Get GameObjects
    local gameObjects = player:GetNearObjects(range, 3) -- type 3 = GameObject
    if gameObjects then
        for _, gob in ipairs(gameObjects) do
            if gob then
                local success, gobData = pcall(function()
                    -- Double-check this is actually a GameObject by checking TypeId
                    local typeId = gob:GetTypeId()
                    if ObjectEditorUtils.IsDebugEnabled() then
                        print(string.format("[ObjectEditor] Object TypeId: %d for entry %d", typeId, gob:GetEntry()))
                    end

                    -- Only process if this is truly a GameObject (TypeId 5)
                    if typeId ~= 5 then
                        if ObjectEditorUtils.IsDebugEnabled() then
                            print(string.format("[ObjectEditor] WARNING: GetNearObjects(3) returned non-GameObject with TypeId %d", typeId))
                        end
                        return nil
                    end

                    return {
                        guid = gob:GetGUIDLow(),
                        entry = gob:GetEntry(),
                        distance = player:GetDistance(gob),
                        x = gob:GetX(),
                        y = gob:GetY(),
                        z = gob:GetZ(),
                        o = gob:GetO(),
                        inWorld = gob:IsInWorld()
                    }
                end)

                if success and gobData and gobData.inWorld and gobData.distance <= range then
                    -- Check for duplicate GUID
                    if not seenGuids[gobData.guid] then
                        seenGuids[gobData.guid] = true

                        -- Get GameObject name directly from the object
                        local name = gob:GetName() or ("GameObject " .. gobData.entry)

                        table.insert(entities, {
                            guid = gobData.guid,
                            entry = gobData.entry,
                            name = name,
                            distance = gobData.distance,
                            x = gobData.x,
                            y = gobData.y,
                            z = gobData.z,
                            o = gobData.o,
                            entityType = "GameObject"
                        })
                    elseif ObjectEditorUtils.IsDebugEnabled() then
                        print(string.format("[ObjectEditor] Skipping duplicate GameObject GUID: %d", gobData.guid))
                    end
                end
            end
        end
    end

    -- Get Creatures using the correct Eluna API
    local creatures = player:GetCreaturesInRange(range) -- This returns only creatures, no players

    if creatures then
        if ObjectEditorUtils.IsDebugEnabled() then
            print(string.format("[ObjectEditor] GetCreaturesInRange found %d creatures", #creatures))
        end

        for i, creature in ipairs(creatures) do
            if creature then
                -- Get creature data safely
                local success, creatureData = pcall(function()
                    -- Verify creature is valid and in world
                    if not creature:IsInWorld() then
                        return nil
                    end

                    return {
                        guid = creature:GetGUIDLow(),
                        entry = creature:GetEntry(),
                        name = creature:GetName(),
                        distance = player:GetDistance(creature),
                        x = creature:GetX(),
                        y = creature:GetY(),
                        z = creature:GetZ(),
                        o = creature:GetO()
                    }
                end)

                if success and creatureData then
                    -- Check distance (GetCreaturesInRange might return creatures slightly outside range)
                    if creatureData.distance <= range then
                        -- Check for duplicate GUID
                        if not seenGuids[creatureData.guid] then
                            seenGuids[creatureData.guid] = true

                            table.insert(entities, {
                                guid = creatureData.guid,
                                entry = creatureData.entry,
                                name = creatureData.name,
                                distance = creatureData.distance,
                                x = creatureData.x,
                                y = creatureData.y,
                                z = creatureData.z,
                                o = creatureData.o,
                                entityType = "Creature"
                            })

                            if ObjectEditorUtils.IsDebugEnabled() then
                                print(string.format("[ObjectEditor] Added Creature: %s (Entry: %d, Distance: %.1f)",
                                    creatureData.name, creatureData.entry, creatureData.distance))
                            end
                        elseif ObjectEditorUtils.IsDebugEnabled() then
                            print(string.format("[ObjectEditor] Skipping duplicate Creature GUID: %d", creatureData.guid))
                        end
                    end
                elseif ObjectEditorUtils.IsDebugEnabled() then
                    print(string.format("[ObjectEditor] Failed to get data for creature %d", i))
                end
            end
        end

        if ObjectEditorUtils.IsDebugEnabled() then
            print(string.format("[ObjectEditor] Successfully processed %d creatures", #creatures))
        end
    else
        if ObjectEditorUtils.IsDebugEnabled() then
            print("[ObjectEditor] GetCreaturesInRange returned nil")
        end
    end

    -- Sort by distance
    table.sort(entities, function(a, b) return a.distance < b.distance end)

    -- Final summary and debug
    local gobCount = 0
    local creatureEntityCount = 0
    for i, entity in ipairs(entities) do
        if entity.entityType == "GameObject" then
            gobCount = gobCount + 1
        else
            creatureEntityCount = creatureEntityCount + 1
        end
        -- Debug first few entities
        if i <= 5 then
            print(string.format("[ObjectEditor] Entity %d: %s (Entry: %d, Type: %s, Distance: %.1f)",
                i, entity.name or "Unknown", entity.entry or 0, entity.entityType or "nil", entity.distance or 0))
        end
    end

    print(string.format("[ObjectEditor] FINAL: Total %d entities (%d GameObjects, %d Creatures) within %d yards",
        #entities, gobCount, creatureEntityCount, range))

    return entities
end

-- =====================================================
-- Utility Functions for Combined Operations
-- =====================================================

-- Get nearby entities of specific type
function EntityEditorHandlers.getNearbyEntitiesByType(player, entityType, range)
    if entityType == "GameObject" then
        return GameObjectEditorHandlers.getNearbyGameObjects(player, range)
    elseif entityType == "Creature" then
        return CreatureEditorHandlers.getNearbyCreatures(player, range)
    else
        -- Return both types
        return EntityEditorHandlers.getNearbyEntities(player, range)
    end
end

-- Filter entities by entry ID
function EntityEditorHandlers.filterEntitiesByEntry(entities, entryId)
    local filtered = {}
    for _, entity in ipairs(entities) do
        if entity.entry == entryId then
            table.insert(filtered, entity)
        end
    end
    return filtered
end

-- Filter entities by distance range
function EntityEditorHandlers.filterEntitiesByDistance(entities, minDistance, maxDistance)
    local filtered = {}
    for _, entity in ipairs(entities) do
        if entity.distance >= minDistance and entity.distance <= maxDistance then
            table.insert(filtered, entity)
        end
    end
    return filtered
end

-- Get entity statistics
function EntityEditorHandlers.getEntityStatistics(entities)
    local stats = {
        total = #entities,
        gameObjects = 0,
        creatures = 0,
        entries = {},
        averageDistance = 0
    }

    local totalDistance = 0
    for _, entity in ipairs(entities) do
        if entity.entityType == "GameObject" then
            stats.gameObjects = stats.gameObjects + 1
        elseif entity.entityType == "Creature" then
            stats.creatures = stats.creatures + 1
        end

        -- Track unique entries
        if not stats.entries[entity.entry] then
            stats.entries[entity.entry] = {
                count = 0,
                entityType = entity.entityType,
                name = entity.name
            }
        end
        stats.entries[entity.entry].count = stats.entries[entity.entry].count + 1

        totalDistance = totalDistance + entity.distance
    end

    if stats.total > 0 then
        stats.averageDistance = totalDistance / stats.total
    end

    return stats
end

-- =====================================================
-- Advanced Search Functions
-- =====================================================

-- Search entities by name pattern
function EntityEditorHandlers.searchEntitiesByName(player, namePattern, range)
    local entities = EntityEditorHandlers.getNearbyEntities(player, range)
    local matches = {}

    namePattern = namePattern:lower()
    for _, entity in ipairs(entities) do
        if entity.name and entity.name:lower():find(namePattern, 1, true) then
            table.insert(matches, entity)
        end
    end

    return matches
end

-- Find closest entity of specific type
function EntityEditorHandlers.findClosestEntity(player, entityType, range)
    local entities
    if entityType == "GameObject" then
        entities = GameObjectEditorHandlers.getNearbyGameObjects(player, range)
    elseif entityType == "Creature" then
        entities = CreatureEditorHandlers.getNearbyCreatures(player, range)
    else
        entities = EntityEditorHandlers.getNearbyEntities(player, range)
    end

    if #entities > 0 then
        return entities[1] -- Already sorted by distance
    end
    return nil
end

return EntityEditorHandlers