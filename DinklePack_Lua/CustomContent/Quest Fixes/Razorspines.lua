local RazorspineQuestItemGiver = {}

RazorspineQuestItemGiver.CREATURE_ID = 23841
RazorspineQuestItemGiver.ITEM_ID = 33110
RazorspineQuestItemGiver.ITEM_COUNT = 1
RazorspineQuestItemGiver.REQUIRED_QUEST_ID = 1203

function RazorspineQuestItemGiver.OnCreatureKill(event, player, creature)
    if creature:GetEntry() == RazorspineQuestItemGiver.CREATURE_ID and player:HasQuest(RazorspineQuestItemGiver.REQUIRED_QUEST_ID) then
        player:AddItem(RazorspineQuestItemGiver.ITEM_ID, RazorspineQuestItemGiver.ITEM_COUNT)
        player:CompleteQuest(RazorspineQuestItemGiver.REQUIRED_QUEST_ID)
    end
end

RegisterPlayerEvent(7, RazorspineQuestItemGiver.OnCreatureKill)
