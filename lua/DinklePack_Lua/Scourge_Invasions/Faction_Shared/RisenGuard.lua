local RisenGuard = {}

RisenGuard.npcId = 10489

function RisenGuard.OnCombat(event, creature, target)
    creature:RegisterEvent(RisenGuard.Ability2, 100, 1)
    creature:RegisterEvent(RisenGuard.Ability1, 7000, 0)
    creature:RegisterEvent(RisenGuard.Ability2, 12000, 0)
    creature:RegisterEvent(RisenGuard.Ability3, 10000, 0)
end

function RisenGuard.Ability1(event, delay, calls, creature)
    creature:CastSpell(creature:GetVictim(), 34113, true)
end

function RisenGuard.Ability2(event, delay, calls, creature)
    creature:CastSpell(creature:GetVictim(), 8380, true)
end

function RisenGuard.Ability3(event, delay, calls, creature)
    creature:CastSpell(creature:GetVictim(), 5164, true)
end

function RisenGuard.OnLeaveCombat(event, creature)
    creature:RemoveEvents()
end

function RisenGuard.OnDeath(event, creature, killer)
    creature:RemoveEvents()
end

RegisterCreatureEvent(RisenGuard.npcId, 1, RisenGuard.OnCombat)
RegisterCreatureEvent(RisenGuard.npcId, 2, RisenGuard.OnLeaveCombat)
RegisterCreatureEvent(RisenGuard.npcId, 4, RisenGuard.OnDeath)
