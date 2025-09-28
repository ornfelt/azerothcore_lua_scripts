--[[
    GameMaster UI - Player Spell Aura Handlers Sub-Module
    
    This module handles aura and cooldown operations for specific players:
    - Apply/remove auras to/from players
    - Reset spell cooldowns for players
    - Check cooldown status
]]--

local PlayerSpellAuraHandlers = {}

-- Module dependencies (will be injected)
local GameMasterSystem, Config, Utils, Database, DatabaseHelper

function PlayerSpellAuraHandlers.RegisterHandlers(gms, config, utils, database, dbHelper)
    GameMasterSystem = gms
    Config = config
    Utils = utils
    Database = database
    DatabaseHelper = dbHelper
    
    -- Register player aura and cooldown handlers
    GameMasterSystem.playerSpellApplyAura = PlayerSpellAuraHandlers.playerSpellApplyAura
    GameMasterSystem.playerSpellRemoveAura = PlayerSpellAuraHandlers.playerSpellRemoveAura
    GameMasterSystem.playerSpellResetCooldown = PlayerSpellAuraHandlers.playerSpellResetCooldown
    GameMasterSystem.playerSpellCheckCooldown = PlayerSpellAuraHandlers.playerSpellCheckCooldown
    GameMasterSystem.playerResetAllCooldowns = PlayerSpellAuraHandlers.playerResetAllCooldowns
end

-- Apply aura to player
function PlayerSpellAuraHandlers.playerSpellApplyAura(player, targetName, spellId)
    if player:GetGMRank() < 2 then
        Utils.sendMessage(player, "error", "You do not have permission to use this command.")
        return
    end
    
    local targetPlayer = GetPlayerByName(targetName)
    if not targetPlayer then
        Utils.sendMessage(player, "error", "Player '" .. targetName .. "' not found or offline.")
        return
    end
    
    targetPlayer:AddAura(spellId, targetPlayer)
    Utils.sendMessage(player, "success", string.format("Applied aura %d to %s.", spellId, targetName))
end

-- Remove specific aura from player
function PlayerSpellAuraHandlers.playerSpellRemoveAura(player, targetName, spellId)
    if player:GetGMRank() < 2 then
        Utils.sendMessage(player, "error", "You do not have permission to use this command.")
        return
    end
    
    local targetPlayer = GetPlayerByName(targetName)
    if not targetPlayer then
        Utils.sendMessage(player, "error", "Player '" .. targetName .. "' not found or offline.")
        return
    end
    
    if targetPlayer:HasAura(spellId) then
        targetPlayer:RemoveAura(spellId)
        Utils.sendMessage(player, "success", string.format("Removed aura %d from %s.", spellId, targetName))
    else
        Utils.sendMessage(player, "info", string.format("%s doesn't have aura %d.", targetName, spellId))
    end
end

-- Reset spell cooldown for player
function PlayerSpellAuraHandlers.playerSpellResetCooldown(player, targetName, spellId)
    if player:GetGMRank() < 2 then
        Utils.sendMessage(player, "error", "You do not have permission to use this command.")
        return
    end
    
    local targetPlayer = GetPlayerByName(targetName)
    if not targetPlayer then
        Utils.sendMessage(player, "error", "Player '" .. targetName .. "' not found or offline.")
        return
    end
    
    if targetPlayer:HasSpell(spellId) then
        targetPlayer:ResetSpellCooldown(spellId)
        Utils.sendMessage(player, "success", string.format("Reset cooldown for spell %d for %s.", spellId, targetName))
    else
        Utils.sendMessage(player, "warning", string.format("%s doesn't know spell %d.", targetName, spellId))
    end
end

-- Check spell cooldown for player
function PlayerSpellAuraHandlers.playerSpellCheckCooldown(player, targetName, spellId)
    if player:GetGMRank() < 2 then
        Utils.sendMessage(player, "error", "You do not have permission to use this command.")
        return
    end
    
    local targetPlayer = GetPlayerByName(targetName)
    if not targetPlayer then
        Utils.sendMessage(player, "error", "Player '" .. targetName .. "' not found or offline.")
        return
    end
    
    if targetPlayer:HasSpellCooldown(spellId) then
        local remaining = targetPlayer:GetSpellCooldownDelay(spellId)
        if remaining then
            local seconds = math.floor(remaining / 1000)
            Utils.sendMessage(player, "info", string.format("%s's spell %d cooldown: %d seconds", targetName, spellId, seconds))
        else
            Utils.sendMessage(player, "info", string.format("%s's spell %d is on cooldown.", targetName, spellId))
        end
    else
        Utils.sendMessage(player, "info", string.format("%s's spell %d is not on cooldown.", targetName, spellId))
    end
end

-- Reset all cooldowns for player
function PlayerSpellAuraHandlers.playerResetAllCooldowns(player, targetName)
    if player:GetGMRank() < 2 then
        Utils.sendMessage(player, "error", "You do not have permission to use this command.")
        return
    end
    
    local targetPlayer = GetPlayerByName(targetName)
    if not targetPlayer then
        Utils.sendMessage(player, "error", "Player '" .. targetName .. "' not found or offline.")
        return
    end
    
    targetPlayer:ResetAllCooldowns()
    Utils.sendMessage(player, "success", string.format("Reset all cooldowns for %s.", targetName))
    targetPlayer:SendBroadcastMessage(string.format("Staff %s reset all your spell cooldowns.", player:GetName()))
end

return PlayerSpellAuraHandlers