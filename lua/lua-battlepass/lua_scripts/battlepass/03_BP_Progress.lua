--[[
    Battle Pass System - Progress Module
    BP_Progress.lua

    Handles progression: XP calculation, level-ups, progression sources.
]]

BattlePass = BattlePass or {}
BattlePass.Progress = BattlePass.Progress or {}

-- XP Required Per Level

function BattlePass.Progress.GetExpForLevel(level)
    if level <= 0 then
        return 0
    end

    -- Check for custom XP defined for this level
    local levelData = BattlePass.LevelCache[level]
    if levelData and levelData.exp_required > 0 then
        return levelData.exp_required
    end

    -- Use formula: base * scaling^(level-1)
    local baseExp = BattlePass.GetConfigNumber("exp_per_level", 1000)
    local scaling = BattlePass.GetConfigNumber("exp_scaling", 1.1)

    return math.floor(baseExp * math.pow(scaling, level - 1))
end

function BattlePass.Progress.GetTotalExpForLevel(level)
    local total = 0
    for i = 1, level do
        total = total + BattlePass.Progress.GetExpForLevel(i)
    end
    return total
end

-- XP Award

function BattlePass.Progress.AwardExp(player, amount, source)
    if not BattlePass.IsEnabled() then
        return 0, 0
    end

    if amount <= 0 then
        return 0, 0
    end

    local data = BattlePass.DB.GetOrCreatePlayerData(player)
    local maxLevel = BattlePass.GetConfigNumber("max_level", 100)

    if data.current_level >= maxLevel then
        BattlePass.Debug("Player already at max level, no XP awarded")
        return 0, 0
    end

    local oldLevel = data.current_level
    data.current_exp = data.current_exp + amount
    data.total_exp = data.total_exp + amount
    data.dirty = true

    BattlePass.Debug(string.format("Awarded %d XP to %s from %s (Current: %d)",
        amount, player:GetName(), source or "unknown", data.current_exp))

    -- Check for level-ups
    local levelsGained = 0
    while data.current_level < maxLevel do
        local expRequired = BattlePass.Progress.GetExpForLevel(data.current_level + 1)
        if data.current_exp >= expRequired then
            data.current_exp = data.current_exp - expRequired
            data.current_level = data.current_level + 1
            levelsGained = levelsGained + 1

            BattlePass.Info(string.format("%s reached Battle Pass level %d!",
                player:GetName(), data.current_level))
        else
            break
        end
    end

    -- Notify player
    if levelsGained > 0 then
        BattlePass.Progress.NotifyLevelUp(player, oldLevel, data.current_level)
    else
        BattlePass.Progress.NotifyExpGain(player, amount, data)
    end

    -- Send update to addon
    if BattlePass.Communication then
        BattlePass.Communication.SendProgressUpdate(player, amount, levelsGained)
    end

    -- Save to database immediately
    BattlePass.DB.SavePlayerProgress(player:GetGUIDLow(), data)

    return amount, levelsGained
end

-- Player Notifications

function BattlePass.Progress.NotifyExpGain(player, amount, data)
    local expRequired = BattlePass.Progress.GetExpForLevel(data.current_level + 1)
    local maxLevel = BattlePass.GetConfigNumber("max_level", 100)

    if data.current_level >= maxLevel then
        player:SendBroadcastMessage(string.format(
            "|cff00ff00[Battle Pass]|r +%d XP (MAX level reached)",
            amount))
    else
        player:SendBroadcastMessage(string.format(
            "|cff00ff00[Battle Pass]|r +%d XP (%d/%d for level %d)",
            amount, data.current_exp, expRequired, data.current_level + 1))
    end
end

function BattlePass.Progress.NotifyLevelUp(player, oldLevel, newLevel)
    local levelsGained = newLevel - oldLevel

    if levelsGained == 1 then
        player:SendBroadcastMessage(string.format(
            "|cffff8000[Battle Pass]|r Level %d reached! Use |cff00ff00.bp claim %d|r to claim your reward.",
            newLevel, newLevel))
    else
        player:SendBroadcastMessage(string.format(
            "|cffff8000[Battle Pass]|r %d levels gained! (Level %d -> %d)",
            levelsGained, oldLevel, newLevel))
        player:SendBroadcastMessage(
            "|cff00ff00[Battle Pass]|r Use |cff00ff00.bp|r to see your available rewards.")
    end

    -- Play level-up sound (optional)
    -- player:PlayDirectSound(888)
end

-- Progression Sources

function BattlePass.Progress.GetSourceConfig(sourceType, subtype)
    subtype = subtype or 0

    -- Look for specific source first
    if subtype > 0 then
        local specificKey = sourceType .. ":" .. subtype
        if BattlePass.SourceCache[specificKey] then
            return BattlePass.SourceCache[specificKey]
        end
    end

    -- Fall back to generic source
    return BattlePass.SourceCache[sourceType]
end

function BattlePass.Progress.CanReceiveExp(player, sourceConfig)
    if not sourceConfig or not sourceConfig.enabled then
        return false
    end

    local playerLevel = player:GetLevel()

    if sourceConfig.min_level and playerLevel < sourceConfig.min_level then
        return false
    end

    if sourceConfig.max_level and sourceConfig.max_level > 0 and playerLevel > sourceConfig.max_level then
        return false
    end

    return true
end

function BattlePass.Progress.CalculateExp(player, sourceType, subtype)
    local sourceConfig = BattlePass.Progress.GetSourceConfig(sourceType, subtype)

    if not sourceConfig then
        BattlePass.Debug("No source config for: " .. sourceType)
        return 0
    end

    if not BattlePass.Progress.CanReceiveExp(player, sourceConfig) then
        BattlePass.Debug("Player cannot receive XP from: " .. sourceType)
        return 0
    end

    local baseExp = sourceConfig.exp_value or 0
    local multiplier = sourceConfig.multiplier or 1.0

    return math.floor(baseExp * multiplier)
end

function BattlePass.Progress.AwardFromSource(player, sourceType, subtype)
    local exp = BattlePass.Progress.CalculateExp(player, sourceType, subtype)

    if exp > 0 then
        return BattlePass.Progress.AwardExp(player, exp, sourceType)
    end

    return 0, 0
end

-- Status Functions

function BattlePass.Progress.GetPlayerStatus(player)
    local data = BattlePass.DB.GetOrCreatePlayerData(player)
    local maxLevel = BattlePass.GetConfigNumber("max_level", 100)
    local expRequired = BattlePass.Progress.GetExpForLevel(data.current_level + 1)

    return {
        level = data.current_level,
        current_exp = data.current_exp,
        exp_required = expRequired,
        total_exp = data.total_exp,
        max_level = maxLevel,
        is_max_level = data.current_level >= maxLevel,
        claimed_levels = data.claimed_levels,
        progress_percent = data.current_level >= maxLevel and 100
            or math.floor((data.current_exp / expRequired) * 100)
    }
end

function BattlePass.Progress.CountUnclaimedRewards(player)
    local data = BattlePass.DB.GetOrCreatePlayerData(player)
    local count = 0

    for level = 1, data.current_level do
        if BattlePass.LevelCache[level] and not BattlePass.IsInCSV(data.claimed_levels, level) then
            count = count + 1
        end
    end

    return count
end

function BattlePass.Progress.GetAvailableRewards(player)
    local data = BattlePass.DB.GetOrCreatePlayerData(player)
    local rewards = {}

    for level = 1, data.current_level do
        if BattlePass.LevelCache[level] and not BattlePass.IsInCSV(data.claimed_levels, level) then
            table.insert(rewards, BattlePass.LevelCache[level])
        end
    end

    return rewards
end
