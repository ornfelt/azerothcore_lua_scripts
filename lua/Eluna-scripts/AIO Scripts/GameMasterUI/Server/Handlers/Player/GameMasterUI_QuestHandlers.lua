--[[
    GameMaster UI - Quest Handlers

    Handles quest management for target players:
    - Search quests by name/ID
    - Add, complete, remove, reset, fail quests
    - View active quest log and completed quest history
]]--

local QuestHandlers = {}

local GameMasterSystem, Config, Utils, Database, DatabaseHelper

local function GetTargetPlayerByName(player, targetName)
    if not targetName or targetName == "" or targetName == "Self" or targetName:lower() == "self" then
        return player
    end
    local targetPlayer = GetPlayerByName(targetName)
    if not targetPlayer then
        return nil, "Player '" .. targetName .. "' not found or offline"
    end
    return targetPlayer
end

local QUEST_STATUS_LABELS = {
    [0] = "Not Started",
    [1] = "Complete",
    [3] = "Incomplete",
    [5] = "Failed",
    [6] = "Rewarded",
}

-- Quest-state writes only touch the player's in-memory quest log.
-- character_queststatus isn't updated until SaveToDB flushes the
-- transaction. Reads (getPlayerQuestLog / getPlayerCompletedQuests)
-- therefore SaveToDB then wait REFRESH_DELAY_MS before querying.
-- Action handlers only SaveToDB; the client re-requests the log after
-- its own timer, same pattern as other GM tabs in this project.
local REFRESH_DELAY_MS = 200

local function pushQuestLog(gmPlayer, targetName, targetGuid)
    local query = string.format(
        "SELECT cs.quest, qt.LogTitle, cs.status FROM character_queststatus cs " ..
        "LEFT JOIN world.quest_template qt ON cs.quest = qt.ID " ..
        "WHERE cs.guid = %d AND cs.status != 6 ORDER BY cs.quest ASC",
        targetGuid
    )
    DatabaseHelper.SafeQueryAsync(query, function(result)
        local quests = {}
        if result then
            repeat
                local row = result:GetRow()
                if not row then break end
                local qid = tonumber(row.quest)
                local status = tonumber(row.status) or 0
                table.insert(quests, {
                    id = qid,
                    title = row.LogTitle or ("Quest " .. qid),
                    status = status,
                    statusLabel = QUEST_STATUS_LABELS[status] or ("Status " .. status),
                })
            until not result:NextRow()
        end
        AIO.Handle(gmPlayer, "GameMasterSystem", "receivePlayerQuestLog", {
            targetName = targetName,
            quests = quests,
        })
    end, "char")
end

-- Search quests in quest_template by name or ID
function QuestHandlers.searchQuests(player, searchText, offset, pageSize)
    if player:GetGMRank() < Config.MIN_GM_RANK then
        AIO.Handle(player, "GameMasterSystem", "questError", "Insufficient GM rank")
        return
    end

    searchText = tostring(searchText or "")
    offset = tonumber(offset) or 0
    pageSize = tonumber(pageSize) or 50

    local condition
    local numericId = tonumber(searchText)
    if numericId then
        condition = string.format("WHERE ID = %d", numericId)
    else
        local escaped = searchText:gsub("'", "''"):gsub("%%", "%%%%")
        condition = string.format("WHERE LogTitle LIKE '%%%s%%'", escaped)
    end

    local countQuery = "SELECT COUNT(*) AS cnt FROM quest_template " .. condition
    local dataQuery = string.format(
        "SELECT ID, LogTitle, QuestLevel, MinLevel, QuestType, Flags FROM quest_template %s ORDER BY ID ASC LIMIT %d OFFSET %d",
        condition, pageSize + 1, offset
    )

    DatabaseHelper.SafeQueryAsync(countQuery, function(countResult)
        local totalCount = 0
        if countResult then
            local row = countResult:GetRow()
            if row then totalCount = tonumber(row.cnt) or 0 end
        end

        DatabaseHelper.SafeQueryAsync(dataQuery, function(dataResult)
            local quests = {}
            if dataResult then
                repeat
                    local row = dataResult:GetRow()
                    if not row then break end
                    table.insert(quests, {
                        id = tonumber(row.ID),
                        title = row.LogTitle or "Unknown Quest",
                        level = tonumber(row.QuestLevel) or 0,
                        minLevel = tonumber(row.MinLevel) or 0,
                        questType = tonumber(row.QuestType) or 0,
                        flags = tonumber(row.Flags) or 0,
                    })
                until not dataResult:NextRow()
            end

            local hasMore = #quests > pageSize
            if hasMore then table.remove(quests) end

            AIO.Handle(player, "GameMasterSystem", "receiveQuestSearchResults", {
                quests = quests,
                totalCount = totalCount,
                offset = offset,
                hasMore = hasMore,
            })
        end, "world")
    end, "world")
