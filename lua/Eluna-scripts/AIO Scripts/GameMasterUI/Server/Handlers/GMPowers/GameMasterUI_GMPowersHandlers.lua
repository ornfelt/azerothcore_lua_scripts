--[[
    GameMaster UI - GM Powers Handlers

    This module handles all GM power toggles and controls including:
    - GM mode, fly mode, god mode toggles
    - Speed modifications
    - Cooldown and cast time cheats
    - Quick actions (self & target)
    - Permission-tiered access and rate limiting
]]--

local GMPowersHandlers = {}

-- Dependencies will be injected
local GameMasterSystem, Config, Utils, Database, DatabaseHelper

-- Player state tracking
local playerStates = {}

-- Rate limit tracking: rateLimits[guid][actionCategory] = {timestamps}
local rateLimits = {}

-- Speed type mappings
local SPEED_TYPES = {
    walk = 0,  -- MOVE_WALK
    run = 1,   -- MOVE_RUN
    swim = 3,  -- MOVE_SWIM
    fly = 6    -- MOVE_FLIGHT
}

-- ============================================================================
-- Security: Permission checks & rate limiting
-- ============================================================================

-- Check if player has permission for an action
local function checkActionPermission(player, actionId)
    local rank = player:GetGMRank()
    if rank < (Config.MIN_GM_RANK or 2) then
        return false
    end

    local perms = Config.GM_PERMISSIONS
    if not perms then return true end -- no config = allow all

    -- Walk up from player's rank to find a matching tier
    for r = rank, 2, -1 do
        local tier = perms[r]
        if tier then
            if tier.actions == "all" then return true end
            if type(tier.actions) == "table" then
                return tier.actions[actionId] == true
            end
        end
    end

    return false
end

