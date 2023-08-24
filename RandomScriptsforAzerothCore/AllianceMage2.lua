local AMage = {}

local function CastFireball(eventId, delay, calls, creature)
creature:CastSpell(creature:GetVictim(), 38692, true)
end

local function CastFrostbolt(eventId, delay, calls, creature)
creature:CastSpell(creature:GetVictim(), 27071, true)
end

local function CastBlizzard(eventId, delay, calls, creature)
creature:CastSpell(creature:GetVictim(), 42213, true)
end

local function CastArcaneExplosion(eventId, delay, calls, creature)
creature:CastSpell(creature:GetVictim(), 19712, true)
end

local function OnEnterCombat(event, creature, target)
creature:RegisterEvent(CastFireball, 3600, 0)
creature:RegisterEvent(CastFrostbolt, 7200, 0)
creature:RegisterEvent(CastBlizzard, 9000, 0)
creature:RegisterEvent(CastArcaneExplosion, 10800, 0)
end

local function OnLeaveCombat(event, creature)
creature:RemoveEvents()
end

local function OnDied(event, creature, killer)
creature:RemoveEvents()
end

RegisterCreatureEvent(400027, 1, OnEnterCombat)
RegisterCreatureEvent(400027, 2, OnLeaveCombat)
RegisterCreatureEvent(400027, 4, OnDied)