Golemagg = {} 

-- I did not use the spell que system for this fight as his cast spell skipcheck is set to 'true' meaning all are free casts and instant casts, except earthquake which won't get interrupted
-- This fight is closer in line with SoM Golemagg. 
-- Function to cast Pyroblast spell on a random target
function Golemagg.CastPyroblast(eventId, delay, calls, creature) 
local targets = creature:GetAITargets() -- Get a list of the creature's current AI targets (players or NPCs in combat with it)
local target = targets[math.random(#targets)] -- Choose a random target from the list
creature:CastSpell(target, 20228, true) -- Cast Pyroblast (spell id 20228) on the chosen target
end

function Golemagg.CastEarthquake(eventId, delay, calls, creature)
creature:CastSpell(creature, 19798, false) -- Cast Earthquake (spell id 19798) on the creature itself
delay = math.max(5000, delay * 0.9) -- Decrease the delay by 10% each time, with a minimum delay of 5 seconds. This is a soft enrage
creature:RegisterEvent(Golemagg.CastEarthquake, delay, 0) -- Schedule the next Earthquake
end

-- Function to execute when the creature enters combat
function Golemagg.OnEnterCombat(event, creature, target)
creature:RegisterEvent(Golemagg.CastPyroblast, math.random(3000, 7000), 0)
creature:RegisterEvent(Golemagg.CastEarthquake, 24000, 0) -- Schedule the first Earthquake
-- Cast three different spells on the creature itself as soon as combat starts
creature:CastSpell(creature, 13879, true) -- Magma Splash, which procs a periodic aura. 'Splashes the target with Magma, melting its armor, dealing Fire damage and additional Fire damage for 30 sec.' Requires tank swapping.
creature:CastSpell(creature, 20556, true) -- don't know what this spell is lol. I think it was in cpp code so I put it in 
creature:CastSpell(creature, 18943, true) -- spell to periodically generates an extra attack.
end

function Golemagg.OnLeaveCombat(event, creature)
creature:RemoveEvents()
end

function Golemagg.OnDied(event, creature, killer)
creature:RemoveEvents()
end

function Golemagg.OnSpawn(event, creature)
--creature:SetMaxHealth(1652176) -- you can actually set creature hp in lua but is not advisable with auto balance since it won't be overwritten by autobalance
end

RegisterCreatureEvent(11988, 1, Golemagg.OnEnterCombat)
RegisterCreatureEvent(11988, 2, Golemagg.OnLeaveCombat)
RegisterCreatureEvent(11988, 4, Golemagg.OnDied)
RegisterCreatureEvent(11988, 5, Golemagg.OnSpawn)
