local Turalyontwix = {}

Turalyontwix.NPC_ID = 400020
Turalyontwix.SPELL_IDS = {
    CHARGE = 22911,
    CRUSADER_STRIKE = 66003,
    DIVINE_STORM = 53385,
    CONSECRATION = 69930,
    CHALLENGING_SHOUT = 1161
}

function Turalyontwix.CastCharge(eventId, delay, calls, creature)
    creature:CastSpell(creature:GetVictim(), Turalyontwix.SPELL_IDS.CHARGE, true)
end

function Turalyontwix.CastCrusaderStrike(eventId, delay, calls, creature)
    creature:CastSpell(creature:GetVictim(), Turalyontwix.SPELL_IDS.CRUSADER_STRIKE, true)
end

function Turalyontwix.CastDivineStorm(eventId, delay, calls, creature)
    creature:CastSpell(creature:GetVictim(), Turalyontwix.SPELL_IDS.DIVINE_STORM, true)
end

function Turalyontwix.CastConsecration(eventId, delay, calls, creature)
    creature:CastSpell(creature, Turalyontwix.SPELL_IDS.CONSECRATION, true)
end

function Turalyontwix.CastChallengingShout(eventId, delay, calls, creature)
    creature:CastSpell(creature, Turalyontwix.SPELL_IDS.CHALLENGING_SHOUT, true)
end

function Turalyontwix.ForceDespawn(eventId, delay, calls, creature)
    creature:DespawnOrUnsummon(1)
end

function Turalyontwix.OnEnterCombat(event, creature, target)
    creature:RegisterEvent(Turalyontwix.CastCharge, 250, 1)
    creature:RegisterEvent(Turalyontwix.CastCrusaderStrike, 5000, 0)
    creature:RegisterEvent(Turalyontwix.CastDivineStorm, 10000, 0)
    creature:RegisterEvent(Turalyontwix.CastConsecration, 15000, 0)
    creature:RegisterEvent(Turalyontwix.CastChallengingShout, 6500, 0)
    creature:RegisterEvent(Turalyontwix.ForceDespawn, 90000, 1)
end

function Turalyontwix.OnLeaveCombat(event, creature)
    creature:RemoveEvents()
end

function Turalyontwix.OnDied(event, creature, killer)
    creature:RemoveEvents()
end

RegisterCreatureEvent(Turalyontwix.NPC_ID, 1, Turalyontwix.OnEnterCombat)
RegisterCreatureEvent(Turalyontwix.NPC_ID, 2, Turalyontwix.OnLeaveCombat)
RegisterCreatureEvent(Turalyontwix.NPC_ID, 4, Turalyontwix.OnDied)
