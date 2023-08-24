local Rattlegore = {};

local function Thunderclap(eventId, delay, calls, creature)
creature:CastSpell(creature:GetVictim(), 26554, true)
end

local function WhirlwindKnockback(eventId, delay, calls, creature)
creature:CastSpell(creature:GetVictim(), 34109, true)
end

local function Enrage(eventId, delay, calls, creature)
creature:CastSpell(creature, 15716, true)
end

local function BoneArmor(eventId, delay, calls, creature)
creature:CastSpell(creature, 38882, true)
end

local function Thrash(eventId, delay, calls, creature)
creature:CastSpell(creature, 3391, true)
end

local function SweepingStrikes(eventId, delay, calls, creature)
creature:CastSpell(creature, 18765, true)
end

function Stun(eventId, delay, calls, creature)
local targets = creature:GetAITargets(10)
if #targets == 0 then
return
end
local target = targets[math.random(#targets)]
creature:CastSpell(target, 17308, true)
end

local function OnEnterCombat(event, creature, target)
creature:RegisterEvent(Thunderclap, 7000, 0)
creature:RegisterEvent(WhirlwindKnockback, 11000)
creature:RegisterEvent(Stun, 16000, 0)
creature:RegisterEvent(Thrash, 8500, 0)
creature:RegisterEvent(BoneArmor, 15000, 0)
creature:RegisterEvent(BoneArmor, 500, 1)
creature:RegisterEvent(SweepingStrikes, 100, 1)
end

local function OnHealthUpdate(event, creature, value)
if (creature:GetHealthPct() <= 20) then
creature:RemoveEvents()
creature:RegisterEvent(Enrage, 100, 1)
end
end

local function OnLeaveCombat(event, creature)
creature:RemoveEvents()
end

local function OnDied(event, creature, killer)
creature:RemoveEvents()
end

RegisterCreatureEvent(11622, 1, OnEnterCombat)
RegisterCreatureEvent(11622, 9, OnHealthUpdate)
RegisterCreatureEvent(11622, 2, OnLeaveCombat)
RegisterCreatureEvent(11622, 4, OnDied)