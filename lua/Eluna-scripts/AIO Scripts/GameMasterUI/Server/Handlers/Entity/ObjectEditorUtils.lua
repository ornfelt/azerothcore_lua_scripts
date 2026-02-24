--[[
    GameMasterUI Object Editor Utilities Module

    This module contains shared configuration, helper functions, and validation logic
    for the Object Editor system:
    - Configuration constants and bounds
    - GameObject and Creature lookup helpers
    - Entity validation functions
    - World coordinate validation

    Extracted from GameMasterUI_ObjectEditorHandlers.lua (1,751 lines) to improve
    maintainability and support modular architecture.
]]--

local ObjectEditorUtils = {}

-- Module dependencies (will be injected)
local Config, Utils, Database, DatabaseHelper

-- =====================================================
-- Configuration
-- =====================================================

local EDITOR_CONFIG = {
    MAX_EDIT_RANGE = 100, -- Maximum range to edit objects
    MIN_SCALE = 0.1,
    MAX_SCALE = 10.0,
    -- World coordinate bounds for WoW 3.3.5 (covers all continents)
    -- Eastern Kingdoms, Kalimdor, Outland, and Northrend typically range from -17066 to +17066
    -- Using -20000 to +20000 for safety margin
    WORLD_BOUNDS = {
        x = { min = -20000, max = 20000 },
        y = { min = -20000, max = 20000 },
        z = { min = -5000, max = 5000 },  -- From deep underground to sky limit
    },
    DEBUG = true -- Temporarily enable debug for troubleshooting
}

-- =====================================================
-- Module Initialization
-- =====================================================

function ObjectEditorUtils.Initialize(config, utils, database, databaseHelper)
    Config = config
    Utils = utils
    Database = database
    DatabaseHelper = databaseHelper

    -- Update configuration based on main config
    EDITOR_CONFIG.DEBUG = Config.debug or false
end

-- =====================================================
-- Configuration Access
-- =====================================================

function ObjectEditorUtils.GetConfig()
    return EDITOR_CONFIG
end

function ObjectEditorUtils.UpdateDebugMode(debugEnabled)
    EDITOR_CONFIG.DEBUG = debugEnabled
end

-- =====================================================
-- GameObject Helper Functions
-- =====================================================

-- Helper function to get GameObject by GUID
function ObjectEditorUtils.GetGameObjectByGuid(player, guid)
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

-- =====================================================
-- Creature Helper Functions
-- =====================================================

-- Helper function to get Creature by GUID
function ObjectEditorUtils.GetCreatureByGuid(player, guid)
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

-- =====================================================
-- Generic Entity Helper Functions
-- =====================================================

-- Helper function to get any entity (GameObject or Creature) by GUID
function ObjectEditorUtils.GetEntityByGuid(player, guid, entityType)
    if entityType == "GameObject" then
        return ObjectEditorUtils.GetGameObjectByGuid(player, guid)
    elseif entityType == "Creature" then
        return ObjectEditorUtils.GetCreatureByGuid(player, guid)
    end
    return nil
end

-- =====================================================
-- Validation Functions
-- =====================================================

-- Helper function to validate player can edit entity
function ObjectEditorUtils.CanEditEntity(player, entity, entityType)
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
function ObjectEditorUtils.CanEditObject(player, gameObject)
    return ObjectEditorUtils.CanEditEntity(player, gameObject, "GameObject")
end

-- Validate world coordinates
function ObjectEditorUtils.ValidateWorldCoordinates(x, y, z)
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

-- =====================================================
-- Utility Functions
-- =====================================================

-- Get configuration value safely
function ObjectEditorUtils.GetConfigValue(key)
    return EDITOR_CONFIG[key]
end

-- Update configuration value
function ObjectEditorUtils.SetConfigValue(key, value)
    EDITOR_CONFIG[key] = value
end

-- Check if debug mode is enabled
function ObjectEditorUtils.IsDebugEnabled()
    return EDITOR_CONFIG.DEBUG
end

return ObjectEditorUtils