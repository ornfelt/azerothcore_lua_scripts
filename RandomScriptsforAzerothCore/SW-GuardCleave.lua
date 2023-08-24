local Stormwind = {};

local function CastCleave(eventId, delay, calls, creature)
    creature:CastSpell(creature:GetVictim(), 20677, true)
end

local function CastSunderArmor(eventId, delay, calls, creature)
    creature:CastSpell(creature:GetVictim(), 8380, true)
end

local function OnEnterCombat(event, creature, target)
	    creature:RegisterEvent(CastCleave, 5000, 0)
		creature:RegisterEvent(CastSunderArmor, 7000, 0)
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

RegisterCreatureEvent(400039, 1, OnEnterCombat)
RegisterCreatureEvent(400039, 2, OnLeaveCombat)
RegisterCreatureEvent(400039, 4, OnDied)
RegisterCreatureEvent(400039, 5, OnSpawn)