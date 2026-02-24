--[[
    GameMasterUI Template Core Module

    This module acts as the central coordinator for all template operations:
    - Initializes and imports all template handler modules
    - Registers handlers with the GameMaster system
    - Provides unified interface for template operations

    Coordinates the following modules:
    - TemplateValidation.lua (354 lines) - Field validation logic
    - CreatureTemplateHandlers.lua (451 lines) - Creature template operations
    - GameObjectTemplateHandlers.lua (438 lines) - GameObject template operations
    - ItemTemplateHandlers.lua (574 lines) - Item template operations

    Extracted from GameMasterUI_TemplateHandlers.lua (2,393 lines) to complete
    the modularization and maintain single responsibility principle.
]]--

local TemplateCore = {}

-- Import all template handler modules
local TemplateValidation = require("Server.Handlers.Template.TemplateValidation")
local CreatureTemplateHandlers = require("Server.Handlers.Template.CreatureTemplateHandlers")
local GameObjectTemplateHandlers = require("Server.Handlers.Template.GameObjectTemplateHandlers")
local ItemTemplateHandlers = require("Server.Handlers.Template.ItemTemplateHandlers")

-- Module references (will be injected)
local Config, Utils, Database, DatabaseHelper
local GameMasterSystem

-- =====================================================
-- Module Initialization
-- =====================================================

function TemplateCore.Initialize(gmSystem, config, utils, database, databaseHelper)
    -- Store references
    GameMasterSystem = gmSystem
    Config = config
    Utils = utils
    Database = database
    DatabaseHelper = databaseHelper

    -- Initialize all sub-modules with shared dependencies
    TemplateValidation.Initialize(config, utils, databaseHelper)
    CreatureTemplateHandlers.Initialize(config, utils, databaseHelper, TemplateValidation)
    GameObjectTemplateHandlers.Initialize(config, utils, databaseHelper, TemplateValidation)
    ItemTemplateHandlers.Initialize(config, utils, databaseHelper, TemplateValidation)

    if Config.debug then
        print("[TemplateCore] Initialized all template handler modules successfully")
    end
end

-- =====================================================
-- Handler Registration
-- =====================================================

function TemplateCore.RegisterHandlers(gmSystem, config, utils, database, databaseHelper)
    -- Initialize all modules first
    TemplateCore.Initialize(gmSystem, config, utils, database, databaseHelper)

    -- =====================================================
    -- Register Creature Template Handlers
    -- =====================================================

    GameMasterSystem.getCreatureTemplateData = function(player, entry)
        CreatureTemplateHandlers.getCreatureTemplateData(player, entry)
    end

    GameMasterSystem.updateCreatureTemplate = function(player, data)
        CreatureTemplateHandlers.updateCreatureTemplate(player, data)
    end

    GameMasterSystem.duplicateCreatureWithTemplate = function(player, data)
        CreatureTemplateHandlers.duplicateCreatureWithTemplate(player, data)
    end

    GameMasterSystem.getNextAvailableEntry = function(player)
        CreatureTemplateHandlers.getNextAvailableEntry(player)
    end

    GameMasterSystem.createBlankCreatureTemplate = function(player)
        CreatureTemplateHandlers.createBlankCreatureTemplate(player)
    end

    -- =====================================================
    -- Register GameObject Template Handlers
    -- =====================================================

    GameMasterSystem.getGameObjectTemplateData = function(player, entry)
        GameObjectTemplateHandlers.getGameObjectTemplateData(player, entry)
    end

    GameMasterSystem.updateGameObjectTemplate = function(player, data)
        GameObjectTemplateHandlers.updateGameObjectTemplate(player, data)
    end

    GameMasterSystem.duplicateGameObjectWithTemplate = function(player, data)
        GameObjectTemplateHandlers.duplicateGameObjectWithTemplate(player, data)
    end

    GameMasterSystem.getNextAvailableGameObjectEntry = function(player)
        GameObjectTemplateHandlers.getNextAvailableGameObjectEntry(player)
    end

    GameMasterSystem.createBlankGameObjectTemplate = function(player)
        GameObjectTemplateHandlers.createBlankGameObjectTemplate(player)
    end

    -- =====================================================
    -- Register Item Template Handlers
    -- =====================================================

    GameMasterSystem.getItemTemplateData = function(player, entry)
        ItemTemplateHandlers.getItemTemplateData(player, entry)
    end

    GameMasterSystem.saveItemTemplate = function(player, requestData)
        ItemTemplateHandlers.saveItemTemplate(player, requestData)
    end

    GameMasterSystem.duplicateItemWithTemplate = function(player, requestData)
        -- For duplicates, mark as duplicate and call saveItemTemplate
        if type(requestData) == "table" then
            requestData.isDuplicate = true
        end
        ItemTemplateHandlers.saveItemTemplate(player, requestData)
    end

    GameMasterSystem.deleteItemTemplate = function(player, entry)
        ItemTemplateHandlers.deleteItemTemplate(player, entry)
    end

    GameMasterSystem.createBlankItemTemplate = function(player)
        ItemTemplateHandlers.createBlankItemTemplate(player)
    end

    GameMasterSystem.getNextAvailableItemEntry = function(player)
        ItemTemplateHandlers.getNextAvailableItemEntry(player)
    end

    if Config.debug then
        print("[TemplateCore] Successfully registered all template handlers (Creature, GameObject & Item)")
    end
end

-- =====================================================
-- Public Interface
-- =====================================================

-- Expose sub-modules for direct access if needed
TemplateCore.Validation = TemplateValidation
TemplateCore.CreatureHandlers = CreatureTemplateHandlers
TemplateCore.GameObjectHandlers = GameObjectTemplateHandlers
TemplateCore.ItemHandlers = ItemTemplateHandlers

-- =====================================================
-- Module Statistics
-- =====================================================

function TemplateCore.GetModuleStats()
    return {
        modules = {
            "TemplateValidation.lua (354 lines) - Field validation logic",
            "CreatureTemplateHandlers.lua (451 lines) - Creature template operations",
            "GameObjectTemplateHandlers.lua (438 lines) - GameObject template operations",
            "ItemTemplateHandlers.lua (574 lines) - Item template operations",
            "TemplateCore.lua (~150 lines) - Module coordination"
        },
        totalExtracted = 1817, -- Lines extracted from original 2,393-line file
        reductionPercentage = 76, -- ~76% of the original file has been modularized
        originalFileSize = "2,393 lines (97KB)",
        newModularSize = "5 focused modules with clear responsibilities"
    }
end

return TemplateCore