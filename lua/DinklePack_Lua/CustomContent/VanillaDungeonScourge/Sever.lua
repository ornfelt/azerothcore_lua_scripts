local Sever = {}

Sever.NPC_ID = 14682
Sever.SPELL_IDS = {
    DISEASED_SPIT = 17745,
    INTIMIDATING_ROAR = 16508,
    UNKNOWN_AURA = 41305
}

function Sever.CastDiseasedSpit(eventId, delay, calls, creature)
    creature:CastSpell(creature:GetVictim(), Sever.SPELL_IDS.DISEASED_SPIT, true)
end

function Sever.CastIntimidatingRoar(eventId, delay, calls, creature)
    creature:CastSpell(creature:GetVictim(), Sever.SPELL_IDS.INTIMIDATING_ROAR, true)
end

function Sever.OnEnterCombat(event, creature, target)
    creature:RegisterEvent(Sever.CastDiseasedSpit, 10000, 0)
    creature:RegisterEvent(Sever.CastIntimidatingRoar, 30000, 0)
end

function Sever.OnLeaveCombat(event, creature)
    creature:RemoveEvents()
end

function Sever.OnDied(event, creature, killer)
    creature:RemoveEvents()
end

function Sever.OnDamageTaken(event, creature, attacker, damage)
    if (creature:GetHealthPct() < 50 and not creature:HasAura(Sever.SPELL_IDS.UNKNOWN_AURA)) then
        creature:CastSpell(creature, Sever.SPELL_IDS.UNKNOWN_AURA, true)
    end
end

RegisterCreatureEvent(Sever.NPC_ID, 1, Sever.OnEnterCombat)
RegisterCreatureEvent(Sever.NPC_ID, 2, Sever.OnLeaveCombat)
RegisterCreatureEvent(Sever.NPC_ID, 4, Sever.OnDied)
RegisterCreatureEvent(Sever.NPC_ID, 9, Sever.OnDamageTaken)