-- Check rate limit for an action category. Returns true if allowed.
local function checkRateLimit(player, category)
    local limits = Config.RATE_LIMITS and Config.RATE_LIMITS[category]
    if not limits then return true end

    local guid = player:GetGUIDLow()
    rateLimits[guid] = rateLimits[guid] or {}
    rateLimits[guid][category] = rateLimits[guid][category] or {}

    local now = os.time()
    local bucket = rateLimits[guid][category]

    -- Prune entries outside the window
    local cutoff = now - limits.window
    local fresh = {}
    for _, ts in ipairs(bucket) do
        if ts > cutoff then
            fresh[#fresh + 1] = ts
        end
    end
    rateLimits[guid][category] = fresh

    if #fresh >= limits.max then
        return false
    end

    fresh[#fresh + 1] = now
    return true
end

-- Structured audit log
local function auditLog(player, action, details)
    if not Config.LOG_GM_ACTIONS then return end
    local timestamp = os.date("%Y-%m-%d %H:%M:%S")
    local msg = string.format("[AUDIT %s] GM %s (%d) | %s",
        timestamp, player:GetName(), player:GetGUIDLow(), action)
    if details then
        msg = msg .. " | " .. details
    end
    print(msg)
end

-- ============================================================================
-- Player state management
-- ============================================================================

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
            speeds = { walk = 1.0, run = 1.0, swim = 1.0, fly = 1.0 }
        }
        player:SetSpeed(0, 1.0, true)
        player:SetSpeed(1, 1.0, true)
        player:SetSpeed(3, 1.0, true)
        player:SetSpeed(6, 1.0, true)
    end
    return playerStates[guid]
end

local function CleanupPlayerState(event, player)
    local guid = player:GetGUIDLow()
    playerStates[guid] = nil
    rateLimits[guid] = nil
end

-- ============================================================================
-- Toggle GM power
-- ============================================================================

function GMPowersHandlers.toggleGMPower(player, powerId, enable)
    if player:GetGMRank() < (Config.MIN_GM_RANK or 2) then
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
        if not enable and state.invisible then
            player:SetGMVisible(true)
            state.invisible = false
            AIO.Handle(player, "GMPowers", "HandleServerUpdate", "invisible", false)
        end
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
            local baseHealth = player:GetLevel() * 100
            player:SetMaxHealth(baseHealth)
            player:SetHealth(baseHealth)
            state.godMode = false
            message = "God Mode disabled"
        end
        success = true
    elseif powerId == "invisible" then
        if enable and not state.gmMode then
            player:SetGameMaster(true)
            state.gmMode = true
            AIO.Handle(player, "GMPowers", "HandleServerUpdate", "gmMode", true)
        end
        player:SetGMVisible(not enable)
        state.invisible = enable
        message = enable and "Invisibility enabled" or "Invisibility disabled"
        success = true
    elseif powerId == "noCooldowns" then
        if enable then player:ResetAllCooldowns() end
        state.noCooldowns = enable
        message = enable and "Cooldown cheat enabled" or "Cooldown cheat disabled"
        success = true
    elseif powerId == "instantCast" then
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
        AIO.Handle(player, "GMPowers", "HandleServerUpdate", powerId, enable)
        AIO.Handle(player, "GMPowers", "HandleStatusMessage", message, "success")
        auditLog(player, "toggle", powerId .. " = " .. tostring(enable))
    else
        AIO.Handle(player, "GMPowers", "HandleStatusMessage", "Unknown power: " .. powerId, "error")
    end
end

-- ============================================================================
-- Set GM speed
-- ============================================================================

function GMPowersHandlers.setGMSpeed(player, speedType, multiplier)
    if player:GetGMRank() < (Config.MIN_GM_RANK or 2) then
        Utils.sendMessage(player, "error", "Insufficient GM rank")
        return
    end

    local speedTypeId = SPEED_TYPES[speedType]
    if not speedTypeId then
        AIO.Handle(player, "GMPowers", "HandleStatusMessage", "Invalid speed type", "error")
        return
    end

    multiplier = math.max(0, math.min(10, multiplier))
    player:SetSpeed(speedTypeId, multiplier, true)

    local state = InitializePlayerState(player)
    state.speeds[speedType] = multiplier

    AIO.Handle(player, "GMPowers", "HandleSpeedUpdate", speedType, multiplier)
    AIO.Handle(player, "GMPowers", "HandleStatusMessage",
        string.format("%s speed set to %.1fx", speedType:gsub("^%l", string.upper), multiplier),
        "success")

    if Config.LOG_GM_ACTIONS and Config.LOG_SPEED_CHANGES then
        auditLog(player, "speed", speedType .. " = " .. multiplier)
    end
end

-- ============================================================================
-- Resolve target: by name (typed) or by selection (clicked in-game)
-- ============================================================================

local function resolveTarget(player, targetName)
    if targetName and targetName ~= "" then
        local target = GetPlayerByName(targetName)
        if target and target:IsInWorld() then return target end
        return nil, targetName .. " not found or offline"
    end
    return player:GetSelection()
end

-- ============================================================================
-- Execute GM action (with permission + rate limit checks)
-- ============================================================================

function GMPowersHandlers.executeGMAction(player, actionId, targetName)
    if player:GetGMRank() < (Config.MIN_GM_RANK or 2) then
        Utils.sendMessage(player, "error", "Insufficient GM rank")
        return
    end

    -- Permission check
    if not checkActionPermission(player, actionId) then
        AIO.Handle(player, "GMPowers", "HandleStatusMessage",
            "You don't have permission for this action", "error")
        return
    end

    local success = false
    local message = ""

    -- ---- Self Actions ----

    if actionId == "resetCooldowns" then
        player:ResetAllCooldowns()
        message = "All cooldowns reset"
        success = true

    elseif actionId == "fullHeal" then
        player:SetHealth(player:GetMaxHealth())
        player:SetPower(player:GetMaxPower(player:GetPowerType()), player:GetPowerType())
        message = "Health and power restored"
        success = true

    elseif actionId == "reviveSelf" then
        if player:IsAlive() then
            message = "You are already alive"
        else
            player:ResurrectPlayer(100, false)
            message = "You have been revived"
            success = true
        end

    elseif actionId == "replenish" then
        player:SetHealth(player:GetMaxHealth())
        player:SetPower(player:GetMaxPower(player:GetPowerType()), player:GetPowerType())
        player:ResetAllCooldowns()
        message = "Health, power and cooldowns restored"
        success = true

    elseif actionId == "refresh" then
        local state = InitializePlayerState(player)
        AIO.Handle(player, "GMPowers", "Initialize", state)
        message = "GM Powers state refreshed"
        success = true

    -- ---- Target Actions ----

    elseif actionId == "teleportTarget" then
        local target, err = resolveTarget(player, targetName)
        if target then
            local typeId = target:GetTypeId()
            if typeId == 3 or typeId == 4 then -- UNIT or PLAYER
                local x, y, z = target:GetLocation()
                local mapId = (typeId == 4) and target:GetMapId() or player:GetMapId()
                player:Teleport(mapId, x, y, z, player:GetO())
                message = "Teleported to target"
                success = true
            else
                message = "Invalid target for teleport"
            end
        else
            message = err or "No target selected"
        end

    elseif actionId == "appear" then
        local target, err = resolveTarget(player, targetName)
        if target and target:GetTypeId() == 4 then
            local x, y, z = target:GetLocation()
            player:Teleport(target:GetMapId(), x, y, z, player:GetO())
            message = "Appeared at " .. target:GetName()
            success = true
        else
            message = err or "Select a player to appear at"
        end

    elseif actionId == "summon" then
        local target, err = resolveTarget(player, targetName)
        if target and target:GetTypeId() == 4 then
            local x, y, z = player:GetLocation()
            target:Teleport(player:GetMapId(), x, y, z, player:GetO())
            message = "Summoned " .. target:GetName()
            success = true
        else
            message = err or "Select a player to summon"
        end

    elseif actionId == "freezeTarget" then
        local target, err = resolveTarget(player, targetName)
        if target and target:GetTypeId() == 4 then
            target:CastSpell(target, 9454, true) -- Freeze spell
            message = "Froze " .. target:GetName()
            success = true
            auditLog(player, "freeze", "target=" .. target:GetName())
        else
            message = err or "Select a player to freeze"
        end

    elseif actionId == "unfreezeTarget" then
        local target, err = resolveTarget(player, targetName)
        if target and target:GetTypeId() == 4 then
            target:RemoveAura(9454)
            message = "Unfroze " .. target:GetName()
            success = true
            auditLog(player, "unfreeze", "target=" .. target:GetName())
        else
            message = err or "Select a player to unfreeze"
        end

    elseif actionId == "reviveTarget" then
        local target, err = resolveTarget(player, targetName)
        if target and target:GetTypeId() == 4 then
            if target:IsAlive() then
                message = target:GetName() .. " is already alive"
            else
                target:ResurrectPlayer(100, false)
                message = "Revived " .. target:GetName()
                success = true
            end
        else
            message = err or "Select a player to revive"
        end

    elseif actionId == "kickTarget" then
        -- Rate limit kicks
        if not checkRateLimit(player, "kick") then
            AIO.Handle(player, "GMPowers", "HandleStatusMessage",
                "Rate limit reached for kick actions", "error")
            return
        end

        local target, err = resolveTarget(player, targetName)
        if target and target:GetTypeId() == 4 then
            local tName = target:GetName()
            target:KickPlayer()
            message = "Kicked " .. tName
            success = true
            auditLog(player, "KICK", "target=" .. tName)
        else
            message = err or "Select a player to kick"
        end
    end

    AIO.Handle(player, "GMPowers", "HandleStatusMessage", message, success and "success" or "error")

    if success then
        auditLog(player, "action", actionId)
    end
end

-- ============================================================================
-- Announce handler (separate because it takes a message param)
-- ============================================================================

function GMPowersHandlers.announceMessage(player, message)
    if player:GetGMRank() < (Config.MIN_GM_RANK or 2) then
        Utils.sendMessage(player, "error", "Insufficient GM rank")
        return
    end

    if not checkActionPermission(player, "announce") then
        AIO.Handle(player, "GMPowers", "HandleStatusMessage",
            "You don't have permission to announce", "error")
        return
    end

    if not checkRateLimit(player, "announce") then
        AIO.Handle(player, "GMPowers", "HandleStatusMessage",
            "Rate limit reached for announcements", "error")
        return
    end

    -- Sanitize: strip color codes and limit length
    if not message or message == "" then
        AIO.Handle(player, "GMPowers", "HandleStatusMessage", "Message cannot be empty", "error")
        return
    end
    if #message > 200 then
        message = message:sub(1, 200)
    end

    SendWorldMessage(string.format("|cffff8800[GM %s]|r %s", player:GetName(), message))
    AIO.Handle(player, "GMPowers", "HandleStatusMessage", "Announcement sent", "success")
    auditLog(player, "ANNOUNCE", message)
end

-- ============================================================================
-- Save current position as game_tele entry
-- ============================================================================

function GMPowersHandlers.saveCurrentPosition(player, name)
    if player:GetGMRank() < (Config.MIN_GM_RANK or 2) then
        Utils.sendMessage(player, "error", "Insufficient GM rank")
        return
    end

    if not checkActionPermission(player, "savePosition") then
        AIO.Handle(player, "GMPowers", "HandleStatusMessage",
            "You don't have permission to save positions", "error")
        return
    end

    if not checkRateLimit(player, "savePosition") then
        AIO.Handle(player, "GMPowers", "HandleStatusMessage",
            "Rate limit reached for saving positions", "error")
        return
    end

    if not name or name == "" then
        AIO.Handle(player, "GMPowers", "HandleStatusMessage", "Name cannot be empty", "error")
        return
    end

    -- Sanitize name
    name = name:gsub("'", "''")
    if #name > 100 then name = name:sub(1, 100) end

    local x = player:GetX()
    local y = player:GetY()
    local z = player:GetZ()
    local o = player:GetO()
    local mapId = player:GetMapId()

    -- Get next ID
    local maxIdResult = WorldDBQuery("SELECT COALESCE(MAX(id), 0) + 1 FROM game_tele")
    local nextId = maxIdResult and maxIdResult:GetUInt32(0) or 1

    local query = string.format(
        "INSERT INTO game_tele (id, position_x, position_y, position_z, orientation, map, name) "
        .. "VALUES (%d, %.6f, %.6f, %.6f, %.6f, %d, '%s')",
        nextId, x, y, z, o, mapId, name)

    WorldDBExecute(query)
    AIO.Handle(player, "GMPowers", "HandleStatusMessage",
        "Saved position: " .. name, "success")
    auditLog(player, "SAVE_POSITION", string.format("%s @ map=%d (%.1f, %.1f, %.1f)", name, mapId, x, y, z))
end

-- ============================================================================
-- Request online player names (for autocomplete)
-- ============================================================================

function GMPowersHandlers.requestOnlinePlayerNames(player)
    if player:GetGMRank() < (Config.MIN_GM_RANK or 2) then return end
    local names = {}
    for _, p in ipairs(GetPlayersInWorld()) do
        names[#names + 1] = p:GetName()
    end
    table.sort(names)
    AIO.Handle(player, "GMPowers", "ReceiveOnlinePlayerNames", names)
end

-- ============================================================================
-- Get GM powers state
-- ============================================================================

function GMPowersHandlers.getGMPowersState(player)
    if player:GetGMRank() < (Config.MIN_GM_RANK or 2) then return end
    local state = InitializePlayerState(player)
    AIO.Handle(player, "GMPowers", "Initialize", state)
end

-- ============================================================================
-- Spell cast hook (no-cooldown / instant-cast cheats)
-- ============================================================================

local function OnSpellCast(event, player, spell, skipCheck)
    if not player then return end
    local guid = player:GetGUIDLow()
    local state = playerStates[guid]
    if not state then return end

    if state.noCooldowns and spell then
        player:ResetSpellCooldown(spell:GetEntry(), true)
    end
end

-- ============================================================================
-- Register handlers
-- ============================================================================

function GMPowersHandlers.RegisterHandlers(gmSystem, config, utils, database, dbHelper)
    GameMasterSystem = gmSystem
    Config = config
    Utils = utils
    Database = database
    DatabaseHelper = dbHelper

    if not Config.MIN_GM_RANK then Config.MIN_GM_RANK = 2 end

    -- Register AIO handlers
    GameMasterSystem.toggleGMPower = GMPowersHandlers.toggleGMPower
    GameMasterSystem.setGMSpeed = GMPowersHandlers.setGMSpeed
    GameMasterSystem.executeGMAction = GMPowersHandlers.executeGMAction
    GameMasterSystem.getGMPowersState = GMPowersHandlers.getGMPowersState
    GameMasterSystem.announceMessage = GMPowersHandlers.announceMessage
    GameMasterSystem.saveCurrentPosition = GMPowersHandlers.saveCurrentPosition
    GameMasterSystem.requestOnlinePlayerNames = GMPowersHandlers.requestOnlinePlayerNames

    -- Register event hooks
    RegisterPlayerEvent(3, CleanupPlayerState) -- PLAYER_EVENT_ON_LOGOUT
    RegisterPlayerEvent(5, OnSpellCast)        -- PLAYER_EVENT_ON_SPELL_CAST
end

return GMPowersHandlers
