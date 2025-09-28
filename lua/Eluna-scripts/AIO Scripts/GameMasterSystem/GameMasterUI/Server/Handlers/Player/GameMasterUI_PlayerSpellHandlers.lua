--[[
    GameMaster UI - Player Spell Handlers Coordinator Module
    
    This module coordinates all player spell management sub-modules:
    - SpellDataHandlers: Spell data queries and searches (~250 lines)
    - SpellEntityHandlers: Spell operations on targets (~280 lines)
    - PlayerSpellManagementHandlers: Player-specific spell management (~270 lines)
    - PlayerSpellAuraHandlers: Player aura and cooldown operations (~120 lines)
    
    Original file: 969 lines
    After modularization: ~60 lines (coordinator) + 920 lines (sub-modules)
]]--

local PlayerSpellHandlers = {}

-- Sub-modules storage
local subModules = {}

-- Module dependencies (will be injected)
local GameMasterSystem, Config, Utils, Database, DatabaseHelper

function PlayerSpellHandlers.RegisterHandlers(gms, config, utils, database, dbHelper)
    GameMasterSystem = gms
    Config = config
    Utils = utils
    Database = database
    DatabaseHelper = dbHelper
    
    -- Set up package path for sub-modules
    local scriptPath = debug.getinfo(1, "S").source:sub(2)
    local scriptDir = scriptPath:match("(.*/)")  or ""
    package.path = package.path .. ";" .. scriptDir .. "Spells/?.lua"
    
    -- Load sub-modules
    local SpellDataHandlers = require("SpellDataHandlers")
    local SpellEntityHandlers = require("SpellEntityHandlers")
    local PlayerSpellManagementHandlers = require("PlayerSpellManagementHandlers")
    local PlayerSpellAuraHandlers = require("PlayerSpellAuraHandlers")
    
    -- Store sub-module references
    subModules.dataHandlers = SpellDataHandlers
    subModules.entityHandlers = SpellEntityHandlers
    subModules.managementHandlers = PlayerSpellManagementHandlers
    subModules.auraHandlers = PlayerSpellAuraHandlers
    
    -- Register all sub-module handlers
    SpellDataHandlers.RegisterHandlers(gms, config, utils, database, dbHelper)
    SpellEntityHandlers.RegisterHandlers(gms, config, utils, database, dbHelper)
    PlayerSpellManagementHandlers.RegisterHandlers(gms, config, utils, database, dbHelper)
    PlayerSpellAuraHandlers.RegisterHandlers(gms, config, utils, database, dbHelper)
    
    -- Print module loading confirmation
    print("[PlayerSpellHandlers] All spell sub-modules loaded successfully")
    print("[PlayerSpellHandlers] Coordinator module size: ~60 lines")
    print("[PlayerSpellHandlers] Data handlers: ~250 lines")
    print("[PlayerSpellHandlers] Entity handlers: ~280 lines")
    print("[PlayerSpellHandlers] Management handlers: ~270 lines")
    print("[PlayerSpellHandlers] Aura handlers: ~120 lines")
end

-- Provide access to sub-modules if needed by other modules
function PlayerSpellHandlers.GetSubModules()
    return subModules
end

return PlayerSpellHandlers