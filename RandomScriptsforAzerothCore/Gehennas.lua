Gehennas = {}

function Gehennas.CastGehennasCurse(eventId, delay, calls, creature)
creature:CastSpell(creature:GetVictim(), 19716, true)
end

function Gehennas.CastRainOfFire(eventId, delay, calls, creature)
local targets = creature:GetAITargets(10)
local target = targets[math.random(#targets)]
creature:CastSpell(target, 19717, true)
end

function Gehennas.CastShadowBolt(eventId, delay, calls, creature)
local random = math.random(0,1)
if random == 0 then
creature:CastSpell(creature:GetVictim(), 19729, true)
else
local targets = creature:GetAITargets(10)
local target = targets[math.random(#targets)]
creature:CastSpell(target, 19728, true)
end
end

function Gehennas.CastShadowboltVolley(eventId, delay, calls, creature)
creature:CastSpell(creature:GetVictim(), 36275, true)
end

function Gehennas.OnEnterCombat(event, creature, target)
creature:RegisterEvent(Gehennas.CastGehennasCurse, math.random(25000, 30000), 0)
creature:RegisterEvent(Gehennas.CastRainOfFire, 6000, 0)
creature:RegisterEvent(Gehennas.CastShadowBolt, 5000, 0)
creature:RegisterEvent(Gehennas.CastShadowboltVolley, 15000, 0)
end

function Gehennas.OnLeaveCombat(event, creature)
creature:RemoveEvents()
end

function Gehennas.OnDied(event, creature, killer)
creature:RemoveEvents()
end

function Gehennas.OnSpawn(event, creature)
creature:SetMaxHealth(648000)
end

RegisterCreatureEvent(12259, 1, Gehennas.OnEnterCombat)
RegisterCreatureEvent(12259, 2, Gehennas.OnLeaveCombat)
RegisterCreatureEvent(12259, 4, Gehennas.OnDied)
RegisterCreatureEvent(12259, 5, Gehennas.OnSpawn)