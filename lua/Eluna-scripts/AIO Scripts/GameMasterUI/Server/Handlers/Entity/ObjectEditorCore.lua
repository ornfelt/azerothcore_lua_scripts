--[[
    GameMasterUI Object Editor Core Module

    This module acts as the central coordinator for all Object Editor operations:
    - Initializes and imports all Object Editor handler modules
    - Registers handlers with the GameMaster system
    - Provides unified interface for object editing operations

    Coordinates the following modules:
    - ObjectEditorUtils.lua (254 lines) - Shared utilities and validation
    - GameObjectEditorHandlers.lua (559 lines) - GameObject operations
    - CreatureEditorHandlers.lua (620 lines) - Creature operations
    - EntityEditorHandlers.lua (234 lines) - Combined entity operations

    Extracted from GameMasterUI_ObjectEditorHandlers.lua (1,751 lines) to complete
    the modularization and maintain single responsibility principle.
]]--

local ObjectEditorCore = {}

-- Import all Object Editor handler modules
local ObjectEditorUtils = require("Server.Handlers.Entity.ObjectEditorUtils")
local GameObjectEditorHandlers = require("Server.Handlers.Entity.GameObjectEditorHandlers")
local CreatureEditorHandlers = require("Server.Handlers.Entity.CreatureEditorHandlers")
local EntityEditorHandlers = require("Server.Handlers.Entity.EntityEditorHandlers")

-- Module references (will be injected)
local Config, Utils, Database, DatabaseHelper
local GameMasterSystem

-- =====================================================
-- Module Initialization
-- =====================================================

function ObjectEditorCore.Initialize(gmSystem, config, utils, database, databaseHelper)
    -- Store references
    GameMasterSystem = gmSystem
    Config = config
    Utils = utils
    Database = database
    DatabaseHelper = databaseHelper

    -- Initialize all sub-modules with shared dependencies
    ObjectEditorUtils.Initialize(config, utils, database, databaseHelper)
    GameObjectEditorHandlers.Initialize(config, utils, database, databaseHelper, ObjectEditorUtils)
    CreatureEditorHandlers.Initialize(config, utils, database, databaseHelper, ObjectEditorUtils)
    EntityEditorHandlers.Initialize(config, utils, database, databaseHelper, ObjectEditorUtils, GameObjectEditorHandlers, CreatureEditorHandlers)

    -- Update configuration
    ObjectEditorUtils.UpdateDebugMode(Config.debug or false)

    if Config.debug then
        print("[ObjectEditorCore] Initialized all Object Editor handler modules successfully")
    end
end

-- =====================================================
-- Handler Registration
-- =====================================================

