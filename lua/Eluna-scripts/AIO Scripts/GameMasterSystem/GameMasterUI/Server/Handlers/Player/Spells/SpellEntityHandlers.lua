--[[
    GameMaster UI - Spell Entity Handlers Sub-Module
    
    This module handles spell operations on the current target:
    - Learn/remove spells
    - Cast spells (self, target, from target)
    - Aura management (apply, remove, get info)
    - Cooldown management (reset, check status)
]]--

local SpellEntityHandlers = {}

-- Module dependencies (will be injected)
local GameMasterSystem, Config, Utils, Database, DatabaseHelper

function SpellEntityHandlers.RegisterHandlers(gms, config, utils, database, dbHelper)
    GameMasterSystem = gms
    Config = config
    Utils = utils
    Database = database
    DatabaseHelper = dbHelper
    
    -- Register spell entity handlers
    GameMasterSystem.learnSpellEntity = SpellEntityHandlers.learnSpellEntity
    GameMasterSystem.deleteSpellEntity = SpellEntityHandlers.deleteSpellEntity
    GameMasterSystem.castSelfSpellEntity = SpellEntityHandlers.castSelfSpellEntity
    GameMasterSystem.castOnTargetSpellEntity = SpellEntityHandlers.castOnTargetSpellEntity
    GameMasterSystem.castTargetSpellEntity = SpellEntityHandlers.castTargetSpellEntity
    GameMasterSystem.applyAuraToSelf = SpellEntityHandlers.applyAuraToSelf
    GameMasterSystem.applyAuraToTarget = SpellEntityHandlers.applyAuraToTarget
    GameMasterSystem.resetSpellCooldown = SpellEntityHandlers.resetSpellCooldown
    GameMasterSystem.resetAllCooldowns = SpellEntityHandlers.resetAllCooldowns
    GameMasterSystem.checkCooldownStatus = SpellEntityHandlers.checkCooldownStatus
    GameMasterSystem.applyAuraWithDuration = SpellEntityHandlers.applyAuraWithDuration
    GameMasterSystem.removeSpecificAura = SpellEntityHandlers.removeSpecificAura
    GameMasterSystem.getAuraInfo = SpellEntityHandlers.getAuraInfo
end

-- Server-side handler to add spell learnSpell
function SpellEntityHandlers.learnSpellEntity(player, spellID)
    local target, isSelf = GameMasterSystem.getTarget(player)

    if not target:HasSpell(spellID) then
        target:LearnSpell(spellID)
        if isSelf then
            Utils.sendMessage(player, "success", string.format("You have successfully learned spell (ID: %d).", spellID))
        else
            Utils.sendMessage(player, "success", string.format("Target has successfully learned spell (ID: %d).", spellID))
        end
    else
        if isSelf then
            Utils.sendMessage(player, "warning", string.format("You already know spell (ID: %d).", spellID))
        else
            Utils.sendMessage(player, "warning", string.format("Target already knows spell (ID: %d).", spellID))
        end
    end
end

-- Server-side handler to delete spell deleteEntitySpell
function SpellEntityHandlers.deleteSpellEntity(player, spellID)
    local target, isSelf = GameMasterSystem.getTarget(player)

    if target:HasSpell(spellID) then
        target:RemoveSpell(spellID)
        if isSelf then
            Utils.sendMessage(player, "success", string.format("You have successfully removed spell (ID: %d).", spellID))
        else
            Utils.sendMessage(player, "success", string.format("Target has successfully removed spell (ID: %d).", spellID))
        end
    else
        if isSelf then
            Utils.sendMessage(player, "warning", string.format("You do not know spell (ID: %d).", spellID))
        else
            Utils.sendMessage(player, "warning", string.format("Target does not know spell (ID: %d).", spellID))
        end
    end
end

-- Server-side handler to castSelfSpellEntity
function SpellEntityHandlers.castSelfSpellEntity(player, spellID)
    local target, isSelf = GameMasterSystem.getTarget(player)
    if not target or isSelf then
        Utils.sendMessage(player, "success", "Casting spell on yourself.")
        player:CastSpell(player, spellID, true)
    else
        Utils.sendMessage(player, "success", "Cast spell on target.")
        player:CastSpell(target, spellID, true)
    end
