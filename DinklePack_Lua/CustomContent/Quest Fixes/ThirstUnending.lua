local tueQuestCompletion = {}

tueQuestCompletion.QUEST_ID = 8346
tueQuestCompletion.SPELL_ID = 80025
tueQuestCompletion.TARGET_CREATURE_ID = 15274

function tueQuestCompletion.OnPlayerSpellCast(event, player, spell, skipCheck)

    if spell:GetEntry() == tueQuestCompletion.SPELL_ID then

        local target = spell:GetUnitTarget()
        if target and target:GetEntry() == tueQuestCompletion.TARGET_CREATURE_ID then

            if player:HasQuest(tueQuestCompletion.QUEST_ID) then
                player:CompleteQuest(tueQuestCompletion.QUEST_ID)
            end
        end
    end
end

RegisterPlayerEvent(5, tueQuestCompletion.OnPlayerSpellCast) -- 5 is the PLAYER_EVENT_ON_SPELL_CAST
