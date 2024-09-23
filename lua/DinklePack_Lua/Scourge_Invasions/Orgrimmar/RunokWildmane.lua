local Shaman = {}

Shaman.NPC_ID = 400070
Shaman.SPELL_IDS = {
    FLAME_SHOCK = 8050,
    LIGHTNING_BOLT = 403,
    LAVA_BURST = 51505,
    CHAIN_LIGHTNING = 421,
    SPAWN_SPELL = 17683
}

function Shaman.CastFlameShock(eventId, delay, calls, creature)
    creature:CastSpell(creature:GetVictim(), Shaman.SPELL_IDS.FLAME_SHOCK, true)
end

function Shaman.CastLightningBolt(eventId, delay, calls, creature)
    creature:CastSpell(creature:GetVictim(), Shaman.SPELL_IDS.LIGHTNING_BOLT, false)
end

function Shaman.CastLavaBurst(eventId, delay, calls, creature)
    creature:CastSpell(creature:GetVictim(), Shaman.SPELL_IDS.LAVA_BURST, false)
end

function Shaman.CastChainLightning(eventId, delay, calls, creature)
    creature:CastSpell(creature:GetVictim(), Shaman.SPELL_IDS.CHAIN_LIGHTNING, true)
end

function Shaman.OnEnterCombat(event, creature, target)
    if not creature:IsCasting() then
        creature:RegisterEvent(Shaman.CastFlameShock, 5000, 0)
        creature:RegisterEvent(Shaman.CastLightningBolt, 6500, 0)
        creature:RegisterEvent(Shaman.CastLavaBurst, 9000, 0)
        creature:RegisterEvent(Shaman.CastChainLightning, 11700, 0)
    end
end

function Shaman.OnLeaveCombat(event, creature)
    creature:RemoveEvents()
end

function Shaman.OnDied(event, creature, killer)
    creature:RemoveEvents()
end

function Shaman.OnSpawn(event, creature)
    creature:CastSpell(creature, Shaman.SPELL_IDS.SPAWN_SPELL, true)
end

RegisterCreatureEvent(Shaman.NPC_ID, 1, Shaman.OnEnterCombat)
RegisterCreatureEvent(Shaman.NPC_ID, 2, Shaman.OnLeaveCombat)
RegisterCreatureEvent(Shaman.NPC_ID, 4, Shaman.OnDied)
RegisterCreatureEvent(Shaman.NPC_ID, 5, Shaman.OnSpawn)
