--[[
    GameMaster UI - Buff Application Handlers Sub-Module
    
    This module handles buff and aura application operations:
    - Applying single buffs to players
    - Applying auras with custom durations
    - Retrieving detailed aura information
]]--

local BuffApplicationHandlers = {}

-- Module dependencies (will be injected)
local GameMasterSystem, Config, Utils, Database, DatabaseHelper

function BuffApplicationHandlers.RegisterHandlers(gms, config, utils, database, dbHelper)
    GameMasterSystem = gms
    Config = config
    Utils = utils
    Database = database
    DatabaseHelper = dbHelper
    
    -- Register buff application handlers
    GameMasterSystem.applyBuffToPlayer = BuffApplicationHandlers.applyBuffToPlayer
    GameMasterSystem.playerApplyAuraWithDuration = BuffApplicationHandlers.playerApplyAuraWithDuration
    GameMasterSystem.playerGetAuraInfo = BuffApplicationHandlers.playerGetAuraInfo
end

-- Apply buff to player
function BuffApplicationHandlers.applyBuffToPlayer(player, targetName, spellId)
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
    
    -- Apply the buff/aura using the correct Eluna API
    -- The caster (GM) adds the aura to the target
    player:AddAura(spellId, targetPlayer)
    
    Utils.sendMessage(player, "success", string.format("Applied buff (ID: %d) to %s.", spellId, targetName))
    targetPlayer:SendBroadcastMessage(string.format("You received a buff from Staff %s.", player:GetName()))
end

-- Apply aura with custom duration to player
function BuffApplicationHandlers.playerApplyAuraWithDuration(player, targetName, spellId, duration)
    if player:GetGMRank() < 2 then
        Utils.sendMessage(player, "error", "You do not have permission to use this command.")
        return
    end
    
    local targetPlayer = GetPlayerByName(targetName)
    if not targetPlayer then
        Utils.sendMessage(player, "error", "Player '" .. targetName .. "' not found or offline.")
        return
    end
    
    -- Apply the aura
    local aura = targetPlayer:AddAura(spellId, targetPlayer)
    
    if aura then
        -- Set custom duration if specified (duration in milliseconds)
        if duration and duration > 0 then
            aura:SetDuration(duration)
            aura:SetMaxDuration(duration)
            local seconds = math.floor(duration / 1000)
            local timeStr = seconds >= 3600 and string.format("%.1f hours", seconds / 3600) or 
                           seconds >= 60 and string.format("%.1f minutes", seconds / 60) or 
                           string.format("%d seconds", seconds)
            Utils.sendMessage(player, "success", string.format("Applied aura %d to %s for %s.", spellId, targetName, timeStr))
            targetPlayer:SendBroadcastMessage(string.format("Staff %s applied a buff to you for %s.", player:GetName(), timeStr))
        elseif duration and duration < 0 then
            -- Permanent aura (until death/removal)
            aura:SetDuration(-1)
            aura:SetMaxDuration(-1)
            Utils.sendMessage(player, "success", string.format("Applied permanent aura %d to %s.", spellId, targetName))
            targetPlayer:SendBroadcastMessage(string.format("Staff %s applied a permanent buff to you.", player:GetName()))
        else
            -- Default duration from spell data
            Utils.sendMessage(player, "success", string.format("Applied aura %d to %s.", spellId, targetName))
            targetPlayer:SendBroadcastMessage(string.format("Staff %s applied a buff to you.", player:GetName()))
        end
    else
        Utils.sendMessage(player, "error", string.format("Failed to apply aura %d to %s.", spellId, targetName))
    end
end

-- Get aura info for a player
function BuffApplicationHandlers.playerGetAuraInfo(player, targetName, spellId)
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
        -- Get all auras to find our specific one
        local auras = targetPlayer:GetAuras()
        for _, aura in pairs(auras) do
            if aura:GetSpellId() == spellId then
                local duration = aura:GetDuration()
                local maxDuration = aura:GetMaxDuration()
                local stacks = aura:GetStackAmount()
                local caster = aura:GetCaster()
                
                local info = string.format("Aura %d on %s:", spellId, targetName)
                
                -- Duration info
                if duration > 0 then
                    local seconds = math.floor(duration / 1000)
                    info = info .. string.format("\n  Duration: %d seconds remaining", seconds)
                else
                    info = info .. "\n  Duration: Permanent"
                end
                
                -- Stack info
                if stacks > 0 then
                    info = info .. string.format("\n  Stacks: %d", stacks)
                end
                
                -- Caster info
                if caster then
                    local casterName = caster:GetName()
                    info = info .. string.format("\n  Caster: %s", casterName or "Unknown")
                end
                
                Utils.sendMessage(player, "info", info)
                return
            end
        end
        
        -- Shouldn't reach here if HasAura is true
        Utils.sendMessage(player, "info", string.format("%s has aura %d but couldn't get detailed info.", targetName, spellId))
    else
        Utils.sendMessage(player, "info", string.format("%s doesn't have aura %d.", targetName, spellId))
    end
end

return BuffApplicationHandlers