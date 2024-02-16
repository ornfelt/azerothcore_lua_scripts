--[[

-- Quest ID for the quest that should trigger the sound
local QUEST_ID = 30004

-- Creature ID for the creature that gives the quest
local CREATURE_ID = 12480

-- Sound ID for the sound that should play when the quest is accepted
local SOUND_ID = 20426

-- Emote ID for the emote that should play when the quest is accepted
local EMOTE_ID = 113

-- Register the event for quest acceptance
RegisterCreatureEvent(CREATURE_ID, 31, function(event, player, creature, quest)
    if quest:GetId() == QUEST_ID then
        creature:PlayDistanceSound(SOUND_ID)
        creature:PerformEmote(EMOTE_ID)
    end
end)
]]