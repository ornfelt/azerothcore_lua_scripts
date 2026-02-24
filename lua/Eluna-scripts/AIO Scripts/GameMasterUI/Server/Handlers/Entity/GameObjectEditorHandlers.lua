--[[
    GameMasterUI GameObject Editor Handlers Module

    This module handles all GameObject editing operations:
    - Get GameObject data for editing
    - Update GameObject properties (position, rotation, scale)
    - Copy player position to GameObject
    - Face GameObject to player
    - Reset GameObject to original state
    - Save GameObject to database
    - Duplicate GameObject at specific position
    - Get nearby GameObjects for selection
    - Handle GameObject spawn events

    Extracted from GameMasterUI_ObjectEditorHandlers.lua (1,751 lines) to improve
    maintainability and follow single responsibility principle.
]]--

local GameObjectEditorHandlers = {}

-- Module dependencies (will be injected)
local Config, Utils, Database, DatabaseHelper
local ObjectEditorUtils

-- =====================================================
-- Module Initialization
-- =====================================================

function GameObjectEditorHandlers.Initialize(config, utils, database, databaseHelper, editorUtils)
    Config = config
    Utils = utils
    Database = database
    DatabaseHelper = databaseHelper
    ObjectEditorUtils = editorUtils
end

-- =====================================================
-- GameObject Data Retrieval
-- =====================================================

-- Get GameObject data for editor
function GameObjectEditorHandlers.getGameObjectData(player, guid)
    local gob = ObjectEditorUtils.GetGameObjectByGuid(player, guid)
    if not gob then
        AIO.Handle(player, "ObjectEditor", "ObjectNotFound", guid)
        return
    end

    local canEdit, reason = ObjectEditorUtils.CanEditObject(player, gob)
    if not canEdit then
        AIO.Handle(player, "ObjectEditor", "Error", reason)
        return
    end

    -- Gather object data
    local objectData = {
        guid = gob:GetGUIDLow(),
        entry = gob:GetEntry(),
        name = gob:GetName(),
        x = gob:GetX(),
        y = gob:GetY(),
        z = gob:GetZ(),
        o = gob:GetO(),
        scale = gob:GetScale() or 1.0,
        entityType = "GameObject"
    }

    -- Send data to client
    AIO.Handle(player, "ObjectEditor", "OpenEditor", objectData)
end

-- Get selected GameObject data
function GameObjectEditorHandlers.getSelectedGameObject(player)
    local target = player:GetSelection()
    if not target then
        AIO.Handle(player, "ObjectEditor", "RequestSelection")
        return
    end

    -- Check if selection is a GameObject (TypeId 5)
    if target:GetTypeId() ~= 5 then
        AIO.Handle(player, "ObjectEditor", "Error", "Selected target is not a GameObject")
        return
    end

    -- Get GameObject data
    GameObjectEditorHandlers.getGameObjectData(player, target:GetGUIDLow())
end

-- =====================================================
-- GameObject Property Updates
-- =====================================================

