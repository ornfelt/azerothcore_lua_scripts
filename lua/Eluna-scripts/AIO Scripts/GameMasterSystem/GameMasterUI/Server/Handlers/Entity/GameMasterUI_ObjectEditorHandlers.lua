local ObjectEditorHandlers = {}

-- Local references (will be set in RegisterHandlers)
local Config, Utils, Database, DatabaseHelper
local GameMasterSystem

-- Configuration
local EDITOR_CONFIG = {
    MAX_EDIT_RANGE = 100, -- Maximum range to edit objects
    MIN_SCALE = 0.1,
    MAX_SCALE = 5.0,
    -- World coordinate bounds (can be customized per map)
    WORLD_BOUNDS = {
        x = { min = -5000, max = 5000 },
        y = { min = -5000, max = 5000 },
        z = { min = -500, max = 1500 },
    },
    DEBUG = true -- Temporarily enable debug for troubleshooting
}

-- Helper function to get GameObject by GUID
local function GetGameObjectByGuid(player, guid)
    if not guid then 
        if EDITOR_CONFIG.DEBUG then
            print("[ObjectEditor] GetGameObjectByGuid: No GUID provided")
        end
        return nil 
    end
    
    if EDITOR_CONFIG.DEBUG then
        print(string.format("[ObjectEditor] Looking for GameObject with GUID: %d", guid))
    end
    
    -- Try to find the GameObject in range using GetNearObjects
    -- GetNearObjects(range, type, entry, hostile, dead)
    -- type 3 = GameObject
    local gameObjects = player:GetNearObjects(EDITOR_CONFIG.MAX_EDIT_RANGE, 3)
    if gameObjects then
        if EDITOR_CONFIG.DEBUG then
            print(string.format("[ObjectEditor] Found %d objects with type mask 3", #gameObjects))
        end
        
        for _, gob in ipairs(gameObjects) do
            if gob then
                -- Safely check if GameObject is valid before accessing its methods
                local success, gobData = pcall(function() 
                    -- Verify this is actually a GameObject by checking TypeId
                    local typeId = gob:GetTypeId()
                    if typeId ~= 5 then -- TypeId 5 = GameObject
                        if EDITOR_CONFIG.DEBUG then
                            print(string.format("[ObjectEditor] Object has wrong TypeId: %d (expected 5)", typeId))
                        end
                        return nil
                    end
                    
                    -- Verify GameObject is in world
                    if not gob:IsInWorld() then
                        return nil
                    end
                    
                    return {
                        guid = gob:GetGUIDLow(),
                        name = gob:GetName()
                    }
                end)
                
                if success and gobData and gobData.guid == guid then
                    if EDITOR_CONFIG.DEBUG then
                        print(string.format("[ObjectEditor] Found matching GameObject: %s (GUID: %d)", 
                            gobData.name or "Unknown", guid))
                    end
                    return gob
                elseif success and EDITOR_CONFIG.DEBUG and gobData then
                    -- Log non-matching GUIDs for debugging
                    if math.abs(gobData.guid - guid) < 100 then -- Only log if GUIDs are close
                        print(string.format("[ObjectEditor] GameObject GUID %d doesn't match target %d", gobData.guid, guid))
                    end
                end
            end
        end
        
        if EDITOR_CONFIG.DEBUG then
            print(string.format("[ObjectEditor] GameObject with GUID %d not found", guid))
        end
    else
        if EDITOR_CONFIG.DEBUG then
            print("[ObjectEditor] GetNearObjects returned nil")
        end
    end
    
    return nil
end

-- Helper function to get Creature by GUID
local function GetCreatureByGuid(player, guid)
    if not guid then 
        if EDITOR_CONFIG.DEBUG then
            print("[ObjectEditor] GetCreatureByGuid: No GUID provided")
        end
        return nil 
    end
    
    if EDITOR_CONFIG.DEBUG then
        print(string.format("[ObjectEditor] Looking for Creature with GUID: %d", guid))
    end
    
    -- Use GetCreaturesInRange for more reliable creature detection
    local creatures = player:GetCreaturesInRange(EDITOR_CONFIG.MAX_EDIT_RANGE)
    if creatures then
        if EDITOR_CONFIG.DEBUG then
            print(string.format("[ObjectEditor] Found %d creatures in range %d", #creatures, EDITOR_CONFIG.MAX_EDIT_RANGE))
        end
        
        for _, creature in ipairs(creatures) do
            if creature then
                -- Safely check if Creature is valid before accessing its methods
                local success, creatureGuid = pcall(function() 
                    -- Verify creature is in world first
                    if not creature:IsInWorld() then
                        return nil
                    end
                    return creature:GetGUIDLow() 
                end)
                
                if success and creatureGuid == guid then
                    if EDITOR_CONFIG.DEBUG then
                        print(string.format("[ObjectEditor] Found matching Creature: %s (GUID: %d)", 
                            creature:GetName() or "Unknown", guid))
                    end
                    return creature
                elseif success and EDITOR_CONFIG.DEBUG and creatureGuid then
                    -- Log non-matching GUIDs for debugging
                    if math.abs(creatureGuid - guid) < 100 then -- Only log if GUIDs are close
                        print(string.format("[ObjectEditor] Creature GUID %d doesn't match target %d", creatureGuid, guid))
                    end
                end
            end
        end
        
        if EDITOR_CONFIG.DEBUG then
            print(string.format("[ObjectEditor] Creature with GUID %d not found among %d creatures", guid, #creatures))
        end
    else
        if EDITOR_CONFIG.DEBUG then
            print("[ObjectEditor] GetCreaturesInRange returned nil")
        end
    end
    
    return nil
end

-- Helper function to get any entity (GameObject or Creature) by GUID
local function GetEntityByGuid(player, guid, entityType)
    if entityType == "GameObject" then
        return GetGameObjectByGuid(player, guid)
    elseif entityType == "Creature" then
        return GetCreatureByGuid(player, guid)
    end
    return nil
end

-- Helper function to validate player can edit entity
local function CanEditEntity(player, entity, entityType)
    if not entity then
        return false, entityType .. " not found"
    end
    
    if not entity:IsInWorld() then
        return false, entityType .. " is not in world"
    end
    
    local distance = player:GetDistance(entity)
    if distance > EDITOR_CONFIG.MAX_EDIT_RANGE then
        return false, entityType .. " is too far away"
    end
    
    return true
end

-- Compatibility wrapper for GameObject
local function CanEditObject(player, gameObject)
    return CanEditEntity(player, gameObject, "GameObject")
end

-- Validate world coordinates
local function ValidateWorldCoordinates(x, y, z)
    local bounds = EDITOR_CONFIG.WORLD_BOUNDS
    
    -- Validate X coordinate
    if x < bounds.x.min or x > bounds.x.max then
        return false, string.format("X coordinate %.2f is out of bounds [%.0f, %.0f]", x, bounds.x.min, bounds.x.max)
    end
    
    -- Validate Y coordinate
    if y < bounds.y.min or y > bounds.y.max then
        return false, string.format("Y coordinate %.2f is out of bounds [%.0f, %.0f]", y, bounds.y.min, bounds.y.max)
    end
    
    -- Validate Z coordinate
    if z < bounds.z.min or z > bounds.z.max then
        return false, string.format("Z coordinate %.2f is out of bounds [%.0f, %.0f]", z, bounds.z.min, bounds.z.max)
    end
    
    return true
end

-- Get GameObject data for editor
function ObjectEditorHandlers.getGameObjectData(player, guid)
    local gob = GetGameObjectByGuid(player, guid)
    if not gob then
        AIO.Handle(player, "ObjectEditor", "ObjectNotFound", guid)
        return
    end
    
    local canEdit, reason = CanEditObject(player, gob)
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
function ObjectEditorHandlers.getSelectedGameObject(player)
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
    ObjectEditorHandlers.getGameObjectData(player, target:GetGUIDLow())
end

-- Update GameObject with multiple changes at once
function ObjectEditorHandlers.updateGameObject(player, guid, updates)
    -- Debug: log incoming update request
    print(string.format("[ObjectEditor] Player %s updating GameObject %d", player:GetName(), guid))
    if updates then
        for k, v in pairs(updates) do
            print(string.format("  - Update type: %s", tostring(k)))
        end
    end
    
    local gob = GetGameObjectByGuid(player, guid)
    if not gob then
        print(string.format("[ObjectEditor] GameObject %d not found!", guid))
        AIO.Handle(player, "ObjectEditor", "ObjectNotFound", guid)
        return
    end
    
    local canEdit, reason = CanEditObject(player, gob)
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
        local valid, errorMsg = ValidateWorldCoordinates(newX, newY, newZ)
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
        newScale = math.max(EDITOR_CONFIG.MIN_SCALE, math.min(EDITOR_CONFIG.MAX_SCALE, updates.scale))
        needsRespawn = true
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
            -- Apply scale if changed
            if newScale ~= 1.0 then
                newGob:SetScale(newScale)
            end
            
            -- Get new GUID
            local newGuid = newGob:GetGUIDLow()
            
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
            
            if EDITOR_CONFIG.DEBUG then
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

-- Copy player position to GameObject
function ObjectEditorHandlers.copyPlayerPositionToObject(player, guid)
    local gob = GetGameObjectByGuid(player, guid)
    if not gob then
        AIO.Handle(player, "ObjectEditor", "ObjectNotFound", guid)
        return
    end
    
    local canEdit, reason = CanEditObject(player, gob)
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
function ObjectEditorHandlers.faceObjectToPlayer(player, guid)
    local gob = GetGameObjectByGuid(player, guid)
    if not gob then
        AIO.Handle(player, "ObjectEditor", "ObjectNotFound", guid)
        return
    end
    
    local canEdit, reason = CanEditObject(player, gob)
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

-- Reset GameObject to original state
function ObjectEditorHandlers.resetGameObject(player, guid, originalState)
    local gob = GetGameObjectByGuid(player, guid)
    if not gob then
        AIO.Handle(player, "ObjectEditor", "ObjectNotFound", guid)
        return
    end
    
    local canEdit, reason = CanEditObject(player, gob)
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

-- Save GameObject to database
function ObjectEditorHandlers.saveGameObjectToDB(player, guid)
    local gob = GetGameObjectByGuid(player, guid)
    if not gob then
        AIO.Handle(player, "ObjectEditor", "ObjectNotFound", guid)
        return
    end
    
    local canEdit, reason = CanEditObject(player, gob)
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
        if EDITOR_CONFIG.DEBUG then
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

-- Duplicate GameObject at specified position
function ObjectEditorHandlers.duplicateGameObjectAtPosition(player, entry, x, y, z, o, scale)
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

-- Hook for when GameObject is spawned (to auto-open editor)
function ObjectEditorHandlers.onGameObjectSpawn(player, gameObject)
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

-- Get nearby GameObjects for selection
function ObjectEditorHandlers.getNearbyGameObjects(player, range)
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

-- Get creature data for editor
function ObjectEditorHandlers.getCreatureData(player, guid)
    if EDITOR_CONFIG.DEBUG then
        print(string.format("[ObjectEditor] getCreatureData called for GUID: %d by player %s", 
            guid or 0, player:GetName()))
    end
    
    local creature = GetCreatureByGuid(player, guid)
    if not creature then
        print(string.format("[ObjectEditor] ERROR: Creature with GUID %d not found in range!", guid))
        AIO.Handle(player, "ObjectEditor", "CreatureNotFound", guid)
        return
    end
    
    local canEdit, reason = CanEditEntity(player, creature, "Creature")
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
    
    if EDITOR_CONFIG.DEBUG then
        print(string.format("[ObjectEditor] Sending creature data to client: %s (Entry: %d, GUID: %d)", 
            creatureData.name, creatureData.entry, creatureData.guid))
    end
    
    -- Send data to client
    AIO.Handle(player, "ObjectEditor", "OpenEditor", creatureData)
end

-- Get selected creature data
function ObjectEditorHandlers.getSelectedCreature(player)
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
    ObjectEditorHandlers.getCreatureData(player, target:GetGUIDLow())
end

-- Update Creature with multiple changes at once
function ObjectEditorHandlers.updateCreature(player, guid, updates)
    -- Debug: log incoming update request
    print(string.format("[ObjectEditor] Player %s updating Creature %d", player:GetName(), guid))
    if updates then
        for k, v in pairs(updates) do
            print(string.format("  - Update type: %s", tostring(k)))
        end
    end
    
    local creature = GetCreatureByGuid(player, guid)
    if not creature then
        print(string.format("[ObjectEditor] Creature %d not found!", guid))
        AIO.Handle(player, "ObjectEditor", "CreatureNotFound", guid)
        return
    end
    
    local canEdit, reason = CanEditEntity(player, creature, "Creature")
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
        local valid, errorMsg = ValidateWorldCoordinates(newX, newY, newZ)
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
        local newScale = updates.scale and math.max(EDITOR_CONFIG.MIN_SCALE, math.min(EDITOR_CONFIG.MAX_SCALE, updates.scale)) or currentScale
        local oldGuid = guid
        
        -- Despawn the existing creature
        creature:DespawnOrUnsummon(0) -- Immediate despawn
        creature = nil -- Clear reference
        
        -- Respawn at new position with new properties
        -- PerformIngameSpawn(spawnType, entry, mapId, instanceId, x, y, z, o, save, durorresptime, phase)
        -- spawnType 1 = Creature, 2 = GameObject
        local newCreature = PerformIngameSpawn(1, entry, mapId, instanceId, newX, newY, newZ, newO, false, 0, phase)
        
        if newCreature then
            -- Apply scale if needed
            if newScale ~= 1.0 then
                newCreature:SetScale(newScale)
            end
            
            -- Get new GUID
            local newGuid = newCreature:GetGUIDLow()
            
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
            
            if EDITOR_CONFIG.DEBUG then
                print(string.format("[ObjectEditor] Respawned Creature %d (new GUID: %d): Pos(%.2f, %.2f, %.2f) Rot(%.2f) Scale(%.2f)",
                    entry, newGuid, newX, newY, newZ, newO, newScale))
            end
        else
            -- Failed to respawn
            AIO.Handle(player, "ObjectEditor", "Error", "Failed to respawn creature")
            print(string.format("[ObjectEditor] Failed to respawn Creature %d", entry))
        end
    end
    
    -- Debug output handled in the respawn section above
end

-- Copy player position to Creature
function ObjectEditorHandlers.copyPlayerPositionToCreature(player, guid)
    local creature = GetCreatureByGuid(player, guid)
    if not creature then
        AIO.Handle(player, "ObjectEditor", "CreatureNotFound", guid)
        return
    end
    
    local canEdit, reason = CanEditEntity(player, creature, "Creature")
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
function ObjectEditorHandlers.faceCreatureToPlayer(player, guid)
    local creature = GetCreatureByGuid(player, guid)
    if not creature then
        AIO.Handle(player, "ObjectEditor", "CreatureNotFound", guid)
        return
    end
    
    local canEdit, reason = CanEditEntity(player, creature, "Creature")
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

-- Reset Creature to original state
function ObjectEditorHandlers.resetCreature(player, guid, originalState)
    local creature = GetCreatureByGuid(player, guid)
    if not creature then
        AIO.Handle(player, "ObjectEditor", "CreatureNotFound", guid)
        return
    end
    
    local canEdit, reason = CanEditEntity(player, creature, "Creature")
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

-- Save Creature to database
function ObjectEditorHandlers.saveCreatureToDB(player, guid)
    local creature = GetCreatureByGuid(player, guid)
    if not creature then
        AIO.Handle(player, "ObjectEditor", "CreatureNotFound", guid)
        return
    end
    
    local canEdit, reason = CanEditEntity(player, creature, "Creature")
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
    -- PerformIngameSpawn(spawnType, entry, mapId, instanceId, x, y, z, o, save, durorresptime, phase)
    -- Use respawn time 0 for instant respawn, matching GameObject behavior
    local savedCreature = PerformIngameSpawn(1, entry, mapId, instanceId, x, y, z, o, true, 0, phase)
    
    if savedCreature then
        -- Apply scale if needed
        if scale ~= 1.0 then
            savedCreature:SetScale(scale)
        end
        
        local newGuid = savedCreature:GetGUIDLow()
        
        -- Log action
        if EDITOR_CONFIG.DEBUG then
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

-- Combined function to save and duplicate creature in one operation
function ObjectEditorHandlers.duplicateAndSaveCreature(player, guid)
    local creature = GetCreatureByGuid(player, guid)
    if not creature then
        AIO.Handle(player, "ObjectEditor", "CreatureNotFound", guid)
        return
    end
    
    local canEdit, reason = CanEditEntity(player, creature, "Creature")
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
    
    if EDITOR_CONFIG.DEBUG then
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
        
        if EDITOR_CONFIG.DEBUG then
            print(string.format("[ObjectEditor] Created duplicate creature %d with GUID %d", 
                entry, duplicateData.guid))
        end
        
        Utils.sendMessage(player, "success", "Creature saved & duplicated")
        
        -- Send to client to switch editor to the duplicate
        AIO.Handle(player, "ObjectEditor", "CreatureDuplicated", originalGuid, duplicateData)
    else
        AIO.Handle(player, "ObjectEditor", "Error", "Failed to create duplicate creature")
    end
end

-- Duplicate Creature at specified position
function ObjectEditorHandlers.duplicateCreatureAtPosition(player, entry, x, y, z, o, scale)
    entry = tonumber(entry)
    if not entry or entry <= 0 then
        AIO.Handle(player, "ObjectEditor", "Error", "Invalid creature entry")
        return
    end
    
    -- Position parameters should be provided from the current edited creature position
    if not x or not y or not z then
        AIO.Handle(player, "ObjectEditor", "Error", "Position required for creature duplication")
        return
    end
    
    -- Ensure orientation and scale are valid
    o = o or 0
    scale = scale or 1.0
    
    local mapId = player:GetMapId()
    local instanceId = player:GetInstanceId()
    local save = true  -- Save to database
    local respawnTime = 0 -- Instant respawn, matching GameObject behavior
    local phase = player:GetPhaseMask() or 1
    
    -- Spawn the duplicate at the exact same position as the original creature
    local creature = PerformIngameSpawn(1, entry, mapId, instanceId, x, y, z, o, save, respawnTime, phase)
    
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
        
        if EDITOR_CONFIG.DEBUG then
            print(string.format("[ObjectEditor] Creature %d duplicated at position (%.2f, %.2f, %.2f)", 
                entry, x, y, z))
        end
        
        -- Send to client to open editor for new creature (originalGuid = nil since original is already saved)
        AIO.Handle(player, "ObjectEditor", "CreatureDuplicated", nil, newCreatureData)
    else
        AIO.Handle(player, "ObjectEditor", "Error", "Failed to duplicate creature")
    end
end

-- Get nearby Creatures for selection
function ObjectEditorHandlers.getNearbyCreatures(player, range)
    range = range or 20 -- Default 20 yard range
    
    if EDITOR_CONFIG.DEBUG then
        print(string.format("[ObjectEditor] Searching for Creatures within %d yards of player %s",
            range, player:GetName()))
    end
    
    -- Use the correct Eluna API for getting creatures
    local creatures = player:GetCreaturesInRange(range)
    local creatureList = {}
    
    if creatures then
        if EDITOR_CONFIG.DEBUG then
            print(string.format("[ObjectEditor] GetCreaturesInRange returned %d creatures", #creatures))
        end
        
        for _, creature in ipairs(creatures) do
            if creature then
                -- Safely check if Creature is valid before accessing its methods
                local success, creatureData = pcall(function()
                    -- Verify creature is in world
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
                
                if success and creatureData and creatureData.distance <= range then
                    table.insert(creatureList, {
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
                    
                    if EDITOR_CONFIG.DEBUG then
                        print(string.format("[ObjectEditor] Added Creature: Entry=%d, Name=%s, Distance=%.1f",
                            creatureData.entry, creatureData.name, creatureData.distance))
                    end
                end
            end
        end
    else
        if EDITOR_CONFIG.DEBUG then
            print("[ObjectEditor] GetCreaturesInRange returned nil")
        end
    end
    
    if EDITOR_CONFIG.DEBUG then
        print(string.format("[ObjectEditor] Total Creatures found: %d", #creatureList))
    end
    
    -- Sort by distance
    table.sort(creatureList, function(a, b) return a.distance < b.distance end)
    
    return creatureList
end

-- Get both nearby GameObjects and Creatures combined
function ObjectEditorHandlers.getNearbyEntities(player, range)
    range = range or 30 -- Default 30 yard range
    
    local entities = {}
    local seenGuids = {} -- Track GUIDs to prevent duplicates
    
    -- Debug log
    if EDITOR_CONFIG.DEBUG then
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
                    if EDITOR_CONFIG.DEBUG then
                        print(string.format("[ObjectEditor] Object TypeId: %d for entry %d", typeId, gob:GetEntry()))
                    end
                    
                    -- Only process if this is truly a GameObject (TypeId 5)
                    if typeId ~= 5 then
                        if EDITOR_CONFIG.DEBUG then
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
                    elseif EDITOR_CONFIG.DEBUG then
                        print(string.format("[ObjectEditor] Skipping duplicate GameObject GUID: %d", gobData.guid))
                    end
                end
            end
        end
    end
    
    -- Get Creatures using the correct Eluna API
    local creatures = player:GetCreaturesInRange(range) -- This returns only creatures, no players
    
    if creatures then
        if EDITOR_CONFIG.DEBUG then
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
                            
                            if EDITOR_CONFIG.DEBUG then
                                print(string.format("[ObjectEditor] Added Creature: %s (Entry: %d, Distance: %.1f)",
                                    creatureData.name, creatureData.entry, creatureData.distance))
                            end
                        elseif EDITOR_CONFIG.DEBUG then
                            print(string.format("[ObjectEditor] Skipping duplicate Creature GUID: %d", creatureData.guid))
                        end
                    end
                elseif EDITOR_CONFIG.DEBUG then
                    print(string.format("[ObjectEditor] Failed to get data for creature %d", i))
                end
            end
        end
        
        if EDITOR_CONFIG.DEBUG then
            print(string.format("[ObjectEditor] Successfully processed %d creatures", #creatures))
        end
    else
        if EDITOR_CONFIG.DEBUG then
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

-- Register all handlers with the GameMasterSystem
function ObjectEditorHandlers.RegisterHandlers(gmSystem, config, utils, database, databaseHelper)
    -- Store references
    GameMasterSystem = gmSystem
    Config = config
    Utils = utils
    Database = database
    DatabaseHelper = databaseHelper
    
    -- Update configuration
    EDITOR_CONFIG.DEBUG = Config.debug or false
    
    -- Register handlers for GameObject editing
    GameMasterSystem.getGameObjectForEdit = function(player, guid)
        ObjectEditorHandlers.getGameObjectData(player, guid)
    end
    
    GameMasterSystem.getSelectedGameObject = function(player)
        ObjectEditorHandlers.getSelectedGameObject(player)
    end
    
    GameMasterSystem.updateGameObject = function(player, guid, updates)
        ObjectEditorHandlers.updateGameObject(player, guid, updates)
    end
    
    GameMasterSystem.copyPlayerPositionToObject = function(player, guid)
        ObjectEditorHandlers.copyPlayerPositionToObject(player, guid)
    end
    
    GameMasterSystem.faceObjectToPlayer = function(player, guid)
        ObjectEditorHandlers.faceObjectToPlayer(player, guid)
    end
    
    GameMasterSystem.resetGameObject = function(player, guid, originalState)
        ObjectEditorHandlers.resetGameObject(player, guid, originalState)
    end
    
    GameMasterSystem.saveGameObjectToDB = function(player, guid)
        ObjectEditorHandlers.saveGameObjectToDB(player, guid)
    end
    
    GameMasterSystem.duplicateGameObjectAtPosition = function(player, entry, x, y, z, o, scale)
        ObjectEditorHandlers.duplicateGameObjectAtPosition(player, entry, x, y, z, o, scale)
    end
    
    GameMasterSystem.getNearbyGameObjects = function(player, range)
        local objects = ObjectEditorHandlers.getNearbyGameObjects(player, range)
        -- Send to client
        AIO.Handle(player, "ObjectEditor", "ReceiveNearbyObjects", objects)
    end
    
    -- Register handlers for Creature editing
    GameMasterSystem.getCreatureForEdit = function(player, guid)
        ObjectEditorHandlers.getCreatureData(player, guid)
    end
    
    GameMasterSystem.getSelectedCreature = function(player)
        ObjectEditorHandlers.getSelectedCreature(player)
    end
    
    GameMasterSystem.updateCreature = function(player, guid, updates)
        ObjectEditorHandlers.updateCreature(player, guid, updates)
    end
    
    GameMasterSystem.copyPlayerPositionToCreature = function(player, guid)
        ObjectEditorHandlers.copyPlayerPositionToCreature(player, guid)
    end
    
    GameMasterSystem.faceCreatureToPlayer = function(player, guid)
        ObjectEditorHandlers.faceCreatureToPlayer(player, guid)
    end
    
    GameMasterSystem.resetCreature = function(player, guid, originalState)
        ObjectEditorHandlers.resetCreature(player, guid, originalState)
    end
    
    GameMasterSystem.saveCreatureToDB = function(player, guid)
        ObjectEditorHandlers.saveCreatureToDB(player, guid)
    end
    
    GameMasterSystem.duplicateAndSaveCreature = function(player, guid)
        ObjectEditorHandlers.duplicateAndSaveCreature(player, guid)
    end
    
    GameMasterSystem.duplicateCreatureAtPosition = function(player, entry, x, y, z, o, scale)
        ObjectEditorHandlers.duplicateCreatureAtPosition(player, entry, x, y, z, o, scale)
    end
    
    GameMasterSystem.getNearbyCreatures = function(player, range)
        local creatures = ObjectEditorHandlers.getNearbyCreatures(player, range)
        -- Send to client
        AIO.Handle(player, "ObjectEditor", "ReceiveNearbyCreatures", creatures)
    end
    
    -- Combined entity handler
    GameMasterSystem.getNearbyEntities = function(player, range)
        print(string.format("[ObjectEditor] getNearbyEntities called with range: %d", range or 30))
        local entities = ObjectEditorHandlers.getNearbyEntities(player, range)
        print(string.format("[ObjectEditor] Found %d entities, sending to client", #entities))
        -- Send to client
        AIO.Handle(player, "EntitySelectionDialog", "ReceiveEntities", entities)
    end
    
    -- Delete handlers
    GameMasterSystem.deleteGameObjectFromWorld = function(player, guid)
        local gob = GetGameObjectByGuid(player, guid)
        if gob then
            gob:Despawn()
            AIO.Handle(player, "GameMasterSystem", "EntityDeleted", "GameObject", guid)
        end
    end
    
    GameMasterSystem.deleteCreatureFromWorld = function(player, guid)
        local creature = GetCreatureByGuid(player, guid)
        if creature then
            creature:DespawnOrUnsummon(0)
            AIO.Handle(player, "GameMasterSystem", "EntityDeleted", "Creature", guid)
        end
    end
    
    -- Duplicate at position handlers
    GameMasterSystem.duplicateCreatureAtPosition = function(player, entry, x, y, z, o)
        o = o or player:GetO()
        local creature = player:SpawnCreature(entry, x, y, z, o, 2) -- spawn type 2 = TEMPSUMMON_TIMED_OR_DEAD_DESPAWN
        if creature then
            AIO.Handle(player, "GameMasterSystem", "EntityDuplicated", "Creature", entry)
        end
    end
    
    
    -- Teleport to position
    GameMasterSystem.teleportToPosition = function(player, x, y, z)
        player:Teleport(player:GetMapId(), x, y, z, player:GetO())
    end
    
    -- Generic update handler that determines entity type
    GameMasterSystem.updateEntity = function(player, guid, entityType, updates)
        if entityType == "GameObject" then
            ObjectEditorHandlers.updateGameObject(player, guid, updates)
        elseif entityType == "Creature" then
            ObjectEditorHandlers.updateCreature(player, guid, updates)
        end
    end
    
    -- Log initialization
    if EDITOR_CONFIG.DEBUG then
        print("[ObjectEditor] Handlers registered successfully")
    end
end

return ObjectEditorHandlers