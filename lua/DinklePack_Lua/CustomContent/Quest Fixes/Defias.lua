local StormwindDefias = {}

StormwindDefias.NPC_ID = 100163

function StormwindDefias.OnEnterCombat(event, creature, target)
    creature:SendUnitSay("You can't have our explosives!", 0)
end

function StormwindDefias.OnDied(event, creature, killer)
    creature:SendUnitSay("Ugh...our grand entrance is ruined...", 0)
end

RegisterCreatureEvent(StormwindDefias.NPC_ID, 1, StormwindDefias.OnEnterCombat)
RegisterCreatureEvent(StormwindDefias.NPC_ID, 4, StormwindDefias.OnDied)
