local StormwindDefiasRitualist = {}

StormwindDefiasRitualist.NPC_ID = 100165
StormwindDefiasRitualist.SPELL_ID = 67040

function StormwindDefiasRitualist.OnSpawn(event, creature)
    creature:CastSpell(creature, StormwindDefiasRitualist.SPELL_ID, false)
end

function StormwindDefiasRitualist.RecastSpell(event, delay, pCall, creature)
    creature:CastSpell(creature, StormwindDefiasRitualist.SPELL_ID, false)
end

function StormwindDefiasRitualist.OnLeaveCombat(event, creature)
    creature:RemoveEvents()
    creature:RegisterEvent(StormwindDefiasRitualist.RecastSpell, 8000, 1) 
end

RegisterCreatureEvent(StormwindDefiasRitualist.NPC_ID, 5, StormwindDefiasRitualist.OnSpawn)
RegisterCreatureEvent(StormwindDefiasRitualist.NPC_ID, 2, StormwindDefiasRitualist.OnLeaveCombat)
