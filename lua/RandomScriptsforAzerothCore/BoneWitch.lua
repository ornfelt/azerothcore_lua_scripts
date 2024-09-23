local BoneWitch = {};


local function CastBoneShards(eventId, delay, calls, creature)
    creature:CastSpell(creature, 17014, true)
end

local function OnSpawn(event, creature, target)
		creature:RegisterEvent(CastBoneShards, 100, 1)
		creature:RegisterEvent(CastBoneShards, 14000, 0)
	end
	
local function OnDied(event, creature, killer)
	creature:DespawnOrUnsummon(25000)
    creature:RemoveEvents()
end

RegisterCreatureEvent(16380, 5, OnSpawn)
RegisterCreatureEvent(16380, 4, OnDied)