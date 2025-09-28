--[[
    GameMaster UI - Player Buff/Aura Handlers Coordinator Module
    
    This module coordinates all buff and aura management sub-modules:
    - BuffApplicationHandlers: Applying buffs/auras with durations
    - BuffRemovalHandlers: Removing auras and healing
    - SpellCastingHandlers: Spell casting commands
    
    Original file split into modular components for better maintainability.
]]--

local PlayerBuffHandlers = {}

-- Load sub-modules
local BuffApplicationHandlers = require("GameMasterUI.Server.Handlers.Player.Buffs.BuffApplicationHandlers")
local BuffRemovalHandlers = require("GameMasterUI.Server.Handlers.Player.Buffs.BuffRemovalHandlers")
local SpellCastingHandlers = require("GameMasterUI.Server.Handlers.Player.Buffs.SpellCastingHandlers")

-- Module dependencies (will be injected)
local GameMasterSystem, Config, Utils, Database, DatabaseHelper

function PlayerBuffHandlers.RegisterHandlers(gms, config, utils, database, dbHelper)
    GameMasterSystem = gms
    Config = config
    Utils = utils
    Database = database
    DatabaseHelper = dbHelper
    
    -- Register all sub-modules
    BuffApplicationHandlers.RegisterHandlers(gms, config, utils, database, dbHelper)
    BuffRemovalHandlers.RegisterHandlers(gms, config, utils, database, dbHelper)
    SpellCastingHandlers.RegisterHandlers(gms, config, utils, database, dbHelper)
    
    print("[GameMasterUI] PlayerBuffHandlers: All buff/aura handler sub-modules loaded successfully")
end

return PlayerBuffHandlers