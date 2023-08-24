local LakeshireGuard = {};

local function CastCleave(eventId, delay, calls, creature)
    creature:CastSpell(creature:GetVictim(), 20605, true)
end

local function OnEnterCombat(event, creature, target)
	    creature:RegisterEvent(CastCleave, 9000, 0)
	end
	
local function OnLeaveCombat(event, creature)
    creature:RemoveEvents()
end

local function OnDied(event, creature, killer)
    creature:RemoveEvents()
end

local function OnSpawn(event, creature)
creature:CastSpell(creature, 17683, true)
end

RegisterCreatureEvent(400013, 1, OnEnterCombat)
RegisterCreatureEvent(400013, 2, OnLeaveCombat)
RegisterCreatureEvent(400013, 4, OnDied)
RegisterCreatureEvent(400013, 5, OnSpawn)

