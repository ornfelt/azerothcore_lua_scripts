local CenarionHoldSentry = {}

CenarionHoldSentry.NPC_ID = 15184
CenarionHoldSentry.SPELL_IDS = {
    ABILITY_ONE = 845,
    ABILITY_TWO = 1680
}

function CenarionHoldSentry.CastAbilities(eventId, delay, calls, creature)
    creature:CastSpell(creature:GetVictim(), CenarionHoldSentry.SPELL_IDS.ABILITY_ONE, true)
    creature:CastSpell(creature:GetVictim(), CenarionHoldSentry.SPELL_IDS.ABILITY_TWO, true)
end

function CenarionHoldSentry.OnEnterCombat(event, creature, target)
    creature:SendUnitYell("For Cenarion Hold!", 0)
    creature:RegisterEvent(CenarionHoldSentry.CastAbilities, 4000, 0)
end

function CenarionHoldSentry.OnLeaveCombat(event, creature)
    creature:RemoveEvents()
end

function CenarionHoldSentry.OnDied(event, creature, killer)
    creature:RemoveEvents()
end

RegisterCreatureEvent(CenarionHoldSentry.NPC_ID, 1, CenarionHoldSentry.OnEnterCombat)
RegisterCreatureEvent(CenarionHoldSentry.NPC_ID, 2, CenarionHoldSentry.OnLeaveCombat)
RegisterCreatureEvent(CenarionHoldSentry.NPC_ID, 4, CenarionHoldSentry.OnDied)
