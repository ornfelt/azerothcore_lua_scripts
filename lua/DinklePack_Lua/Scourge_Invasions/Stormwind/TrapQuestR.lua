--[[

local TrapQuestRewardHandler = {}

TrapQuestRewardHandler.QUEST_ID = 30004
TrapQuestRewardHandler.CREATURE_ID = 12480
TrapQuestRewardHandler.SOUND_ID = 20427
TrapQuestRewardHandler.EMOTE_ID = 113

function TrapQuestRewardHandler.OnQuestReward(event, player, creature, quest)
    if quest:GetId() == TrapQuestRewardHandler.QUEST_ID then
        creature:PlayDistanceSound(TrapQuestRewardHandler.SOUND_ID)
        creature:PerformEmote(TrapQuestRewardHandler.EMOTE_ID)
    end
end

RegisterCreatureEvent(TrapQuestRewardHandler.CREATURE_ID, 34, TrapQuestRewardHandler.OnQuestReward)
]]