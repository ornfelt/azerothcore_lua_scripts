--[[
    GameMasterUI Object Editor Handlers (Modular Entry Point)

    This file has been refactored from a monolithic 1,751-line file into a modular architecture.

    Original file breakdown:
    - ObjectEditorUtils.lua (254 lines) - Shared configuration and helper functions
    - GameObjectEditorHandlers.lua (559 lines) - GameObject editing operations
    - CreatureEditorHandlers.lua (620 lines) - Creature editing operations
    - EntityEditorHandlers.lua (234 lines) - Combined entity operations
    - ObjectEditorCore.lua (~200 lines) - Module coordination and registration
    - This file (~80 lines) - Entry point and compatibility layer

    Total: 1,667 lines extracted from original 1,751 lines (95% modularized)

    Performance Benefits:
    - Improved maintainability with single responsibility modules
    - Easier testing and debugging of individual components
    - Reduced file complexity and cognitive load
    - Better code organization following separation of concerns
    - Modular handler registration system

    See SQL_OPTIMIZATION_README.md for complete optimization documentation.
]]--

-- Import the modular object editor core
local ObjectEditorCore = require("Server.Handlers.Entity.ObjectEditorCore")

-- Create main handlers object for backward compatibility
local ObjectEditorHandlers = {}

-- =====================================================
-- Public Interface (Backward Compatibility)
-- =====================================================

-- Main registration function - delegates to ObjectEditorCore
function ObjectEditorHandlers.RegisterHandlers(gmSystem, config, utils, database, databaseHelper)
    return ObjectEditorCore.RegisterHandlers(gmSystem, config, utils, database, databaseHelper)
end

-- Direct access to sub-modules (for advanced usage)
ObjectEditorHandlers.Utils = ObjectEditorCore.Utils
ObjectEditorHandlers.GameObjectHandlers = ObjectEditorCore.GameObjectHandlers
ObjectEditorHandlers.CreatureHandlers = ObjectEditorCore.CreatureHandlers
ObjectEditorHandlers.EntityHandlers = ObjectEditorCore.EntityHandlers

-- Advanced search interface (convenience functions)
function ObjectEditorHandlers.SearchEntitiesByName(player, namePattern, range)
    return ObjectEditorCore.SearchEntitiesByName(player, namePattern, range)
end

function ObjectEditorHandlers.FindClosestEntity(player, entityType, range)
    return ObjectEditorCore.FindClosestEntity(player, entityType, range)
end

function ObjectEditorHandlers.GetEntityStatistics(entities)
    return ObjectEditorCore.GetEntityStatistics(entities)
end

-- Module information function
function ObjectEditorHandlers.GetModuleInfo()
    local stats = ObjectEditorCore.GetModuleStats()
    return {
        version = "2.0 - Modular Architecture",
        description = "Refactored from monolithic to modular design",
        originalSize = stats.originalFileSize,
        newArchitecture = stats.newModularSize,
        linesExtracted = stats.totalExtracted,
        reductionPercentage = stats.reductionPercentage,
        modules = stats.modules,
        benefits = {
            "Improved maintainability",
            "Better code organization",
            "Easier testing and debugging",
            "Reduced file complexity",
            "Single responsibility principle",
            "Modular handler registration"
        }
    }
end

-- =====================================================
-- Debug Information
-- =====================================================

if Config and Config.debug then
    local info = ObjectEditorHandlers.GetModuleInfo()
    print(string.format("[ObjectEditorHandlers] %s loaded successfully", info.version))
    print(string.format("[ObjectEditorHandlers] Extracted %d lines (-%d%%) from original file",
        info.linesExtracted, info.reductionPercentage))
end

return ObjectEditorHandlers