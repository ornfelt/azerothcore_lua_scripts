local SWPatchWorkHorror = {}

SWPatchWorkHorror.NPC_ID = 400054
SWPatchWorkHorror.SPELL_IDS = {
    ACID_SPIT = 61597,
    SPECIAL_SPELL = 5,
    BLUDGEONING_STRIKE = 60870
}

function SWPatchWorkHorror.AcidSpit(eventId, delay, calls, creature)
    creature:CastSpell(creature:GetVictim(), SWPatchWorkHorror.SPELL_IDS.ACID_SPIT, true)
end

function SWPatchWorkHorror.CastSpecialSpell(eventId, delay, calls, creature)
    local victim = creature:GetVictim()
    if not victim then
        return
    end
    if victim:GetEntry() == 32666 or victim:GetEntry() == 32667 or victim:GetEntry() == 31144 or victim:GetEntry() == 31146 then
        creature:CastSpell(victim, SWPatchWorkHorror.SPELL_IDS.SPECIAL_SPELL, true)
    end
end

function SWPatchWorkHorror.CastBludgeoningStrike(eventId, delay, calls, creature)
    local targets = creature:GetAITargets(10)
    if #targets == 0 then
        return
    end
    local target = targets[math.random(#targets)]
    creature:CastSpell(target, SWPatchWorkHorror.SPELL_IDS.BLUDGEONING_STRIKE, true)
end

function SWPatchWorkHorror.OnEnterCombat(event, creature, target)
    creature:RegisterEvent(SWPatchWorkHorror.AcidSpit, 7000, 0)
    creature:RegisterEvent(SWPatchWorkHorror.CastBludgeoningStrike, 13000, 0)
    creature:RegisterEvent(SWPatchWorkHorror.CastSpecialSpell, 1000, 0)
end

function SWPatchWorkHorror.OnLeaveCombat(event, creature)
    creature:RemoveEvents()
end

function SWPatchWorkHorror.OnDied(event, creature, killer)
    creature:DespawnOrUnsummon(5000)
    creature:RemoveEvents()
end

RegisterCreatureEvent(SWPatchWorkHorror.NPC_ID, 1, SWPatchWorkHorror.OnEnterCombat)
RegisterCreatureEvent(SWPatchWorkHorror.NPC_ID, 2, SWPatchWorkHorror.OnLeaveCombat)
RegisterCreatureEvent(SWPatchWorkHorror.NPC_ID, 4, SWPatchWorkHorror.OnDied)
