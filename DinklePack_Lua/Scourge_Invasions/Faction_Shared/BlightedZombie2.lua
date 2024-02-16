local BlightedZombieTwo = {}

function BlightedZombieTwo.OnCombat(event, creature, target)
creature:RegisterEvent(BlightedZombieTwo.Ability1, 7000, 0)
creature:RegisterEvent(BlightedZombieTwo.Ability2, 12000, 0)
end

function BlightedZombieTwo.Ability1(event, delay, calls, creature)
creature:CastSpell(creature:GetVictim(), 52476, true)
end

function BlightedZombieTwo.Ability2(event, delay, calls, creature)
creature:CastSpell(creature:GetVictim(), 37597, true)
end

function BlightedZombieTwo.OnLeaveCombat(event, creature)
creature:RemoveEvents()
end

function BlightedZombieTwo.OnDeath(event, creature, killer)
    creature:RemoveEvents()
end

RegisterCreatureEvent(4475, 1, BlightedZombieTwo.OnCombat)
RegisterCreatureEvent(4475, 2, BlightedZombieTwo.OnLeaveCombat)
RegisterCreatureEvent(4475, 4, BlightedZombieTwo.OnDeath)
