--[[
    GameMaster UI - Player Action Handlers Sub-Module
    
    This sub-module handles player management actions:
    - Gold management
    - Teleportation (to player, summon)
    - Kick operations (single and batch)
    - Batch summon operations
]]--

local PlayerActionHandlers = {}

-- Module dependencies (will be injected)
local GameMasterSystem, Config, Utils, Database, DatabaseHelper

function PlayerActionHandlers.RegisterHandlers(gms, config, utils, database, dbHelper)
    GameMasterSystem = gms
    Config = config
    Utils = utils
    Database = database
    DatabaseHelper = dbHelper
    
    -- Register action handlers
    GameMasterSystem.givePlayerGold = PlayerActionHandlers.givePlayerGold
    GameMasterSystem.teleportToPlayer = PlayerActionHandlers.teleportToPlayer
    GameMasterSystem.summonPlayer = PlayerActionHandlers.summonPlayer
    GameMasterSystem.kickPlayer = PlayerActionHandlers.kickPlayer
    GameMasterSystem.batchKick = PlayerActionHandlers.batchKick
    GameMasterSystem.batchSummon = PlayerActionHandlers.batchSummon
end

-- Give gold to a player
function PlayerActionHandlers.givePlayerGold(player, targetName, amount)
    -- Validate GM permissions
    if player:GetGMRank() < 2 then
        Utils.sendMessage(player, "error", "You do not have permission to use this command.")
        return
    end
    
    amount = tonumber(amount)
    if not amount or amount <= 0 then
        Utils.sendMessage(player, "error", "Invalid gold amount.")
        return
    end
    
    -- Convert gold to copper (1 gold = 10000 copper)
    local copper = amount * 10000
    
    -- Find target player
    local targetPlayer = GetPlayerByName(targetName)
    if not targetPlayer then
        Utils.sendMessage(player, "error", "Player '" .. targetName .. "' not found or offline.")
        return
    end
    
    -- Give gold
    targetPlayer:ModifyMoney(copper)
    
    -- Notify both players
    Utils.sendMessage(player, "success", string.format("Gave %d gold to %s.", amount, targetName))
    targetPlayer:SendBroadcastMessage(string.format("You received %d gold from Staff %s.", amount, player:GetName()))
end

-- Teleport GM to player
function PlayerActionHandlers.teleportToPlayer(player, targetName)
    -- Validate GM permissions
    if player:GetGMRank() < 2 then
        Utils.sendMessage(player, "error", "You do not have permission to use this command.")
        return
    end
    
    -- Find target player
    local targetPlayer = GetPlayerByName(targetName)
    if not targetPlayer then
        Utils.sendMessage(player, "error", "Player '" .. targetName .. "' not found or offline.")
        return
    end
    
    -- Teleport GM to player
    player:Teleport(
        targetPlayer:GetMapId(),
        targetPlayer:GetX(),
        targetPlayer:GetY(),
        targetPlayer:GetZ(),
        targetPlayer:GetO()
    )
    
    Utils.sendMessage(player, "success", "Teleported to " .. targetName .. ".")
end

-- Summon player to GM
function PlayerActionHandlers.summonPlayer(player, targetName)
    -- Validate GM permissions
    if player:GetGMRank() < 2 then
        Utils.sendMessage(player, "error", "You do not have permission to use this command.")
        return
    end
    
    -- Find target player
    local targetPlayer = GetPlayerByName(targetName)
    if not targetPlayer then
        Utils.sendMessage(player, "error", "Player '" .. targetName .. "' not found or offline.")
        return
    end
    
    -- Summon player to GM
    targetPlayer:Teleport(
        player:GetMapId(),
        player:GetX(),
        player:GetY(),
        player:GetZ(),
        player:GetO()
    )
    
    Utils.sendMessage(player, "success", "Summoned " .. targetName .. " to your location.")
    targetPlayer:SendBroadcastMessage("You have been summoned by Staff " .. player:GetName() .. ".")
end

