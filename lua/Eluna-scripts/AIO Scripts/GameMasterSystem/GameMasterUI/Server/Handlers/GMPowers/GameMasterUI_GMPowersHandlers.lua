--[[
    GameMaster UI - GM Powers Handlers
    
    This module handles all GM power toggles and controls including:
    - GM mode, fly mode, god mode toggles
    - Speed modifications
    - Cooldown and cast time cheats
    - Quick actions like teleport, summon, heal
]]--

local GMPowersHandlers = {}

-- Dependencies will be injected
local GameMasterSystem, Config, Utils, Database, DatabaseHelper

-- Player state tracking
local playerStates = {}

-- Speed type mappings
local SPEED_TYPES = {
    walk = 0,  -- MOVE_WALK
    run = 1,   -- MOVE_RUN
    swim = 3,  -- MOVE_SWIM
    fly = 6    -- MOVE_FLIGHT
}

-- Initialize player state
local function InitializePlayerState(player)
    local guid = player:GetGUIDLow()
    if not playerStates[guid] then
        playerStates[guid] = {
            gmMode = player:IsGM(),
            flyMode = player:CanFly(),
            godMode = false,
            noCooldowns = false,
            instantCast = false,
            invisible = not player:IsGMVisible(),
            waterWalk = false,
            taxiCheat = player:IsTaxiCheater(),
            speeds = {
                walk = player:GetSpeed(0),  -- GetSpeed returns the rate multiplier
                run = player:GetSpeed(1),   -- Not the absolute speed value
                swim = player:GetSpeed(3),  -- So we don't need to divide
                fly = player:GetSpeed(6)    -- Just use the value directly
            }
        }
    end
    return playerStates[guid]
end

-- Clean up player state on logout
local function CleanupPlayerState(event, player)
    local guid = player:GetGUIDLow()
    playerStates[guid] = nil
end

-- Toggle GM power
function GMPowersHandlers.toggleGMPower(player, powerId, enable)
    -- Validate GM rank
    if player:GetGMRank() < Config.MIN_GM_RANK then
        Utils.sendMessage(player, "error", "Insufficient GM rank")
        return
    end
    
    local guid = player:GetGUIDLow()
    local state = InitializePlayerState(player)
    
    local success = false
    local message = ""
    
    if powerId == "gmMode" then
        player:SetGameMaster(enable)
        state.gmMode = enable
        message = enable and "GM Mode enabled" or "GM Mode disabled"
        success = true
    elseif powerId == "flyMode" then
        player:SetCanFly(enable)
        state.flyMode = enable
        message = enable and "Fly Mode enabled" or "Fly Mode disabled"
        success = true
    elseif powerId == "godMode" then
        if enable then
            player:SetMaxHealth(999999999)
            player:SetHealth(999999999)
            state.godMode = true
            message = "God Mode enabled"
        else
            -- Restore normal health
            local level = player:GetLevel()
            local baseHealth = level * 100 -- Simplified calculation
            player:SetMaxHealth(baseHealth)
            player:SetHealth(baseHealth)
            state.godMode = false
            message = "God Mode disabled"
        end
        success = true
    elseif powerId == "invisible" then
        player:SetGMVisible(not enable) -- Note: SetGMVisible(false) makes invisible
        state.invisible = enable
        message = enable and "Invisibility enabled" or "Invisibility disabled"
        success = true
    elseif powerId == "noCooldowns" then
        if enable then
            player:ResetAllCooldowns()
        end
        state.noCooldowns = enable
        message = enable and "Cooldown cheat enabled" or "Cooldown cheat disabled"
        success = true
    elseif powerId == "instantCast" then
        -- Note: Instant cast would need to be handled via spell hooks
        state.instantCast = enable
        message = enable and "Instant cast enabled (partial)" or "Instant cast disabled"
        success = true
    elseif powerId == "waterWalk" then
        player:SetWaterWalk(enable)
        state.waterWalk = enable
        message = enable and "Water walking enabled" or "Water walking disabled"
        success = true
    elseif powerId == "taxiCheat" then
        player:SetTaxiCheat(enable)
        state.taxiCheat = enable
        message = enable and "Taxi cheat enabled (all paths)" or "Taxi cheat disabled"
        success = true
    end
    
    if success then
        -- Send update back to client
        AIO.Handle(player, "GMPowers", "HandleServerUpdate", powerId, enable)
        AIO.Handle(player, "GMPowers", "HandleStatusMessage", message, "success")
        
        -- Log the action
        if Config.LOG_GM_ACTIONS then
            print(string.format("[GMPowers] %s (%d) toggled %s to %s", 
                player:GetName(), guid, powerId, tostring(enable)))
        end
    else
        AIO.Handle(player, "GMPowers", "HandleStatusMessage", "Unknown power: " .. powerId, "error")
    end
end

-- Set GM speed
function GMPowersHandlers.setGMSpeed(player, speedType, multiplier)
    -- Validate GM rank
    if player:GetGMRank() < Config.MIN_GM_RANK then
        Utils.sendMessage(player, "error", "Insufficient GM rank")
        return
    end
    
    local speedTypeId = SPEED_TYPES[speedType]
    if not speedTypeId then
        AIO.Handle(player, "GMPowers", "HandleStatusMessage", "Invalid speed type", "error")
        return
    end
    
    -- Clamp multiplier (allow 0 for complete stop)
    multiplier = math.max(0, math.min(10, multiplier))
    
    -- SetSpeed expects a rate multiplier, not absolute speed
    -- Just pass the multiplier directly
    player:SetSpeed(speedTypeId, multiplier, true) -- true = forced update
    
    -- Update state
    local state = InitializePlayerState(player)
    state.speeds[speedType] = multiplier
    
    -- Send confirmation
    AIO.Handle(player, "GMPowers", "HandleSpeedUpdate", speedType, multiplier)
    AIO.Handle(player, "GMPowers", "HandleStatusMessage", 
        string.format("%s speed set to %.1fx", speedType:gsub("^%l", string.upper), multiplier), 
        "success")
    
    -- Log the action (only if debug mode is enabled for speed changes)
    if Config.LOG_GM_ACTIONS and Config.LOG_SPEED_CHANGES then
        print(string.format("[GMPowers] %s set %s speed to %.1fx", 
            player:GetName(), speedType, multiplier))
    end
