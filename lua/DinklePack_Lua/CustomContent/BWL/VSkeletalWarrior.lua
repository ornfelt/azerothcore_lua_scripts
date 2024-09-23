local VSkeletalWarrior = {}

VSkeletalWarrior.NPC_ID = 400150
VSkeletalWarrior.SPELL_IDS = {
    CLEAVE = 15496,
    ON_SPAWN = 51908
}

function VSkeletalWarrior.CastCleave(eventId, delay, calls, creature)
    creature:CastSpell(creature:GetVictim(), VSkeletalWarrior.SPELL_IDS.CLEAVE, true)
end

function VSkeletalWarrior.OnEnterCombat(event, creature, target)
    creature:RegisterEvent(VSkeletalWarrior.CastCleave, math.random(8000, 12000), 0)
end

function VSkeletalWarrior.OnLeaveCombat(event, creature)
    creature:RemoveEvents()
end

function VSkeletalWarrior.OnDied(event, creature, killer)
    creature:DespawnOrUnsummon(5000)
    creature:RemoveEvents()
end

function VSkeletalWarrior.OnSpawn(event, creature)
    creature:CastSpell(creature, VSkeletalWarrior.SPELL_IDS.ON_SPAWN, true)
end

RegisterCreatureEvent(VSkeletalWarrior.NPC_ID, 1, VSkeletalWarrior.OnEnterCombat)
RegisterCreatureEvent(VSkeletalWarrior.NPC_ID, 2, VSkeletalWarrior.OnLeaveCombat)
RegisterCreatureEvent(VSkeletalWarrior.NPC_ID, 4, VSkeletalWarrior.OnDied)
RegisterCreatureEvent(VSkeletalWarrior.NPC_ID, 5, VSkeletalWarrior.OnSpawn)
