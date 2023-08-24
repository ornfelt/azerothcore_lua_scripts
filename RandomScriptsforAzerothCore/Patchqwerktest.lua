local Patchqwerk = {}

function Patchqwerk.OnSpawn(event, creature)
creature:SendUnitYell("Patchqwerk make Lich King proud! You die now!",0)
creature:CastSpell(creature, 41924, true) 
end

function Patchqwerk.PoisonBoltVolley(eventId, delay, calls, creature)
creature:CastSpell(creature:GetVictim(), 40095, true)
end

function Patchqwerk.CastHatefulStrike(eventId, delay, calls, creature)
creature:CastSpell(creature:GetVictim(), 28308, true)
end

function Patchqwerk.CastGore(eventId, delay, calls, creature)
creature:CastSpell(creature:GetVictim(), 48130, true)
end

function Patchqwerk.OnEnterCombat(event, creature, target)
local yellOptions = { "Patchqwerk huuuuungry!", "Time for a snack!", "You're mine now!", "You look delicious. Patchqwerk eat you now!", "I not eat in days, time to feast!", "Me smash and eat you now!", "Me so hungry, me eat anything... even you!" }
local randomIndex = math.random(1, 7)
local selectedYell = yellOptions[randomIndex]
creature:SendUnitYell(selectedYell, 0)
creature:RegisterEvent(Patchqwerk.PoisonBoltVolley, 7000, 0)
creature:RegisterEvent(Patchqwerk.CastHatefulStrike, 15000, 0)
creature:RegisterEvent(Patchqwerk.CastGore, 20000, 0)
end

function Patchqwerk.OnLeaveCombat(event, creature)
local yellOptions = { "You not so tasty afterall...", "I be back for seconds!", "No more play? Too bad...", "Maybe next time you taste better!","Me still hungry, come back later!","You not enough food, me go find more!", "Awww...You no stay for dinner? You make Patchqwerk sad." }
local randomIndex = math.random(1, 7)
local selectedYell = yellOptions[randomIndex]
creature:SendUnitYell(selectedYell, 0)
creature:RemoveEvents()
end

function Patchqwerk.OnDied(event, creature, killer)
creature:SendUnitYell("Patchqwerk forget to chew...", 0)
if(killer:GetObjectType() == "Player") then
killer:SendBroadcastMessage("You killed " ..creature:GetName().."!")
end
creature:RemoveEvents()
end

function Patchqwerk.CheckHealth(event, creature)
if (creature:HealthBelowPct(20)) then
creature:SendUnitYell("Patchqwerk go berserk!", 0)
creature:CastSpell(creature, 41305, true) -- Cast the berserk spell (ID 41305)
elseif (creature:HealthAbovePct(95)) then
creature:CastSpell(creature, 41924, true) -- Cast the other berserk spell (ID 41924)
end
end

RegisterCreatureEvent(400012, 1, Patchqwerk.OnEnterCombat)
RegisterCreatureEvent(400012, 2, Patchqwerk.OnLeaveCombat)
RegisterCreatureEvent(400012, 4, Patchqwerk.OnDied)
RegisterCreatureEvent(400012, 5, Patchqwerk.OnSpawn)
RegisterCreatureEvent(400012, 6, Patchqwerk.CheckHealth)


