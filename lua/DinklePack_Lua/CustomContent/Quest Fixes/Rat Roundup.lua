local RatQuestCompleter = {}

RatQuestCompleter.PLAYER_SPELL = 21050
RatQuestCompleter.QUEST_TO_COMPLETE = 6661
RatQuestCompleter.CREATURE_TO_CHECK = 12997
RatQuestCompleter.CHECK_RANGE = 4.0

RatQuestCompleter.playerSpellCastCount = {}

function RatQuestCompleter.IsCreatureInRange(player, creatureEntry, range)
    local creatures = player:GetCreaturesInRange(range, creatureEntry, 2) -- 2 for friendly
    return #creatures > 0
end

function RatQuestCompleter.CheckRange(eventId, delay, repeats, player)
    local playerGuid = player:GetGUIDLow()
    local count = RatQuestCompleter.playerSpellCastCount[playerGuid] or 0
    if count >= 5 then
        if player:HasQuest(RatQuestCompleter.QUEST_TO_COMPLETE) then
            if RatQuestCompleter.IsCreatureInRange(player, RatQuestCompleter.CREATURE_TO_CHECK, RatQuestCompleter.CHECK_RANGE) then
                player:CompleteQuest(RatQuestCompleter.QUEST_TO_COMPLETE)
                RatQuestCompleter.playerSpellCastCount[playerGuid] = 0
            end
        end
    end
end

RegisterPlayerEvent(5, function(_, player, spell)
    if spell:GetEntry() == RatQuestCompleter.PLAYER_SPELL then
        local playerGuid = player:GetGUIDLow()

        if not RatQuestCompleter.playerSpellCastCount[playerGuid] then
            RatQuestCompleter.playerSpellCastCount[playerGuid] = 0
        end

        RatQuestCompleter.playerSpellCastCount[playerGuid] = RatQuestCompleter.playerSpellCastCount[playerGuid] + 1

        if RatQuestCompleter.playerSpellCastCount[playerGuid] >= 5 then
            player:RegisterEvent(RatQuestCompleter.CheckRange, 1000, 0)
        end
    end
end)
