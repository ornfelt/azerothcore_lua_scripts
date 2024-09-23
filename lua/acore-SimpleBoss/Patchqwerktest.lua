local Patchqwerk = {} 

function Patchqwerk.OnSpawn(event, creature)
creature:SendUnitYell("Patchqwerk make Lich King proud! You die now!",0)
creature:SetMaxHealth(46664000)
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
local selectedYell = yellOptions[randomIndex] --script pulls one dialogue option from above upon entering combat.
creature:SendUnitYell(selectedYell, 0)
creature:RegisterEvent(Patchqwerk.PoisonBoltVolley, 7000, 0)
creature:RegisterEvent(Patchqwerk.CastHatefulStrike, 15000, 0)
creature:RegisterEvent(Patchqwerk.CastGore, 20000, 0)
end

function Patchqwerk.OnLeaveCombat(event, creature)
local yellOptions = { "You not so tasty afterall...", "I'll be back for seconds!", "No more play? Too bad...", "Maybe next time you'll taste better!","Me still hungry, come back later!","You not enough food, me go find more!" }
local randomIndex = math.random(1, 6)
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

RegisterCreatureEvent(400012, 1, Patchqwerk.OnEnterCombat)
RegisterCreatureEvent(400012, 2, Patchqwerk.OnLeaveCombat)
RegisterCreatureEvent(400012, 4, Patchqwerk.OnDied)
RegisterCreatureEvent(400012, 5, Patchqwerk.OnSpawn)
local function CastTrample(eventId, delay, calls, creature) --CastTrample, CastHatefulStrike, and CastGore are functions that cast spells on the creature's target (obtained through creature:GetVictim()). The spells cast are specified by their spell IDs (5568, 28308, and 48130 respectively).
    creature:CastSpell(creature:GetVictim(), 5568, true)
end

local function CastHatefulStrike(eventId, delay, calls, creature) 
    creature:CastSpell(creature:GetVictim(), 28308, true)
end

local function CastGore(eventId, delay, calls, creature)
    creature:CastSpell(creature:GetVictim(), 48130, true)
end

local function OnEnterCombat(event, creature, target) --OnEnterCombat is a function that is triggered when the creature enters combat, it sends a unit yell message and registers the spells from the first 3 functions to be cast every 10, 15 and 20 seconds respectively.
	local yellOptions = { "Patchqwerk huuuuungry!", "Time for a snack!", "You're mine now!", "You look delicious. Patchqwerk eat you now!", "I not eat in days, time to feast!", "Me smash and eat you now!", "Me so hungry, me eat anything... even you!" }
	local randomIndex = math.random(1, 7) --7 = number of dialogue options
	local selectedYell = yellOptions[randomIndex] --script pulls one dialogue option from above upon entering combat.
	creature:SendUnitYell(selectedYell, 0)
	creature:RegisterEvent(CastTrample, 10000, 0) --The 0 in creature:RegisterEvent(CastTrample, 10000, 0) is the number of times the event will be called. In this case, 0 means the event will be called an unlimited number of times until the creature is killed or leaves combat. If you set it to 1, for example, the event will only be called once and then stop.
	creature:RegisterEvent(CastHatefulStrike, 15000, 0)
	creature:RegisterEvent(CastGore, 20000, 0)
end
	
local function OnLeaveCombat(event, creature) --Stuff the creature will do upon leaving combat, in this case yell
	local yellOptions = { "You not so tasty afterall...", "I'll be back for seconds!", "No more play? Too bad...", "Maybe next time you'll taste better!","Me still hungry, come back later!","You not enough food, me go find more!" }
	local randomIndex = math.random(1, 6)
	local selectedYell = yellOptions[randomIndex]
	creature:SendUnitYell(selectedYell, 0)
	creature:RemoveEvents()
end

local function OnDied(event, creature, killer) --OnDied is a function that is triggered when the creature dies. Creature sends Yell and broadcast message. If the killer is a player, it sends a broadcast message to the player with the text "You killed <creature name>!". The function also removes all registered events.
    creature:SendUnitYell("Patchqwerk forget to chew...", 0)
	if(killer:GetObjectType() == "Player") then
        killer:SendBroadcastMessage("You killed " ..creature:GetName().."!")
    endlocal Patchqwerk = {} 

function Patchqwerk.OnSpawn(event, creature)
creature:SendUnitYell("Patchqwerk make Lich King proud! You die now!",0)
creature:SetMaxHealth(46664000)
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
local selectedYell = yellOptions[randomIndex] --script pulls one dialogue option from above upon entering combat.
creature:SendUnitYell(selectedYell, 0)
creature:RegisterEvent(Patchqwerk.PoisonBoltVolley, 7000, 0)
creature:RegisterEvent(Patchqwerk.CastHatefulStrike, 15000, 0)
creature:RegisterEvent(Patchqwerk.CastGore, 20000, 0)
end

function Patchqwerk.OnLeaveCombat(event, creature)
local yellOptions = { "You not so tasty afterall...", "I'll be back for seconds!", "No more play? Too bad...", "Maybe next time you'll taste better!","Me still hungry, come back later!","You not enough food, me go find more!" }
local randomIndex = math.random(1, 6)
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

RegisterCreatureEvent(400012, 1, Patchqwerk.OnEnterCombat)
RegisterCreatureEvent(400012, 2, Patchqwerk.OnLeaveCombat)
RegisterCreatureEvent(400012, 4, Patchqwerk.OnDied)
RegisterCreatureEvent(400012, 5, Patchqwerk.OnSpawn)
    creature:RemoveEvents()
end

RegisterCreatureEvent(npcId, 1, OnEnterCombat) --RegisterCreatureEvent is a function that registers the event handlers OnEnterCombat, OnLeaveCombat, OnDied, and Onspawn for the specified creature npcId with events 1, 2, 4, and 5 respectively.
RegisterCreatureEvent(npcId, 2, OnLeaveCombat)
RegisterCreatureEvent(npcId, 4, OnDied)
RegisterCreatureEvent(npcId, 5, OnSpawn)
