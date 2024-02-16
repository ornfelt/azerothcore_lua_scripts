local Avery = {}

Avery.NPC_ID = 100164
Avery.SPELL_IDS = {
    CAST_ON_SPAWN = 67040,
    SHADOW_BOLT = 695
}

function Avery.OnSpawn(event, creature)
    creature:CastSpell(creature, Avery.SPELL_IDS.CAST_ON_SPAWN, false)
end

function Avery.ShadowBolt(event, delay, pCall, creature)
    creature:CastSpell(creature:GetVictim(), Avery.SPELL_IDS.SHADOW_BOLT, false)
end

function Avery.RecastSpell(event, delay, pCall, creature)
    creature:CastSpell(creature, Avery.SPELL_IDS.CAST_ON_SPAWN, false)
end

function Avery.OnEnterCombat(event, creature)
    creature:SendUnitYell("I will not permit you to interfere!", 0)
    creature:RegisterEvent(Avery.ShadowBolt, 3000, 0) -- Cast Shadow Bolt every 3 seconds
end

function Avery.OnLeaveCombat(event, creature)
    creature:RemoveEvents()
    creature:RegisterEvent(Avery.RecastSpell, 8000, 1) -- Recast the spell 5 seconds after leaving combat
end

function Avery.OnDied(event, creature)
    creature:RemoveEvents()
    creature:SendUnitSay("We were so...close....", 0)
end

RegisterCreatureEvent(Avery.NPC_ID, 5, Avery.OnSpawn)
RegisterCreatureEvent(Avery.NPC_ID, 1, Avery.OnEnterCombat)
RegisterCreatureEvent(Avery.NPC_ID, 2, Avery.OnLeaveCombat)
RegisterCreatureEvent(Avery.NPC_ID, 4, Avery.OnDied)
