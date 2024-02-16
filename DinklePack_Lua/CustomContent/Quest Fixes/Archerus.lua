local KnightCommanderPlaguefist = {}

KnightCommanderPlaguefist.NPC_ID = 28377
KnightCommanderPlaguefist.SPELL_IDS = {
    SPELL_ONE = 32992,
    SPELL_TWO = 24085
}
KnightCommanderPlaguefist.QUEST_ID = 12701

function KnightCommanderPlaguefist.OnQuestAccept(event, player, creature, quest)
    if quest:GetId() == KnightCommanderPlaguefist.QUEST_ID then
        creature:CastSpell(player, KnightCommanderPlaguefist.SPELL_IDS.SPELL_ONE, true)
        player:CastSpell(player, KnightCommanderPlaguefist.SPELL_IDS.SPELL_TWO, true)
        player:Teleport(609, 2263.189, -6200.54, 13.16, 1.78) -- Teleport to new location
        player:RegisterEvent(ResetPlayerDisplayId, 19800, 1) -- Adjust the delay time based on how long it takes to reach the destination
    end
end

RegisterCreatureEvent(KnightCommanderPlaguefist.NPC_ID, 31, KnightCommanderPlaguefist.OnQuestAccept)
