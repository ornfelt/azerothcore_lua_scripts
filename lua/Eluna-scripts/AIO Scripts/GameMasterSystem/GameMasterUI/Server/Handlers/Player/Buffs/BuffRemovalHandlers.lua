--[[
    GameMaster UI - Buff Removal Handlers Sub-Module
    
    This module handles buff removal and restoration operations:
    - Removing all auras from players
    - Healing and restoring players (health, power, debuff removal)
]]--

local BuffRemovalHandlers = {}

-- Module dependencies (will be injected)
local GameMasterSystem, Config, Utils, Database, DatabaseHelper

function BuffRemovalHandlers.RegisterHandlers(gms, config, utils, database, dbHelper)
    GameMasterSystem = gms
    Config = config
    Utils = utils
    Database = database
    DatabaseHelper = dbHelper
    
    -- Register buff removal handlers
    GameMasterSystem.removePlayerAuras = BuffRemovalHandlers.removePlayerAuras
    GameMasterSystem.healAndRestorePlayer = BuffRemovalHandlers.healAndRestorePlayer
end

-- Remove all auras from player
function BuffRemovalHandlers.removePlayerAuras(player, targetName)
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
    
    -- Remove all auras
    targetPlayer:RemoveAllAuras()
    
    Utils.sendMessage(player, "success", string.format("Removed all auras from %s.", targetName))
    targetPlayer:SendBroadcastMessage(string.format("All your auras have been removed by Staff %s.", player:GetName()))
end

-- Heal and restore player
function BuffRemovalHandlers.healAndRestorePlayer(player, targetName)
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
    
    -- Full heal
    targetPlayer:SetHealth(targetPlayer:GetMaxHealth())
    
    -- Restore mana/energy/rage
    local powerType = targetPlayer:GetPowerType()
    targetPlayer:SetPower(targetPlayer:GetMaxPower(powerType), powerType)
    
    -- Remove common debuffs from Utils
    for _, debuffId in ipairs(Utils.commonDebuffs) do
        if targetPlayer:HasAura(debuffId) then
            targetPlayer:RemoveAura(debuffId)
        end
    end
    
    -- Alternative: Remove ALL auras (both positive and negative)
    -- This is more thorough but also removes buffs
    -- targetPlayer:RemoveAllAuras()
    
    Utils.sendMessage(player, "success", string.format("Fully healed and restored %s.", targetName))
    targetPlayer:SendBroadcastMessage(string.format("You have been fully restored by Staff %s.", player:GetName()))
end

return BuffRemovalHandlers