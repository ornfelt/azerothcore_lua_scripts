local RisenConstruct = {};

local function ArcingSmash(eventId, delay, calls, creature)
creature:CastSpell(creature:GetVictim(), 1619, true)
end

local function Enrage(eventId, delay, calls, creature)
creature:CastSpell(creature, 15716, true)
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
creature:RegisterEvent(ArcingSmash, 7000, 0)
creature:RegisterEvent(Stun, 13000, 0)
creature:RegisterEvent(Thrash, 8500, 0)
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

RegisterCreatureEvent(10488, 1, OnEnterCombat)
RegisterCreatureEvent(10488, 9, OnHealthUpdate)
RegisterCreatureEvent(10488, 2, OnLeaveCombat)
RegisterCreatureEvent(10488, 4, OnDied)