-- Update GameObject with multiple changes at once
function GameObjectEditorHandlers.updateGameObject(player, guid, updates)
    local editorConfig = ObjectEditorUtils.GetConfig()

    local gob = ObjectEditorUtils.GetGameObjectByGuid(player, guid)
    if not gob then
        print(string.format("[ObjectEditor] GameObject %d not found!", guid))
        AIO.Handle(player, "ObjectEditor", "ObjectNotFound", guid)
        return
    end

    local canEdit, reason = ObjectEditorUtils.CanEditObject(player, gob)
    if not canEdit then
        print(string.format("[ObjectEditor] Cannot edit: %s", reason))
        AIO.Handle(player, "ObjectEditor", "Error", reason)
        return
    end

    -- Store GameObject data before changes
    local entry = gob:GetEntry()
    local currentScale = gob:GetScale() or 1.0

    -- Process updates
    local needsRespawn = false
    local newX, newY, newZ, newO = gob:GetX(), gob:GetY(), gob:GetZ(), gob:GetO()
    local newScale = currentScale

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

        needsRespawn = true
    end

    if updates.rotation then
        newO = updates.rotation
        needsRespawn = true
    end

    if updates.scale then
        newScale = math.max(editorConfig.MIN_SCALE, math.min(editorConfig.MAX_SCALE, updates.scale))
        needsRespawn = true
        if ObjectEditorUtils.IsDebugEnabled() then
            print(string.format("[ObjectEditor] Scale update requested: %.2f (clamped: %.2f)", updates.scale, newScale))
        end
    end

    -- Apply changes by despawning and respawning the GameObject
    if needsRespawn then
        -- Get spawn parameters
        local mapId = player:GetMapId()
        local instanceId = player:GetInstanceId()
        local phase = player:GetPhaseMask() or 1
        local save = false -- Don't save to DB until user clicks Save Changes
        local durorresptime = 0

        -- Store the GUID before removal (as it becomes invalid after)
        local oldGuid = guid

        -- Remove the current GameObject from world completely
        gob:RemoveFromWorld(true)
        gob = nil -- Clear reference to avoid accessing invalid pointer

        -- Respawn at new position with new properties
        local newGob = PerformIngameSpawn(2, entry, mapId, instanceId, newX, newY, newZ, newO, save, durorresptime, phase)

        if newGob then
            -- Always apply scale to ensure it's set correctly (even if 1.0)
            newGob:SetScale(newScale)

            if ObjectEditorUtils.IsDebugEnabled() then
                print(string.format("[ObjectEditor] Applied scale %.2f to GameObject", newScale))
            end

            -- Get new GUID
            local newGuid = newGob:GetGUIDLow()

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
            local objectData = {
                guid = newGuid,
                entry = entry,
                x = newX,
                y = newY,
                z = newZ,
                o = newO,
                scale = newScale,
                entityType = "GameObject"
            }

            -- Send update to client (use oldGuid as original is now invalid)
            AIO.Handle(player, "ObjectEditor", "ObjectRespawned", oldGuid, objectData)

            if ObjectEditorUtils.IsDebugEnabled() then
                print(string.format("[ObjectEditor] Respawned GameObject %d (new GUID: %d): Pos(%.2f, %.2f, %.2f) Rot(%.2f) Scale(%.2f)",
                    entry, newGuid, newX, newY, newZ, newO, newScale))
            end
        else
            -- Failed to respawn
            AIO.Handle(player, "ObjectEditor", "Error", "Failed to respawn GameObject")
            print(string.format("[ObjectEditor] Failed to respawn GameObject %d", entry))
        end
    end
end

-- =====================================================
-- GameObject Position Operations
-- =====================================================

-- Copy player position to GameObject
function GameObjectEditorHandlers.copyPlayerPositionToObject(player, guid)
    local gob = ObjectEditorUtils.GetGameObjectByGuid(player, guid)
    if not gob then
        AIO.Handle(player, "ObjectEditor", "ObjectNotFound", guid)
        return
    end

    local canEdit, reason = ObjectEditorUtils.CanEditObject(player, gob)
    if not canEdit then
        AIO.Handle(player, "ObjectEditor", "Error", reason)
        return
    end

    -- Get player position and GameObject data
    local x, y, z, o = player:GetX(), player:GetY(), player:GetZ(), player:GetO()
    local entry = gob:GetEntry()
    local scale = gob:GetScale() or 1.0
    local mapId = player:GetMapId()
    local instanceId = player:GetInstanceId()
    local phase = player:GetPhaseMask() or 1
    local oldGuid = guid -- Store before removal

    -- Remove GameObject and respawn at player position
    gob:RemoveFromWorld(true)
    gob = nil -- Clear reference

    local newGob = PerformIngameSpawn(2, entry, mapId, instanceId, x, y, z, o, false, 0, phase)

    if newGob then
        -- Apply scale
        if scale ~= 1.0 then
            newGob:SetScale(scale)
        end

        -- Get new GUID
        local newGuid = newGob:GetGUIDLow()

        -- Send updated data to client
        local objectData = {
            guid = newGuid,
            entry = entry,
            x = x,
            y = y,
            z = z,
            o = o,
            scale = scale,
            entityType = "GameObject"
        }

        AIO.Handle(player, "ObjectEditor", "ObjectRespawned", oldGuid, objectData)
        AIO.Handle(player, "ObjectEditor", "Success", "Object moved to your position")
    else
        AIO.Handle(player, "ObjectEditor", "Error", "Failed to move object to your position")
    end
end

