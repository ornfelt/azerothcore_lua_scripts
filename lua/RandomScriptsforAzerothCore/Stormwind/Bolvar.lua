local Bolvar = {}

local function CastAS(eventId, delay, calls, creature)
creature:CastSpell(creature:GetVictim(), 32699, true)
end

local function CastHOR(eventId, delay, calls, creature)
creature:CastSpell(creature:GetVictim(), 53595, true)
end

local function CastSunder(eventId, delay, calls, creature)
creature:CastSpell(creature:GetVictim(), 58461, true)
end

local function CastAvengingWrath(event, creature)
creature:CastSpell(creature, 31884, true)
end

local function CastKings(event, creature)
creature:CastSpell(creature, 20217, true)
end

local function OnEnterCombat(event, creature, target)
creature:RegisterEvent(CastAS, 12600, 0)
creature:RegisterEvent(CastHOR, 5000, 0)
creature:RegisterEvent(CastSunder, 10000, 0)
creature:RegisterEvent(CastAvengingWrath, 1, 1)
end

local function OnLeaveCombat(event, creature)
creature:RemoveEvents()
end

local function OnDied(event, creature, killer)
creature:RemoveEvents()
end

local function OnSpawn(event, creature)
creature:CastSpell(creature, 20217, true)
end

RegisterCreatureEvent(1748, 1, OnEnterCombat)
RegisterCreatureEvent(1748, 2, OnLeaveCombat)
RegisterCreatureEvent(1748, 4, OnDied)
RegisterCreatureEvent(1748, 5, OnSpawn)

