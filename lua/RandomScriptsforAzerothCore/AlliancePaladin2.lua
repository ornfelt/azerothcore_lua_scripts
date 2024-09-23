local AlliancePaladin = {}

local function CastCS(eventId, delay, calls, creature)
creature:CastSpell(creature, 35395, true)
end

local function CastCons(eventId, delay, calls, creature)
creature:CastSpell(creature:GetVictim(), 20924, true)
end

local function CastDS(eventId, delay, calls, creature)
creature:CastSpell(creature:GetVictim(), 53385, true)
end

local function CastJOL(eventId, delay, calls, creature)
creature:CastSpell(creature:GetVictim(), 20271, true)
end

local function CastAvengingWrath(event, creature)
creature:CastSpell(creature, 31884, true)
end

local function CastKings(event, creature)
creature:CastSpell(creature, 20217, true)
end

local function OnEnterCombat(event, creature, target)
creature:RegisterEvent(CastCS, 6000, 0)
creature:RegisterEvent(CastCons, 8000, 0)
creature:RegisterEvent(CastDS, 10000, 0)
creature:RegisterEvent(CastJOL, 11000, 0)
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

RegisterCreatureEvent(400030, 1, OnEnterCombat)
RegisterCreatureEvent(400030, 2, OnLeaveCombat)
RegisterCreatureEvent(400030, 4, OnDied)
RegisterCreatureEvent(400030, 5, OnSpawn)

