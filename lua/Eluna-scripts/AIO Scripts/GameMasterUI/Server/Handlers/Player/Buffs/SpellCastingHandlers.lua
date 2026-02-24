--[[
    GameMaster UI - Spell Casting Handlers Sub-Module
    
    This module handles spell casting operations:
    - Making players cast spells on themselves
    - Making players cast spells on their targets
    - GM casting spells on players
]]--

local SpellCastingHandlers = {}

-- Module dependencies (will be injected)
local GameMasterSystem, Config, Utils, Database, DatabaseHelper

function SpellCastingHandlers.RegisterHandlers(gms, config, utils, database, dbHelper)
    GameMasterSystem = gms
    Config = config
    Utils = utils
    Database = database
    DatabaseHelper = dbHelper
    
    -- Register spell casting handlers
    GameMasterSystem.makePlayerCastOnSelf = SpellCastingHandlers.makePlayerCastOnSelf
    GameMasterSystem.makePlayerCastOnTarget = SpellCastingHandlers.makePlayerCastOnTarget
    GameMasterSystem.castSpellOnPlayer = SpellCastingHandlers.castSpellOnPlayer
end

-- Make player cast spell on themselves
function SpellCastingHandlers.makePlayerCastOnSelf(player, targetName, spellId)
    -- Validate GM permissions
    if player:GetGMRank() < 2 then
        Utils.sendMessage(player, "error", "You do not have permission to use this command.")
        return
    end
    
    spellId = tonumber(spellId)
    if not spellId or spellId <= 0 then
        Utils.sendMessage(player, "error", "Invalid spell ID.")
        return
    end
    
    -- Find target player
    local targetPlayer = GetPlayerByName(targetName)
    if not targetPlayer then
        Utils.sendMessage(player, "error", "Player '" .. targetName .. "' not found or offline.")
        return
    end
    
    -- Make player cast spell on themselves
    targetPlayer:CastSpell(targetPlayer, spellId, true)
    
    Utils.sendMessage(player, "success", string.format("Made %s cast spell (ID: %d) on themselves.", targetName, spellId))
end

-- Make player cast spell on their target
function SpellCastingHandlers.makePlayerCastOnTarget(player, targetName, spellId)
    -- Validate GM permissions
    if player:GetGMRank() < 2 then
        Utils.sendMessage(player, "error", "You do not have permission to use this command.")
        return
    end
    
    spellId = tonumber(spellId)
    if not spellId or spellId <= 0 then
        Utils.sendMessage(player, "error", "Invalid spell ID.")
        return
    end
    
    -- Find target player
    local targetPlayer = GetPlayerByName(targetName)
    if not targetPlayer then
        Utils.sendMessage(player, "error", "Player '" .. targetName .. "' not found or offline.")
        return
    end
    
    -- Get player's target
    local playersTarget = targetPlayer:GetSelection()
    if not playersTarget then
        Utils.sendMessage(player, "error", targetName .. " has no target selected.")
        return
    end
    
    -- Make player cast spell on their target
    targetPlayer:CastSpell(playersTarget, spellId, true)
    
    Utils.sendMessage(player, "success", string.format("Made %s cast spell (ID: %d) on their target.", targetName, spellId))
end

-- Cast spell on player (GM casts on target)
function SpellCastingHandlers.castSpellOnPlayer(player, targetName, spellId)
    -- Validate GM permissions
    if player:GetGMRank() < 2 then
        Utils.sendMessage(player, "error", "You do not have permission to use this command.")
        return
    end
    
    spellId = tonumber(spellId)
    if not spellId or spellId <= 0 then
        Utils.sendMessage(player, "error", "Invalid spell ID.")
        return
    end
    
    -- Find target player
    local targetPlayer = GetPlayerByName(targetName)
    if not targetPlayer then
        Utils.sendMessage(player, "error", "Player '" .. targetName .. "' not found or offline.")
        return
    end
    
    -- GM casts spell on target player
    player:CastSpell(targetPlayer, spellId, true)
    
    Utils.sendMessage(player, "success", string.format("Cast spell (ID: %d) on %s.", spellId, targetName))
    targetPlayer:SendBroadcastMessage(string.format("Staff %s cast a spell on you.", player:GetName()))
end

return SpellCastingHandlers