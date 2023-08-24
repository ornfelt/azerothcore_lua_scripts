local Laurena = {};

local function CastSmite(eventId, delay, calls, creature)
    creature:CastSpell(creature:GetVictim(), 10934, true)
end

local function OnEnterCombat(event, creature, target)
	    creature:RegisterEvent(CastSmite, 3000, 0)
	end
	
local function OnLeaveCombat(event, creature)
    creature:RemoveEvents()
end

local function OnDied(event, creature, killer)
    creature:RemoveEvents()
end

RegisterCreatureEvent(376, 1, OnEnterCombat)
RegisterCreatureEvent(376, 2, OnLeaveCombat)
RegisterCreatureEvent(376, 4, OnDied)