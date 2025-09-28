--[[
    GameMaster UI - Player Handlers Coordinator Module
    
    This module coordinates all player management sub-modules:
    - PlayerDataQueryHandlers: Player data queries (online/offline/all)
    - PlayerActionHandlers: Player actions (gold, teleport, kick, summon)
    - PlayerSearchHandlers: Search and refresh operations
    
    File sizes after modularization:
    - This coordinator: ~100 lines
    - Data query handlers: ~400 lines
    - Action handlers: ~230 lines
    - Search handlers: ~180 lines
    
    Other player-related functionality is in separate modules:
    - PlayerSpellHandlers: Spell management
    - PlayerInventoryHandlers: Inventory management
    - PlayerMailHandlers: Mail sending
    - PlayerBuffHandlers: Buff/aura management
    - BanHandlers: Ban system
]]--

local PlayerHandlers = {}

-- Sub-modules storage
local subModules = {}

-- Module dependencies (will be injected)
local GameMasterSystem, Config, Utils, Database, EntityHandlers, DatabaseHelper

-- Sub-module references (will be injected after loading)
local PlayerSpellHandlers, PlayerInventoryHandlers, PlayerMailHandlers, PlayerBuffHandlers

function PlayerHandlers.RegisterHandlers(gms, config, utils, database, entityHandlers, dbHelper)
    GameMasterSystem = gms
    Config = config
    Utils = utils
    Database = database
    EntityHandlers = entityHandlers
    DatabaseHelper = dbHelper
    
    -- Set up package path for sub-modules
    local scriptPath = debug.getinfo(1, "S").source:sub(2)
    local scriptDir = scriptPath:match("(.*/)")  or ""
    package.path = package.path .. ";" .. scriptDir .. "PlayerData/?.lua"
    
    -- Load sub-modules
    local PlayerDataQueryHandlers = require("PlayerDataQueryHandlers")
    local PlayerActionHandlers = require("PlayerActionHandlers")
    local PlayerSearchHandlers = require("PlayerSearchHandlers")
    
    -- Store sub-module references
    subModules.queryHandlers = PlayerDataQueryHandlers
    subModules.actionHandlers = PlayerActionHandlers
    subModules.searchHandlers = PlayerSearchHandlers
    
    -- Set cross-references between sub-modules
    PlayerSearchHandlers.SetQueryHandlers(PlayerDataQueryHandlers)
    
    -- Register all sub-module handlers
    PlayerDataQueryHandlers.RegisterHandlers(gms, config, utils, database, dbHelper)
    PlayerActionHandlers.RegisterHandlers(gms, config, utils, database, dbHelper)
    PlayerSearchHandlers.RegisterHandlers(gms, config, utils, database, dbHelper)
    
    -- Print module loading confirmation
    print("[PlayerHandlers] All player data sub-modules loaded successfully")
    print("[PlayerHandlers] Coordinator module size: ~100 lines")
    print("[PlayerHandlers] Data query handlers: ~400 lines")
    print("[PlayerHandlers] Action handlers: ~230 lines")
    print("[PlayerHandlers] Search handlers: ~180 lines")
end

-- Set sub-module references (called after all modules are loaded)
function PlayerHandlers.SetSubModules(spellHandlers, inventoryHandlers, mailHandlers, buffHandlers)
    PlayerSpellHandlers = spellHandlers
    PlayerInventoryHandlers = inventoryHandlers
    PlayerMailHandlers = mailHandlers
    PlayerBuffHandlers = buffHandlers
end

-- Provide access to sub-modules if needed by other modules
function PlayerHandlers.GetSubModules()
    return subModules
end

return PlayerHandlers