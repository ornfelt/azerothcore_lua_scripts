local OrgBerserker = {};

local function CastWhirlWind(eventId, delay, calls, creature)
creature:CastSpell(creature:GetVictim(), 53361, true)
end

local function CastEnrage(eventId, delay, calls, creature)
creature:CastSpell(creature, 12880, true)
end

local function OnEnterCombat(event, creature, target)
creature:RegisterEvent(CastWhirlWind, 7000, 0)
creature:RegisterEvent(CastEnrage, 10000, 0)
end

local function OnLeaveCombat(event, creature)
creature:RemoveEvents()
end

local function OnSpawn(event, creature)
creature:CastSpell(creature, 17683, true)
end

local function OnDied(event, creature, killer)
creature:RemoveEvents()
end

RegisterCreatureEvent(400040, 1, OnEnterCombat)
RegisterCreatureEvent(400040, 2, OnLeaveCombat)
RegisterCreatureEvent(400040, 4, OnDied)
RegisterCreatureEvent(400040, 5, OnSpawn)

RegisterCreatureEvent(400045, 1, OnEnterCombat)
RegisterCreatureEvent(400045, 2, OnLeaveCombat)
RegisterCreatureEvent(400045, 4, OnDied)
RegisterCreatureEvent(400045, 5, OnSpawn)

RegisterCreatureEvent(14720, 1, OnEnterCombat)
RegisterCreatureEvent(14720, 2, OnLeaveCombat)
RegisterCreatureEvent(14720, 4, OnDied)
RegisterCreatureEvent(14720, 5, OnSpawn)