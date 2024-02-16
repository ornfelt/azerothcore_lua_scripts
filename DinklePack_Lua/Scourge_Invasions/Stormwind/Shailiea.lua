local Shailiea = {}

Shailiea.NPC_ID = 7295
Shailiea.SPELL_IDS = {
    RAPID_SHOT = 71251,
    SUMMON_TAMED_BEAR = 7903,
    WHIRLWIND = 1680,
    EXPLOSIVE_TRAP = 49066,
    MORTAL_STRIKE = 30330,
    DISENGAGE = 57635,
    ROOT = 50762,
    FD = 23604
}

function Shailiea.CastRapidShot(eventId, delay, calls, creature)
    local victim = creature:GetVictim()
    creature:CastSpell(victim, Shailiea.SPELL_IDS.RAPID_SHOT, true)
end

function Shailiea.CastSummonTamedBear(eventId, delay, calls, creature)
    local victim = creature:GetVictim()
    creature:CastSpell(victim, Shailiea.SPELL_IDS.SUMMON_TAMED_BEAR, true)
end

function Shailiea.CastWhirlwind(eventId, delay, calls, creature)
    local victim = creature:GetVictim()
    creature:CastSpell(victim, Shailiea.SPELL_IDS.WHIRLWIND, false)
end

function Shailiea.CastExplosiveTrap(eventId, delay, calls, creature)
    local victim = creature:GetVictim()
    creature:CastSpell(victim, Shailiea.SPELL_IDS.EXPLOSIVE_TRAP, false)
end

function Shailiea.CastMortalStrike(eventId, delay, calls, creature)
    local victim = creature:GetVictim()
    creature:CastSpell(victim, Shailiea.SPELL_IDS.MORTAL_STRIKE, false)
end

function Shailiea.CastDisengage(eventId, delay, calls, creature)
    local victim = creature:GetVictim()
    creature:CastSpell(victim, Shailiea.SPELL_IDS.DISENGAGE, false)
end

function Shailiea.CastRoot(eventId, delay, calls, creature)
    local victim = creature:GetVictim()
    creature:CastSpell(victim, Shailiea.SPELL_IDS.ROOT, false)
end

function Shailiea.CastFD(eventId, delay, calls, creature)
    creature:CastSpell(creature, Shailiea.SPELL_IDS.FD, false)
end

function Shailiea.OnEnterCombat(event, creature, target)
    local sayings = {
        "You dare enter my territory?",
        "I'll make sure you never come back!",
        "You won't make it out of here alive!",
        "You're nothing but prey to me!"
    }
    local index = math.random(1, #sayings)
    creature:SendUnitSay(sayings[index], 0)
    creature:RegisterEvent(Shailiea.CastFD, 100, 1)
    creature:RegisterEvent(Shailiea.CastRoot, 10300, 0)
    creature:RegisterEvent(Shailiea.CastDisengage, 10400, 0)
    creature:RegisterEvent(Shailiea.CastRapidShot, 11000, 0)
    creature:RegisterEvent(Shailiea.CastWhirlwind, 6100, 0)
    creature:RegisterEvent(Shailiea.CastExplosiveTrap, 12600, 0)
    creature:RegisterEvent(Shailiea.CastMortalStrike, 5300, 0)
    creature:RegisterEvent(Shailiea.CastSummonTamedBear, 5, 1)
end

function Shailiea.OnLeaveCombat(event, creature)
    creature:SendUnitSay("You are not worth my time.", 0)
    creature:RemoveEvents()
end

function Shailiea.OnDied(event, creature, killer)
    creature:SendUnitSay("You may have defeated me, but the hunt continues.", 0)
    creature:RemoveEvents()
end

function Shailiea.OnSpawn(event, creature)
    creature:SendUnitSay("The hunt begins.", 0)
end

RegisterCreatureEvent(Shailiea.NPC_ID, 1, Shailiea.OnEnterCombat)
RegisterCreatureEvent(Shailiea.NPC_ID, 2, Shailiea.OnLeaveCombat)
RegisterCreatureEvent(Shailiea.NPC_ID, 4, Shailiea.OnDied)
RegisterCreatureEvent(Shailiea.NPC_ID, 5, Shailiea.OnSpawn)
