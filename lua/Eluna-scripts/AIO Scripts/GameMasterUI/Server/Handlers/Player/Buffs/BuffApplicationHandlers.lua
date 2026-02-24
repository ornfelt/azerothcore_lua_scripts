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
    GameMasterSystem.playerApplyAuraWithOptions = BuffApplicationHandlers.playerApplyAuraWithOptions
    GameMasterSystem.playerGetAuraInfo = BuffApplicationHandlers.playerGetAuraInfo
    GameMasterSystem.applyAuraWithOptionsToSelf = BuffApplicationHandlers.applyAuraWithOptionsToSelf
    GameMasterSystem.applyAuraWithOptionsToTarget = BuffApplicationHandlers.applyAuraWithOptionsToTarget
    GameMasterSystem.applyAuraWithOptionsToGroup = BuffApplicationHandlers.applyAuraWithOptionsToGroup
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

-- Apply aura with comprehensive options (duration, stacks, etc.)
function BuffApplicationHandlers.playerApplyAuraWithOptions(player, targetName, spellId, duration, stacks)
    if player:GetGMRank() < 2 then
        Utils.sendMessage(player, "error", "You do not have permission to use this command.")
        return
    end

    local targetPlayer = GetPlayerByName(targetName)
    if not targetPlayer then
        Utils.sendMessage(player, "error", "Player '" .. targetName .. "' not found or offline.")
        return
    end

    -- Validate inputs
    duration = tonumber(duration) or 60000
    stacks = tonumber(stacks) or 1
    stacks = math.max(1, math.min(255, math.floor(stacks))) -- Clamp between 1-255

    -- Remove existing aura if present
    if targetPlayer:HasAura(spellId) then
        targetPlayer:RemoveAura(spellId)
    end

    -- Apply the aura multiple times for stacks (if needed)
    local aura = nil

    -- First application
    aura = targetPlayer:AddAura(spellId, targetPlayer)

    if not aura then
        Utils.sendMessage(player, "error", string.format("Failed to apply aura %d to %s.", spellId, targetName))
        return
    end

    -- Set duration
    if duration > 0 then
        aura:SetDuration(duration)
        aura:SetMaxDuration(duration)
    elseif duration < 0 then
        -- Permanent aura
        aura:SetDuration(-1)
        aura:SetMaxDuration(-1)
    end

    -- Apply additional stacks if needed (stacks > 1)
    -- Note: Some spells stack automatically, some need multiple applications
    if stacks > 1 then
        for i = 2, stacks do
            local stackAura = targetPlayer:AddAura(spellId, targetPlayer)
            if stackAura and duration > 0 then
                stackAura:SetDuration(duration)
                stackAura:SetMaxDuration(duration)
            elseif stackAura and duration < 0 then
                stackAura:SetDuration(-1)
                stackAura:SetMaxDuration(-1)
            end
        end
    end

    -- Build success message
    local timeStr = ""
    if duration > 0 then
        local seconds = math.floor(duration / 1000)
        timeStr = seconds >= 3600 and string.format("%.1f hours", seconds / 3600) or
                  seconds >= 60 and string.format("%.1f minutes", seconds / 60) or
                  string.format("%d seconds", seconds)
    else
        timeStr = "permanent"
    end

    local stackStr = stacks > 1 and string.format(" with %d stacks", stacks) or ""

    Utils.sendMessage(player, "success",
        string.format("Applied aura %d to %s for %s%s.", spellId, targetName, timeStr, stackStr))

    targetPlayer:SendBroadcastMessage(
        string.format("Staff %s applied a buff to you for %s%s.", player:GetName(), timeStr, stackStr))
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

