local OrgArcher = {}

OrgArcher.NPC_ID = 400041
OrgArcher.SPELL_IDS = {
    SHOOT = 37770,
    MULTISHOT = 30990
}

function OrgArcher.OnEnterCombat(event, creature, target)
    creature:RegisterEvent(OrgArcher.CastShoot, 850, 0)
    creature:RegisterEvent(OrgArcher.CastMultiShot, 5000, 0)
end

function OrgArcher.OnLeaveCombat(event, creature)
    creature:RemoveEvents()
end

function OrgArcher.OnDied(event, creature, killer)
    creature:RemoveEvents()
end

function OrgArcher.CastShoot(event, delay, calls, creature)
    creature:CastSpell(creature:GetVictim(), OrgArcher.SPELL_IDS.SHOOT, true)
end

function OrgArcher.CastMultiShot(event, delay, calls, creature)
    creature:CastSpell(creature:GetVictim(), OrgArcher.SPELL_IDS.MULTISHOT, true)
end

RegisterCreatureEvent(OrgArcher.NPC_ID, 1, OrgArcher.OnEnterCombat)
RegisterCreatureEvent(OrgArcher.NPC_ID, 2, OrgArcher.OnLeaveCombat)
RegisterCreatureEvent(OrgArcher.NPC_ID, 4, OrgArcher.OnDied)
