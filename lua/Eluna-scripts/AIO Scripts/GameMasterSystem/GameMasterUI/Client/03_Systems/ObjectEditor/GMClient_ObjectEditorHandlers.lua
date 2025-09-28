local AIO = AIO or require("AIO")

if AIO.AddAddon() then
    return -- Exit if on server
end

-- Get references
local ObjectEditor = _G.ObjectEditor
if not ObjectEditor then
    print("[ERROR] ObjectEditor namespace not found! Check load order.")
    return
end

local GameMasterSystem = _G.GameMasterSystem

-- Register handlers
local handlers = AIO.AddHandlers("ObjectEditor", {})

-- Handler: Open editor with object data
function handlers.OpenEditor(player, objectData)
    if not objectData then
        print("[ObjectEditor] Error: No object data received")
        return
    end
    
    -- Ensure we have required data
    if not objectData.guid or not objectData.entry then
        print("[ObjectEditor] Error: Invalid object data - missing GUID or entry")
        return
    end
    
    -- Open the editor
    ObjectEditor.OpenEditor(objectData)
end

-- Handler: Update object data in editor
function handlers.UpdateObjectData(player, objectData)
    if not ObjectEditor.currentObject or not objectData then
        return
    end
    
    -- Update current object data
    if objectData.guid == ObjectEditor.currentObject.guid then
        for key, value in pairs(objectData) do
            ObjectEditor.currentObject[key] = value
        end
        
        -- Reload UI values if not actively editing
        if not ObjectEditor.isEditing then
            ObjectEditor.LoadObjectData(ObjectEditor.currentObject)
        end
    end
end

-- Handler: Object position updated
function handlers.ObjectPositionUpdated(player, guid, x, y, z)
    if not ObjectEditor.currentObject or ObjectEditor.currentObject.guid ~= guid then
        return
    end
    
    -- Update stored position
    ObjectEditor.currentObject.x = x
    ObjectEditor.currentObject.y = y
    ObjectEditor.currentObject.z = z
    
    -- Update UI if not actively editing
    if not ObjectEditor.isEditing then
        ObjectEditor.isUpdating = true
        
        -- Update value displays and labels
        if ObjectEditor.positionSliders then
            -- Update X
            if ObjectEditor.positionSliders.x.label then
                ObjectEditor.positionSliders.x.label:SetText(string.format("X: %.1f", x))
            end
            ObjectEditor.positionSliders.x.offsetText:SetText("+0.0")
            
            -- Update Y
            if ObjectEditor.positionSliders.y.label then
                ObjectEditor.positionSliders.y.label:SetText(string.format("Y: %.1f", y))
            end
            ObjectEditor.positionSliders.y.offsetText:SetText("+0.0")
            
            -- Update Z
            if ObjectEditor.positionSliders.z.label then
                ObjectEditor.positionSliders.z.label:SetText(string.format("Z: %.1f", z))
            end
            ObjectEditor.positionSliders.z.offsetText:SetText("+0.0")
        end
        
        ObjectEditor.isUpdating = false
    end
end

-- Handler: Object rotation updated
function handlers.ObjectRotationUpdated(player, guid, orientation)
    if not ObjectEditor.currentObject or ObjectEditor.currentObject.guid ~= guid then
        return
    end
    
    -- Update stored orientation
    ObjectEditor.currentObject.o = orientation
    
    -- Update UI if not actively editing
    if not ObjectEditor.isEditing and ObjectEditor.rotationSlider then
        ObjectEditor.isUpdating = true
        local degrees = math.deg(orientation)
        ObjectEditor.rotationSlider:SetValue(degrees)
        ObjectEditor.isUpdating = false
    end
end