end

-- Server-side handler to cast spell on target
function SpellEntityHandlers.castOnTargetSpellEntity(player, spellID)
    local target, isSelf = GameMasterSystem.getTarget(player)
    if target then
        Utils.sendMessage(player, "success", string.format("Casting spell %d on %s.", spellID, isSelf and "yourself" or "target"))
        player:CastSpell(target, spellID, true)
    else
        Utils.sendMessage(player, "error", "No valid target selected.")
    end
end

-- Server-side handler to castTargetSpellEntity
function SpellEntityHandlers.castTargetSpellEntity(player, spellID)
    local target, isSelf = GameMasterSystem.getTarget(player)
    if not isSelf then
        Utils.sendMessage(player, "success", "Cast spell from target.")
        target:CastSpell(player, spellID, true)
    else
        Utils.sendMessage(player, "warning", "You cannot make yourself cast on yourself. Use 'Cast on Self' instead.")
    end
end

-- Server-side handler to apply aura to self
function SpellEntityHandlers.applyAuraToSelf(player, spellID)
    -- AddAura applies the spell as a persistent buff/aura
    player:AddAura(spellID, player)
    Utils.sendMessage(player, "success", string.format("Applied aura %d to yourself.", spellID))
end

-- Server-side handler to apply aura to target
function SpellEntityHandlers.applyAuraToTarget(player, spellID)
    local target, isSelf = GameMasterSystem.getTarget(player)
    if target then
        -- AddAura applies the spell as a persistent buff/aura
        target:AddAura(spellID, target)
        if isSelf then
            Utils.sendMessage(player, "success", string.format("Applied aura %d to yourself.", spellID))
        else
            Utils.sendMessage(player, "success", string.format("Applied aura %d to target.", spellID))
        end
    else
        Utils.sendMessage(player, "error", "No valid target selected.")
    end
end

-- Server-side handler to reset specific spell cooldown
function SpellEntityHandlers.resetSpellCooldown(player, spellID)
    local target, isSelf = GameMasterSystem.getTarget(player)
    if target then
        -- Check if target has the spell
        if target:HasSpell(spellID) then
            -- Reset the specific spell cooldown
            target:ResetSpellCooldown(spellID)
            if isSelf then
                Utils.sendMessage(player, "success", string.format("Reset cooldown for spell %d.", spellID))
            else
                Utils.sendMessage(player, "success", string.format("Reset cooldown for spell %d on target.", spellID))
            end
        else
            if isSelf then
                Utils.sendMessage(player, "warning", string.format("You don't know spell %d.", spellID))
            else
                Utils.sendMessage(player, "warning", string.format("Target doesn't know spell %d.", spellID))
            end
        end
    else
        Utils.sendMessage(player, "error", "No valid target selected.")
    end
end

-- Server-side handler to reset all cooldowns
function SpellEntityHandlers.resetAllCooldowns(player)
    local target, isSelf = GameMasterSystem.getTarget(player)
    if target then
        -- Reset all spell cooldowns
        target:ResetAllCooldowns()
        if isSelf then
            Utils.sendMessage(player, "success", "Reset all spell cooldowns.")
        else
            Utils.sendMessage(player, "success", "Reset all spell cooldowns for target.")
        end
    else
        Utils.sendMessage(player, "error", "No valid target selected.")
    end
end

-- Server-side handler to check cooldown status
function SpellEntityHandlers.checkCooldownStatus(player, spellID)
    local target, isSelf = GameMasterSystem.getTarget(player)
    if target then
        -- Check if spell is on cooldown
        if target:HasSpellCooldown(spellID) then
            local remaining = target:GetSpellCooldownDelay(spellID)
            if remaining then
                local seconds = math.floor(remaining / 1000) -- Convert from milliseconds
                local minutes = math.floor(seconds / 60)
                local displayTime = minutes > 0 and string.format("%d minutes %d seconds", minutes, seconds % 60) or string.format("%d seconds", seconds)
                
                if isSelf then
                    Utils.sendMessage(player, "info", string.format("Spell %d cooldown remaining: %s", spellID, displayTime))
                else
                    Utils.sendMessage(player, "info", string.format("Target's spell %d cooldown remaining: %s", spellID, displayTime))
                end
            else
                Utils.sendMessage(player, "info", string.format("Spell %d is on cooldown (duration unknown).", spellID))
            end
        else
            if isSelf then
                Utils.sendMessage(player, "info", string.format("Spell %d is not on cooldown.", spellID))
            else
                Utils.sendMessage(player, "info", string.format("Target's spell %d is not on cooldown.", spellID))
            end
        end
    else
        Utils.sendMessage(player, "error", "No valid target selected.")
    end
