Golemagg = {}
Golemagg.enraged = {}

function Golemagg.CastPyroblast(eventId, delay, calls, creature)
local targets = creature:GetAITargets()
local target = targets[math.random(#targets)]
creature:CastSpell(target, 20228, true)
end

function Golemagg.CastEarthquake(eventId, delay, calls, creature)
creature:CastSpell(creature, 19798, false)
creature:RegisterEvent(Golemagg.CastEarthquake, 17000, 0)
end

function Golemagg.DamageTaken(event, creature, attacker, damage)
if not Golemagg.enraged[creature:GetGUID()] and creature:GetHealthPct() < 10 then
creature:CastSpell(creature, 20544, true)
creature:CastSpell(creature, 19798, true)
creature:RegisterEvent(Golemagg.CastEarthquake, 5300, 1)
Golemagg.enraged[creature:GetGUID()] = true
end
end

function Golemagg.OnEnterCombat(event, creature, target)
creature:RegisterEvent(Golemagg.CastPyroblast, math.random(3000, 7000), 0)
creature:CastSpell(creature, 13879, true)
creature:CastSpell(creature, 20556, true)
creature:CastSpell(creature, 18943, true)
end

function Golemagg.OnLeaveCombat(event, creature)
creature:RemoveEvents()
end

function Golemagg.OnDied(event, creature, killer)
creature:RemoveEvents()
Golemagg.enraged[creature:GetGUID()] = nil
end

function Golemagg.OnSpawn(event, creature)
--creature:SetMaxHealth(1652176)
Golemagg.enraged[creature:GetGUID()] = false
end

RegisterCreatureEvent(11988, 1, Golemagg.OnEnterCombat)
RegisterCreatureEvent(11988, 2, Golemagg.OnLeaveCombat)
RegisterCreatureEvent(11988, 4, Golemagg.OnDied)
RegisterCreatureEvent(11988, 5, Golemagg.OnSpawn)
RegisterCreatureEvent(11988, 9, Golemagg.DamageTaken)