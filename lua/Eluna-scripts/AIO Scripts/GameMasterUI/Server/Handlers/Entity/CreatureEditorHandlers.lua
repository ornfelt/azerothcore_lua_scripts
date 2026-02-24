--[[
    GameMasterUI Creature Editor Handlers Module

    This module handles all Creature editing operations:
    - Get Creature data for editing
    - Update Creature properties (position, rotation, scale)
    - Copy player position to Creature
    - Face Creature to player
    - Reset Creature to original state
    - Save Creature to database
    - Duplicate and save Creature operations
    - Duplicate Creature at specific position
    - Get nearby Creatures for selection

    Extracted from GameMasterUI_ObjectEditorHandlers.lua (1,751 lines) to improve
    maintainability and follow single responsibility principle.
]]--

local CreatureEditorHandlers = {}

-- Module dependencies (will be injected)
local Config, Utils, Database, DatabaseHelper
local ObjectEditorUtils

-- =====================================================
-- Module Initialization
-- =====================================================

function CreatureEditorHandlers.Initialize(config, utils, database, databaseHelper, editorUtils)
    Config = config
    Utils = utils
    Database = database
    DatabaseHelper = databaseHelper
    ObjectEditorUtils = editorUtils
end

-- =====================================================
-- Creature Data Retrieval
-- =====================================================

-- Get Creature data for editor
function CreatureEditorHandlers.getCreatureData(player, guid)
    if ObjectEditorUtils.IsDebugEnabled() then
        print(string.format("[ObjectEditor] getCreatureData called for GUID: %d by player %s",
            guid or 0, player:GetName()))
    end

    local creature = ObjectEditorUtils.GetCreatureByGuid(player, guid)
    if not creature then
        print(string.format("[ObjectEditor] ERROR: Creature with GUID %d not found in range!", guid))
        AIO.Handle(player, "ObjectEditor", "CreatureNotFound", guid)
        return
    end

    local canEdit, reason = ObjectEditorUtils.CanEditEntity(player, creature, "Creature")
    if not canEdit then
        print(string.format("[ObjectEditor] Cannot edit creature: %s", reason))
        AIO.Handle(player, "ObjectEditor", "Error", reason)
        return
    end

    -- Gather creature data
    local creatureData = {
        guid = creature:GetGUIDLow(),
        entry = creature:GetEntry(),
        name = creature:GetName(),
        x = creature:GetX(),
        y = creature:GetY(),
        z = creature:GetZ(),
        o = creature:GetO(),
        scale = creature:GetScale() or 1.0,
        entityType = "Creature"
    }

    if ObjectEditorUtils.IsDebugEnabled() then
        print(string.format("[ObjectEditor] Sending creature data to client: %s (Entry: %d, GUID: %d)",
            creatureData.name, creatureData.entry, creatureData.guid))
    end

    -- Send data to client
    AIO.Handle(player, "ObjectEditor", "OpenEditor", creatureData)
end

-- Get selected creature data
function CreatureEditorHandlers.getSelectedCreature(player)
    local target = player:GetSelection()
    if not target then
        AIO.Handle(player, "ObjectEditor", "RequestSelection")
        return
    end

    -- Check if selection is a Creature (TypeId 3 = Unit)
    if target:GetTypeId() ~= 3 then
        AIO.Handle(player, "ObjectEditor", "Error", "Selected target is not a Creature")
        return
    end

    -- Get Creature data
    CreatureEditorHandlers.getCreatureData(player, target:GetGUIDLow())
end

-- =====================================================
-- Creature Property Updates
-- =====================================================

