--[[ Gastric - PrimordialFire.lua

Second boss ive finished. This one is so bad ass, you can't
kill him. He does an average hit of 2.7k , with fire spells.
Also summons invisible triggers to erupt the ground in flames.

Spells/data:
33077, agility buff,casts when summoning voids
33082, stamina buff, casts when summoning
22080, i think its a debuff, cant remember
27237, slow heal self over time
28900, chain lightning
24437, health leech

Voids:
Explode on combat
attack target for 10 seconds before dying

-- By Gastricpenguin ]]

function PrimeordialFlameA(Unit)
	if Unit:GetHealthPct() < 75 then
		Unit:CastSpell(33077)
		Unit:SendChatMessage(12, 0, "Let the flames consume you!")
		Unit:SpawnCreature(100248, -7603, -764, 191, 0.5, 17, 36000)
		Unit:SpawnCreature(100248, -7620, -768, 191, 1.22, 17, 36000)
		Unit:SpawnCreature(100248, -7612, -762, 191, 1.5, 17, 36000)
	end
end

function PrimeordialFlameB(Unit)
	if Unit:GetHealthPct() < 50 then
		Unit:CastSpell(33082)
		Unit:SendChatMessage(12, 0, "Is it hot in here or what?")
		Unit:SpawnCreature(100248, -7594, -775, 191, 0.5, 17, 36000)
		Unit:SpawnCreature(100248, -7608, -755, 193.5, 1.22, 17, 36000)
		Unit:SpawnCreature(100248, -7621, -783, 191, 1.5, 17, 36000)
	end
end

function PrimeordialFlameC(Unit)
	if Unit:GetHealthPct() < 25 then
		Unit:CastSpell(33080)
		Unit:SendChatMessage(12, 0, "Feel the burn?")
		Unit:SpawnCreature(100248, -7594, -775, 191, 0.5, 17, 36000)
		Unit:SpawnCreature(100248, -7603, -764, 191, 1.22, 17, 36000)
		Unit:SpawnCreature(100248, -7620, -768, 191, 1.5, 17, 36000)
	end
end

function PrimeordialFlameD(Unit)
	if Unit:GetHealthPct() < 10 then
		Unit:CastSpell(27237)
		Unit:SendChatMessage(12, 0, "That's ENOUGH!")
		Unit:SpawnCreature(100248, -7617, -744, 191, 0.5, 17, 36000)
		Unit:SpawnCreature(100248, -7608, -755, 193.5, 1.22, 17, 36000)
		Unit:SpawnCreature(100248, -7620, -768, 191, 1.5, 17, 36000)
	end
end

function Voider_OnSpawn (Unit, Event)
	Unit:Despawn (10000, 0)
end
RegisterUnitEvent (100248, 6, "Voider_OnSpawn")

function Voider_onCombat (Unit, Event)
	Unit:CastSpell(33132)
end
RegisterUnitEvent (100248, 1, "Voider_onCombat") 


function Fire_Pillar(Unit)
	Unit:CastSpell(28900)
	Unit:SendChatMessage(12, 0, "Die in a fire!")
end

function Fire_Leech(Unit)
	Unit:CastSpell(24437)
	Unit:SendChatMessage(12, 0, "Your health feeds me.")
end

function PrimeordialFlame_OnCombat(Unit, Event)
	Unit:SendChatMessage (11, 0, "Who dares desturb my peace!")
	Unit:RegisterEvent("PrimeordialFlameA",10000, 0)
	Unit:RegisterEvent("PrimeordialFlameB",14000, 0)
	Unit:RegisterEvent("PrimeordialFlameC",17000, 0)
	Unit:RegisterEvent("PrimeordialFlameD",21000, 0)
	Unit:RegisterEvent("Fire_Pillar",20000, 0)
	Unit:RegisterEvent("Fire_Leech",31000, 0)
end

function PrimeordialFlame_OnLeaveCombat(Unit)
	Unit:RemoveEvents()
end

function PrimeordialFlame_KilledTarget(Unit)
	Unit:SendChatMessage(12, 0, "Ding!")
	Unit:CastSpell(27237)
	Unit:RemoveEvents()
end

function PrimeordialFlame_OnDied(Unit)
	Unit:SendChatMessage(12, 0, "So c-cold..!")
	Unit:RemoveEvents()
end

RegisterUnitEvent(100247, 1, "PrimeordialFlame_OnCombat")
RegisterUnitEvent(100247, 2, "PrimeordialFlame_OnLeaveCombat")
RegisterUnitEvent(100247, 3, "PrimeordialFlame_OnKilledTarget")
RegisterUnitEvent(100247, 4, "PrimeordialFlame_OnDied") 