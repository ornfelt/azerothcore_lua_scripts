local Hunter = {};

local function CastRapidShot(eventId, delay, calls, creature)
local victim = creature:GetVictim()
creature:CastSpell(victim, 71251, true)
end

local function CastSummonTamedBear(eventId, delay, calls, creature)
local victim = creature:GetVictim()
creature:CastSpell(victim, 7903, true)
end

local function CastWhirlwind(eventId, delay, calls, creature)
local victim = creature:GetVictim()
creature:CastSpell(victim, 1680, false)
end

local function CastExplosiveTrap(eventId, delay, calls, creature)
local victim = creature:GetVictim()
creature:CastSpell(victim, 49066, false)
end

local function CastMortalStrike(eventId, delay, calls, creature)
local victim = creature:GetVictim()
creature:CastSpell(victim, 30330, false)
end

local function CastDisengage(eventId, delay, calls, creature)
local victim = creature:GetVictim()
creature:CastSpell(victim, 57635, false)
end

local function CastRoot(eventId, delay, calls, creature)
local victim = creature:GetVictim()
creature:CastSpell(victim, 50762, false)
end

local function CastFD(eventId, delay, calls, creature)
creature:CastSpell(creature, 23604, false)
end

local function OnEnterCombat(event, creature, target)
local sayings = {
"You dare enter my territory?",
"I'll make sure you never come back!",
"You won't make it out of here alive!",
"You're nothing but prey to me!"
}
local index = math.random(1, #sayings)
creature:SendUnitSay(sayings[index], 0)
creature:RegisterEvent(CastFD, 100, 1)
creature:RegisterEvent(CastRoot, 10300, 0)
creature:RegisterEvent(CastDisengage, 10400, 0)
creature:RegisterEvent(CastRapidShot, 11000, 0)
creature:RegisterEvent(CastWhirlwind, 6100, 0)
creature:RegisterEvent(CastExplosiveTrap, 12600, 0)
creature:RegisterEvent(CastMortalStrike, 5300, 0)
creature:RegisterEvent(CastSummonTamedBear, 5, 1)
end

local function OnLeaveCombat(event, creature)
creature:SendUnitSay("You are not worth my time.", 0)
creature:RemoveEvents()
end

local function OnDied(event, creature, killer)
creature:SendUnitSay("You may have defeated me, but the hunt continues.", 0)
creature:RemoveEvents()
end

local function OnSpawn(event, creature)
creature:SendUnitSay("The hunt begins.", 0)
end

RegisterCreatureEvent(7295, 1, OnEnterCombat)
RegisterCreatureEvent(7295, 2, OnLeaveCombat)
RegisterCreatureEvent(7295, 4, OnDied)
RegisterCreatureEvent(7295, 5, OnSpawn)