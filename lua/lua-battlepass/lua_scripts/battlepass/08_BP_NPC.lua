--[[
    Battle Pass System - NPC Module
    BP_NPC.lua

    NPC gossip interface for the Battle Pass.
    Allows players without addon to interact with the system.
]]

-- ============================================================================
-- Namespace
-- ============================================================================

BattlePass = BattlePass or {}
BattlePass.NPC = BattlePass.NPC or {}

-- ============================================================================
-- Gossip Constants
-- ============================================================================

-- Menu IDs
local MENU_MAIN = 1
local MENU_STATUS = 2
local MENU_REWARDS = 3
local MENU_PREVIEW = 4
local MENU_CLAIM_CONFIRM = 5

-- Option IDs
local OPT_STATUS = 1
local OPT_REWARDS = 2
local OPT_CLAIM_ALL = 3
local OPT_PREVIEW = 4
local OPT_SYNC = 5
local OPT_BACK = 100
local OPT_CLOSE = 101

-- Offset for individual claims (level + offset)
local CLAIM_OFFSET = 1000
local PREVIEW_OFFSET = 2000

-- ============================================================================
-- NPC Texts
-- ============================================================================

local NPC_TEXTS = {
    greeting = "Welcome, adventurer! I am the Battle Pass keeper. How can I help you?",
    status_header = "Your Battle Pass progression:",
    no_rewards = "You have no rewards available at the moment. Keep progressing!",
    rewards_header = "Here are your available rewards:",
    preview_header = "Preview of upcoming levels:",
    claim_success = "Congratulations! Reward claimed successfully.",
    claim_error = "Unable to claim this reward.",
    sync_done = "Data synchronized with your addon.",
    disabled = "The Battle Pass system is currently disabled.",
}

-- ============================================================================
-- Utility Functions
-- ============================================================================

local function GetNPCEntry()
    return BattlePass.GetConfigNumber("npc_entry", 90100)
end

local function FormatMoney(copper)
    local gold = math.floor(copper / 10000)
    local silver = math.floor((copper % 10000) / 100)
    local copperRem = copper % 100

    local parts = {}
    if gold > 0 then table.insert(parts, gold .. "g") end
    if silver > 0 then table.insert(parts, silver .. "s") end
    if copperRem > 0 then table.insert(parts, copperRem .. "c") end

    return table.concat(parts, " ")
end

-- ============================================================================
-- Gossip Menus
-- ============================================================================

local function ShowMainMenu(player, creature)
    if not BattlePass.IsEnabled() then
        player:GossipMenuAddItem(0, NPC_TEXTS.disabled, 0, OPT_CLOSE)
        player:GossipSendMenu(1, creature)
        return
    end

    local status = BattlePass.Progress.GetPlayerStatus(player)
    local unclaimed = BattlePass.Progress.CountUnclaimedRewards(player)

    player:GossipClearMenu()

    local statusText = string.format("[Level %d/%d] View my progression",
        status.level, status.max_level)
    player:GossipMenuAddItem(3, statusText, MENU_MAIN, OPT_STATUS)

    if unclaimed > 0 then
        local rewardsText = string.format("|cffff8000[%d] Available rewards|r", unclaimed)
        player:GossipMenuAddItem(4, rewardsText, MENU_MAIN, OPT_REWARDS)
    else
        player:GossipMenuAddItem(0, "Rewards (none available)", MENU_MAIN, OPT_REWARDS)
    end

    if unclaimed > 0 then
        player:GossipMenuAddItem(1, "|cff00ff00Claim all rewards|r", MENU_MAIN, OPT_CLAIM_ALL)
    end

    player:GossipMenuAddItem(2, "Preview upcoming levels", MENU_MAIN, OPT_PREVIEW)
    player:GossipMenuAddItem(6, "Sync with addon", MENU_MAIN, OPT_SYNC)

    player:GossipSendMenu(1, creature)
end

local function ShowStatusMenu(player, creature)
    local status = BattlePass.Progress.GetPlayerStatus(player)

    player:GossipClearMenu()

    player:SendBroadcastMessage("|cff00ff00========== Battle Pass Status ==========|r")
    player:SendBroadcastMessage(string.format("Level: |cffffd700%d|r / %d",
        status.level, status.max_level))

    if status.is_max_level then
        player:SendBroadcastMessage("Experience: |cff00ff00MAXIMUM LEVEL REACHED!|r")
    else
        player:SendBroadcastMessage(string.format("Experience: |cffffd700%d|r / %d (%d%%)",
            status.current_exp, status.exp_required, status.progress_percent))
    end

    player:SendBroadcastMessage(string.format("Total XP accumulated: |cff888888%d|r", status.total_exp))

    local unclaimed = BattlePass.Progress.CountUnclaimedRewards(player)
    if unclaimed > 0 then
        player:SendBroadcastMessage(string.format(
            "|cffff8000Pending rewards: %d|r", unclaimed))
    end

    player:SendBroadcastMessage("|cff00ff00==========================================|r")

    player:GossipMenuAddItem(0, "<< Back", MENU_STATUS, OPT_BACK)
    player:GossipSendMenu(1, creature)
end

