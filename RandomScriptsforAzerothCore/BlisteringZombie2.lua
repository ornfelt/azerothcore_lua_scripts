local BlisteringZombie = {};

function BlisteringZombie.OnSpawn(event, creature)
creature:SetMaxHealth(8224)
creature:CastSpell(creature:GetVictim(), 17683, true)
end

function BlisteringZombie.OnCombat(event, creature, target)
creature:RegisterEvent(BlisteringZombie.Ability1, 8000, 0)
end

function BlisteringZombie.Ability1(event, delay, calls, creature)
creature:CastSpell(creature:GetVictim(), 55604, true)
end

function BlisteringZombie.OnLeaveCombat(event, creature)
creature:RemoveEvents()
end

function BlisteringZombie.OnDeath(event, creature, killer)
    creature:DespawnOrUnsummon(10000)
    creature:RemoveEvents()
end

RegisterCreatureEvent(400077, 1, BlisteringZombie.OnCombat)
RegisterCreatureEvent(400077, 2, BlisteringZombie.OnLeaveCombat)
RegisterCreatureEvent(400077, 4, BlisteringZombie.OnDeath)
RegisterCreatureEvent(400077, 5, BlisteringZombie.OnSpawn)