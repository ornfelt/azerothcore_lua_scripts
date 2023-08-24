local BlightedZombie = {}

function BlightedZombie.OnSpawn(event, creature)
--creature:SetMaxHealth(17720)
creature:CastSpell(creature:GetVictim(), 17683, true)
end

function BlightedZombie.OnCombat(event, creature, target)
creature:RegisterEvent(BlightedZombie.Ability1, 7000, 0)
creature:RegisterEvent(BlightedZombie.Ability2, 14000, 0)
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
    creature:DespawnOrUnsummon(5000)
    creature:RemoveEvents()
end

RegisterCreatureEvent(400051, 1, BlightedZombie.OnCombat)
RegisterCreatureEvent(400051, 2, BlightedZombie.OnLeaveCombat)
RegisterCreatureEvent(400051, 4, BlightedZombie.OnDeath)
RegisterCreatureEvent(400051, 5, BlightedZombie.OnSpawn)