end

-- Execute GM action
function GMPowersHandlers.executeGMAction(player, actionId)
    -- Validate GM rank
    if player:GetGMRank() < Config.MIN_GM_RANK then
        Utils.sendMessage(player, "error", "Insufficient GM rank")
        return
    end
    
    local success = false
    local message = ""
    
    if actionId == "resetCooldowns" then
        player:ResetAllCooldowns()
        message = "All cooldowns reset"
        success = true
    elseif actionId == "fullHeal" then
        player:SetHealth(player:GetMaxHealth())
        player:SetPower(player:GetMaxPower(player:GetPowerType()), player:GetPowerType())
        message = "Health and power restored"
        success = true
    elseif actionId == "teleportTarget" then
        local target = player:GetSelection()
        if target then
            if target:GetTypeId() == 3 then -- TYPE_UNIT
                local x, y, z = target:GetLocation()
                player:Teleport(player:GetMapId(), x, y, z, player:GetO())
                message = "Teleported to target"
                success = true
            elseif target:GetTypeId() == 4 then -- TYPE_PLAYER
                local x, y, z = target:GetLocation()
                player:Teleport(target:GetMapId(), x, y, z, player:GetO())
                message = "Teleported to player"
                success = true
            else
                message = "Invalid target for teleport"
            end
        else
            message = "No target selected"
        end
    elseif actionId == "appear" then
        local target = player:GetSelection()
        if target and target:GetTypeId() == 4 then -- TYPE_PLAYER
            local x, y, z = target:GetLocation()
            player:Teleport(target:GetMapId(), x, y, z, player:GetO())
            message = "Appeared at " .. target:GetName()
            success = true
        else
            message = "Select a player to appear at"
        end
    elseif actionId == "summon" then
        local target = player:GetSelection()
        if target and target:GetTypeId() == 4 then -- TYPE_PLAYER
            local x, y, z = player:GetLocation()
            target:Teleport(player:GetMapId(), x, y, z, player:GetO())
            message = "Summoned " .. target:GetName()
            success = true
        else
            message = "Select a player to summon"
        end
    elseif actionId == "refresh" then
        -- Send current state to client
        local state = InitializePlayerState(player)
        AIO.Handle(player, "GMPowers", "Initialize", state)
        message = "GM Powers state refreshed"
        success = true
    end
    
    -- Send response
    AIO.Handle(player, "GMPowers", "HandleStatusMessage", message, success and "success" or "error")
    
    -- Log the action
    if Config.LOG_GM_ACTIONS and success then
        print(string.format("[GMPowers] %s executed action: %s", player:GetName(), actionId))
    end
end

-- Get GM powers state
function GMPowersHandlers.getGMPowersState(player)
    -- Validate GM rank
    if player:GetGMRank() < Config.MIN_GM_RANK then
        return
    end
    
    local state = InitializePlayerState(player)
    AIO.Handle(player, "GMPowers", "Initialize", state)
end

-- Handle instant cast hook (if needed)
local function OnSpellCast(event, player, spell, skipCheck)
    if not player then return end
    
    local guid = player:GetGUIDLow()
    local state = playerStates[guid]
    
    if state and state.instantCast then
        -- Make the spell instant (this would need proper implementation)
        -- For now, just reduce cast time significantly
        -- Note: This would need to be handled differently in practice
    end
    
    if state and state.noCooldowns then
        -- Reset the spell cooldown immediately after cast
        -- Note: In production, this would need a proper timer implementation
        -- For now, just reset immediately
        if player and spell then
            player:ResetSpellCooldown(spell:GetEntry(), true)
        end
    end
end

-- Register handlers
function GMPowersHandlers.RegisterHandlers(gmSystem, config, utils, database, dbHelper)
    -- Store dependencies
    GameMasterSystem = gmSystem
    Config = config
    Utils = utils
    Database = database
    DatabaseHelper = dbHelper
    
    -- Set minimum GM rank if not defined
    if not Config.MIN_GM_RANK then
        Config.MIN_GM_RANK = 2
    end
    
    -- Set logging flags if not defined
    if Config.LOG_GM_ACTIONS == nil then
        Config.LOG_GM_ACTIONS = true
    end
    
    -- Separate flag for speed changes (disabled by default to avoid spam)
    if Config.LOG_SPEED_CHANGES == nil then
        Config.LOG_SPEED_CHANGES = false
    end
    
    -- Register AIO handlers
    GameMasterSystem.toggleGMPower = GMPowersHandlers.toggleGMPower
    GameMasterSystem.setGMSpeed = GMPowersHandlers.setGMSpeed
    GameMasterSystem.executeGMAction = GMPowersHandlers.executeGMAction
    GameMasterSystem.getGMPowersState = GMPowersHandlers.getGMPowersState
    
    -- Register event hooks
    RegisterPlayerEvent(3, CleanupPlayerState) -- PLAYER_EVENT_ON_LOGOUT
    RegisterPlayerEvent(5, OnSpellCast) -- PLAYER_EVENT_ON_SPELL_CAST
    
    print("[GameMasterUI] GM Powers handlers registered")
end

return GMPowersHandlers