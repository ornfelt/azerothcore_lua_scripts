--[[
    GameMaster UI - Player Inventory Refresh Handlers Sub-Module
    
    This sub-module handles inventory refresh and save operations:
    - Save online player data before queries
    - Refresh inventory data
    - Main public interface for inventory queries
]]--

local PlayerInventoryRefreshHandlers = {}

-- Module dependencies (will be injected)
local GameMasterSystem, Config, Utils, Database, DatabaseHelper

function PlayerInventoryRefreshHandlers.RegisterHandlers(gms, config, utils, database, dbHelper)
    GameMasterSystem = gms
    Config = config
    Utils = utils
    Database = database
    DatabaseHelper = dbHelper
    
    -- Register refresh handlers
    GameMasterSystem.getPlayerInventory = PlayerInventoryRefreshHandlers.getPlayerInventory
    GameMasterSystem.refreshPlayerInventory = PlayerInventoryRefreshHandlers.refreshPlayerInventory
    GameMasterSystem.saveOnlinePlayerData = PlayerInventoryRefreshHandlers.saveOnlinePlayerData
end

-- Utility function to save online player data before querying
-- This ensures we get the most up-to-date information
function PlayerInventoryRefreshHandlers.saveOnlinePlayerData(targetName, callback, ...)
    local targetPlayer = GetPlayerByName(targetName)
    
    if targetPlayer then
        -- Player is online, save their data to database
        print(string.format("[PlayerInventoryRefreshHandlers] Player %s is online, saving data to database...", targetName))
        targetPlayer:SaveToDB()
        
        -- Add a small delay to ensure database write completes
        -- Then execute the callback with the provided arguments
        local args = {...}
        local function executeCallback()
            if callback then
                callback(unpack(args))
            end
        end
        
        -- Create a delayed call (200ms should be enough for DB update)
        CreateLuaEvent(executeCallback, 200, 1)
        return true  -- Indicates save was performed
    else
        -- Player is offline, execute callback immediately
        print(string.format("[PlayerInventoryRefreshHandlers] Player %s is offline, using existing database data", targetName))
        if callback then
            callback(...)
        end
        return false  -- Indicates no save was needed
    end
end

-- Public function to refresh player inventory (can be called from anywhere)
-- This is useful for forcing a refresh after any inventory-modifying operation
function PlayerInventoryRefreshHandlers.refreshPlayerInventory(player, targetName)
    print(string.format("[PlayerInventoryRefreshHandlers] Manual inventory refresh requested for: %s", targetName))
    
    -- Validate GM permissions
    if player:GetGMRank() < 2 then
        Utils.sendMessage(player, "error", "You do not have permission to refresh inventory.")
        return
    end
    
    -- Use the save and query pattern
    -- Note: _queryAndSendInventory will be provided by the data handlers module
    PlayerInventoryRefreshHandlers.saveOnlinePlayerData(targetName, GameMasterSystem._queryAndSendInventory, player, targetName)
    
    Utils.sendMessage(player, "info", "Refreshing inventory for " .. targetName .. "...")
end

-- Get player inventory and equipment (public interface)
function PlayerInventoryRefreshHandlers.getPlayerInventory(player, targetName)
    print(string.format("[PlayerInventoryRefreshHandlers] getPlayerInventory called for target: %s by player: %s", 
        tostring(targetName), player:GetName()))
    print("[PlayerInventoryRefreshHandlers] Player GM rank:", player:GetGMRank())
    
    -- Validate GM permissions
    if player:GetGMRank() < 2 then
        Utils.sendMessage(player, "error", "You do not have permission to use this command.")
        AIO.Handle(player, "GameMasterSystem", "receiveInventoryData", {}, {}, targetName)
        return
    end
    
    -- Check if we need to save online player data first
    -- Note: _queryAndSendInventory will be provided by the data handlers module
    local savedData = PlayerInventoryRefreshHandlers.saveOnlinePlayerData(targetName, GameMasterSystem._queryAndSendInventory, player, targetName)
    
    if savedData then
        -- Show feedback that we're refreshing from live data
        Utils.sendMessage(player, "info", "Refreshing inventory data for online player " .. targetName .. "...")
    end
end

return PlayerInventoryRefreshHandlers