end

-- Get active quest log for a target player
function QuestHandlers.getPlayerQuestLog(player, targetName)
    if player:GetGMRank() < Config.MIN_GM_RANK then
        AIO.Handle(player, "GameMasterSystem", "questError", "Insufficient GM rank")
        return
    end

    local targetPlayer, err = GetTargetPlayerByName(player, targetName)
    if not targetPlayer then
        AIO.Handle(player, "GameMasterSystem", "questError", err)
        return
    end

    local gmPlayerName = player:GetName()
    local targetName = targetPlayer:GetName()
    local targetGuid = targetPlayer:GetGUIDLow()

    targetPlayer:SaveToDB()
    CreateLuaEvent(function()
        local gm = GetPlayerByName(gmPlayerName)
        if gm then
            pushQuestLog(gm, targetName, targetGuid)
        end
    end, REFRESH_DELAY_MS, 1)
end

-- Get completed quest history (paginated)
function QuestHandlers.getPlayerCompletedQuests(player, targetName, offset, pageSize)
    if player:GetGMRank() < Config.MIN_GM_RANK then
        AIO.Handle(player, "GameMasterSystem", "questError", "Insufficient GM rank")
        return
    end

    local targetPlayer, err = GetTargetPlayerByName(player, targetName)
    if not targetPlayer then
        AIO.Handle(player, "GameMasterSystem", "questError", err)
        return
    end

    offset = tonumber(offset) or 0
    pageSize = tonumber(pageSize) or 50

    local gmPlayerName = player:GetName()
    local targetName = targetPlayer:GetName()
    local targetGuid = targetPlayer:GetGUIDLow()

    targetPlayer:SaveToDB()
    CreateLuaEvent(function()
        local gm = GetPlayerByName(gmPlayerName)
        if not gm then return end

        local dataQuery = string.format(
            "SELECT cr.quest, qt.LogTitle FROM character_queststatus_rewarded cr " ..
            "LEFT JOIN world.quest_template qt ON cr.quest = qt.ID " ..
            "WHERE cr.guid = %d ORDER BY cr.quest ASC LIMIT %d OFFSET %d",
            targetGuid, pageSize + 1, offset
        )

        DatabaseHelper.SafeQueryAsync(dataQuery, function(result)
            local quests = {}
            if result then
                repeat
                    local row = result:GetRow()
                    if not row then break end
                    local questId = tonumber(row.quest)
                    table.insert(quests, {
                        id = questId,
                        title = row.LogTitle or ("Quest " .. questId),
                    })
                until not result:NextRow()
            end

            local hasMore = #quests > pageSize
            if hasMore then table.remove(quests) end

            AIO.Handle(gm, "GameMasterSystem", "receiveCompletedQuests", {
                targetName = targetName,
                quests = quests,
                offset = offset,
                hasMore = hasMore,
            })
        end, "char")
    end, REFRESH_DELAY_MS, 1)
end

