local Stormwind = {}

Stormwind.NPC_IDS = {400013, 400039}
Stormwind.SPELL_IDS = {
    CLEAVE = 20677,
    SUNDER_ARMOR = 8380,
    ON_SPAWN = 17683
}

function Stormwind.CastCleave(eventId, delay, calls, creature)
    creature:CastSpell(creature:GetVictim(), Stormwind.SPELL_IDS.CLEAVE, true)
end

function Stormwind.CastSunderArmor(eventId, delay, calls, creature)
    creature:CastSpell(creature:GetVictim(), Stormwind.SPELL_IDS.SUNDER_ARMOR, true)
end

function Stormwind.OnEnterCombat(event, creature, target)
    creature:RegisterEvent(Stormwind.CastCleave, 5000, 0)
    creature:RegisterEvent(Stormwind.CastSunderArmor, 7000, 0)
end

function Stormwind.OnLeaveCombat(event, creature)
    creature:RemoveEvents()
end

function Stormwind.OnDied(event, creature, killer)
    creature:RemoveEvents()
end

function Stormwind.OnSpawn(event, creature)
    creature:CastSpell(creature, Stormwind.SPELL_IDS.ON_SPAWN, true)
end

for i, npcId in ipairs(Stormwind.NPC_IDS) do
    RegisterCreatureEvent(npcId, 1, Stormwind.OnEnterCombat)
    RegisterCreatureEvent(npcId, 2, Stormwind.OnLeaveCombat)
    RegisterCreatureEvent(npcId, 4, Stormwind.OnDied)
    RegisterCreatureEvent(npcId, 5, Stormwind.OnSpawn)
end
