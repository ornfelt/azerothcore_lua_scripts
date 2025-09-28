--[[
    GameMaster UI - Player Inventory Handlers Coordinator Module
    
    This module coordinates all player inventory management sub-modules:
    - PlayerInventoryDataHandlers: Query and bag mapping logic
    - PlayerInventoryEquipHandlers: Equip/unequip operations
    - PlayerInventoryRefreshHandlers: Refresh and save operations
    
    File sizes after modularization:
    - This coordinator: ~60 lines
    - Data handlers: ~450 lines
    - Equip handlers: ~150 lines
    - Refresh handlers: ~100 lines
]]--

local PlayerInventoryHandlers = {}

-- Sub-modules storage
local subModules = {}

-- Module dependencies (will be injected)
local GameMasterSystem, Config, Utils, Database, DatabaseHelper, PlayerHandlers

function PlayerInventoryHandlers.RegisterHandlers(gms, config, utils, database, dbHelper, playerHandlers)
    GameMasterSystem = gms
    Config = config
    Utils = utils
    Database = database
    DatabaseHelper = dbHelper
    PlayerHandlers = playerHandlers
    
    -- Set up package path for sub-modules
    local scriptPath = debug.getinfo(1, "S").source:sub(2)
    local scriptDir = scriptPath:match("(.*/)")  or ""
    package.path = package.path .. ";" .. scriptDir .. "Inventory/?.lua"
    
    -- Load sub-modules
    local PlayerInventoryDataHandlers = require("PlayerInventoryDataHandlers")
    local PlayerInventoryEquipHandlers = require("PlayerInventoryEquipHandlers")
    local PlayerInventoryRefreshHandlers = require("PlayerInventoryRefreshHandlers")
    
    -- Store sub-module references
    subModules.dataHandlers = PlayerInventoryDataHandlers
    subModules.equipHandlers = PlayerInventoryEquipHandlers
    subModules.refreshHandlers = PlayerInventoryRefreshHandlers
    
    -- Register all sub-module handlers
    PlayerInventoryDataHandlers.RegisterHandlers(gms, config, utils, database, dbHelper)
    PlayerInventoryEquipHandlers.RegisterHandlers(gms, config, utils, database, dbHelper)
    PlayerInventoryRefreshHandlers.RegisterHandlers(gms, config, utils, database, dbHelper)
    
    -- Print module loading confirmation
    print("[PlayerInventoryHandlers] All inventory sub-modules loaded successfully")
    print("[PlayerInventoryHandlers] Coordinator module size: ~60 lines")
    print("[PlayerInventoryHandlers] Data handlers: ~450 lines")
    print("[PlayerInventoryHandlers] Equip handlers: ~150 lines")
    print("[PlayerInventoryHandlers] Refresh handlers: ~100 lines")
end

-- Provide access to sub-modules if needed by other modules
function PlayerInventoryHandlers.GetSubModules()
    return subModules
end

return PlayerInventoryHandlers