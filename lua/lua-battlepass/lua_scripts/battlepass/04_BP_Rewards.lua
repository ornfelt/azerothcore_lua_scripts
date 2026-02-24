--[[
    Battle Pass System - Rewards Module
    BP_Rewards.lua

    Reward distribution: items, gold, titles, spells.
]]

-- ============================================================================
-- Namespace
-- ============================================================================

BattlePass = BattlePass or {}
BattlePass.Rewards = BattlePass.Rewards or {}

-- ============================================================================
-- Reward Handlers by Type
-- ============================================================================

function BattlePass.Rewards.GrantItemReward(player, rewardData)
    local itemId = rewardData.reward_id
    local count = rewardData.reward_count or 1

    local itemTemplate = GetItemTemplate(itemId)
    if not itemTemplate then
        return false, "Invalid item: " .. itemId
    end

    local existingCount = player:GetItemCount(itemId)
    if existingCount > 0 then
        local query = WorldDBQuery(string.format(
            "SELECT maxcount FROM item_template WHERE entry = %d", itemId))

        if query then
            local maxCount = query:GetInt32(0)

            if maxCount == 1 then
                local itemLink = GetItemLink(itemId)
                return false, string.format("You already own %s (unique item)!",
                    itemLink or rewardData.reward_name)
            end

            if maxCount > 0 and (existingCount + count) > maxCount then
                local itemLink = GetItemLink(itemId)
                return false, string.format("Limit reached for %s (max: %d)!",
                    itemLink or rewardData.reward_name, maxCount)
            end
        end
    end

    if not player:AddItem(itemId, count) then
        return false, "Inventory full! Free up space and try again."
    end

    local itemLink = GetItemLink(itemId)
    local message = string.format("Received: %s x%d", itemLink or rewardData.reward_name, count)

    BattlePass.Info(string.format("%s claimed item reward: %d x%d",
        player:GetName(), itemId, count))

    return true, message
end

function BattlePass.Rewards.GrantGoldReward(player, rewardData)
    local copper = rewardData.reward_count or 0

    if copper <= 0 then
        return false, "Invalid gold amount"
    end

    player:ModifyMoney(copper)

    local gold = math.floor(copper / 10000)
    local silver = math.floor((copper % 10000) / 100)
    local copperRem = copper % 100

    local amountStr = ""
    if gold > 0 then
        amountStr = amountStr .. gold .. "g "
    end
    if silver > 0 then
        amountStr = amountStr .. silver .. "s "
    end
    if copperRem > 0 then
        amountStr = amountStr .. copperRem .. "c"
    end

    local message = "Received: " .. amountStr

    BattlePass.Info(string.format("%s claimed gold reward: %d copper",
        player:GetName(), copper))

    return true, message
end

function BattlePass.Rewards.GrantTitleReward(player, rewardData)
    local titleId = rewardData.reward_id

    if not titleId or titleId <= 0 then
        return false, "Invalid title"
    end

    if player:HasTitle(titleId) then
        return false, "You already have this title!"
    end

    player:SetKnownTitle(titleId)

    local message = string.format("Title unlocked: %s", rewardData.reward_name)

    BattlePass.Info(string.format("%s claimed title reward: %d (%s)",
        player:GetName(), titleId, rewardData.reward_name))

    return true, message
end

function BattlePass.Rewards.GrantSpellReward(player, rewardData)
    local spellId = rewardData.reward_id

    if not spellId or spellId <= 0 then
        return false, "Invalid spell"
    end

    if player:HasSpell(spellId) then
        return false, "You already know this spell!"
    end

    player:LearnSpell(spellId)

    local message = string.format("Spell learned: %s", rewardData.reward_name)

    BattlePass.Info(string.format("%s claimed spell reward: %d (%s)",
        player:GetName(), spellId, rewardData.reward_name))

    return true, message
end

function BattlePass.Rewards.GrantCurrencyReward(player, rewardData)
    return BattlePass.Rewards.GrantItemReward(player, rewardData)
end

-- ============================================================================
-- Handler Table by Type
-- ============================================================================

local REWARD_HANDLERS = {
    [1] = BattlePass.Rewards.GrantItemReward,     -- item
    [2] = BattlePass.Rewards.GrantGoldReward,     -- gold
    [3] = BattlePass.Rewards.GrantTitleReward,    -- title
    [4] = BattlePass.Rewards.GrantSpellReward,    -- spell
    [5] = BattlePass.Rewards.GrantCurrencyReward, -- currency
}

-- ============================================================================
-- Main Interface
-- ============================================================================