-- Add quest to player
function QuestHandlers.addQuestToPlayer(player, targetName, questId)
    if player:GetGMRank() < Config.MIN_GM_RANK then
        AIO.Handle(player, "GameMasterSystem", "questError", "Insufficient GM rank")
        return
    end

    local targetPlayer, err = GetTargetPlayerByName(player, targetName)
    if not targetPlayer then
        AIO.Handle(player, "GameMasterSystem", "questError", err)
        return
    end

    questId = tonumber(questId)
    if not questId then
        AIO.Handle(player, "GameMasterSystem", "questError", "Invalid quest ID")
        return
    end

    if targetPlayer:HasQuest(questId) then
        AIO.Handle(player, "GameMasterSystem", "receiveQuestActionResult", {
            success = false, message = "Player already has this quest"
        })
        return
    end

    targetPlayer:AddQuest(questId)

    if Config.LOG_GM_ACTIONS and Utils and Utils.debug then
        Utils.debug("INFO", string.format("[Quest] %s added quest %d to %s",
            player:GetName(), questId, targetPlayer:GetName()))
    end

    AIO.Handle(player, "GameMasterSystem", "receiveQuestActionResult", {
        success = true, message = "Quest added successfully"
    })
    targetPlayer:SaveToDB()
end

-- Complete and reward quest
function QuestHandlers.completePlayerQuest(player, targetName, questId)
    if player:GetGMRank() < Config.MIN_GM_RANK then
        AIO.Handle(player, "GameMasterSystem", "questError", "Insufficient GM rank")
        return
    end

    local targetPlayer, err = GetTargetPlayerByName(player, targetName)
    if not targetPlayer then
        AIO.Handle(player, "GameMasterSystem", "questError", err)
        return
    end

    questId = tonumber(questId)
    if not questId then
        AIO.Handle(player, "GameMasterSystem", "questError", "Invalid quest ID")
        return
    end

    targetPlayer:CompleteQuest(questId)
    targetPlayer:RewardQuest(questId)

    if Config.LOG_GM_ACTIONS and Utils and Utils.debug then
        Utils.debug("INFO", string.format("[Quest] %s completed+rewarded quest %d for %s",
            player:GetName(), questId, targetPlayer:GetName()))
    end

    AIO.Handle(player, "GameMasterSystem", "receiveQuestActionResult", {
        success = true, message = "Quest completed and rewarded"
    })
    targetPlayer:SaveToDB()
end

-- Remove quest from log
function QuestHandlers.removePlayerQuest(player, targetName, questId)
    if player:GetGMRank() < Config.MIN_GM_RANK then
        AIO.Handle(player, "GameMasterSystem", "questError", "Insufficient GM rank")
        return
    end

    local targetPlayer, err = GetTargetPlayerByName(player, targetName)
    if not targetPlayer then
        AIO.Handle(player, "GameMasterSystem", "questError", err)
        return
    end

    questId = tonumber(questId)
    if not questId then
        AIO.Handle(player, "GameMasterSystem", "questError", "Invalid quest ID")
        return
    end

    targetPlayer:RemoveQuest(questId)

    if Config.LOG_GM_ACTIONS and Utils and Utils.debug then
        Utils.debug("INFO", string.format("[Quest] %s removed quest %d from %s",
            player:GetName(), questId, targetPlayer:GetName()))
    end

    AIO.Handle(player, "GameMasterSystem", "receiveQuestActionResult", {
        success = true, message = "Quest removed from log"
    })
    targetPlayer:SaveToDB()
end

-- Full reset (remove from rewarded + remove from log)
function QuestHandlers.resetPlayerQuest(player, targetName, questId)
    if player:GetGMRank() < Config.MIN_GM_RANK then
        AIO.Handle(player, "GameMasterSystem", "questError", "Insufficient GM rank")
        return
    end

    local targetPlayer, err = GetTargetPlayerByName(player, targetName)
    if not targetPlayer then
        AIO.Handle(player, "GameMasterSystem", "questError", err)
        return
    end

    questId = tonumber(questId)
    if not questId then
        AIO.Handle(player, "GameMasterSystem", "questError", "Invalid quest ID")
        return
    end

    targetPlayer:RemoveRewardedQuest(questId)
    targetPlayer:RemoveQuest(questId)

    if Config.LOG_GM_ACTIONS and Utils and Utils.debug then
        Utils.debug("INFO", string.format("[Quest] %s reset quest %d for %s",
            player:GetName(), questId, targetPlayer:GetName()))
    end

    AIO.Handle(player, "GameMasterSystem", "receiveQuestActionResult", {
        success = true, message = "Quest fully reset (can re-accept)"
    })
    targetPlayer:SaveToDB()
