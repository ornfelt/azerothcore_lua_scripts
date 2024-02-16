local ArcherSW = {}

ArcherSW.NPC_ID = 400033
ArcherSW.SPELL_IDS = {
    SHOOT = 37770,
    SERPENT_STING = 36984,
    MULTI_SHOT = 30990
}

function ArcherSW.CastShoot(eventId, delay, calls, creature)
    creature:CastSpell(creature:GetVictim(), ArcherSW.SPELL_IDS.SHOOT, true)
end

function ArcherSW.CastSerpentSting(eventId, delay, calls, creature)
    creature:CastSpell(creature:GetVictim(), ArcherSW.SPELL_IDS.SERPENT_STING, true)
end

function ArcherSW.CastMultiShot(eventId, delay, calls, creature)
    creature:CastSpell(creature:GetVictim(), ArcherSW.SPELL_IDS.MULTI_SHOT, true)
end

function ArcherSW.OnEnterCombat(event, creature, target)
    creature:RegisterEvent(ArcherSW.CastShoot, 750, 0)
    creature:RegisterEvent(ArcherSW.CastShoot, 15000, 0)
    creature:RegisterEvent(ArcherSW.CastMultiShot, 5000, 0)
end

function ArcherSW.OnLeaveCombat(event, creature)
    creature:RemoveEvents()
end

function ArcherSW.OnDied(event, creature, killer)
    creature:RemoveEvents()
end

RegisterCreatureEvent(ArcherSW.NPC_ID, 1, ArcherSW.OnEnterCombat)
RegisterCreatureEvent(ArcherSW.NPC_ID, 2, ArcherSW.OnLeaveCombat)
RegisterCreatureEvent(ArcherSW.NPC_ID, 4, ArcherSW.OnDied)
