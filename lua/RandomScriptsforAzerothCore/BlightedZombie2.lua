local BlightedZombie = {}

function BlightedZombie.OnCombat(event, creature, target)
creature:RegisterEvent(BlightedZombie.Ability1, 7000, 0)
creature:RegisterEvent(BlightedZombie.Ability2, 12000, 0)
end

function BlightedZombie.Ability1(event, delay, calls, creature)
creature:CastSpell(creature:GetVictim(), 52476, true)
end

function BlightedZombie.Ability2(event, delay, calls, creature)
creature:CastSpell(creature:GetVictim(), 37597, true)
end

function BlightedZombie.OnLeaveCombat(event, creature)
creature:RemoveEvents()
end

function BlightedZombie.OnDeath(event, creature, killer)
    creature:RemoveEvents()
end

RegisterCreatureEvent(4475, 1, BlightedZombie.OnCombat)
RegisterCreatureEvent(4475, 2, BlightedZombie.OnLeaveCombat)
RegisterCreatureEvent(4475, 4, BlightedZombie.OnDeath)
