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

    -- Check state machine availability and use it for coordination
    local StateMachine = _G.GMStateMachine
    if StateMachine then
        if not StateMachine.canOpenModal() then
            print("[ObjectEditor] Cannot open - system busy")
            return
        end
        -- Use state machine for coordinated opening
        if not StateMachine.openObjectEditor(objectData.type or "unknown", objectData.guid) then
            print("[ObjectEditor] State machine transition failed - using fallback")
            ObjectEditor.OpenEditor(objectData)
            return
        end
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
            -- Update based on position mode
            if ObjectEditor.positionMode == "relative" then
                ObjectEditor.positionSliders.x.slider:SetValue(0)
                ObjectEditor.positionSliders.x.offsetText:SetText("+0.0")
            else
                ObjectEditor.positionSliders.x.slider:SetValue(x)
                ObjectEditor.positionSliders.x.offsetText:SetText(string.format("%.1f", x))
            end
            -- Update input box
            if ObjectEditor.positionSliders.x.inputBox then
                ObjectEditor.positionSliders.x.inputBox:SetText(string.format("%.2f", x))
            end

            -- Update Y
            if ObjectEditor.positionSliders.y.label then
                ObjectEditor.positionSliders.y.label:SetText(string.format("Y: %.1f", y))
            end
            -- Update based on position mode
            if ObjectEditor.positionMode == "relative" then
                ObjectEditor.positionSliders.y.slider:SetValue(0)
                ObjectEditor.positionSliders.y.offsetText:SetText("+0.0")
            else
                ObjectEditor.positionSliders.y.slider:SetValue(y)
                ObjectEditor.positionSliders.y.offsetText:SetText(string.format("%.1f", y))
            end
            -- Update input box
            if ObjectEditor.positionSliders.y.inputBox then
                ObjectEditor.positionSliders.y.inputBox:SetText(string.format("%.2f", y))
            end

            -- Update Z
            if ObjectEditor.positionSliders.z.label then
                ObjectEditor.positionSliders.z.label:SetText(string.format("Z: %.1f", z))
            end
            -- Update based on position mode
            if ObjectEditor.positionMode == "relative" then
                ObjectEditor.positionSliders.z.slider:SetValue(0)
                ObjectEditor.positionSliders.z.offsetText:SetText("+0.0")
            else
                ObjectEditor.positionSliders.z.slider:SetValue(z)
                ObjectEditor.positionSliders.z.offsetText:SetText(string.format("%.1f", z))
            end
            -- Update input box
            if ObjectEditor.positionSliders.z.inputBox then
                ObjectEditor.positionSliders.z.inputBox:SetText(string.format("%.2f", z))
            end
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
    -- Received nearby objects from server
    
    -- Update the nearby objects menu
    if _G.EntityMenus and _G.EntityMenus.updateNearbyObjectsMenu then
        -- Updating nearby objects menu
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
    -- Received nearby creatures from server
    
    -- Update the nearby creatures menu
    if _G.EntityMenus and _G.EntityMenus.updateNearbyCreaturesMenu then
        -- Updating nearby creatures menu
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
    -- Received entities from server
    
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
            -- Update based on position mode
            if ObjectEditor.positionMode == "relative" then
                ObjectEditor.positionSliders.x.slider:SetValue(0)
                ObjectEditor.positionSliders.x.offsetText:SetText("+0.0")
            else
                ObjectEditor.positionSliders.x.slider:SetValue(x)
                ObjectEditor.positionSliders.x.offsetText:SetText(string.format("%.1f", x))
            end
            -- Update input box
            if ObjectEditor.positionSliders.x.inputBox then
                ObjectEditor.positionSliders.x.inputBox:SetText(string.format("%.2f", x))
            end

            -- Update Y
            if ObjectEditor.positionSliders.y.label then
                ObjectEditor.positionSliders.y.label:SetText(string.format("Y: %.1f", y))
            end
            -- Update based on position mode
            if ObjectEditor.positionMode == "relative" then
                ObjectEditor.positionSliders.y.slider:SetValue(0)
                ObjectEditor.positionSliders.y.offsetText:SetText("+0.0")
            else
                ObjectEditor.positionSliders.y.slider:SetValue(y)
                ObjectEditor.positionSliders.y.offsetText:SetText(string.format("%.1f", y))
            end
            -- Update input box
            if ObjectEditor.positionSliders.y.inputBox then
                ObjectEditor.positionSliders.y.inputBox:SetText(string.format("%.2f", y))
            end

            -- Update Z
            if ObjectEditor.positionSliders.z.label then
                ObjectEditor.positionSliders.z.label:SetText(string.format("Z: %.1f", z))
            end
            -- Update based on position mode
            if ObjectEditor.positionMode == "relative" then
                ObjectEditor.positionSliders.z.slider:SetValue(0)
                ObjectEditor.positionSliders.z.offsetText:SetText("+0.0")
            else
                ObjectEditor.positionSliders.z.slider:SetValue(z)
                ObjectEditor.positionSliders.z.offsetText:SetText(string.format("%.1f", z))
            end
            -- Update input box
            if ObjectEditor.positionSliders.z.inputBox then
                ObjectEditor.positionSliders.z.inputBox:SetText(string.format("%.2f", z))
            end
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
    -- GameObject saved with new GUID
    
    -- Update current object if this was the one being edited
    if ObjectEditor.currentObject and ObjectEditor.currentObject.guid == oldGuid then
        -- Update all data with new values
        ObjectEditor.currentObject = newObjectData
        
        -- Update original state GUID if needed
        if ObjectEditor.originalState then
            ObjectEditor.originalState.guid = newObjectData.guid
        end
        
        -- Updated to saved GUID
    end
    
    -- Show success message
    if CreateStyledToast then
        CreateStyledToast("GameObject saved to database!", 2, 0.5)
    end