-- Make GameObject face the player
function GameObjectEditorHandlers.faceObjectToPlayer(player, guid)
    local gob = ObjectEditorUtils.GetGameObjectByGuid(player, guid)
    if not gob then
        AIO.Handle(player, "ObjectEditor", "ObjectNotFound", guid)
        return
    end

    local canEdit, reason = ObjectEditorUtils.CanEditObject(player, gob)
    if not canEdit then
        AIO.Handle(player, "ObjectEditor", "Error", reason)
        return
    end

    -- Calculate angle from object to player
    local gobX, gobY, gobZ = gob:GetX(), gob:GetY(), gob:GetZ()
    local playerX, playerY = player:GetX(), player:GetY()

    local angle = math.atan2(playerY - gobY, playerX - gobX)

    -- Get GameObject data
    local entry = gob:GetEntry()
    local scale = gob:GetScale() or 1.0
    local mapId = player:GetMapId()
    local instanceId = player:GetInstanceId()
    local phase = player:GetPhaseMask() or 1
    local oldGuid = guid -- Store before removal

    -- Remove GameObject and respawn with new orientation
    gob:RemoveFromWorld(true)
    gob = nil -- Clear reference

    local newGob = PerformIngameSpawn(2, entry, mapId, instanceId, gobX, gobY, gobZ, angle, false, 0, phase)

    if newGob then
        -- Apply scale
        if scale ~= 1.0 then
            newGob:SetScale(scale)
        end

        -- Get new GUID
        local newGuid = newGob:GetGUIDLow()

        -- Send updated data to client
        local objectData = {
            guid = newGuid,
            entry = entry,
            x = gobX,
            y = gobY,
            z = gobZ,
            o = angle,
            scale = scale,
            entityType = "GameObject"
        }

        AIO.Handle(player, "ObjectEditor", "ObjectRespawned", oldGuid, objectData)
        AIO.Handle(player, "ObjectEditor", "Success", "Object now facing you")
    else
        AIO.Handle(player, "ObjectEditor", "Error", "Failed to rotate object")
    end
end

-- =====================================================
-- GameObject State Management
-- =====================================================

-- Reset GameObject to original state
function GameObjectEditorHandlers.resetGameObject(player, guid, originalState)
    local gob = ObjectEditorUtils.GetGameObjectByGuid(player, guid)
    if not gob then
        AIO.Handle(player, "ObjectEditor", "ObjectNotFound", guid)
        return
    end

    local canEdit, reason = ObjectEditorUtils.CanEditObject(player, gob)
    if not canEdit then
        AIO.Handle(player, "ObjectEditor", "Error", reason)
        return
    end

    -- Get GameObject data
    local entry = gob:GetEntry()
    local mapId = player:GetMapId()
    local instanceId = player:GetInstanceId()
    local phase = player:GetPhaseMask() or 1
    local oldGuid = guid -- Store before removal

    -- Remove current GameObject completely
    gob:RemoveFromWorld(true)
    gob = nil -- Clear reference

    -- Respawn at original position
    local newGob = PerformIngameSpawn(2, entry, mapId, instanceId,
        originalState.x, originalState.y, originalState.z, originalState.o,
        false, 0, phase)

    if newGob then
        -- Apply original scale
        if originalState.scale and originalState.scale ~= 1.0 then
            newGob:SetScale(originalState.scale)
        end

        -- Get new GUID
        local newGuid = newGob:GetGUIDLow()

        -- Send updated data to client
        local objectData = {
            guid = newGuid,
            entry = entry,
            x = originalState.x,
            y = originalState.y,
            z = originalState.z,
            o = originalState.o,
            scale = originalState.scale,
            entityType = "GameObject"
        }

        AIO.Handle(player, "ObjectEditor", "ObjectRespawned", oldGuid, objectData)
        AIO.Handle(player, "ObjectEditor", "Success", "Object reset to original state")
    else
        AIO.Handle(player, "ObjectEditor", "Error", "Failed to reset object")
    end
end

-- =====================================================
-- GameObject Database Operations
-- =====================================================

-- Save GameObject to database
function GameObjectEditorHandlers.saveGameObjectToDB(player, guid)
    local gob = ObjectEditorUtils.GetGameObjectByGuid(player, guid)
    if not gob then
        AIO.Handle(player, "ObjectEditor", "ObjectNotFound", guid)
        return
    end

    local canEdit, reason = ObjectEditorUtils.CanEditObject(player, gob)
    if not canEdit then
        AIO.Handle(player, "ObjectEditor", "Error", reason)
        return
    end

    -- Get current GameObject data before removal
    local entry = gob:GetEntry()
    local x, y, z, o = gob:GetX(), gob:GetY(), gob:GetZ(), gob:GetO()
    local scale = gob:GetScale() or 1.0
    local mapId = player:GetMapId()
    local instanceId = player:GetInstanceId()
    local phase = player:GetPhaseMask() or 1
    local oldGuid = guid

    -- Remove the temporary GameObject
    gob:RemoveFromWorld(true)
    gob = nil

    -- Respawn with save = true to persist in database
    local savedGob = PerformIngameSpawn(2, entry, mapId, instanceId, x, y, z, o, true, 0, phase)

    if savedGob then
        -- Apply scale if needed
        if scale ~= 1.0 then
            savedGob:SetScale(scale)
        end

        -- Save explicitly to ensure it's in database
        savedGob:SaveToDB()

        local newGuid = savedGob:GetGUIDLow()

        -- Log action
        if ObjectEditorUtils.IsDebugEnabled() then
            print(string.format("[ObjectEditor] Player %s saved GameObject %d to database (new GUID: %d)",
                player:GetName(), entry, newGuid))
        end

        Utils.sendMessage(player, "success", string.format("GameObject %d saved to database", entry))

        -- Send updated data to client with new GUID
        local objectData = {
            guid = newGuid,
            entry = entry,
            x = x,
            y = y,
            z = z,
            o = o,
            scale = scale,
            entityType = "GameObject"
        }

        -- Send confirmation with new object data
        AIO.Handle(player, "ObjectEditor", "ObjectSavedWithData", oldGuid, objectData)
    else
        AIO.Handle(player, "ObjectEditor", "Error", "Failed to save GameObject to database")
    end
