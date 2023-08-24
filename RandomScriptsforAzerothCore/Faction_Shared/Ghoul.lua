local Ghoul = {};

local function CastLeap(eventId, delay, calls, creature)
    creature:CastSpell(creature:GetVictim(), 47482, true)
end

local function CastPlague(eventId, delay, calls, creature)
    creature:CastSpell(creature:GetVictim(), 52230, true)
end

local function CastExplode(eventId, delay, calls, creature)
creature:CastSpell(creature, 47496, true)
end

local function OnEnterCombat(event, creature, target)
	creature:RegisterEvent(CastLeap, 100, 1)
	creature:RegisterEvent(CastPlague, 100, 1)
	creature:RegisterEvent(CastPlague, 20000, 0)
	creature:RegisterEvent(CastExplode, 23000, 0)
	end
	
local function OnLeaveCombat(event, creature)
    creature:RemoveEvents()
end

local function OnDied(event, creature, killer)
	creature:DespawnOrUnsummon(5000)
    creature:RemoveEvents()
end

RegisterCreatureEvent(400047, 1, OnEnterCombat)
RegisterCreatureEvent(400047, 2, OnLeaveCombat)
RegisterCreatureEvent(400047, 4, OnDied)