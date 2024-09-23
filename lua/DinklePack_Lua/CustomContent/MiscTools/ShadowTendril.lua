local ShadowTendril = {}

ShadowTendril.NPC_ID = 401118
ShadowTendril.SPELL_IDS = {
    SHADOW_WORD_PAIN = 10892,
    MIND_BLAST = 10945,
    ON_SPAWN = 80000,
    STEALTH = 16592,
    SLOW = 30283
}

function ShadowTendril.CastSlow(eventId, delay, repeats, creature)
    creature:CastSpell(creature:GetVictim(), ShadowTendril.SPELL_IDS.SLOW, true)
end

function ShadowTendril.CastShadowWordPain(eventId, delay, repeats, creature)
    creature:CastSpell(creature:GetVictim(), ShadowTendril.SPELL_IDS.SHADOW_WORD_PAIN, true)
end

function ShadowTendril.CastMindBlast(eventId, delay, repeats, creature)
    creature:CastSpell(creature:GetVictim(), ShadowTendril.SPELL_IDS.MIND_BLAST, true)
end

function ShadowTendril.OnEnterCombat(event, creature)
    creature:CastSpell(creature, ShadowTendril.SPELL_IDS.STEALTH, true)
    creature:CastSpell(creature, ShadowTendril.SPELL_IDS.ON_SPAWN, true)
    creature:RegisterEvent(ShadowTendril.CastSlow, 100, 1)
    creature:RegisterEvent(ShadowTendril.CastShadowWordPain, 100, 1)
    creature:RegisterEvent(ShadowTendril.CastShadowWordPain, 10000, 0)
    creature:RegisterEvent(ShadowTendril.CastMindBlast, 5000, 0)
end

function ShadowTendril.OnLeaveCombat(event, creature)
    creature:RemoveEvents()
    creature:CastSpell(creature, ShadowTendril.SPELL_IDS.STEALTH, true)
    creature:CastSpell(creature, ShadowTendril.SPELL_IDS.ON_SPAWN, true)
end

function ShadowTendril.OnCreatureDeath(event, creature)
    creature:RemoveEvents()
end

function ShadowTendril.OnCreatureSpawn(event, creature)
    creature:CastSpell(creature, ShadowTendril.SPELL_IDS.STEALTH, true)
    creature:CastSpell(creature, ShadowTendril.SPELL_IDS.ON_SPAWN, true)
end

function ShadowTendril.OnCreatureReset(event, creature)
    creature:CastSpell(creature, ShadowTendril.SPELL_IDS.STEALTH, true)
    creature:CastSpell(creature, ShadowTendril.SPELL_IDS.ON_SPAWN, true)
end

RegisterCreatureEvent(ShadowTendril.NPC_ID, 1, ShadowTendril.OnEnterCombat)
RegisterCreatureEvent(ShadowTendril.NPC_ID, 2, ShadowTendril.OnLeaveCombat)
RegisterCreatureEvent(ShadowTendril.NPC_ID, 4, ShadowTendril.OnCreatureDeath)
RegisterCreatureEvent(ShadowTendril.NPC_ID, 5, ShadowTendril.OnCreatureSpawn)
RegisterCreatureEvent(ShadowTendril.NPC_ID, 23, ShadowTendril.OnCreatureReset)