function ObjectEditorCore.RegisterHandlers(gmSystem, config, utils, database, databaseHelper)
    -- Initialize all modules first
    ObjectEditorCore.Initialize(gmSystem, config, utils, database, databaseHelper)

    -- =====================================================
    -- Register GameObject Editing Handlers
    -- =====================================================

    GameMasterSystem.getGameObjectForEdit = function(player, guid)
        GameObjectEditorHandlers.getGameObjectData(player, guid)
    end

    GameMasterSystem.getSelectedGameObject = function(player)
        GameObjectEditorHandlers.getSelectedGameObject(player)
    end

    GameMasterSystem.updateGameObject = function(player, guid, updates)
        GameObjectEditorHandlers.updateGameObject(player, guid, updates)
    end

    GameMasterSystem.copyPlayerPositionToObject = function(player, guid)
        GameObjectEditorHandlers.copyPlayerPositionToObject(player, guid)
    end

    GameMasterSystem.faceObjectToPlayer = function(player, guid)
        GameObjectEditorHandlers.faceObjectToPlayer(player, guid)
    end

    GameMasterSystem.resetGameObject = function(player, guid, originalState)
        GameObjectEditorHandlers.resetGameObject(player, guid, originalState)
    end

    GameMasterSystem.saveGameObjectToDB = function(player, guid)
        GameObjectEditorHandlers.saveGameObjectToDB(player, guid)
    end

    GameMasterSystem.duplicateGameObjectAtPosition = function(player, entry, x, y, z, o, scale)
        GameObjectEditorHandlers.duplicateGameObjectAtPosition(player, entry, x, y, z, o, scale)
    end

    GameMasterSystem.getNearbyGameObjects = function(player, range)
        local objects = GameObjectEditorHandlers.getNearbyGameObjects(player, range)
        -- Send to client
        AIO.Handle(player, "ObjectEditor", "ReceiveNearbyObjects", objects)
    end

    -- =====================================================
    -- Register Creature Editing Handlers
    -- =====================================================

    GameMasterSystem.getCreatureForEdit = function(player, guid)
        CreatureEditorHandlers.getCreatureData(player, guid)
    end

    GameMasterSystem.getSelectedCreature = function(player)
        CreatureEditorHandlers.getSelectedCreature(player)
    end

    GameMasterSystem.updateCreature = function(player, guid, updates)
        CreatureEditorHandlers.updateCreature(player, guid, updates)
    end

    GameMasterSystem.copyPlayerPositionToCreature = function(player, guid)
        CreatureEditorHandlers.copyPlayerPositionToCreature(player, guid)
    end

    GameMasterSystem.faceCreatureToPlayer = function(player, guid)
        CreatureEditorHandlers.faceCreatureToPlayer(player, guid)
    end

    GameMasterSystem.resetCreature = function(player, guid, originalState)
        CreatureEditorHandlers.resetCreature(player, guid, originalState)
    end

    GameMasterSystem.saveCreatureToDB = function(player, guid)
        CreatureEditorHandlers.saveCreatureToDB(player, guid)
    end

    GameMasterSystem.duplicateAndSaveCreature = function(player, guid)
        CreatureEditorHandlers.duplicateAndSaveCreature(player, guid)
    end

    GameMasterSystem.duplicateCreatureAtPosition = function(player, entry, x, y, z, o, scale)
        CreatureEditorHandlers.duplicateCreatureAtPosition(player, entry, x, y, z, o, scale)
    end

    GameMasterSystem.getNearbyCreatures = function(player, range)
        local creatures = CreatureEditorHandlers.getNearbyCreatures(player, range)
        -- Send to client
        AIO.Handle(player, "ObjectEditor", "ReceiveNearbyCreatures", creatures)
    end

    -- =====================================================
    -- Register Combined Entity Handlers
    -- =====================================================

    GameMasterSystem.getNearbyEntities = function(player, range)
        print(string.format("[ObjectEditor] getNearbyEntities called with range: %d", range or 30))
        local entities = EntityEditorHandlers.getNearbyEntities(player, range)
        print(string.format("[ObjectEditor] Found %d entities, sending to client", #entities))
        -- Send to client
        AIO.Handle(player, "EntitySelectionDialog", "ReceiveEntities", entities)
    end

    -- =====================================================
    -- Register Entity Deletion Handlers
    -- =====================================================

    GameMasterSystem.deleteGameObjectFromWorld = function(player, guid)
        local gob = ObjectEditorUtils.GetGameObjectByGuid(player, guid)
        if gob then
            -- Get the database GUID before despawning
            local dbGuid = gob:GetDBTableGUIDLow()

            -- Remove from database first if it's a saved spawn
            if dbGuid and dbGuid > 0 then
                WorldDBExecute("DELETE FROM gameobject WHERE guid = " .. dbGuid)
                if ObjectEditorUtils.IsDebugEnabled() then
                    print(string.format("[ObjectEditor] Deleted GameObject from database (DB GUID: %d)", dbGuid))
                end
            end

            -- Permanently remove the object from world
            -- Use RemoveFromWorld(true) to permanently delete, then Delete() to clean up
            gob:RemoveFromWorld(true)
            gob:Delete()

            if ObjectEditorUtils.IsDebugEnabled() then
                print(string.format("[ObjectEditor] GameObject removed from world (World GUID: %s)", tostring(guid)))
            end

            AIO.Handle(player, "GameMasterSystem", "EntityDeleted", "GameObject", guid)
        else
            if ObjectEditorUtils.IsDebugEnabled() then
                print(string.format("[ObjectEditor] GameObject not found for deletion (GUID: %s)", tostring(guid)))
            end
        end
    end

    GameMasterSystem.deleteCreatureFromWorld = function(player, guid)
        local creature = ObjectEditorUtils.GetCreatureByGuid(player, guid)
        if creature then
            -- Get the database GUID before despawning
            local dbGuid = creature:GetDBTableGUIDLow()

            -- Remove from database first if it's a saved spawn
            if dbGuid and dbGuid > 0 then
                WorldDBExecute("DELETE FROM creature WHERE guid = " .. dbGuid)
                if ObjectEditorUtils.IsDebugEnabled() then
                    print(string.format("[ObjectEditor] Deleted Creature from database (DB GUID: %d)", dbGuid))
                end
            end

            -- Permanently remove the creature from world
            -- Use RemoveFromWorld(true) to permanently delete
            creature:RemoveFromWorld(true)

            if ObjectEditorUtils.IsDebugEnabled() then
                print(string.format("[ObjectEditor] Creature removed from world (World GUID: %s)", tostring(guid)))
            end

            AIO.Handle(player, "GameMasterSystem", "EntityDeleted", "Creature", guid)
        else
            if ObjectEditorUtils.IsDebugEnabled() then
                print(string.format("[ObjectEditor] Creature not found for deletion (GUID: %s)", tostring(guid)))
            end
        end
    end

    -- =====================================================
    -- Register Utility Handlers
    -- =====================================================

    -- Teleport player away from entity (useful when stuck inside)
    GameMasterSystem.teleportAwayFromEntity = function(player, entityX, entityY, entityZ, entityScale)
        -- Calculate safe distance based on entity scale
        -- Base distance: 5 yards + (scale * 3) to account for larger entities
        local baseDistance = 5
        local scaledDistance = entityScale * 3
        local safeDistance = baseDistance + scaledDistance

        -- Get player's current position and facing
        local playerX, playerY, playerZ = player:GetX(), player:GetY(), player:GetZ()
        local playerO = player:GetO()

        -- Calculate direction vector from entity to player
        local dx = playerX - entityX
        local dy = playerY - entityY
        local distance = math.sqrt(dx * dx + dy * dy)

        -- Teleport position
        local newX, newY, newZ

        if distance > 0.1 then
            -- Player is not directly on top of entity - teleport away in current direction
            local dirX = dx / distance
            local dirY = dy / distance
            newX = entityX + (dirX * safeDistance)
            newY = entityY + (dirY * safeDistance)
        else
            -- Player is directly on top of entity - teleport backwards from player's facing
            newX = playerX - math.cos(playerO) * safeDistance
            newY = playerY - math.sin(playerO) * safeDistance
        end

        -- Use entity Z + 2 yards to ensure player is above ground
        newZ = entityZ + 2

        -- Teleport player
        player:Teleport(player:GetMapId(), newX, newY, newZ, playerO)

        if ObjectEditorUtils.IsDebugEnabled() then
            print(string.format("[ObjectEditor] Teleported player away from entity. Distance: %.1f yards", safeDistance))
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
            GameObjectEditorHandlers.updateGameObject(player, guid, updates)
        elseif entityType == "Creature" then
            CreatureEditorHandlers.updateCreature(player, guid, updates)
        end
    end

    if ObjectEditorUtils.IsDebugEnabled() then
        print("[ObjectEditorCore] Successfully registered all Object Editor handlers (GameObject, Creature & Entity)")
    end
end

-- =====================================================
-- Public Interface
-- =====================================================

-- Expose sub-modules for direct access if needed
ObjectEditorCore.Utils = ObjectEditorUtils
ObjectEditorCore.GameObjectHandlers = GameObjectEditorHandlers
ObjectEditorCore.CreatureHandlers = CreatureEditorHandlers
ObjectEditorCore.EntityHandlers = EntityEditorHandlers

-- =====================================================
-- Module Statistics
-- =====================================================

function ObjectEditorCore.GetModuleStats()
    return {
        modules = {
            "ObjectEditorUtils.lua (254 lines) - Shared utilities and validation",
            "GameObjectEditorHandlers.lua (559 lines) - GameObject operations",
            "CreatureEditorHandlers.lua (620 lines) - Creature operations",
            "EntityEditorHandlers.lua (234 lines) - Combined entity operations",
            "ObjectEditorCore.lua (~200 lines) - Module coordination"
        },
        totalExtracted = 1667, -- Lines extracted from original 1,751-line file
        reductionPercentage = 95, -- ~95% of the original file has been modularized
        originalFileSize = "1,751 lines (65KB)",
        newModularSize = "5 focused modules with clear responsibilities"
    }
end

-- =====================================================
-- Advanced Search Interface
-- =====================================================

-- Provide access to advanced search functions
function ObjectEditorCore.SearchEntitiesByName(player, namePattern, range)
    return EntityEditorHandlers.searchEntitiesByName(player, namePattern, range)
end

function ObjectEditorCore.FindClosestEntity(player, entityType, range)
    return EntityEditorHandlers.findClosestEntity(player, entityType, range)
end

function ObjectEditorCore.GetEntityStatistics(entities)
    return EntityEditorHandlers.getEntityStatistics(entities)
end

return ObjectEditorCore