-- Update Creature with multiple changes at once
function CreatureEditorHandlers.updateCreature(player, guid, updates)
    local editorConfig = ObjectEditorUtils.GetConfig()

    local creature = ObjectEditorUtils.GetCreatureByGuid(player, guid)
    if not creature then
        print(string.format("[ObjectEditor] Creature %d not found!", guid))
        AIO.Handle(player, "ObjectEditor", "CreatureNotFound", guid)
        return
    end

    local canEdit, reason = ObjectEditorUtils.CanEditEntity(player, creature, "Creature")
    if not canEdit then
        print(string.format("[ObjectEditor] Cannot edit: %s", reason))
        AIO.Handle(player, "ObjectEditor", "Error", reason)
        return
    end

    -- Process updates
    local needsRelocate = false
    local newX, newY, newZ, newO = creature:GetX(), creature:GetY(), creature:GetZ(), creature:GetO()

    if updates.position then
        -- Handle position updates (can be per-axis or full position)
        if updates.position.axis then
            -- Single axis update
            local axis = updates.position.axis
            local value = updates.position.value
            if axis == "x" then
                newX = value
            elseif axis == "y" then
                newY = value
            elseif axis == "z" then
                newZ = value
            end
        else
            -- Full position update
            newX = updates.position.x or newX
            newY = updates.position.y or newY
            newZ = updates.position.z or newZ
        end

        -- Validate new coordinates
        local valid, errorMsg = ObjectEditorUtils.ValidateWorldCoordinates(newX, newY, newZ)
        if not valid then
            print(string.format("[ObjectEditor] Invalid coordinates: %s", errorMsg))
            AIO.Handle(player, "ObjectEditor", "Error", errorMsg)
            return
        end

        needsRelocate = true
    end

    if updates.rotation then
        newO = updates.rotation
        needsRelocate = true
    end

    -- Check if we need to respawn the creature (for position/rotation/scale changes)
    local needsRespawn = needsRelocate or updates.scale

    if needsRespawn then
        -- Store creature data before despawn
        local entry = creature:GetEntry()
        local mapId = creature:GetMapId() or player:GetMapId()
        local instanceId = creature:GetInstanceId() or player:GetInstanceId()
        local phase = creature:GetPhaseMask() or player:GetPhaseMask() or 1
        local currentScale = creature:GetScale() or 1.0
        local newScale = updates.scale and math.max(editorConfig.MIN_SCALE, math.min(editorConfig.MAX_SCALE, updates.scale)) or currentScale
        local oldGuid = guid

        if updates.scale and ObjectEditorUtils.IsDebugEnabled() then
            print(string.format("[ObjectEditor] Creature scale update requested: %.2f (clamped: %.2f, current: %.2f)",
                updates.scale, newScale, currentScale))
        end

        -- Despawn the existing creature
        creature:DespawnOrUnsummon(0) -- Immediate despawn
        creature = nil -- Clear reference

        -- Respawn at new position with new properties
        -- PerformIngameSpawn(spawnType, entry, mapId, instanceId, x, y, z, o, save, durorresptime, phase)
        -- spawnType 1 = Creature, 2 = GameObject
        local newCreature = PerformIngameSpawn(1, entry, mapId, instanceId, newX, newY, newZ, newO, false, 0, phase)

        if newCreature then
            -- Always apply scale to ensure it's set correctly (even if 1.0)
            newCreature:SetScale(newScale)

            if ObjectEditorUtils.IsDebugEnabled() then
                print(string.format("[ObjectEditor] Applied scale %.2f to Creature", newScale))
            end

            -- Get new GUID
            local newGuid = newCreature:GetGUIDLow()

            -- Teleport player +0.1 up to refresh client visual (hack fix for scale update)
            -- Do this BEFORE sending update to ensure client sees the change
            if updates.scale then
                local px, py, pz, po = player:GetX(), player:GetY(), player:GetZ(), player:GetO()
                player:Teleport(player:GetMapId(), px, py, pz + 0.1, po)
                if ObjectEditorUtils.IsDebugEnabled() then
                    print("[ObjectEditor] Teleported player +0.1 up to refresh scale visual")
                end
            end

            -- Send updated data to client with new GUID
            local creatureData = {
                guid = newGuid,
                entry = entry,
                name = newCreature:GetName(),
                x = newX,
                y = newY,
                z = newZ,
                o = newO,
                scale = newScale,
                entityType = "Creature"
            }

            -- Send update to client (similar to GameObject handling)
            AIO.Handle(player, "ObjectEditor", "CreatureRespawned", oldGuid, creatureData)

            if ObjectEditorUtils.IsDebugEnabled() then
                print(string.format("[ObjectEditor] Respawned Creature %d (new GUID: %d): Pos(%.2f, %.2f, %.2f) Rot(%.2f) Scale(%.2f)",
                    entry, newGuid, newX, newY, newZ, newO, newScale))
            end
        else
            -- Failed to respawn
            AIO.Handle(player, "ObjectEditor", "Error", "Failed to respawn creature")
            print(string.format("[ObjectEditor] Failed to respawn Creature %d", entry))
        end
    end
