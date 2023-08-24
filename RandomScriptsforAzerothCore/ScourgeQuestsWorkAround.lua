local questIds = {9265, 9264, 9263, 9262, 9261, 9260}
local itemId = 22892
local itemCount = 3
local totalLooted = {}

local function OnLootItem(event, player, item, count)
  if item:GetEntry() == itemId then
    for _, questId in pairs(questIds) do
      if player:HasQuest(questId) then
        if not totalLooted[questId] then
          totalLooted[questId] = 0
        end
        totalLooted[questId] = totalLooted[questId] + count
        if totalLooted[questId] >= itemCount then
          player:CompleteQuest(questId)
        end
      end
    end
  end
end

RegisterPlayerEvent(32, OnLootItem)