end

-- =====================================================
-- GameObject Creation and Duplication
-- =====================================================

-- Duplicate GameObject at specified position
function GameObjectEditorHandlers.duplicateGameObjectAtPosition(player, entry, x, y, z, o, scale)
    entry = tonumber(entry)
    if not entry or entry <= 0 then
        AIO.Handle(player, "ObjectEditor", "Error", "Invalid GameObject entry")
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
    local gob = PerformIngameSpawn(2, entry, mapId, instanceId, x, y, z, o, save, durorresptime, phase)

    if gob then
        -- Apply scale if not default
        if scale ~= 1.0 then
            gob:SetScale(scale)
            -- Save scale to database
            gob:SaveToDB()
        end

        -- Get data for the new object
        local newObjectData = {
            guid = gob:GetGUIDLow(),
            entry = entry,
            name = gob:GetName(),
            x = gob:GetX(),
            y = gob:GetY(),
            z = gob:GetZ(),
            o = gob:GetO(),
            scale = gob:GetScale() or 1.0,
            entityType = "GameObject"
        }

        Utils.sendMessage(player, "success", "GameObject duplicated at current position")

        -- Send to client to open editor for new object
        AIO.Handle(player, "ObjectEditor", "ObjectDuplicated", nil, newObjectData)
    else
        AIO.Handle(player, "ObjectEditor", "Error", "Failed to duplicate GameObject")
    end
end

-- =====================================================
-- GameObject Events
-- =====================================================

-- Hook for when GameObject is spawned (to auto-open editor)
function GameObjectEditorHandlers.onGameObjectSpawn(player, gameObject)
    if not gameObject then return end

    -- Gather object data
    local objectData = {
        guid = gameObject:GetGUIDLow(),
        entry = gameObject:GetEntry(),
        x = gameObject:GetX(),
        y = gameObject:GetY(),
        z = gameObject:GetZ(),
        o = gameObject:GetO(),
        scale = gameObject:GetScale() or 1.0
    }

    -- Send to client (client will decide whether to auto-open based on config)
    AIO.Handle(player, "ObjectEditor", "AutoOpenAfterSpawn", objectData)
end

-- =====================================================
-- GameObject Search and Discovery
-- =====================================================

-- Get nearby GameObjects for selection
function GameObjectEditorHandlers.getNearbyGameObjects(player, range)
    range = range or 20 -- Default 20 yard range

    -- Debug: Always print for now
    print(string.format("[ObjectEditor] Searching for GameObjects within %d yards of player %s",
        range, player:GetName()))

    -- GetNearObjects(range, type, entry, hostile, dead)
    -- type 3 = GameObject
    local gameObjects = player:GetNearObjects(range, 3)
    local objectList = {}

    if gameObjects then
        print(string.format("[ObjectEditor] GetNearObjects returned %d objects", #gameObjects))
        for _, gob in ipairs(gameObjects) do
            if gob then
                -- Safely check if GameObject is valid before accessing its methods
                local success, gobData = pcall(function()
                    return {
                        guid = gob:GetGUIDLow(),
                        entry = gob:GetEntry(),
                        distance = player:GetDistance(gob),
                        x = gob:GetX(),
                        y = gob:GetY(),
                        z = gob:GetZ(),
                        inWorld = gob:IsInWorld()
                    }
                end)

                if success and gobData and gobData.inWorld and gobData.distance <= range then
                    table.insert(objectList, {
                        guid = gobData.guid,
                        entry = gobData.entry,
                        distance = gobData.distance,
                        x = gobData.x,
                        y = gobData.y,
                        z = gobData.z
                    })
                    print(string.format("[ObjectEditor] Added GameObject: Entry=%d, Distance=%.1f",
                        gobData.entry, gobData.distance))
                end
            end
        end
    else
        print("[ObjectEditor] GetNearObjects returned nil")
    end

    print(string.format("[ObjectEditor] Total GameObjects found: %d", #objectList))

    -- Sort by distance
    table.sort(objectList, function(a, b) return a.distance < b.distance end)

    return objectList
end

return GameObjectEditorHandlers