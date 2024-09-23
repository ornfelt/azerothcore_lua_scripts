local SkeletalWarriorn = {}
SkeletalWarriorn.NPC_ID = 400016

function SkeletalWarriorn.OnSpawn(event, creature)
    --creature:SetMaxHealth(7720)
    creature:SetEquipmentSlots(10570, 0, 0)
    creature:CastSpell(creature:GetVictim(), 17683, true)
end

function SkeletalWarriorn.OnCombat(event, creature, target)
    creature:RegisterEvent(SkeletalWarriorn.Ability1, 10000, 0)
end

function SkeletalWarriorn.Ability1(event, delay, calls, creature)
    creature:CastSpell(creature:GetVictim(), 6547, true)
end

function SkeletalWarriorn.OnLeaveCombat(event, creature)
    creature:RemoveEvents()
end

function SkeletalWarriorn.OnDeath(event, creature, killer)
    creature:DespawnOrUnsummon(10000)
    creature:RemoveEvents()
end

RegisterCreatureEvent(SkeletalWarriorn.NPC_ID, 1, SkeletalWarriorn.OnCombat)
RegisterCreatureEvent(SkeletalWarriorn.NPC_ID, 2, SkeletalWarriorn.OnLeaveCombat)
RegisterCreatureEvent(SkeletalWarriorn.NPC_ID, 4, SkeletalWarriorn.OnDeath)
RegisterCreatureEvent(SkeletalWarriorn.NPC_ID, 5, SkeletalWarriorn.OnSpawn)
