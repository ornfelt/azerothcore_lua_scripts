local BW_NPC_ID = 16380

BoneWitch = {}

local function CastBoneShards(eventId, delay, calls, creature)
    creature:CastSpell(creature, 17014, true)
end

function BoneWitch.OnSpawn(event, creature, target)
    creature:RegisterEvent(CastBoneShards, 100, 1)
    creature:RegisterEvent(CastBoneShards, 14000, 0)
end

function BoneWitch.OnDied(event, creature, killer)
    creature:DespawnOrUnsummon(25000)
    creature:RemoveEvents()
end

RegisterCreatureEvent(BW_NPC_ID, 5, BoneWitch.OnSpawn)
RegisterCreatureEvent(BW_NPC_ID, 4, BoneWitch.OnDied)