end

-- =====================================================
-- Creature Position Operations
-- =====================================================

-- Copy player position to Creature
function CreatureEditorHandlers.copyPlayerPositionToCreature(player, guid)
    local creature = ObjectEditorUtils.GetCreatureByGuid(player, guid)
    if not creature then
        AIO.Handle(player, "ObjectEditor", "CreatureNotFound", guid)
        return
    end

    local canEdit, reason = ObjectEditorUtils.CanEditEntity(player, creature, "Creature")
    if not canEdit then
        AIO.Handle(player, "ObjectEditor", "Error", reason)
        return
    end

    -- Get player position and creature data
    local x, y, z, o = player:GetX(), player:GetY(), player:GetZ(), player:GetO()
    local entry = creature:GetEntry()
    local scale = creature:GetScale() or 1.0
    local mapId = player:GetMapId()
    local instanceId = player:GetInstanceId()
    local phase = player:GetPhaseMask() or 1
    local oldGuid = guid -- Store before removal

    -- Despawn creature and respawn at player position
    creature:DespawnOrUnsummon(0)
    creature = nil -- Clear reference

    local newCreature = PerformIngameSpawn(1, entry, mapId, instanceId, x, y, z, o, false, 0, phase)

    if newCreature then
        -- Apply scale
        if scale ~= 1.0 then
            newCreature:SetScale(scale)
        end

        -- Get new GUID
        local newGuid = newCreature:GetGUIDLow()

        -- Send updated data to client
        local creatureData = {
            guid = newGuid,
            entry = entry,
            name = newCreature:GetName(),
            x = x,
            y = y,
            z = z,
            o = o,
            scale = scale,
            entityType = "Creature"
        }

        AIO.Handle(player, "ObjectEditor", "CreatureRespawned", oldGuid, creatureData)
        AIO.Handle(player, "ObjectEditor", "Success", "Creature moved to your position")
    else
        AIO.Handle(player, "ObjectEditor", "Error", "Failed to move creature to your position")
    end
end

-- Make Creature face the player
function CreatureEditorHandlers.faceCreatureToPlayer(player, guid)
    local creature = ObjectEditorUtils.GetCreatureByGuid(player, guid)
    if not creature then
        AIO.Handle(player, "ObjectEditor", "CreatureNotFound", guid)
        return
    end

    local canEdit, reason = ObjectEditorUtils.CanEditEntity(player, creature, "Creature")
    if not canEdit then
        AIO.Handle(player, "ObjectEditor", "Error", reason)
        return
    end

    -- Calculate angle from creature to player
    local creatureX, creatureY, creatureZ = creature:GetX(), creature:GetY(), creature:GetZ()
    local playerX, playerY = player:GetX(), player:GetY()

    local angle = math.atan2(playerY - creatureY, playerX - creatureX)

    -- Get creature data
    local entry = creature:GetEntry()
    local scale = creature:GetScale() or 1.0
    local mapId = player:GetMapId()
    local instanceId = player:GetInstanceId()
    local phase = player:GetPhaseMask() or 1
    local oldGuid = guid -- Store before removal

    -- Despawn creature and respawn with new orientation
    creature:DespawnOrUnsummon(0)
    creature = nil -- Clear reference

    local newCreature = PerformIngameSpawn(1, entry, mapId, instanceId, creatureX, creatureY, creatureZ, angle, false, 0, phase)

    if newCreature then
        -- Apply scale
        if scale ~= 1.0 then
            newCreature:SetScale(scale)
        end

        -- Get new GUID
        local newGuid = newCreature:GetGUIDLow()

        -- Send updated data to client
        local creatureData = {
            guid = newGuid,
            entry = entry,
            name = newCreature:GetName(),
            x = creatureX,
            y = creatureY,
            z = creatureZ,
            o = angle,
            scale = scale,
            entityType = "Creature"
        }

        AIO.Handle(player, "ObjectEditor", "CreatureRespawned", oldGuid, creatureData)
        AIO.Handle(player, "ObjectEditor", "Success", "Creature now facing you")
    else
        AIO.Handle(player, "ObjectEditor", "Error", "Failed to rotate creature")
    end
