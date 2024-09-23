local FleshFlayer = {};

local function CastLeap(eventId, delay, calls, creature)
    creature:CastSpell(creature:GetVictim(), 47482, true)
end

local function CastPlague(eventId, delay, calls, creature)
    creature:CastSpell(creature:GetVictim(), 52230, true)
end

local function CastExplode(eventId, delay, calls, creature)
creature:CastSpell(creature, 47496, true)
end

local function CastRend(eventId, delay, calls, creature)
creature:CastSpell(creature:GetVictim(), 18106, true)
end

local function OnEnterCombat(event, creature, target)
	    creature:RegisterEvent(CastLeap, 100, 1)
		creature:RegisterEvent(CastPlague, 500, 1)
		creature:RegisterEvent(CastRend, 2000, 1)
		creature:RegisterEvent(CastPlague, 20000, 0)
		creature:RegisterEvent(CastExplode, 30000, 0)
	end
	
local function OnLeaveCombat(event, creature)
    creature:RemoveEvents()
end

local function OnDied(event, creature, killer)
    creature:RemoveEvents()
end

RegisterCreatureEvent(10407, 1, OnEnterCombat)
RegisterCreatureEvent(10407, 2, OnLeaveCombat)
RegisterCreatureEvent(10407, 4, OnDied)