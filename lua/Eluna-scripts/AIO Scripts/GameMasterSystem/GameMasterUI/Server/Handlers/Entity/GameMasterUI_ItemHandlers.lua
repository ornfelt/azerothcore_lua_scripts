--[[
    GameMaster UI - Item Handlers Coordinator Module
    
    This module coordinates all item-related functionality by loading and managing sub-modules.
    Original file (1,981 lines) has been split into 6 focused modules.
]]--

local ItemHandlers = {}
local subModules = {}

-- Module dependencies (will be injected)
local GameMasterSystem, Config, Utils, Database, DatabaseHelper
local PlayerHandlers = nil  -- Will be set after all modules are loaded

function ItemHandlers.RegisterHandlers(gms, config, utils, database, dbHelper)
    GameMasterSystem = gms
    Config = config
    Utils = utils
    Database = database
    DatabaseHelper = dbHelper
    
    -- Set up package path for sub-modules
    local scriptPath = debug.getinfo(1, "S").source:sub(2)
    local scriptDir = scriptPath:match("(.*/)")  or ""
    package.path = package.path .. ";" .. scriptDir .. "Item/?.lua"
    
    -- Load sub-modules
    local ItemUtilities = require("ItemUtilities")
    local ItemDataHandlers = require("ItemDataHandlers")
    local ItemManagementHandlers = require("ItemManagementHandlers")
    local ItemEnchantmentHandlers = require("ItemEnchantmentHandlers")
    local ItemInventoryHandlers = require("ItemInventoryHandlers")
    local ItemSearchHandlers = require("ItemSearchHandlers")
    
    -- Store references
    subModules.utilities = ItemUtilities
    subModules.data = ItemDataHandlers
    subModules.management = ItemManagementHandlers
    subModules.enchantment = ItemEnchantmentHandlers
    subModules.inventory = ItemInventoryHandlers
    subModules.search = ItemSearchHandlers
    
    -- Initialize utilities
    ItemUtilities.Initialize(config)
    
    -- Register all sub-module handlers
    ItemDataHandlers.RegisterHandlers(gms, config, utils, database, dbHelper)
    ItemManagementHandlers.RegisterHandlers(gms, config, utils, database, dbHelper)
    ItemEnchantmentHandlers.RegisterHandlers(gms, config, utils, database, dbHelper)
    ItemInventoryHandlers.RegisterHandlers(gms, config, utils, database, dbHelper)
    ItemSearchHandlers.RegisterHandlers(gms, config, utils, database, dbHelper)
    
    -- Set up cross-references between modules
    ItemEnchantmentHandlers.SetItemUtilities(ItemUtilities)
    ItemSearchHandlers.SetItemDataHandlers(ItemDataHandlers)
    
    print("[ItemHandlers] All sub-modules loaded and registered successfully")
end

-- Set PlayerHandlers reference after all modules are loaded
function ItemHandlers.SetPlayerHandlers(handlers)
    PlayerHandlers = handlers
    
    -- Pass reference to sub-modules that need it
    if subModules.inventory then
        subModules.inventory.SetPlayerHandlers(handlers)
    end
    if subModules.search then
        subModules.search.SetPlayerHandlers(handlers)
    end
end

-- Expose utility functions for other modules if needed
function ItemHandlers.GetUtilities()
    return subModules.utilities
end

return ItemHandlers