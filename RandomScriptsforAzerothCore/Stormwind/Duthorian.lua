local DuthorianRall = {};

local function CastJoL(eventId, delay, calls, creature)
    creature:CastSpell(creature:GetVictim(), 20185, true)
end

local function OnEnterCombat(event, creature, target)
	    creature:RegisterEvent(CastJoL, 5000, 0)
	end
	
local function OnLeaveCombat(event, creature)
    creature:RemoveEvents()
end

local function OnDied(event, creature, killer)
    creature:RemoveEvents()
end

RegisterCreatureEvent(6171, 1, OnEnterCombat)
RegisterCreatureEvent(6171, 2, OnLeaveCombat)
RegisterCreatureEvent(6171, 4, OnDied)