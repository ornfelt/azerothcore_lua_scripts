--[[
    GameMasterUI - Search Manager Initialization

    This module initializes the unified SearchManager and registers
    all search strategies (spells, items, players).

    Load Order:
    - This file should be loaded AFTER core handlers are initialized
    - This file should be loaded BEFORE any code that uses search functionality

    Registration:
    - SpellSearchStrategy: Search spells by name/ID
    - ItemSearchStrategy: Advanced item search with filters
    - PlayerSearchStrategy: Online player search with batch optimization
]]--

local SearchManagerInit = {}

-- Module dependencies (will be injected)
local GameMasterSystem, Config, Utils, DatabaseHelper, QueryUtils

-- Reference to SearchManager
local SearchManager

function SearchManagerInit.Initialize(gms, config, utils, dbHelper, queryUtils)
    GameMasterSystem = gms
    Config = config
    Utils = utils
    DatabaseHelper = dbHelper
    QueryUtils = queryUtils

    -- Load SearchManager core
    SearchManager = require("GameMasterUI.Server.Core.SearchManager")
    SearchManager.Initialize(gms, config, utils, dbHelper)

    -- Register all search strategies
    SearchManagerInit.RegisterStrategies()
end

function SearchManagerInit.RegisterStrategies()
    -- Load FuzzyMatcher utility
    local FuzzyMatcher = require("GameMasterUI.Server.Utils.FuzzyMatcher")

    -- Load and register spell search (with fuzzy matching)
    local SpellSearchStrategy = require("GameMasterUI.Server.Core.SearchStrategies.SpellSearchStrategy")
    SpellSearchStrategy.Register(SearchManager, Utils, FuzzyMatcher)

    -- Load and register item search
    local ItemSearchStrategy = require("GameMasterUI.Server.Core.SearchStrategies.ItemSearchStrategy")
    ItemSearchStrategy.Register(SearchManager, Utils)

    -- Load and register player search
    local PlayerSearchStrategy = require("GameMasterUI.Server.Core.SearchStrategies.PlayerSearchStrategy")
    PlayerSearchStrategy.Register(SearchManager, Utils, QueryUtils)

    -- Register AIO handlers AFTER all strategies are registered
    SearchManager.RegisterAIOHandlers()

    -- Simple summary
    print("[SearchManager] Registered: spells, items, players (fuzzy matching enabled)")
end

-- Expose SearchManager for external access
function SearchManagerInit.GetSearchManager()
    return SearchManager
end

-- Register global access for console debugging
_G.GMSearchManager = SearchManager

return SearchManagerInit