-- Kick a single player
function PlayerActionHandlers.kickPlayer(player, targetName, reason)
    -- Validate GM permissions
    if player:GetGMRank() < 2 then
        Utils.sendMessage(player, "error", "You do not have permission to use this command.")
        return
    end
    
    -- Find target player
    local targetPlayer = GetPlayerByName(targetName)
    if not targetPlayer then
        Utils.sendMessage(player, "error", "Player '" .. targetName .. "' not found or offline.")
        return
    end
    
    reason = reason or "Kicked by GM"
    
    -- Kick the player
    targetPlayer:KickPlayer()
    
    Utils.sendMessage(player, "success", string.format("Kicked %s. Reason: %s", targetName, reason))
end

-- Batch kick multiple players
function PlayerActionHandlers.batchKick(player, playerNames, reason)
    -- Validate GM permissions
    if player:GetGMRank() < 2 then
        Utils.sendMessage(player, "error", "You do not have permission to use this command.")
        return
    end
    
    if not playerNames or type(playerNames) ~= "table" or #playerNames == 0 then
        Utils.sendMessage(player, "error", "No players selected for batch kick.")
        return
    end
    
    reason = reason or "Kicked by GM (Batch Action)"
    local successCount = 0
    local failedPlayers = {}
    
    for _, targetName in ipairs(playerNames) do
        local targetPlayer = GetPlayerByName(targetName)
        if targetPlayer then
            targetPlayer:KickPlayer()
            successCount = successCount + 1
        else
            table.insert(failedPlayers, targetName)
        end
    end
    
    -- Send feedback
    if successCount > 0 then
        Utils.sendMessage(player, "success", string.format("Successfully kicked %d player(s). Reason: %s", successCount, reason))
    end
    
    if #failedPlayers > 0 then
        Utils.sendMessage(player, "warning", string.format("Failed to kick %d player(s) (offline or not found): %s", 
            #failedPlayers, table.concat(failedPlayers, ", ")))
    end
end

-- Batch summon multiple players
function PlayerActionHandlers.batchSummon(player, playerNames)
    -- Validate GM permissions
    if player:GetGMRank() < 2 then
        Utils.sendMessage(player, "error", "You do not have permission to use this command.")
        return
    end
    
    if not playerNames or type(playerNames) ~= "table" or #playerNames == 0 then
        Utils.sendMessage(player, "error", "No players selected for batch summon.")
        return
    end
    
    local onlineCount = 0
    local offlineCount = 0
    local notFoundPlayers = {}
    
    -- Get GM's location
    local mapId = player:GetMapId()
    local x, y, z, o = player:GetX(), player:GetY(), player:GetZ(), player:GetO()
    
    for _, targetName in ipairs(playerNames) do
        -- Try to find online player first
        local targetPlayer = GetPlayerByName(targetName)
        if targetPlayer then
            -- Player is online, teleport immediately
            targetPlayer:Teleport(mapId, x, y, z, o)
            targetPlayer:SendBroadcastMessage(string.format("You have been summoned by Staff %s.", player:GetName()))
            onlineCount = onlineCount + 1
        else
            -- Player not online, check if they exist in database and update position
            local escapedName = targetName:gsub("'", "''")  -- Escape single quotes for SQL
            
            -- Check if player exists
            local checkQuery = string.format("SELECT guid FROM characters WHERE name = '%s'", escapedName)
            local result = CharDBQuery(checkQuery)
            
            if result then
                -- Player exists, update their position for next login
                local updateQuery = string.format(
                    "UPDATE characters SET position_x = %f, position_y = %f, position_z = %f, map = %d, orientation = %f WHERE name = '%s'",
                    x, y, z, mapId, o, escapedName
                )
                CharDBExecute(updateQuery)
                offlineCount = offlineCount + 1
            else
                -- Player doesn't exist
                table.insert(notFoundPlayers, targetName)
            end
        end
    end
    
    -- Send detailed feedback
    local messages = {}
    
    if onlineCount > 0 then
        table.insert(messages, string.format("%d player(s) summoned immediately", onlineCount))
    end
    
    if offlineCount > 0 then
        table.insert(messages, string.format("%d offline player(s) will be summoned on next login", offlineCount))
    end
    
    if #notFoundPlayers > 0 then
        table.insert(messages, string.format("%d player(s) not found: %s", 
            #notFoundPlayers, table.concat(notFoundPlayers, ", ")))
    end
    
    if #messages > 0 then
        Utils.sendMessage(player, "success", "Summon results: " .. table.concat(messages, ", "))
    end
end

return PlayerActionHandlers