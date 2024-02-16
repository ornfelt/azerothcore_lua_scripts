local QuestCompletionAqua = {}

QuestCompletionAqua.QUEST_IDS = {5061, 31}
QuestCompletionAqua.SPELL_ID = 1066

function QuestCompletionAqua.OnQuestComplete(event, player, quest)
    for _, id in ipairs(QuestCompletionAqua.QUEST_IDS) do
        if quest:GetId() == id then
            player:LearnSpell(QuestCompletionAqua.SPELL_ID)
            break
        end
    end
end

RegisterPlayerEvent(54, QuestCompletionAqua.OnQuestComplete)
