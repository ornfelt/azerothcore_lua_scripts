local DarkRanger = {}

local function CastShoot(eventId, delay, calls, creature)
creature:CastSpell(target, 37770, true) -- cast shoot on target
end


local function CastBlackArrow(eventId, delay, calls, creature)
    creature:CastSpell(creature:GetVictim(), 63671, true)
end

local function CastExplodingShot(eventId, delay, calls, creature)
    creature:CastSpell(creature:GetVictim(), 33792, true)
end

local function CastBarrage(eventId, delay, calls, creature)
    creature:CastSpell(creature:GetVictim(), 10188, true)
end

local function OnEnterCombat(event, creature, target)
    creature:RegisterEvent(CastShoot, 750, 0)
    creature:RegisterEvent(CastBlackArrow, 16000, 0)
    creature:RegisterEvent(CastBarrage, 10000, 0)
	creature:RegisterEvent(CastExplodingShot, 7000, 0)
end

local function OnLeaveCombat(event, creature)
    creature:RemoveEvents()
end

local function OnDied(event, creature, killer)
    creature:RemoveEvents()
end

RegisterCreatureEvent(400072, 1, OnEnterCombat)
RegisterCreatureEvent(400072, 2, OnLeaveCombat)
RegisterCreatureEvent(400072, 4, OnDied)

RegisterCreatureEvent(400073, 1, OnEnterCombat)
RegisterCreatureEvent(400073, 2, OnLeaveCombat)
RegisterCreatureEvent(400073, 4, OnDied)

