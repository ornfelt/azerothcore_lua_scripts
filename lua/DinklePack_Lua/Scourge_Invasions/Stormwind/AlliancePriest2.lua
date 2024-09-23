local APriest = {}

APriest.NPC_ID = 400026
APriest.SPELL_IDS = {
    SMITE = 48122,
    HOLY_FIRE = 48134,
    SWP = 27605
}

function APriest.CastSmite(eventId, delay, calls, creature)
    creature:CastSpell(creature:GetVictim(), APriest.SPELL_IDS.SMITE, true)
end

function APriest.CastHolyFire(eventId, delay, calls, creature)
    creature:CastSpell(creature:GetVictim(), APriest.SPELL_IDS.HOLY_FIRE, true)
end

function APriest.CastSWP(eventId, delay, calls, creature)
    creature:CastSpell(creature:GetVictim(), APriest.SPELL_IDS.SWP, true)
end

function APriest.OnEnterCombat(event, creature, target)
    creature:RegisterEvent(APriest.CastSmite, 2600, 0)
    creature:RegisterEvent(APriest.CastHolyFire, 5000, 0)
    creature:RegisterEvent(APriest.CastSWP, 15000, 0)
end

function APriest.OnLeaveCombat(event, creature)
    creature:RemoveEvents()
end

function APriest.OnDied(event, creature, killer)
    creature:RemoveEvents()
end

RegisterCreatureEvent(APriest.NPC_ID, 1, APriest.OnEnterCombat)
RegisterCreatureEvent(APriest.NPC_ID, 2, APriest.OnLeaveCombat)
RegisterCreatureEvent(APriest.NPC_ID, 4, APriest.OnDied)
