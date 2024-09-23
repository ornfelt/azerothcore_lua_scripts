-- Creature ID for the creature that gives the quests
local CREATURE_ID = 400096

-- Quest and sound IDs for the quests that should trigger the sounds
local QUEST_ACCEPT = {
    [30015] = 20439,
    [30016] = 20441,
    [30017] = 20443,
	[30018] = 20449
}

local QUEST_COMPLETE = {
    [30014] = 20438,
    [30015] = 20440,
    [30016] = 20442,
    [30017] = 20444,
	[30018] = 20450
}

-- Register the event for quest accept
RegisterCreatureEvent(CREATURE_ID, 31, function(event, player, creature, quest)
    local soundID = QUEST_ACCEPT[quest:GetId()]
    if soundID then
        player:PlayDistanceSound(soundID)
    end
end)

-- Register the event for quest reward
RegisterCreatureEvent(CREATURE_ID, 34, function(event, player, creature, quest)
    local soundID = QUEST_COMPLETE[quest:GetId()]
    if soundID then
        creature:PlayDistanceSound(soundID)
    end
end)
