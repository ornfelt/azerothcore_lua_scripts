-- GameMaster UI System - Main Entry Point
-- This file creates the namespace and initializes global data structures
-- Load order: 00 (First)

local AIO = AIO or require("AIO")

if AIO.AddAddon() then
    return
end

-- Create the namespace for the addon (only done in main file)
_G.GameMasterSystem = AIO.AddHandlers("GameMasterSystem", {})

-- Create global data structures that will be used across all modules
_G.GMData = {
    -- Core data storage
    DataStore = {},
    
    -- System state
    coreName = "",
    gmLevel = 3, -- Default to non-GM level
    
    -- State flags
    isGmLevelFetched = false,
    isCoreNameFetched = false,
    
    -- UI state (current tab reference)
    currentOffset = 0,
    lastRequestedOffset = 0,  -- Track last requested offset to prevent duplicate requests
    activeTab = 1,
    sortOrder = "DESC",
    currentSearchQuery = "",
    hasMoreData = false,
    
    -- Per-tab pagination states
    tabStates = {},
    
    -- UI references (will be populated by UI module)
    frames = {},
    models = {},
    
    -- Performance tracking
    lastUpdate = 0,
    updateThrottle = 0.1, -- Minimum time between updates
}

-- Create module tables for organization
_G.GMUtils = {}      -- Utility functions
_G.GMConfig = {}     -- Configuration data
_G.GMUI = {}         -- UI creation and management
_G.GMCards = {}      -- Card creation functions
_G.GMModels = {}     -- Model management
_G.GMMenus = {}      -- Menu system
_G.GMDataHandler = {} -- Data filtering and management

-- Debug flag (can be overridden by config)
_G.GM_DEBUG = false

-- Version information
_G.GM_VERSION = "2.0.0"
_G.GM_ADDON_NAME = "GameMaster UI System"

-- Main namespace initialized