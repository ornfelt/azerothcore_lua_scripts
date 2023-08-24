local Turalyon = {};

local function CastCharge(eventId, delay, calls, creature)
creature:CastSpell(creature:GetVictim(), 22911, true)
end

local function CastCrusaderStrike(eventId, delay, calls, creature)
creature:CastSpell(creature:GetVictim(), 66003, true)
end

local function CastDivineStorm(eventId, delay, calls, creature)
creature:CastSpell(creature:GetVictim(), 53385, true)
end

local function CastConsecration(eventId, delay, calls, creature)
creature:CastSpell(creature, 69930, true)
end

local function CastChallengingShout(eventId, delay, calls, creature)
creature:CastSpell(creature, 1161, true)
end


local function ForceDespawn(eventId, delay, calls, creature)
creature:DespawnOrUnsummon(1)
end

local function OnEnterCombat(event, creature, target)
creature:RegisterEvent(CastCharge, 250, 1)
creature:RegisterEvent(CastCrusaderStrike, 5000, 0)
creature:RegisterEvent(CastDivineStorm, 10000, 0)
creature:RegisterEvent(CastConsecration, 15000, 0)
creature:RegisterEvent(CastChallengingShout, 6500, 0)
creature:RegisterEvent(ForceDespawn, 90000, 1)
end

local function OnLeaveCombat(event, creature)
creature:RemoveEvents()
end

local function OnDied(event, creature, killer)
creature:RemoveEvents()
end

RegisterCreatureEvent(400020, 1, OnEnterCombat)
RegisterCreatureEvent(400020, 2, OnLeaveCombat)
RegisterCreatureEvent(400020, 4, OnDied)