end

-- Server-side handler to apply aura with custom duration
function SpellEntityHandlers.applyAuraWithDuration(player, spellID, duration)
    local target, isSelf = GameMasterSystem.getTarget(player)
    if target then
        -- Apply the aura
        local aura = target:AddAura(spellID, target)
        
        if aura then
            -- Set custom duration if specified (duration in milliseconds)
            if duration > 0 then
                aura:SetDuration(duration)
                aura:SetMaxDuration(duration)
                local seconds = math.floor(duration / 1000)
                local timeStr = seconds >= 3600 and string.format("%.1f hours", seconds / 3600) or 
                               seconds >= 60 and string.format("%.1f minutes", seconds / 60) or 
                               string.format("%d seconds", seconds)
                if isSelf then
                    Utils.sendMessage(player, "success", string.format("Applied aura %d for %s.", spellID, timeStr))
                else
                    Utils.sendMessage(player, "success", string.format("Applied aura %d to target for %s.", spellID, timeStr))
                end
            else
                -- Permanent aura (until death/removal)
                aura:SetDuration(-1)
                aura:SetMaxDuration(-1)
                if isSelf then
                    Utils.sendMessage(player, "success", string.format("Applied permanent aura %d.", spellID))
                else
                    Utils.sendMessage(player, "success", string.format("Applied permanent aura %d to target.", spellID))
                end
            end
        else
            Utils.sendMessage(player, "error", string.format("Failed to apply aura %d.", spellID))
        end
    else
        Utils.sendMessage(player, "error", "No valid target selected.")
    end
end

-- Server-side handler to remove specific aura
function SpellEntityHandlers.removeSpecificAura(player, spellID)
    local target, isSelf = GameMasterSystem.getTarget(player)
    if target then
        if target:HasAura(spellID) then
            target:RemoveAura(spellID)
            if isSelf then
                Utils.sendMessage(player, "success", string.format("Removed aura %d.", spellID))
            else
                Utils.sendMessage(player, "success", string.format("Removed aura %d from target.", spellID))
            end
        else
            if isSelf then
                Utils.sendMessage(player, "info", string.format("You don't have aura %d.", spellID))
            else
                Utils.sendMessage(player, "info", string.format("Target doesn't have aura %d.", spellID))
            end
        end
    else
        Utils.sendMessage(player, "error", "No valid target selected.")
    end
end

-- Server-side handler to get aura information
function SpellEntityHandlers.getAuraInfo(player, spellID)
    local target, isSelf = GameMasterSystem.getTarget(player)
    if target then
        if target:HasAura(spellID) then
            -- Get all auras to find our specific one
            local auras = target:GetAuras()
            for _, aura in pairs(auras) do
                if aura:GetSpellId() == spellID then
                    local duration = aura:GetDuration()
                    local maxDuration = aura:GetMaxDuration()
                    local stacks = aura:GetStackAmount()
                    local caster = aura:GetCaster()
                    
                    local info = string.format("Aura %d Info:", spellID)
                    
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
            Utils.sendMessage(player, "info", string.format("Aura %d exists but details unavailable.", spellID))
        else
            if isSelf then
                Utils.sendMessage(player, "info", string.format("You don't have aura %d.", spellID))
            else
                Utils.sendMessage(player, "info", string.format("Target doesn't have aura %d.", spellID))
            end
        end
    else
        Utils.sendMessage(player, "error", "No valid target selected.")
    end
end

return SpellEntityHandlers