local function ShowRewardsMenu(player, creature)
    local rewards = BattlePass.Progress.GetAvailableRewards(player)

    player:GossipClearMenu()

    if #rewards == 0 then
        player:GossipMenuAddItem(0, "No rewards available", MENU_REWARDS, OPT_BACK)
    else
        local maxShow = math.min(#rewards, 10)

        for i = 1, maxShow do
            local reward = rewards[i]
            local typeName = BattlePass.Rewards.GetRewardTypeName(reward.reward_type)

            local text = string.format("[Lvl %d] %s",
                reward.level, reward.reward_name)

            if reward.reward_type == 2 then -- Gold
                text = text .. " (" .. FormatMoney(reward.reward_count) .. ")"
            elseif reward.reward_type == 1 then -- Item
                text = text .. " x" .. reward.reward_count
            end

            player:GossipMenuAddItem(4, text, MENU_REWARDS, CLAIM_OFFSET + reward.level)
        end

        if #rewards > 10 then
            player:GossipMenuAddItem(0, string.format("... and %d more", #rewards - 10),
                MENU_REWARDS, OPT_BACK)
        end
    end

    player:GossipMenuAddItem(0, "<< Back", MENU_REWARDS, OPT_BACK)
    player:GossipSendMenu(1, creature)
end

local function ShowPreviewMenu(player, creature, startLevel)
    local status = BattlePass.Progress.GetPlayerStatus(player)
    startLevel = startLevel or (status.level + 1)

    local maxLevel = BattlePass.GetConfigNumber("max_level", 100)
    local endLevel = math.min(startLevel + 9, maxLevel)

    player:GossipClearMenu()

    for level = startLevel, endLevel do
        local levelData = BattlePass.LevelCache[level]
        if levelData then
            local expRequired = BattlePass.Progress.GetExpForLevel(level)
            local prefix = ""

            if level <= status.level then
                if BattlePass.DB.IsLevelClaimed(player:GetGUIDLow(), level) then
                    prefix = "|cff00ff00[OK]|r "
                else
                    prefix = "|cffff8000[!]|r "
                end
            else
                prefix = string.format("|cff888888[%d XP]|r ", expRequired)
            end

            local text = string.format("%sLvl %d: %s",
                prefix, level, levelData.reward_name)

            player:GossipMenuAddItem(0, text, MENU_PREVIEW, PREVIEW_OFFSET + level)
        end
    end

    -- Navigation
    if startLevel > 1 then
        local prevStart = math.max(1, startLevel - 10)
        player:GossipMenuAddItem(7, "<< Previous levels", MENU_PREVIEW, PREVIEW_OFFSET + prevStart)
    end

    if endLevel < maxLevel then
        player:GossipMenuAddItem(7, "Next levels >>", MENU_PREVIEW, PREVIEW_OFFSET + endLevel + 1)
    end

    player:GossipMenuAddItem(0, "<< Back to main menu", MENU_PREVIEW, OPT_BACK)
    player:GossipSendMenu(1, creature)
end

-- ============================================================================
-- Gossip Handlers
-- ============================================================================

local function OnGossipHello(event, player, creature)
    ShowMainMenu(player, creature)
end

local function OnGossipSelect(event, player, creature, sender, intid, code)
    if intid == OPT_CLOSE then
        player:GossipComplete()
        return
    end

    if intid == OPT_BACK then
        ShowMainMenu(player, creature)
        return
    end

    if sender == MENU_MAIN then
        if intid == OPT_STATUS then
            ShowStatusMenu(player, creature)
        elseif intid == OPT_REWARDS then
            ShowRewardsMenu(player, creature)
        elseif intid == OPT_CLAIM_ALL then
            player:GossipComplete()
            BattlePass.Rewards.ClaimAllRewards(player)
        elseif intid == OPT_PREVIEW then
            ShowPreviewMenu(player, creature)
        elseif intid == OPT_SYNC then
            player:GossipComplete()
            BattlePass.Communication.FullSync(player)
            player:SendBroadcastMessage("|cff00ff00[Battle Pass]|r " .. NPC_TEXTS.sync_done)
        end
        return
    end

    if sender == MENU_STATUS then
        ShowMainMenu(player, creature)
        return
    end

    -- Individual reward claim
    if sender == MENU_REWARDS then
        if intid >= CLAIM_OFFSET and intid < PREVIEW_OFFSET then
            local level = intid - CLAIM_OFFSET
            player:GossipComplete()
            BattlePass.Rewards.ClaimReward(player, level)
        else
            ShowMainMenu(player, creature)
        end
        return
    end

    -- Preview navigation
    if sender == MENU_PREVIEW then
        if intid >= PREVIEW_OFFSET then
            local level = intid - PREVIEW_OFFSET
            ShowPreviewMenu(player, creature, level)
        else
            ShowMainMenu(player, creature)
        end
        return
    end
end

-- ============================================================================
-- NPC Registration
-- ============================================================================

function BattlePass.NPC.Register()
    local npcEntry = GetNPCEntry()

    RegisterCreatureGossipEvent(npcEntry, 1, OnGossipHello)  -- GOSSIP_EVENT_ON_HELLO
    RegisterCreatureGossipEvent(npcEntry, 2, OnGossipSelect) -- GOSSIP_EVENT_ON_SELECT

    BattlePass.Info("NPC registered (entry: " .. npcEntry .. ")")
end

BattlePass.NPC.Register()
