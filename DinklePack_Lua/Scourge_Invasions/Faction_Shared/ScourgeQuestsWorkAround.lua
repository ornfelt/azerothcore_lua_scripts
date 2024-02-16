local QuestCompletionModule = {}

QuestCompletionModule.questIds = {9265, 9264, 9263, 9262, 9261, 9260}
QuestCompletionModule.itemId = 22892
QuestCompletionModule.itemCount = 3
QuestCompletionModule.totalLooted = {}

function QuestCompletionModule.OnLootItem(event, player, item, count)
  if item:GetEntry() == QuestCompletionModule.itemId then
    for _, questId in pairs(QuestCompletionModule.questIds) do
      if player:HasQuest(questId) then
        if not QuestCompletionModule.totalLooted[questId] then
          QuestCompletionModule.totalLooted[questId] = 0
        end
        QuestCompletionModule.totalLooted[questId] = QuestCompletionModule.totalLooted[questId] + count
        if QuestCompletionModule.totalLooted[questId] >= QuestCompletionModule.itemCount then
          player:CompleteQuest(questId)
        end
      end
    end
  end
end

RegisterPlayerEvent(32, QuestCompletionModule.OnLootItem)