end

-- Handler: GameObject respawned with new GUID
function handlers.ObjectRespawned(player, oldGuid, newObjectData)
    -- GameObject respawned with new GUID
    
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
                -- Update based on position mode
                if ObjectEditor.positionMode == "relative" then
                    ObjectEditor.positionSliders.x.slider:SetValue(0)
                    ObjectEditor.positionSliders.x.offsetText:SetText("+0.0")
                else
                    ObjectEditor.positionSliders.x.slider:SetValue(newObjectData.x)
                    ObjectEditor.positionSliders.x.offsetText:SetText(string.format("%.1f", newObjectData.x))
                end
                -- Update input box
                if ObjectEditor.positionSliders.x.inputBox then
                    ObjectEditor.positionSliders.x.inputBox:SetText(string.format("%.2f", newObjectData.x))
                end

                -- Update Y
                if ObjectEditor.positionSliders.y.label then
                    ObjectEditor.positionSliders.y.label:SetText(string.format("Y: %.1f", newObjectData.y))
                end
                -- Update based on position mode
                if ObjectEditor.positionMode == "relative" then
                    ObjectEditor.positionSliders.y.slider:SetValue(0)
                    ObjectEditor.positionSliders.y.offsetText:SetText("+0.0")
                else
                    ObjectEditor.positionSliders.y.slider:SetValue(newObjectData.y)
                    ObjectEditor.positionSliders.y.offsetText:SetText(string.format("%.1f", newObjectData.y))
                end
                -- Update input box
                if ObjectEditor.positionSliders.y.inputBox then
                    ObjectEditor.positionSliders.y.inputBox:SetText(string.format("%.2f", newObjectData.y))
                end

                -- Update Z
                if ObjectEditor.positionSliders.z.label then
                    ObjectEditor.positionSliders.z.label:SetText(string.format("Z: %.1f", newObjectData.z))
                end
                -- Update based on position mode
                if ObjectEditor.positionMode == "relative" then
                    ObjectEditor.positionSliders.z.slider:SetValue(0)
                    ObjectEditor.positionSliders.z.offsetText:SetText("+0.0")
                else
                    ObjectEditor.positionSliders.z.slider:SetValue(newObjectData.z)
                    ObjectEditor.positionSliders.z.offsetText:SetText(string.format("%.1f", newObjectData.z))
                end
                -- Update input box
                if ObjectEditor.positionSliders.z.inputBox then
                    ObjectEditor.positionSliders.z.inputBox:SetText(string.format("%.2f", newObjectData.z))
                end
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
        
        -- Updated to new GUID
    end
end