-- Apply aura with options to self
function BuffApplicationHandlers.applyAuraWithOptionsToSelf(player, spellId, duration, stacks)
    if player:GetGMRank() < 2 then
        Utils.sendMessage(player, "error", "You do not have permission to use this command.")
        return
    end

    -- Validate inputs
    duration = tonumber(duration) or 60000
    stacks = tonumber(stacks) or 1
    stacks = math.max(1, math.min(255, math.floor(stacks)))

    -- Remove existing aura if present
    if player:HasAura(spellId) then
        player:RemoveAura(spellId)
    end

    -- Apply the aura to self
    local aura = player:AddAura(spellId, player)

    if not aura then
        Utils.sendMessage(player, "error", string.format("Failed to apply aura %d to yourself.", spellId))
        return
    end

    -- Set duration
    if duration > 0 then
        aura:SetDuration(duration)
        aura:SetMaxDuration(duration)
    elseif duration < 0 then
        aura:SetDuration(-1)
        aura:SetMaxDuration(-1)
    end

    -- Apply additional stacks if needed
    if stacks > 1 then
        for i = 2, stacks do
            local stackAura = player:AddAura(spellId, player)
            if stackAura and duration > 0 then
                stackAura:SetDuration(duration)
                stackAura:SetMaxDuration(duration)
            elseif stackAura and duration < 0 then
                stackAura:SetDuration(-1)
                stackAura:SetMaxDuration(-1)
            end
        end
    end

    -- Build success message
    local timeStr = ""
    if duration > 0 then
        local seconds = math.floor(duration / 1000)
        timeStr = seconds >= 3600 and string.format("%.1f hours", seconds / 3600) or
                  seconds >= 60 and string.format("%.1f minutes", seconds / 60) or
                  string.format("%d seconds", seconds)
    else
        timeStr = "permanent"
    end

    local stackStr = stacks > 1 and string.format(" with %d stacks", stacks) or ""

    Utils.sendMessage(player, "success",
        string.format("Applied aura %d to yourself for %s%s.", spellId, timeStr, stackStr))
end

-- Apply aura with options to target
function BuffApplicationHandlers.applyAuraWithOptionsToTarget(player, spellId, duration, stacks)
    if player:GetGMRank() < 2 then
        Utils.sendMessage(player, "error", "You do not have permission to use this command.")
        return
    end

    local target = player:GetSelection()
    if not target then
        Utils.sendMessage(player, "error", "You must have a target selected.")
        return
    end

    -- Check if target is a valid unit (Player or Creature)
    local targetUnit = nil
    if target:IsPlayer() then
        targetUnit = target:ToPlayer()
    elseif target:IsCreature() then
        targetUnit = target:ToCreature()
    else
        Utils.sendMessage(player, "error", "Invalid target. Must be a player or creature.")
        return
    end

    -- Validate inputs
    duration = tonumber(duration) or 60000
    stacks = tonumber(stacks) or 1
    stacks = math.max(1, math.min(255, math.floor(stacks)))

    -- Remove existing aura if present
    if targetUnit:HasAura(spellId) then
        targetUnit:RemoveAura(spellId)
    end

    -- Apply the aura to target
    local aura = targetUnit:AddAura(spellId, targetUnit)

    if not aura then
        Utils.sendMessage(player, "error", string.format("Failed to apply aura %d to target.", spellId))
        return
    end

    -- Set duration
    if duration > 0 then
        aura:SetDuration(duration)
        aura:SetMaxDuration(duration)
    elseif duration < 0 then
        aura:SetDuration(-1)
        aura:SetMaxDuration(-1)
    end

    -- Apply additional stacks if needed
    if stacks > 1 then
        for i = 2, stacks do
            local stackAura = targetUnit:AddAura(spellId, targetUnit)
            if stackAura and duration > 0 then
                stackAura:SetDuration(duration)
                stackAura:SetMaxDuration(duration)
            elseif stackAura and duration < 0 then
                stackAura:SetDuration(-1)
                stackAura:SetMaxDuration(-1)
            end
        end
    end

    -- Build success message
    local timeStr = ""
    if duration > 0 then
        local seconds = math.floor(duration / 1000)
        timeStr = seconds >= 3600 and string.format("%.1f hours", seconds / 3600) or
                  seconds >= 60 and string.format("%.1f minutes", seconds / 60) or
                  string.format("%d seconds", seconds)
    else
        timeStr = "permanent"
    end

    local stackStr = stacks > 1 and string.format(" with %d stacks", stacks) or ""
    local targetName = targetUnit:GetName()

    Utils.sendMessage(player, "success",
        string.format("Applied aura %d to %s for %s%s.", spellId, targetName, timeStr, stackStr))

    -- Notify target if it's a player
    if targetUnit:IsPlayer() then
        targetUnit:SendBroadcastMessage(
            string.format("Staff %s applied a buff to you for %s%s.", player:GetName(), timeStr, stackStr))
    end
