--[[
    Battle Pass System - Communication Module
    BP_Communication.lua

    Server -> Client communication protocol using CSMH.
    Uses SendServerResponse via addon messages.
]]

-- Require CSMH Server Message Handler
require("lib.CSMH.CSMH_SMH")

-- Namespace
BattlePass = BattlePass or {}
BattlePass.Communication = BattlePass.Communication or {}

-- CSMH Configuration
local CSMHConfig = {
    Prefix = "BattlePass",
    Functions = {
        [1] = "OnSyncRequest",
        [2] = "OnClaimRequest",
        [3] = "OnClaimAllRequest",
    }
}

-- ============================================================================
-- CSMH Request Handlers (Client -> Server)
-- ============================================================================

-- Handler for sync request (function ID 1)
function OnSyncRequest(player, args)
    BattlePass.Communication.FullSync(player)
end

-- Handler for claim request (function ID 2)
-- Receives: { level }
function OnClaimRequest(player, args)
    if not args or #args < 1 then
        BattlePass.Communication.SendError(player, "INVALID", "Invalid claim request")
        return
    end

    local level = tonumber(args[1])
    if not level then
        BattlePass.Communication.SendError(player, "INVALID", "Invalid level")
        return
    end

    BattlePass.Rewards.ClaimReward(player, level)
end

-- Handler for claim all request (function ID 3)
function OnClaimAllRequest(player, args)
    BattlePass.Rewards.ClaimAllRewards(player)
end

-- ============================================================================
-- Server -> Client Response Functions
-- ============================================================================

-- Sends complete progression data to the player (function ID 1)
-- Sends: level, currentExp, expRequired, totalExp, maxLevel, claimedLevels (table), config (table)
function BattlePass.Communication.SendSync(player)
    local guid = player:GetGUIDLow()

    BattlePass.PlayerCache[guid] = nil

    local status = BattlePass.Progress.GetPlayerStatus(player)

    -- Build claimed levels as a proper table {[1]=true, [5]=true, ...}
    local claimedTable = {}
    if status.claimed_levels and status.claimed_levels ~= "" then
        for levelStr in string.gmatch(status.claimed_levels, "[^,]+") do
            local lvl = tonumber(levelStr)
            if lvl then
                claimedTable[lvl] = true
            end
        end
    end

    -- Build config table
    local configTable = {
        max_level = BattlePass.GetConfigNumber("max_level", 100),
        exp_per_level = BattlePass.GetConfigNumber("exp_per_level", 1000),
        exp_scaling = BattlePass.GetConfigNumber("exp_scaling", 1.0),
    }

    -- Send via CSMH (function ID 1: OnFullSync)
    player:SendServerResponse(CSMHConfig.Prefix, 1,
        status.level,
        status.current_exp,
        status.exp_required,
        status.total_exp,
        status.max_level,
        claimedTable,
        configTable
    )

    BattlePass.Debug("Sent sync to " .. player:GetName())
end

-- Sends level definitions to the player (function ID 2)
-- Sends: { levels = { {level, name, icon, rewardType, count, status}, ... } }
function BattlePass.Communication.SendLevelDefinitions(player)
    local maxLevel = BattlePass.GetConfigNumber("max_level", 100)
    local guid = player:GetGUIDLow()
    local playerData = BattlePass.DB.GetOrCreatePlayerData(player)

    local levelsTable = {}

    for level = 1, maxLevel do
        if BattlePass.LevelCache[level] then
            local lvl = BattlePass.LevelCache[level]

            -- Determine status: 0=locked, 1=available, 2=claimed, 3=owned
            local status = 0
            if lvl.level > playerData.current_level then
                status = 0  -- Locked
            elseif BattlePass.DB.IsLevelClaimed(guid, lvl.level) then
                status = 2  -- Claimed
            elseif BattlePass.Rewards and BattlePass.Rewards.PlayerOwnsReward and
                   BattlePass.Rewards.PlayerOwnsReward(player, lvl) then
                status = 3  -- Already owns reward
            else
                status = 1  -- Available to claim
            end

            table.insert(levelsTable, {
                level = lvl.level,
                name = lvl.reward_name or "Unknown",
                icon = lvl.reward_icon or "INV_Misc_QuestionMark",
                rewardType = lvl.reward_type,
                count = lvl.reward_count,
                status = status,
            })
        end
    end

    -- Send via CSMH (function ID 2: OnLevelDefinitions)
    player:SendServerResponse(CSMHConfig.Prefix, 2, levelsTable)

    BattlePass.Debug("Sent level definitions to " .. player:GetName())
end

-- Sends a progression update after XP gain (function ID 3)
-- Sends: gainedExp, newLevel, currentExp, expRequired, levelsGained
function BattlePass.Communication.SendProgressUpdate(player, gainedExp, levelsGained)
    local status = BattlePass.Progress.GetPlayerStatus(player)

    -- Send via CSMH (function ID 3: OnProgressUpdate)
    player:SendServerResponse(CSMHConfig.Prefix, 3,
        gainedExp,
        status.level,
        status.current_exp,
        status.exp_required,
        levelsGained
    )

    BattlePass.Debug("Sent progress update to " .. player:GetName())
end

-- Sends a claim confirmation (function ID 4)
-- Sends: success, level, message, updatedLevels (optional)
function BattlePass.Communication.SendClaimConfirmation(player, level, success, message)
    success = success ~= false  -- Default to true
    message = message or "Reward claimed!"

    -- Get updated level status for this level
    local updatedLevels = {}
    local lvl = BattlePass.LevelCache[level]
    if lvl then
        local guid = player:GetGUIDLow()
        local status = 2  -- Claimed

        table.insert(updatedLevels, {
            level = level,
            status = status,
        })
    end

    -- Send via CSMH (function ID 4: OnClaimResult)
    player:SendServerResponse(CSMHConfig.Prefix, 4,
        success,
        level,
        message,
        updatedLevels
    )

    BattlePass.Debug("Sent claim confirmation to " .. player:GetName() .. " for level " .. level)
end

-- Sends an error message to the addon (function ID 5)
-- Sends: code, message
function BattlePass.Communication.SendError(player, code, message)
    -- Send via CSMH (function ID 5: OnError)
    player:SendServerResponse(CSMHConfig.Prefix, 5,
        code or "UNKNOWN",
        message or "Unknown error"
    )

    BattlePass.Debug("Sent error to " .. player:GetName() .. ": " .. (message or code))
end

-- ============================================================================
-- High-Level Communication Functions
-- ============================================================================

-- Performs a full synchronization with the client
function BattlePass.Communication.FullSync(player)
    if not BattlePass.IsEnabled() then
        BattlePass.Communication.SendError(player, "DISABLED", "Battle Pass is disabled")
        return
    end

    BattlePass.Debug("Full sync for " .. player:GetName())

    -- Send level definitions first, then sync data
    BattlePass.Communication.SendLevelDefinitions(player)
    BattlePass.Communication.SendSync(player)
end

-- Register CSMH client request handlers
RegisterClientRequests(CSMHConfig)

BattlePass.Debug("CSMH Communication module loaded")