end

-- =====================================================
-- Creature State Management
-- =====================================================

-- Reset Creature to original state
function CreatureEditorHandlers.resetCreature(player, guid, originalState)
    local creature = ObjectEditorUtils.GetCreatureByGuid(player, guid)
    if not creature then
        AIO.Handle(player, "ObjectEditor", "CreatureNotFound", guid)
        return
    end

    local canEdit, reason = ObjectEditorUtils.CanEditEntity(player, creature, "Creature")
    if not canEdit then
        AIO.Handle(player, "ObjectEditor", "Error", reason)
        return
    end

    -- Get creature data
    local entry = creature:GetEntry()
    local mapId = player:GetMapId()
    local instanceId = player:GetInstanceId()
    local phase = player:GetPhaseMask() or 1
    local oldGuid = guid -- Store before removal

    -- Despawn current creature completely
    creature:DespawnOrUnsummon(0)
    creature = nil -- Clear reference

    -- Respawn at original position
    local newCreature = PerformIngameSpawn(1, entry, mapId, instanceId,
        originalState.x, originalState.y, originalState.z, originalState.o,
        false, 0, phase)

    if newCreature then
        -- Apply original scale
        if originalState.scale and originalState.scale ~= 1.0 then
            newCreature:SetScale(originalState.scale)
        end

        -- Get new GUID
        local newGuid = newCreature:GetGUIDLow()

        -- Send updated data to client
        local creatureData = {
            guid = newGuid,
            entry = entry,
            name = newCreature:GetName(),
            x = originalState.x,
            y = originalState.y,
            z = originalState.z,
            o = originalState.o,
            scale = originalState.scale,
            entityType = "Creature"
        }

        AIO.Handle(player, "ObjectEditor", "CreatureRespawned", oldGuid, creatureData)
        AIO.Handle(player, "ObjectEditor", "Success", "Creature reset to original state")
    else
        AIO.Handle(player, "ObjectEditor", "Error", "Failed to reset creature")
    end
end

-- =====================================================
-- Creature Database Operations
-- =====================================================