function BattlePass.Rewards.ClaimReward(player, level)
    if not BattlePass.IsEnabled() then
        return false, "Battle Pass system is disabled."
    end

    local guid = player:GetGUIDLow()
    local data = BattlePass.DB.GetOrCreatePlayerData(player)

    local levelData = BattlePass.LevelCache[level]
    if not levelData then
        return false, string.format("Level %d does not exist.", level)
    end

    if data.current_level < level then
        return false, string.format(
            "You must reach level %d (current: %d).",
            level, data.current_level)
    end

    if BattlePass.DB.IsLevelClaimed(guid, level) then
        return false, string.format("Level %d reward already claimed!", level)
    end

    local rewardType = levelData.reward_type
    local handler = REWARD_HANDLERS[rewardType]

    if not handler then
        BattlePass.Error("Unknown reward type: " .. tostring(rewardType))
        return false, "Unknown reward type."
    end

    local success, message = handler(player, levelData)

    if success then
        BattlePass.DB.MarkLevelClaimed(guid, level)
        BattlePass.DB.SavePlayerProgress(guid, data)

        if BattlePass.Communication then
            BattlePass.Communication.SendClaimConfirmation(player, level)
        end

        player:SendBroadcastMessage(string.format(
            "|cff00ff00[Battle Pass]|r Level %d: %s", level, message))

        return true, message
    else
        player:SendBroadcastMessage(string.format(
            "|cffff0000[Battle Pass]|r Error: %s", message))

        return false, message
    end
end

function BattlePass.Rewards.ClaimAllRewards(player)
    local availableRewards = BattlePass.Progress.GetAvailableRewards(player)

    local successCount = 0
    local skippedCount = 0
    local inventoryFullCount = 0

    for _, rewardData in ipairs(availableRewards) do
        local success, message = BattlePass.Rewards.ClaimReward(player, rewardData.level)
        if success then
            successCount = successCount + 1
        else
            if message and message:find("Inventory full") then
                inventoryFullCount = inventoryFullCount + 1
                player:SendBroadcastMessage(
                    "|cffff0000[Battle Pass]|r Inventory full! Free up space to continue.")
                break
            else
                skippedCount = skippedCount + 1
            end
        end
    end

    if successCount > 0 then
        player:SendBroadcastMessage(string.format(
            "|cff00ff00[Battle Pass]|r %d reward(s) claimed!", successCount))
    end

    if skippedCount > 0 then
        player:SendBroadcastMessage(string.format(
            "|cffff8000[Battle Pass]|r %d reward(s) skipped (already owned/learned)", skippedCount))
    end

    if successCount == 0 and skippedCount == 0 and inventoryFullCount == 0 then
        player:SendBroadcastMessage(
            "|cffff8000[Battle Pass]|r No rewards available to claim.")
    end

    return successCount, skippedCount + inventoryFullCount
end

-- ============================================================================
-- Reward Preview
-- ============================================================================

function BattlePass.Rewards.GetRewardInfo(level)
    return BattlePass.LevelCache[level]
end

function BattlePass.Rewards.GetRewardTypeName(typeId)
    local typeInfo = BattlePass.RewardTypeCache[typeId]
    if typeInfo then
        return typeInfo.name
    end
    return "unknown"
end

function BattlePass.Rewards.PlayerOwnsReward(player, levelData)
    local rewardType = levelData.reward_type
    local rewardId = levelData.reward_id
    local rewardCount = levelData.reward_count

    if rewardType == 1 or rewardType == 5 then
        -- Item or Currency: only check if it's a UNIQUE item
        local itemCount = player:GetItemCount(rewardId)

        if itemCount > 0 then
            local query = WorldDBQuery(string.format(
                "SELECT maxcount FROM item_template WHERE entry = %d", rewardId))

            if query then
                local maxCount = query:GetInt32(0)
                if maxCount == 1 then
                    return true
                end
            end
        end

        return false
    elseif rewardType == 2 then
        -- Gold: always false
        return false
    elseif rewardType == 3 then
        -- Title: check if player has the title
        return player:HasTitle(rewardId)
    elseif rewardType == 4 then
        -- Spell: check if player knows the spell
        return player:HasSpell(rewardId)
    end

    return false
end

function BattlePass.Rewards.FormatRewardDescription(levelData)
    local typeName = BattlePass.Rewards.GetRewardTypeName(levelData.reward_type)

    local desc = string.format("Level %d: |cffffd700%s|r",
        levelData.level, levelData.reward_name)

    if levelData.description and levelData.description ~= "" then
        desc = desc .. " - " .. levelData.description
    end

    return desc
end
