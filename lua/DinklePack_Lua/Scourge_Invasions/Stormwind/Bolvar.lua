local Bolvarsup = {}

Bolvarsup.NPC_ID = 1748
Bolvarsup.SPELL_IDS = {
    AS = 32699,
    HOR = 53595,
    SUNDER = 58461,
    AVENGING_WRATH = 31884,
    KINGS = 20217
}

function Bolvarsup.CastAS(eventId, delay, calls, creature)
    creature:CastSpell(creature:GetVictim(), Bolvarsup.SPELL_IDS.AS, true)
end

function Bolvarsup.CastHOR(eventId, delay, calls, creature)
    creature:CastSpell(creature:GetVictim(), Bolvarsup.SPELL_IDS.HOR, true)
end

function Bolvarsup.CastSunder(eventId, delay, calls, creature)
    creature:CastSpell(creature:GetVictim(), Bolvarsup.SPELL_IDS.SUNDER, true)
end

function Bolvarsup.CastAvengingWrath(event, creature)
    creature:CastSpell(creature, Bolvarsup.SPELL_IDS.AVENGING_WRATH, true)
end

function Bolvarsup.CastKings(event, creature)
    creature:CastSpell(creature, Bolvarsup.SPELL_IDS.KINGS, true)
end

function Bolvarsup.OnEnterCombat(event, creature, target)
    creature:RegisterEvent(Bolvarsup.CastAS, 12600, 0)
    creature:RegisterEvent(Bolvarsup.CastHOR, 5000, 0)
    creature:RegisterEvent(Bolvarsup.CastSunder, 10000, 0)
    creature:RegisterEvent(Bolvarsup.CastAvengingWrath, 1, 1)
end

function Bolvarsup.OnLeaveCombat(event, creature)
    creature:RemoveEvents()
end

function Bolvarsup.OnDied(event, creature, killer)
    creature:RemoveEvents()
end

function Bolvarsup.OnSpawn(event, creature)
    creature:CastSpell(creature, Bolvarsup.SPELL_IDS.KINGS, true)
end

RegisterCreatureEvent(Bolvarsup.NPC_ID, 1, Bolvarsup.OnEnterCombat)
RegisterCreatureEvent(Bolvarsup.NPC_ID, 2, Bolvarsup.OnLeaveCombat)
RegisterCreatureEvent(Bolvarsup.NPC_ID, 4, Bolvarsup.OnDied)
RegisterCreatureEvent(Bolvarsup.NPC_ID, 5, Bolvarsup.OnSpawn)