-- Save Creature to database
function CreatureEditorHandlers.saveCreatureToDB(player, guid)
    local creature = ObjectEditorUtils.GetCreatureByGuid(player, guid)
    if not creature then
        AIO.Handle(player, "ObjectEditor", "CreatureNotFound", guid)
        return
    end

    local canEdit, reason = ObjectEditorUtils.CanEditEntity(player, creature, "Creature")
    if not canEdit then
        AIO.Handle(player, "ObjectEditor", "Error", reason)
        return
    end

    -- Get current creature data before removal
    local entry = creature:GetEntry()
    local x, y, z, o = creature:GetX(), creature:GetY(), creature:GetZ(), creature:GetO()
    local scale = creature:GetScale() or 1.0
    local mapId = creature:GetMapId() or player:GetMapId()
    local instanceId = creature:GetInstanceId() or player:GetInstanceId()
    local phase = creature:GetPhaseMask() or player:GetPhaseMask() or 1
    local oldGuid = guid

    -- Remove the temporary creature
    creature:DespawnOrUnsummon(0)
    creature = nil

    -- Respawn with save = true to persist in database
    local savedCreature = PerformIngameSpawn(1, entry, mapId, instanceId, x, y, z, o, true, 0, phase)

    if savedCreature then
        -- Apply scale if needed
        if scale ~= 1.0 then
            savedCreature:SetScale(scale)
        end

        local newGuid = savedCreature:GetGUIDLow()

        -- Log action
        if ObjectEditorUtils.IsDebugEnabled() then
            print(string.format("[ObjectEditor] Player %s saved Creature %d to database (new GUID: %d)",
                player:GetName(), entry, newGuid))
        end

        Utils.sendMessage(player, "success", string.format("Creature %d saved to database", entry))

        -- Send updated data to client with new GUID
        local creatureData = {
            guid = newGuid,
            entry = entry,
            name = savedCreature:GetName(),
            x = x,
            y = y,
            z = z,
            o = o,
            scale = scale,
            entityType = "Creature"
        }

        -- Send confirmation with new creature data
        AIO.Handle(player, "ObjectEditor", "CreatureSavedWithData", oldGuid, creatureData)
    else
        AIO.Handle(player, "ObjectEditor", "Error", "Failed to save creature to database")
    end
end

-- =====================================================
-- Creature Creation and Duplication
-- =====================================================

-- Combined function to save and duplicate creature in one operation
function CreatureEditorHandlers.duplicateAndSaveCreature(player, guid)
    local creature = ObjectEditorUtils.GetCreatureByGuid(player, guid)
    if not creature then
        AIO.Handle(player, "ObjectEditor", "CreatureNotFound", guid)
        return
    end

    local canEdit, reason = ObjectEditorUtils.CanEditEntity(player, creature, "Creature")
    if not canEdit then
        AIO.Handle(player, "ObjectEditor", "Error", reason)
        return
    end

    -- Get current creature data before any operations
    local entry = creature:GetEntry()
    local x, y, z, o = creature:GetX(), creature:GetY(), creature:GetZ(), creature:GetO()
    local scale = creature:GetScale() or 1.0
    local mapId = creature:GetMapId() or player:GetMapId()
    local instanceId = creature:GetInstanceId() or player:GetInstanceId()
    local phase = creature:GetPhaseMask() or player:GetPhaseMask() or 1
    local originalGuid = guid

    -- Step 1: Remove the temporary creature and replace with permanent one
    creature:DespawnOrUnsummon(0)
    creature = nil

    -- Spawn the permanent saved version
    local savedCreature = PerformIngameSpawn(1, entry, mapId, instanceId, x, y, z, o, true, 0, phase)

    if not savedCreature then
        AIO.Handle(player, "ObjectEditor", "Error", "Failed to save creature")
        return
    end

    -- Apply scale to saved creature
    if scale ~= 1.0 then
        savedCreature:SetScale(scale)
    end

    if ObjectEditorUtils.IsDebugEnabled() then
        print(string.format("[ObjectEditor] Saved creature %d at position (%.2f, %.2f, %.2f)",
            entry, x, y, z))
    end

    -- Step 2: Spawn the duplicate at the same position
    local duplicateCreature = PerformIngameSpawn(1, entry, mapId, instanceId, x, y, z, o, true, 0, phase)

    if duplicateCreature then
        -- Apply scale to duplicate
        if scale ~= 1.0 then
            duplicateCreature:SetScale(scale)
        end

        -- Get data for the duplicate (this will be the one we edit)
        local duplicateData = {
            guid = duplicateCreature:GetGUIDLow(),
            entry = entry,
            name = duplicateCreature:GetName(),
            x = x,
            y = y,
            z = z,
            o = o,
            scale = scale,
            entityType = "Creature"
        }

        Utils.sendMessage(player, "success", "Creature saved and duplicated")

        -- Send to client to open editor for duplicate
        AIO.Handle(player, "ObjectEditor", "CreatureDuplicatedWithSave", originalGuid, duplicateData)
    else
        AIO.Handle(player, "ObjectEditor", "Error", "Failed to duplicate creature")
    end