end

-- Fail quest
function QuestHandlers.failPlayerQuest(player, targetName, questId)
    if player:GetGMRank() < Config.MIN_GM_RANK then
        AIO.Handle(player, "GameMasterSystem", "questError", "Insufficient GM rank")
        return
    end

    local targetPlayer, err = GetTargetPlayerByName(player, targetName)
    if not targetPlayer then
        AIO.Handle(player, "GameMasterSystem", "questError", err)
        return
    end

    questId = tonumber(questId)
    if not questId then
        AIO.Handle(player, "GameMasterSystem", "questError", "Invalid quest ID")
        return
    end

    targetPlayer:FailQuest(questId)

    if Config.LOG_GM_ACTIONS and Utils and Utils.debug then
        Utils.debug("INFO", string.format("[Quest] %s failed quest %d for %s",
            player:GetName(), questId, targetPlayer:GetName()))
    end

    AIO.Handle(player, "GameMasterSystem", "receiveQuestActionResult", {
        success = true, message = "Quest marked as failed"
    })
    targetPlayer:SaveToDB()
end

-- Get quest status for a specific quest on target player
function QuestHandlers.getQuestStatus(player, targetName, questId)
    if player:GetGMRank() < Config.MIN_GM_RANK then
        AIO.Handle(player, "GameMasterSystem", "questError", "Insufficient GM rank")
        return
    end

    local targetPlayer, err = GetTargetPlayerByName(player, targetName)
    if not targetPlayer then
        AIO.Handle(player, "GameMasterSystem", "questError", err)
        return
    end

    questId = tonumber(questId)
    if not questId then
        AIO.Handle(player, "GameMasterSystem", "questError", "Invalid quest ID")
        return
    end

    local hasQuest = targetPlayer:HasQuest(questId)
    local status = targetPlayer:GetQuestStatus(questId)
    local rewarded = targetPlayer:GetQuestRewardStatus(questId)

    AIO.Handle(player, "GameMasterSystem", "receiveQuestStatus", {
        targetName = targetPlayer:GetName(),
        questId = questId,
        hasQuest = hasQuest,
        status = status,
        statusLabel = QUEST_STATUS_LABELS[status] or ("Status " .. status),
        rewarded = rewarded,
    })
end

function QuestHandlers.RegisterHandlers(gmSystem, config, utils, database, dbHelper)
    GameMasterSystem = gmSystem
    Config = config
    Utils = utils
    Database = database
    DatabaseHelper = dbHelper

    if not Config.MIN_GM_RANK then Config.MIN_GM_RANK = 2 end
    if Config.LOG_GM_ACTIONS == nil then Config.LOG_GM_ACTIONS = true end

    GameMasterSystem.searchQuests = QuestHandlers.searchQuests
    GameMasterSystem.getPlayerQuestLog = QuestHandlers.getPlayerQuestLog
    GameMasterSystem.getPlayerCompletedQuests = QuestHandlers.getPlayerCompletedQuests
    GameMasterSystem.addQuestToPlayer = QuestHandlers.addQuestToPlayer
    GameMasterSystem.completePlayerQuest = QuestHandlers.completePlayerQuest
    GameMasterSystem.removePlayerQuest = QuestHandlers.removePlayerQuest
    GameMasterSystem.resetPlayerQuest = QuestHandlers.resetPlayerQuest
    GameMasterSystem.failPlayerQuest = QuestHandlers.failPlayerQuest
    GameMasterSystem.getQuestStatus = QuestHandlers.getQuestStatus
end

return QuestHandlers
