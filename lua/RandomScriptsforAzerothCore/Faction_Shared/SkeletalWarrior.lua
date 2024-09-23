local SkeletalWarrior = {}



function SkeletalWarrior.OnSpawn(event, creature)
--creature:SetMaxHealth(7720)
creature:SetEquipmentSlots(10570, 0, 0)
creature:CastSpell(creature:GetVictim(), 17683, true)
end

function SkeletalWarrior.OnCombat(event, creature, target)
creature:RegisterEvent(SkeletalWarrior.Ability1, 10000, 0)
end

function SkeletalWarrior.Ability1(event, delay, calls, creature)
creature:CastSpell(creature:GetVictim(), 6547, true)
end

function SkeletalWarrior.OnLeaveCombat(event, creature)
creature:RemoveEvents()
end

function SkeletalWarrior.OnDeath(event, creature, killer)
    creature:DespawnOrUnsummon(10000)
    creature:RemoveEvents()
end

RegisterCreatureEvent(400016, 1, SkeletalWarrior.OnCombat)
RegisterCreatureEvent(400016, 2, SkeletalWarrior.OnLeaveCombat)
RegisterCreatureEvent(400016, 4, SkeletalWarrior.OnDeath)
RegisterCreatureEvent(400016, 5, SkeletalWarrior.OnSpawn)
