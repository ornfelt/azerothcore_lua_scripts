local StoneskinGargoyle = {}

local function GustOfWind(eventId, delay, calls, creature)
creature:CastSpell(creature:GetVictim(), 61663, true)
end

local function StoneStomp(eventId, delay, calls, creature)
local targets = creature:GetAITargets(10)
if #targets == 0 then
return
end
local target = targets[math.random(#targets)]
creature:CastSpell(target, 49675, true)
end

local function OnEnterCombat(event, creature, target)
creature:RegisterEvent(GustOfWind, 15000, 0)
creature:RegisterEvent(StoneStomp, 8000, 0)
end

local function OnLeaveCombat(event, creature)
creature:RemoveEvents()
end

local function OnDied(event, creature, killer)
creature:DespawnOrUnsummon(5000)
creature:RemoveEvents()
end

RegisterCreatureEvent(400053, 1, OnEnterCombat)
RegisterCreatureEvent(400053, 2, OnLeaveCombat)
RegisterCreatureEvent(400053, 4, OnDied)