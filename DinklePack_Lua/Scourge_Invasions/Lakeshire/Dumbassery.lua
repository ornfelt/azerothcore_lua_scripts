local CreatureKillRewards = {}

CreatureKillRewards.CREATURE_ID = 1069
CreatureKillRewards.ITEM_ID = 65006
CreatureKillRewards.ITEM_COUNT = 1
CreatureKillRewards.REQUIRED_QUEST_ID = 30015

function CreatureKillRewards.OnCreatureKill(event, player, creature)
    if creature:GetEntry() == CreatureKillRewards.CREATURE_ID and player:HasQuest(CreatureKillRewards.REQUIRED_QUEST_ID) then
        player:AddItem(CreatureKillRewards.ITEM_ID, CreatureKillRewards.ITEM_COUNT)
    end
end

RegisterPlayerEvent(7, CreatureKillRewards.OnCreatureKill)
