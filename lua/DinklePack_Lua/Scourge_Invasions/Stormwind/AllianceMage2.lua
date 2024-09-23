local AMage = {}

AMage.NPC_ID = 400027
AMage.SPELL_IDS = {
    FIREBALL = 38692,
    FROSTBOLT = 27071,
    BLIZZARD = 42213,
    ARCANE_EXPLOSION = 19712
}

function AMage.CastFireball(eventId, delay, calls, creature)
    creature:CastSpell(creature:GetVictim(), AMage.SPELL_IDS.FIREBALL, true)
end

function AMage.CastFrostbolt(eventId, delay, calls, creature)
    creature:CastSpell(creature:GetVictim(), AMage.SPELL_IDS.FROSTBOLT, true)
end

function AMage.CastBlizzard(eventId, delay, calls, creature)
    creature:CastSpell(creature:GetVictim(), AMage.SPELL_IDS.BLIZZARD, true)
end

function AMage.CastArcaneExplosion(eventId, delay, calls, creature)
    creature:CastSpell(creature:GetVictim(), AMage.SPELL_IDS.ARCANE_EXPLOSION, true)
end

function AMage.OnEnterCombat(event, creature, target)
    creature:RegisterEvent(AMage.CastFireball, 3600, 0)
    creature:RegisterEvent(AMage.CastFrostbolt, 7200, 0)
    creature:RegisterEvent(AMage.CastBlizzard, 9000, 0)
    creature:RegisterEvent(AMage.CastArcaneExplosion, 10800, 0)
end

function AMage.OnLeaveCombat(event, creature)
    creature:RemoveEvents()
end

function AMage.OnDied(event, creature, killer)
    creature:RemoveEvents()
end

RegisterCreatureEvent(AMage.NPC_ID, 1, AMage.OnEnterCombat)
RegisterCreatureEvent(AMage.NPC_ID, 2, AMage.OnLeaveCombat)
RegisterCreatureEvent(AMage.NPC_ID, 4, AMage.OnDied)
