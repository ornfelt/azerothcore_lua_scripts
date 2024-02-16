local QuestLootCompletion = {}

QuestLootCompletion.ITEM_ID = 3622
QuestLootCompletion.QUEST_ID = 437

function QuestLootCompletion.OnLootItem(event, player, item, count)
    if item:GetEntry() == QuestLootCompletion.ITEM_ID then
        if player:HasQuest(QuestLootCompletion.QUEST_ID) then
            player:CompleteQuest(QuestLootCompletion.QUEST_ID)
        end
    end
end

RegisterPlayerEvent(32, QuestLootCompletion.OnLootItem)