end

-- Duplicate Creature at specified position
function CreatureEditorHandlers.duplicateCreatureAtPosition(player, entry, x, y, z, o, scale)
    entry = tonumber(entry)
    if not entry or entry <= 0 then
        AIO.Handle(player, "ObjectEditor", "Error", "Invalid creature entry")
        return
    end

    -- Use provided position or fall back to player position
    if not x or not y or not z then
        x, y, z, o = Utils.calculatePosition(player, 3)
    end

    -- Ensure orientation is valid
    o = o or player:GetO()
    scale = scale or 1.0

    local mapId = player:GetMapId()
    local instanceId = player:GetInstanceId()
    local save = true  -- Save to database
    local durorresptime = 0
    local phase = player:GetPhaseMask() or 1

    -- Spawn the duplicate at specified position
    local creature = PerformIngameSpawn(1, entry, mapId, instanceId, x, y, z, o, save, durorresptime, phase)

    if creature then
        -- Apply scale if not default
        if scale ~= 1.0 then
            creature:SetScale(scale)
        end

        -- Get data for the new creature
        local newCreatureData = {
            guid = creature:GetGUIDLow(),
            entry = entry,
            name = creature:GetName(),
            x = creature:GetX(),
            y = creature:GetY(),
            z = creature:GetZ(),
            o = creature:GetO(),
            scale = creature:GetScale() or 1.0,
            entityType = "Creature"
        }

        Utils.sendMessage(player, "success", "Creature duplicated at current position")

        -- Send to client to open editor for new creature
        AIO.Handle(player, "ObjectEditor", "CreatureDuplicated", nil, newCreatureData)
    else
        AIO.Handle(player, "ObjectEditor", "Error", "Failed to duplicate creature")
    end
end

-- =====================================================
-- Creature Search and Discovery
-- =====================================================

-- Get nearby Creatures for selection
function CreatureEditorHandlers.getNearbyCreatures(player, range)
    range = range or 20 -- Default 20 yard range

    -- Debug: Always print for now
    print(string.format("[ObjectEditor] Searching for Creatures within %d yards of player %s",
        range, player:GetName()))

    -- Use GetCreaturesInRange for reliable creature detection
    local creatures = player:GetCreaturesInRange(range)
    local creatureList = {}

    if creatures then
        print(string.format("[ObjectEditor] GetCreaturesInRange returned %d creatures", #creatures))
        for _, creature in ipairs(creatures) do
            if creature then
                -- Safely check if Creature is valid before accessing its methods
                local success, creatureData = pcall(function()
                    return {
                        guid = creature:GetGUIDLow(),
                        entry = creature:GetEntry(),
                        distance = player:GetDistance(creature),
                        x = creature:GetX(),
                        y = creature:GetY(),
                        z = creature:GetZ(),
                        inWorld = creature:IsInWorld()
                    }
                end)

                if success and creatureData and creatureData.inWorld and creatureData.distance <= range then
                    table.insert(creatureList, {
                        guid = creatureData.guid,
                        entry = creatureData.entry,
                        distance = creatureData.distance,
                        x = creatureData.x,
                        y = creatureData.y,
                        z = creatureData.z
                    })
                    print(string.format("[ObjectEditor] Added Creature: Entry=%d, Distance=%.1f",
                        creatureData.entry, creatureData.distance))
                end
            end
        end
    else
        print("[ObjectEditor] GetCreaturesInRange returned nil")
    end

    print(string.format("[ObjectEditor] Total Creatures found: %d", #creatureList))

    -- Sort by distance
    table.sort(creatureList, function(a, b) return a.distance < b.distance end)

    return creatureList
end

return CreatureEditorHandlers