-- Handler: Object scale updated
function handlers.ObjectScaleUpdated(player, guid, scale)
    if not ObjectEditor.currentObject or ObjectEditor.currentObject.guid ~= guid then
        return
    end
    
    -- Update stored scale
    ObjectEditor.currentObject.scale = scale
    
    -- Update UI if not actively editing
    if not ObjectEditor.isEditing and ObjectEditor.scaleSlider then
        ObjectEditor.isUpdating = true
        ObjectEditor.scaleSlider:SetValue(scale)
        ObjectEditor.isUpdating = false
    end
end

-- Handler: Object saved to database
function handlers.ObjectSaved(player, guid, success)
    if not ObjectEditor.currentObject or ObjectEditor.currentObject.guid ~= guid then
        return
    end
    
    if success then
        -- Update original state to current state
        if ObjectEditor.currentObject then
            ObjectEditor.originalState = {
                x = ObjectEditor.currentObject.x,
                y = ObjectEditor.currentObject.y,
                z = ObjectEditor.currentObject.z,
                o = ObjectEditor.currentObject.o,
                scale = ObjectEditor.currentObject.scale,
                guid = ObjectEditor.currentObject.guid,
                entry = ObjectEditor.currentObject.entry
            }
        end
        
        if CreateStyledToast then
            CreateStyledToast("GameObject saved successfully!", 2, 0.5)
        end
    else
        if CreateStyledToast then
            CreateStyledToast("Failed to save GameObject!", 2, 0.5)
        end
    end
end

-- Handler: Object duplicated
function handlers.ObjectDuplicated(player, originalGuid, newObjectData)
    if not newObjectData then
        if CreateStyledToast then
            CreateStyledToast("Failed to duplicate GameObject!", 2, 0.5)
        end
        return
    end
    
    if CreateStyledToast then
        CreateStyledToast("Original saved & duplicate created!", 2, 0.5)
    end
    
    -- Close any existing editor first
    if ObjectEditor.dialog and ObjectEditor.dialog:IsShown() then
        -- Don't restore original state since we just saved
        ObjectEditor.currentObject = nil
        ObjectEditor.originalState = nil
        ObjectEditor.pendingUpdates = {}
    end
    
    -- Open editor for the new duplicated object
    ObjectEditor.OpenEditor(newObjectData)
end

-- Handler: Error message
function handlers.Error(player, message)
    if CreateStyledToast then
        CreateStyledToast("Error: " .. (message or "Unknown error"), 3, 0.5)
    else
        print("[ObjectEditor] Error: " .. (message or "Unknown error"))
    end
end

-- Handler: Success message
function handlers.Success(player, message)
    if CreateStyledToast then
        CreateStyledToast(message or "Success!", 2, 0.5)
    else
        print("[ObjectEditor] " .. (message or "Success!"))
    end
end

-- Handler: Object not found or out of range
function handlers.ObjectNotFound(player, guid)
    if CreateStyledToast then
        CreateStyledToast("GameObject not found or out of range!", 3, 0.5)
    end
    
    -- Close editor if this was our object
    if ObjectEditor.currentObject and ObjectEditor.currentObject.guid == guid then
        ObjectEditor.CloseEditor()
    end
end

-- Handler: Request to select a GameObject
function handlers.RequestSelection(player)
    if CreateStyledToast then
        CreateStyledToast("Please select a GameObject first!", 2, 0.5)
    end
end

-- Handler: Auto-open editor after spawn (if enabled)
function handlers.AutoOpenAfterSpawn(player, objectData)
    -- Check if auto-open is enabled in config
    if GMConfig and GMConfig.config and GMConfig.config.autoOpenObjectEditor then
        ObjectEditor.OpenEditor(objectData)
    else
        if CreateStyledToast then
            CreateStyledToast("GameObject spawned! Use 'Edit Object' to modify.", 3, 0.5)
        end
    end
end

