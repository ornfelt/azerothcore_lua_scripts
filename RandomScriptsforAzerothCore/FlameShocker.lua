local FlameShocker = {};


local function CastFlameShock(eventId, delay, calls, creature)
    creature:CastSpell(creature:GetVictim(), 10448, true)
end

local function OnEnterCombat(event, creature, target)
		creature:RegisterEvent(CastFlameShock, 100, 1)
		creature:RegisterEvent(CastFlameShock, 8000, 0)
	end
	
	local function OnLeaveCombat(event, creature)
    creature:RemoveEvents()
end
	
local function OnDied(event, creature, killer)
	creature:CastSpell(killer, 28323, true)
	creature:DespawnOrUnsummon(25000)
    creature:RemoveEvents()
end

RegisterCreatureEvent(16383, 1, OnEnterCombat)
RegisterCreatureEvent(16383, 2, OnLeaveCombat)
RegisterCreatureEvent(16383, 4, OnDied)