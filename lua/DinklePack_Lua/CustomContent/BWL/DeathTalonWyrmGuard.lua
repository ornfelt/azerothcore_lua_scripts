local DeathTalonWyrmGuard = {}

DeathTalonWyrmGuard.NPC_ID = 400148
DeathTalonWyrmGuard.SPELL_IDS = {
    ABILITY_1 = 845,
    ABILITY_2 = 5164
}

function DeathTalonWyrmGuard.CastAbility1(eventId, delay, calls, creature)
    creature:CastSpell(creature:GetVictim(), DeathTalonWyrmGuard.SPELL_IDS.ABILITY_1, false)
end

function DeathTalonWyrmGuard.CastAbility2(eventId, delay, calls, creature)
    creature:CastSpell(creature:GetVictim(), DeathTalonWyrmGuard.SPELL_IDS.ABILITY_2, false)
end

function DeathTalonWyrmGuard.OnEnterCombat(event, creature, target)
    creature:RegisterEvent(DeathTalonWyrmGuard.CastAbility1, math.random(8000, 15000), 0)
    creature:RegisterEvent(DeathTalonWyrmGuard.CastAbility2, math.random(20000, 25000), 0)
end

function DeathTalonWyrmGuard.OnLeaveCombat(event, creature)
    creature:RemoveEvents()
end

function DeathTalonWyrmGuard.OnDied(event, creature, killer)
    creature:RemoveEvents()
end

RegisterCreatureEvent(DeathTalonWyrmGuard.NPC_ID, 1, DeathTalonWyrmGuard.OnEnterCombat)
RegisterCreatureEvent(DeathTalonWyrmGuard.NPC_ID, 2, DeathTalonWyrmGuard.OnLeaveCombat)
RegisterCreatureEvent(DeathTalonWyrmGuard.NPC_ID, 4, DeathTalonWyrmGuard.OnDied)
