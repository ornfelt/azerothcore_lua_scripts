local Archer = {};

local function CastShoot(eventId, delay, calls, creature)
    creature:CastSpell(creature:GetVictim(), 37770, true)
end

local function CastSerpentSting(eventId, delay, calls, creature)
    creature:CastSpell(creature:GetVictim(), 36984, true)
end

local function CastMultiShot(eventId, delay, calls, creature)
    creature:CastSpell(creature:GetVictim(), 30990, true)
end

local function OnEnterCombat(event, creature, target)
	    creature:RegisterEvent(CastShoot, 750, 0)
		creature:RegisterEvent(CastShoot, 15000, 0)
		creature:RegisterEvent(CastMultiShot, 5000, 0)
	end
	
local function OnLeaveCombat(event, creature)
    creature:RemoveEvents()
end

local function OnDied(event, creature, killer)
    creature:RemoveEvents()
end

RegisterCreatureEvent(400033, 1, OnEnterCombat)
RegisterCreatureEvent(400033, 2, OnLeaveCombat)
RegisterCreatureEvent(400033, 4, OnDied)