-- Handler: Creature respawned with new GUID
function handlers.CreatureRespawned(player, oldGuid, newCreatureData)
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
                -- Update based on position mode
                if ObjectEditor.positionMode == "relative" then
                    ObjectEditor.positionSliders.x.slider:SetValue(0)
                    ObjectEditor.positionSliders.x.offsetText:SetText("+0.0")
                else
                    ObjectEditor.positionSliders.x.slider:SetValue(newCreatureData.x)
                    ObjectEditor.positionSliders.x.offsetText:SetText(string.format("%.1f", newCreatureData.x))
                end
                -- Update input box
                if ObjectEditor.positionSliders.x.inputBox then
                    ObjectEditor.positionSliders.x.inputBox:SetText(string.format("%.2f", newCreatureData.x))
                end

                -- Update Y
                if ObjectEditor.positionSliders.y.label then
                    ObjectEditor.positionSliders.y.label:SetText(string.format("Y: %.1f", newCreatureData.y))
                end
                -- Update based on position mode
                if ObjectEditor.positionMode == "relative" then
                    ObjectEditor.positionSliders.y.slider:SetValue(0)
                    ObjectEditor.positionSliders.y.offsetText:SetText("+0.0")
                else
                    ObjectEditor.positionSliders.y.slider:SetValue(newCreatureData.y)
                    ObjectEditor.positionSliders.y.offsetText:SetText(string.format("%.1f", newCreatureData.y))
                end
                -- Update input box
                if ObjectEditor.positionSliders.y.inputBox then
                    ObjectEditor.positionSliders.y.inputBox:SetText(string.format("%.2f", newCreatureData.y))
                end

                -- Update Z
                if ObjectEditor.positionSliders.z.label then
                    ObjectEditor.positionSliders.z.label:SetText(string.format("Z: %.1f", newCreatureData.z))
                end
                -- Update based on position mode
                if ObjectEditor.positionMode == "relative" then
                    ObjectEditor.positionSliders.z.slider:SetValue(0)
                    ObjectEditor.positionSliders.z.offsetText:SetText("+0.0")
                else
                    ObjectEditor.positionSliders.z.slider:SetValue(newCreatureData.z)
                    ObjectEditor.positionSliders.z.offsetText:SetText(string.format("%.1f", newCreatureData.z))
                end
                -- Update input box
                if ObjectEditor.positionSliders.z.inputBox then
                    ObjectEditor.positionSliders.z.inputBox:SetText(string.format("%.2f", newCreatureData.z))
                end
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
    -- Creature saved to database with new GUID
    
    -- Update current object if this was the one being edited
    if ObjectEditor.currentObject and ObjectEditor.currentObject.guid == oldGuid then
        -- Update all data with new values
        ObjectEditor.currentObject = newCreatureData
        
        -- Update original state GUID if needed
        if ObjectEditor.originalState then
            ObjectEditor.originalState.guid = newCreatureData.guid
        end
        
        -- Creature saved with new GUID
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
    GMUtils.debug("INFO", string.format("[ObjectEditorHandlers] Received entities handler called with %d entities", entities and #entities or 0))
    if _G.EntitySelectionDialog and _G.EntitySelectionDialog.ReceiveEntities then
        _G.EntitySelectionDialog.ReceiveEntities(entities)
    else
        GMUtils.debug("WARNING", "[ObjectEditorHandlers] EntitySelectionDialog not found or ReceiveEntities not available")
    end
end

-- Handler: Entity deleted from world
function handlers.EntityDeleted(player, entityType, guid)
    -- Show feedback
    if CreateStyledToast then
        CreateStyledToast(string.format("%s deleted from world", entityType), 2, 0.5)
    end
    
    -- If the entity selection dialog is open, refresh it
    if EntitySelectionDialog and EntitySelectionDialog.dialog and EntitySelectionDialog.dialog:IsShown() then
        -- Small delay to ensure server has processed the deletion (3.3.5 compatible timer)
        local frame = CreateFrame("Frame")
        local elapsed = 0
        frame:SetScript("OnUpdate", function(self, delta)
            elapsed = elapsed + delta
            if elapsed >= 0.2 then
                self:SetScript("OnUpdate", nil)
                EntitySelectionDialog.RefreshEntities()
            end
        end)
    end
    
    -- If we were editing this entity, close the editor
    if ObjectEditor and ObjectEditor.currentObject and ObjectEditor.currentObject.guid == guid then
        ObjectEditor.CloseEditor()
        if CreateStyledToast then
            CreateStyledToast("Editor closed - entity was deleted", 2, 0.5)
        end
    end
end

-- Initialize on load
InitializeNearbyObjectsTimer()

-- Initialize
-- print("[ObjectEditor] Client handlers loaded")