-- Handler: Receive nearby GameObjects list
function handlers.ReceiveNearbyObjects(player, objects)
    print(string.format("[ObjectEditor] Received %d nearby objects from server", objects and #objects or 0))
    
    -- Update the nearby objects menu
    if _G.EntityMenus and _G.EntityMenus.updateNearbyObjectsMenu then
        print("[ObjectEditor] Updating nearby objects menu...")
        _G.EntityMenus.updateNearbyObjectsMenu(objects)
    else
        print("[ObjectEditor] EntityMenus.updateNearbyObjectsMenu not found!")
    end
    
    -- Store for potential auto-refresh
    ObjectEditor.nearbyObjects = objects
    ObjectEditor.lastNearbyUpdate = GetTime()
    
    -- Debug: Show first few objects
    if objects and #objects > 0 then
        print(string.format("|cff00ff00Found nearby GameObjects:|r"))
        for i = 1, math.min(3, #objects) do
            local obj = objects[i]
            print(string.format("  [%d] Entry: %d, Distance: %.1f yds", i, obj.entry, obj.distance))
        end
    end
end

-- Handler: Receive nearby Creatures list
function handlers.ReceiveNearbyCreatures(player, creatures)
    print(string.format("[ObjectEditor] Received %d nearby creatures from server", creatures and #creatures or 0))
    
    -- Update the nearby creatures menu
    if _G.EntityMenus and _G.EntityMenus.updateNearbyCreaturesMenu then
        print("[ObjectEditor] Updating nearby creatures menu...")
        _G.EntityMenus.updateNearbyCreaturesMenu(creatures)
    else
        print("[ObjectEditor] EntityMenus.updateNearbyCreaturesMenu not found!")
    end
    
    -- Store for potential auto-refresh
    ObjectEditor.nearbyCreatures = creatures
    ObjectEditor.lastNearbyCreatureUpdate = GetTime()
    
    -- Debug: Show first few creatures
    if creatures and #creatures > 0 then
        print(string.format("|cff00ff00Found nearby Creatures:|r"))
        for i = 1, math.min(3, #creatures) do
            local creature = creatures[i]
            print(string.format("  [%d] %s (Entry: %d, Distance: %.1f yds)", 
                i, creature.name or "Unknown", creature.entry, creature.distance))
        end
    end
end

-- Handler: Receive combined entity list for selection dialog
function handlers.ReceiveEntities(player, entities)
    print(string.format("[ObjectEditor] Received %d entities from server", entities and #entities or 0))
    
    -- Send to EntitySelectionDialog
    if _G.EntitySelectionDialog and _G.EntitySelectionDialog.ReceiveEntities then
        _G.EntitySelectionDialog.ReceiveEntities(entities)
    else
        print("[ObjectEditor] EntitySelectionDialog.ReceiveEntities not found!")
    end
end

-- Handler: Creature position updated
function handlers.CreaturePositionUpdated(player, guid, x, y, z)
    if not ObjectEditor.currentObject or ObjectEditor.currentObject.guid ~= guid then
        return
    end
    
    -- Update stored position
    ObjectEditor.currentObject.x = x
    ObjectEditor.currentObject.y = y
    ObjectEditor.currentObject.z = z
    
    -- Update UI if not actively editing
    if not ObjectEditor.isEditing then
        ObjectEditor.isUpdating = true
        
        -- Update value displays and labels
        if ObjectEditor.positionSliders then
            -- Update X
            if ObjectEditor.positionSliders.x.label then
                ObjectEditor.positionSliders.x.label:SetText(string.format("X: %.1f", x))
            end
            ObjectEditor.positionSliders.x.offsetText:SetText("+0.0")
            
            -- Update Y
            if ObjectEditor.positionSliders.y.label then
                ObjectEditor.positionSliders.y.label:SetText(string.format("Y: %.1f", y))
            end
            ObjectEditor.positionSliders.y.offsetText:SetText("+0.0")
            
            -- Update Z
            if ObjectEditor.positionSliders.z.label then
                ObjectEditor.positionSliders.z.label:SetText(string.format("Z: %.1f", z))
            end
            ObjectEditor.positionSliders.z.offsetText:SetText("+0.0")
        end
        
        ObjectEditor.isUpdating = false
    end
end

-- Handler: Creature rotation updated
function handlers.CreatureRotationUpdated(player, guid, orientation)
    if not ObjectEditor.currentObject or ObjectEditor.currentObject.guid ~= guid then
        return
    end
    
    -- Update stored orientation
    ObjectEditor.currentObject.o = orientation
    
    -- Update UI if not actively editing
    if not ObjectEditor.isEditing and ObjectEditor.rotationSlider then
        ObjectEditor.isUpdating = true
        local degrees = math.deg(orientation)
        ObjectEditor.rotationSlider:SetValue(degrees)
        ObjectEditor.isUpdating = false
    end
end

-- Handler: Creature scale updated
function handlers.CreatureScaleUpdated(player, guid, scale)
    if not ObjectEditor.currentObject or ObjectEditor.currentObject.guid ~= guid then
        return
    end
    
    -- Update stored scale
    ObjectEditor.currentObject.scale = scale
    
    -- Update UI if not actively editing
    if not ObjectEditor.isEditing and ObjectEditor.scaleSlider then
        ObjectEditor.isUpdating = true
        ObjectEditor.scaleSlider:SetValue(scale)
        ObjectEditor.isUpdating = false
    end
end

-- Handler: Creature not found or out of range
function handlers.CreatureNotFound(player, guid)
    if CreateStyledToast then
        CreateStyledToast("Creature not found or out of range!", 3, 0.5)
    end
    
    -- Close editor if this was our creature
    if ObjectEditor.currentObject and ObjectEditor.currentObject.guid == guid then
        ObjectEditor.CloseEditor()
    end
end

-- Handler: GameObject saved with new GUID
function handlers.ObjectSavedWithData(player, oldGuid, newObjectData)
    print(string.format("[ObjectEditor] GameObject saved - Old GUID: %d, New GUID: %d", 
        oldGuid, newObjectData.guid))
    
    -- Update current object if this was the one being edited
    if ObjectEditor.currentObject and ObjectEditor.currentObject.guid == oldGuid then
        -- Update all data with new values
        ObjectEditor.currentObject = newObjectData
        
        -- Update original state GUID if needed
        if ObjectEditor.originalState then
            ObjectEditor.originalState.guid = newObjectData.guid
        end
        
        print(string.format("[ObjectEditor] Updated to saved GUID: %d", newObjectData.guid))
    end
    
    -- Show success message
    if CreateStyledToast then
        CreateStyledToast("GameObject saved to database!", 2, 0.5)
    end
end

-- Handler: GameObject respawned with new GUID
function handlers.ObjectRespawned(player, oldGuid, newObjectData)
    print(string.format("[ObjectEditor] GameObject respawned - Old GUID: %d, New GUID: %d", 
        oldGuid, newObjectData.guid))
    
    -- Update current object if this was the one being edited
    if ObjectEditor.currentObject and ObjectEditor.currentObject.guid == oldGuid then
        -- Update all data with new values
        ObjectEditor.currentObject = newObjectData
        
        -- Update original state GUID if needed
        if ObjectEditor.originalState then
            ObjectEditor.originalState.guid = newObjectData.guid
        end
        
        -- Update UI to reflect new position/rotation/scale
        if not ObjectEditor.isEditing then
            ObjectEditor.isUpdating = true
            
            -- Update position displays
            if ObjectEditor.positionSliders then
                -- Update X
                if ObjectEditor.positionSliders.x.label then
                    ObjectEditor.positionSliders.x.label:SetText(string.format("X: %.1f", newObjectData.x))
                end
                ObjectEditor.positionSliders.x.slider:SetValue(0)
                ObjectEditor.positionSliders.x.offsetText:SetText("+0.0")
                
                -- Update Y
                if ObjectEditor.positionSliders.y.label then
                    ObjectEditor.positionSliders.y.label:SetText(string.format("Y: %.1f", newObjectData.y))
                end
                ObjectEditor.positionSliders.y.slider:SetValue(0)
                ObjectEditor.positionSliders.y.offsetText:SetText("+0.0")
                
                -- Update Z
                if ObjectEditor.positionSliders.z.label then
                    ObjectEditor.positionSliders.z.label:SetText(string.format("Z: %.1f", newObjectData.z))
                end
                ObjectEditor.positionSliders.z.slider:SetValue(0)
                ObjectEditor.positionSliders.z.offsetText:SetText("+0.0")
            end
            
            -- Update rotation display
            if ObjectEditor.rotationSlider then
                local degrees = math.deg(newObjectData.o)
                ObjectEditor.rotationSlider:SetValue(degrees)
                if ObjectEditor.rotationValueText then
                    ObjectEditor.rotationValueText:SetText(string.format("%d deg", degrees))
                end
            end
            
            -- Update scale display
            if ObjectEditor.scaleSlider then
                ObjectEditor.scaleSlider:SetValue(newObjectData.scale)
                if ObjectEditor.scaleValueText then
                    ObjectEditor.scaleValueText:SetText(string.format("%.2fx", newObjectData.scale))
                end
            end
            
            ObjectEditor.isUpdating = false
        end
        
        print(string.format("[ObjectEditor] Updated to new GUID: %d", newObjectData.guid))
    end
end

-- Handler: Creature respawned with new GUID
function handlers.CreatureRespawned(player, oldGuid, newCreatureData)
    print(string.format("[ObjectEditor] Creature respawned - Old GUID: %d, New GUID: %d", 
        oldGuid, newCreatureData.guid))
    
    -- Update current object if this was the one being edited
    if ObjectEditor.currentObject and ObjectEditor.currentObject.guid == oldGuid then
        -- Update all data with new values
        ObjectEditor.currentObject = newCreatureData
        
        -- Update original state GUID if needed
        if ObjectEditor.originalState then
            ObjectEditor.originalState.guid = newCreatureData.guid
        end
        
        -- Update UI to reflect new position/rotation/scale
        if not ObjectEditor.isEditing then
            ObjectEditor.isUpdating = true
            
            -- Update position displays
            if ObjectEditor.positionSliders then
                -- Update X
                if ObjectEditor.positionSliders.x.label then
                    ObjectEditor.positionSliders.x.label:SetText(string.format("X: %.1f", newCreatureData.x))
                end
                ObjectEditor.positionSliders.x.slider:SetValue(0)
                ObjectEditor.positionSliders.x.offsetText:SetText("+0.0")
                
                -- Update Y
                if ObjectEditor.positionSliders.y.label then
                    ObjectEditor.positionSliders.y.label:SetText(string.format("Y: %.1f", newCreatureData.y))
                end
                ObjectEditor.positionSliders.y.slider:SetValue(0)
                ObjectEditor.positionSliders.y.offsetText:SetText("+0.0")
                
                -- Update Z
                if ObjectEditor.positionSliders.z.label then
                    ObjectEditor.positionSliders.z.label:SetText(string.format("Z: %.1f", newCreatureData.z))
                end
                ObjectEditor.positionSliders.z.slider:SetValue(0)
                ObjectEditor.positionSliders.z.offsetText:SetText("+0.0")
            end
            
            -- Update rotation display
            if ObjectEditor.rotationSlider then
                local degrees = math.deg(newCreatureData.o)
                ObjectEditor.rotationSlider:SetValue(degrees)
                if ObjectEditor.rotationValueText then
                    ObjectEditor.rotationValueText:SetText(string.format("%d deg", degrees))
                end
            end
            
            -- Update scale display
            if ObjectEditor.scaleSlider then
                ObjectEditor.scaleSlider:SetValue(newCreatureData.scale)
                if ObjectEditor.scaleValueText then
                    ObjectEditor.scaleValueText:SetText(string.format("%.2fx", newCreatureData.scale))
                end
            end
            
            ObjectEditor.isUpdating = false
        end
        
        print(string.format("[ObjectEditor] Creature updated to new GUID: %d", newCreatureData.guid))
    end
    
    if CreateStyledToast then
        CreateStyledToast("Creature position updated", 2, 0.5)
    end
end

-- Handler: Creature duplicated
function handlers.CreatureDuplicated(player, originalGuid, newCreatureData)
    if not newCreatureData then
        if CreateStyledToast then
            CreateStyledToast("Failed to duplicate creature!", 2, 0.5)
        end
        return
    end
    
    if CreateStyledToast then
        CreateStyledToast("Original saved & duplicate created!", 2, 0.5)
    end
    
    -- Close any existing editor first
    if ObjectEditor.dialog and ObjectEditor.dialog:IsShown() then
        -- Don't restore original state since we just saved
        ObjectEditor.currentObject = nil
        ObjectEditor.originalState = nil
        ObjectEditor.pendingUpdates = {}
    end
    
    -- Open editor for the new duplicated creature
    ObjectEditor.OpenEditor(newCreatureData)
end

-- Handler: Creature saved to database with new data
function handlers.CreatureSavedWithData(player, oldGuid, newCreatureData)
    print(string.format("[ObjectEditor] Creature saved to database - Old GUID: %d, New GUID: %d", 
        oldGuid, newCreatureData.guid))
    
    -- Update current object if this was the one being edited
    if ObjectEditor.currentObject and ObjectEditor.currentObject.guid == oldGuid then
        -- Update all data with new values
        ObjectEditor.currentObject = newCreatureData
        
        -- Update original state GUID if needed
        if ObjectEditor.originalState then
            ObjectEditor.originalState.guid = newCreatureData.guid
        end
        
        print(string.format("[ObjectEditor] Creature saved with new GUID: %d", newCreatureData.guid))
    end
end

-- Initialize auto-refresh timer for nearby objects
local function InitializeNearbyObjectsTimer()
    if not ObjectEditor.nearbyUpdateFrame then
        ObjectEditor.nearbyUpdateFrame = CreateFrame("Frame")
        ObjectEditor.nearbyUpdateInterval = 5 -- Update every 5 seconds
        ObjectEditor.nearbyUpdateElapsed = 0
        
        ObjectEditor.nearbyUpdateFrame:SetScript("OnUpdate", function(self, elapsed)
            -- Only update if a menu is visible
            if not DropDownList1:IsVisible() then
                ObjectEditor.nearbyUpdateElapsed = 0
                return
            end
            
            ObjectEditor.nearbyUpdateElapsed = ObjectEditor.nearbyUpdateElapsed + elapsed
            
            if ObjectEditor.nearbyUpdateElapsed >= ObjectEditor.nearbyUpdateInterval then
                ObjectEditor.nearbyUpdateElapsed = 0
                
                -- Check if we're looking at the nearby objects menu
                if _G.EntityMenus and _G.EntityMenus.nearbyObjectsMenu then
                    -- Request update
                    AIO.Handle("GameMasterSystem", "getNearbyGameObjects", 30)
                end
            end
        end)
    end
end

-- Register separate handler for EntitySelectionDialog
local entityHandlers = AIO.AddHandlers("EntitySelectionDialog", {})

function entityHandlers.ReceiveEntities(player, entities)
    print(string.format("[ObjectEditorHandlers] Received entities handler called with %d entities", entities and #entities or 0))
    if _G.EntitySelectionDialog and _G.EntitySelectionDialog.ReceiveEntities then
        _G.EntitySelectionDialog.ReceiveEntities(entities)
    else
        print("[ObjectEditorHandlers] EntitySelectionDialog not found or ReceiveEntities not available")
    end
end

-- Initialize on load
InitializeNearbyObjectsTimer()

-- Initialize
-- print("[ObjectEditor] Client handlers loaded")