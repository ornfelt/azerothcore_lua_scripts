local QuestSoundHandler = {}

QuestSoundHandler.CREATURE_ID = 400096

QuestSoundHandler.QUEST_ACCEPT = {
    [30015] = 183263,
    [30016] = 183265,
    [30017] = 183267,
    [30018] = 183269
}

QuestSoundHandler.QUEST_COMPLETE = {
    [30014] = 183262,
    [30015] = 183264,
    [30016] = 183266,
    [30017] = 183268,
    [30018] = 183270
}

function QuestSoundHandler.OnQuestAccept(event, player, creature, quest)
    local soundID = QuestSoundHandler.QUEST_ACCEPT[quest:GetId()]
    if soundID then
        player:PlayDirectSound(soundID)
    end
end

function QuestSoundHandler.OnQuestReward(event, player, creature, quest)
    local soundID = QuestSoundHandler.QUEST_COMPLETE[quest:GetId()]
    if soundID then
        creature:PlayDirectSound(soundID)
    end
end

RegisterCreatureEvent(QuestSoundHandler.CREATURE_ID, 31, QuestSoundHandler.OnQuestAccept)
RegisterCreatureEvent(QuestSoundHandler.CREATURE_ID, 34, QuestSoundHandler.OnQuestReward)
