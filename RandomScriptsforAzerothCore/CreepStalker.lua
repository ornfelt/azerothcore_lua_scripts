local CreepStalker = {};

local function CastRake(eventId, delay, calls, creature)
    creature:CastSpell(creature:GetVictim(), 9904, true)
end

local function CastStun(eventId, delay, calls, creature)
    creature:CastSpell(creature:GetVictim(), 34510, true)
end

local function OnEnterCombat(event, creature, target)
	    creature:RegisterEvent(CastRake, 5000, 0)
		creature:RegisterEvent(CastStun, 12000, 0)
	end
	
local function OnLeaveCombat(event, creature)
    creature:RemoveEvents()
end

local function OnDied(event, creature, killer)
	creature:DespawnOrUnsummon(5000)
    creature:RemoveEvents()
end

RegisterCreatureEvent(400032, 1, OnEnterCombat)
RegisterCreatureEvent(400032, 2, OnLeaveCombat)
RegisterCreatureEvent(400032, 4, OnDied)