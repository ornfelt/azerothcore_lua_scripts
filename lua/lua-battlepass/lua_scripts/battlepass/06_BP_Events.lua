--[[
    Battle Pass System - Events Module
    Game event hooks that trigger Battle Pass progression.
]]

-- ============================================================================
-- Namespace
-- ============================================================================

BattlePass = BattlePass or {}
BattlePass.Events = BattlePass.Events or {}

-- ============================================================================
-- Player Events
-- ============================================================================

local function OnPlayerLogin(event, player)
    if not BattlePass.IsEnabled() then
        return
    end

    BattlePass.Debug("Player login: " .. player:GetName())

    local data = BattlePass.DB.GetOrCreatePlayerData(player)

    local guid = player:GetGUIDLow()
    if BattlePass.DB.IsDailyLoginAvailable(guid) then
        local exp, levels = BattlePass.Progress.AwardFromSource(player, "LOGIN_DAILY", 0)

        if exp > 0 then
            BattlePass.DB.UpdateDailyLogin(guid)

            player:SendBroadcastMessage(
                "|cff00ff00[Battle Pass]|r Daily login bonus!")
        end
    end

    local unclaimedCount = BattlePass.Progress.CountUnclaimedRewards(player)
    if unclaimedCount > 0 then
        player:SendBroadcastMessage(string.format(
            "|cffff8000[Battle Pass]|r You have %d unclaimed reward(s)! Use |cff00ff00.bp|r",
            unclaimedCount))
    end
end

local function OnPlayerLogout(event, player)
    if not BattlePass.IsEnabled() then
        return
    end

    BattlePass.Debug("Player logout: " .. player:GetName())

    BattlePass.DB.SaveIfDirty(player)

    local guid = player:GetGUIDLow()
    BattlePass.DB.ClearFromCache(guid)
end

local function OnCreatureKill(event, player, creature)
    if not BattlePass.IsEnabled() then
        return
    end

    local creatureId = creature:GetEntry()
    local rank = creature:GetRank() -- 0=normal, 1=elite, 2=rare elite, 3=boss

    BattlePass.Debug(string.format("Creature kill: %s (entry: %d, rank: %d)",
        creature:GetName(), creatureId, rank))

    local sourceType = "KILL_CREATURE"

    if rank >= 3 then
        sourceType = "KILL_BOSS"
    elseif rank >= 1 then
        sourceType = "KILL_ELITE"
    end

    -- Try specific ID first, then generic
    local exp = BattlePass.Progress.CalculateExp(player, sourceType, creatureId)
    if exp == 0 then
        exp = BattlePass.Progress.CalculateExp(player, sourceType, 0)
    end

    if exp > 0 then
        BattlePass.Progress.AwardExp(player, exp, sourceType)
    end
end

local function OnQuestComplete(event, player, quest)
    if not BattlePass.IsEnabled() then
        return
    end

    local questId = quest:GetId()
    local isDaily = quest:IsDailyQuest()

    BattlePass.Debug(string.format("Quest complete: %d (daily: %s)",
        questId, tostring(isDaily)))

    local sourceType = isDaily and "COMPLETE_DAILY" or "COMPLETE_QUEST"

    -- Try specific ID first, then generic
    local exp = BattlePass.Progress.CalculateExp(player, sourceType, questId)
    if exp == 0 then
        exp = BattlePass.Progress.CalculateExp(player, sourceType, 0)
    end

    if exp > 0 then
        BattlePass.Progress.AwardExp(player, exp, sourceType)
    end
end

local function OnPlayerLevelChange(event, player, oldLevel)
    if not BattlePass.IsEnabled() then
        return
    end

    local newLevel = player:GetLevel()

    -- Only for level gains, not reductions
    if newLevel > oldLevel then
        BattlePass.Debug(string.format("Player level up: %s (%d -> %d)",
            player:GetName(), oldLevel, newLevel))

        BattlePass.Progress.AwardFromSource(player, "PLAYER_LEVELUP", 0)
    end
end

-- ============================================================================
-- PvP Events
-- ============================================================================

local function OnHonorableKill(event, player, victim)
    if not BattlePass.IsEnabled() then
        return
    end

    if not victim or not victim:IsPlayer() then
        return
    end

    BattlePass.Debug("Honorable kill by " .. player:GetName())

    BattlePass.Progress.AwardFromSource(player, "HONOR_KILL", 0)
end

-- ============================================================================
-- Battleground Events (Hook: BG_EVENT_ON_END)
-- ============================================================================

local function OnBattlegroundEndHook(event, bg, bgId, instanceId, winner)
    if not BattlePass.IsEnabled() then
        return
    end

    BattlePass.Debug(string.format("Battleground ended: bgId=%d, winner=%d", bgId or 0, winner or -1))

    local players = bg:GetPlayers()
    if not players then
        BattlePass.Debug("No players found in BG")
        return
    end

    for _, player in pairs(players) do
        if player and player:IsInWorld() then
            local team = player:GetTeam()
            local isWinner = (winner == team)
            local sourceType = isWinner and "WIN_BATTLEGROUND" or "LOSE_BATTLEGROUND"
            BattlePass.Debug(string.format("BG reward for %s: %s", player:GetName(), sourceType))
            BattlePass.Progress.AwardFromSource(player, sourceType, bgId)
        end
    end
end

-- Legacy function for manual calls
function BattlePass.Events.OnBattlegroundEnd(player, isWinner)
    if not BattlePass.IsEnabled() then
        return
    end

    local sourceType = isWinner and "WIN_BATTLEGROUND" or "LOSE_BATTLEGROUND"
    BattlePass.Debug("Battleground end for " .. player:GetName() .. " (win: " .. tostring(isWinner) .. ")")

    BattlePass.Progress.AwardFromSource(player, sourceType, 0)
end

-- ============================================================================
-- Custom Events
-- ============================================================================

-- Awards custom XP (for admin commands or scripts)
function BattlePass.Events.AwardCustomExp(player, amount, reason)
    if not BattlePass.IsEnabled() then
        return
    end

    BattlePass.Progress.AwardExp(player, amount, reason or "CUSTOM")
end

-- ============================================================================
-- Server Events
-- ============================================================================

local function OnServerShutdown(event)
    BattlePass.Info("Server shutdown - saving all Battle Pass data...")
    BattlePass.DB.SaveAllCached()
end

-- ============================================================================
-- Hook Registration
-- ============================================================================

RegisterPlayerEvent(3, OnPlayerLogin)      -- PLAYER_EVENT_ON_LOGIN
RegisterPlayerEvent(4, OnPlayerLogout)     -- PLAYER_EVENT_ON_LOGOUT
RegisterPlayerEvent(7, OnCreatureKill)     -- PLAYER_EVENT_ON_KILL_CREATURE
RegisterPlayerEvent(54, OnQuestComplete)    -- PLAYER_EVENT_ON_QUEST_COMPLETE
RegisterPlayerEvent(13, OnPlayerLevelChange) -- PLAYER_EVENT_ON_LEVEL_CHANGE

RegisterPlayerEvent(6, OnHonorableKill)   -- PLAYER_EVENT_ON_KILL_PLAYER

RegisterServerEvent(15, OnServerShutdown)  -- WORLD_EVENT_ON_SHUTDOWN
RegisterBGEvent(2, OnBattlegroundEndHook)       -- BG_EVENT_ON_END

BattlePass.Info("Event hooks registered")
