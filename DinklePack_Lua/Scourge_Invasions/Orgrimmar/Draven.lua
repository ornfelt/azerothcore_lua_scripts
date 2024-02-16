local Draven = {}

Draven.NPC_ID = 400069
Draven.SPELL_IDS = {
    FAN_OF_KNIVES = 51723,
    SARONITE_BOMB = 56350,
    CLOAK_OF_SHADOWS = 31224,
    BLADE_FLURRY = 13877
}

function Draven.OnEnterCombat(event, creature, target)
    creature:RegisterEvent(Draven.CastFanOfKnives, 10000, 0)
    creature:RegisterEvent(Draven.CastSaroniteBomb, 7000, 0)
    creature:RegisterEvent(Draven.CastCloakOfShadows, 11500, 0)
    creature:RegisterEvent(Draven.CastBladeFlurry, 13000, 0)
end

function Draven.OnLeaveCombat(event, creature)
    creature:RemoveEvents()
end

function Draven.OnDied(event, creature, killer)
    creature:RemoveEvents()
end

function Draven.CastFanOfKnives(event, delay, calls, creature)
    creature:CastSpell(creature:GetVictim(), Draven.SPELL_IDS.FAN_OF_KNIVES, true)
end

function Draven.CastSaroniteBomb(event, delay, calls, creature)
    creature:CastSpell(creature:GetVictim(), Draven.SPELL_IDS.SARONITE_BOMB, true)
end

function Draven.CastCloakOfShadows(event, delay, calls, creature)
    creature:CastSpell(creature, Draven.SPELL_IDS.CLOAK_OF_SHADOWS, true)
end

function Draven.CastBladeFlurry(event, delay, calls, creature)
    creature:CastSpell(creature, Draven.SPELL_IDS.BLADE_FLURRY, true)
end

RegisterCreatureEvent(Draven.NPC_ID, 1, Draven.OnEnterCombat)
RegisterCreatureEvent(Draven.NPC_ID, 2, Draven.OnLeaveCombat)
RegisterCreatureEvent(Draven.NPC_ID, 4, Draven.OnDied)
