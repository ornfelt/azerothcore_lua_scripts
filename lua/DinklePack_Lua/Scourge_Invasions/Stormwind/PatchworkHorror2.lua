local PatchWorkHorrorTwice = {}

PatchWorkHorrorTwice.NPC_ID = 10414
PatchWorkHorrorTwice.SPELL_IDS = {
    ACID_SPIT = 61597,
    KNOCK_AWAY = 10101,
    BLUDGEONING_STRIKE = 60870
}

function PatchWorkHorrorTwice.AcidSpit(eventId, delay, calls, creature)
    creature:CastSpell(creature:GetVictim(), PatchWorkHorrorTwice.SPELL_IDS.ACID_SPIT, true)
end

function PatchWorkHorrorTwice.KnockAway(eventId, delay, calls, creature)
    creature:CastSpell(creature:GetVictim(), PatchWorkHorrorTwice.SPELL_IDS.KNOCK_AWAY, true)
end

function PatchWorkHorrorTwice.CastBludgeoningStrike(eventId, delay, calls, creature)
    local targets = creature:GetAITargets(10)
    if #targets == 0 then
        return
    end
    local target = targets[math.random(#targets)]
    creature:CastSpell(target, PatchWorkHorrorTwice.SPELL_IDS.BLUDGEONING_STRIKE, true)
end

function PatchWorkHorrorTwice.OnEnterCombat(event, creature, target)
    creature:RegisterEvent(PatchWorkHorrorTwice.AcidSpit, 7000, 0)
    creature:RegisterEvent(PatchWorkHorrorTwice.CastBludgeoningStrike, 13000, 0)
    creature:RegisterEvent(PatchWorkHorrorTwice.KnockAway, 16000, 0)
end

function PatchWorkHorrorTwice.OnLeaveCombat(event, creature)
    creature:RemoveEvents()
end

function PatchWorkHorrorTwice.OnDied(event, creature, killer)
    creature:RemoveEvents()
end

RegisterCreatureEvent(PatchWorkHorrorTwice.NPC_ID, 1, PatchWorkHorrorTwice.OnEnterCombat)
RegisterCreatureEvent(PatchWorkHorrorTwice.NPC_ID, 2, PatchWorkHorrorTwice.OnLeaveCombat)
RegisterCreatureEvent(PatchWorkHorrorTwice.NPC_ID, 4, PatchWorkHorrorTwice.OnDied)