end

-- Apply aura with options to group (party/raid)
function BuffApplicationHandlers.applyAuraWithOptionsToGroup(player, spellId, duration, stacks)
    if player:GetGMRank() < 2 then
        Utils.sendMessage(player, "error", "You do not have permission to use this command.")
        return
    end

    -- Check if player is in a group
    local group = player:GetGroup()
    if not group then
        Utils.sendMessage(player, "error", "You are not in a group.")
        return
    end

    -- Validate inputs
    duration = tonumber(duration) or 60000
    stacks = tonumber(stacks) or 1
    stacks = math.max(1, math.min(255, math.floor(stacks)))

    -- Get all group members
    local members = group:GetMembers()
    local successCount = 0
    local totalCount = 0

    -- Apply aura to each member
    for _, member in pairs(members) do
        if member then
            totalCount = totalCount + 1

            -- Remove existing aura if present
            if member:HasAura(spellId) then
                member:RemoveAura(spellId)
            end

            local aura = member:AddAura(spellId, member)

            if aura then
                -- Set duration
                if duration > 0 then
                    aura:SetDuration(duration)
                    aura:SetMaxDuration(duration)
                elseif duration < 0 then
                    aura:SetDuration(-1)
                    aura:SetMaxDuration(-1)
                end

                -- Apply additional stacks if needed
                if stacks > 1 then
                    for i = 2, stacks do
                        local stackAura = member:AddAura(spellId, member)
                        if stackAura and duration > 0 then
                            stackAura:SetDuration(duration)
                            stackAura:SetMaxDuration(duration)
                        elseif stackAura and duration < 0 then
                            stackAura:SetDuration(-1)
                            stackAura:SetMaxDuration(-1)
                        end
                    end
                end

                successCount = successCount + 1

                -- Notify the member
                local timeStr = ""
                if duration > 0 then
                    local seconds = math.floor(duration / 1000)
                    timeStr = seconds >= 3600 and string.format("%.1f hours", seconds / 3600) or
                              seconds >= 60 and string.format("%.1f minutes", seconds / 60) or
                              string.format("%d seconds", seconds)
                else
                    timeStr = "permanent"
                end

                local stackStr = stacks > 1 and string.format(" with %d stacks", stacks) or ""
                member:SendBroadcastMessage(
                    string.format("Staff %s applied a buff to your group for %s%s.", player:GetName(), timeStr, stackStr))
            end
        end
    end

    -- Send feedback to GM
    local timeStr = ""
    if duration > 0 then
        local seconds = math.floor(duration / 1000)
        timeStr = seconds >= 3600 and string.format("%.1f hours", seconds / 3600) or
                  seconds >= 60 and string.format("%.1f minutes", seconds / 60) or
                  string.format("%d seconds", seconds)
    else
        timeStr = "permanent"
    end

    local stackStr = stacks > 1 and string.format(" with %d stacks", stacks) or ""

    Utils.sendMessage(player, "success",
        string.format("Applied aura %d to %d/%d group members for %s%s.",
            spellId, successCount, totalCount, timeStr, stackStr))
end

return BuffApplicationHandlers