--[[ Gastric - TorkinProtector.lua

TorkinProtector LUA script

Outline of the fight: ( [#] = Phase number )
[0] - My favorite part, the beginning. 4 Ancient
Spirits will be spawned in Felwood. On combat, they
will automatically suicide and despawn. A few seconds 
later, Tork`in will erupt from the ground with a sweet
visual :D
[1] - Tor`kin will use some AOE roots every 20 seconds.
Moderate damage, as this is intended for a larger raid.
[2] - At 80%, He will morph into a Bear, increasing damage
and adding a maul effect.
[3] - At 70% He will morph back to normal and have the 
same effects as phase 1
[4] - 60%, He turns into a dragonthingy! :D
At this point he will shoot Fireball Volleys around until he
gets down to 50%
[5] - At 50%, he goes back to phase 1 effects.
[6] - At 35%, He despawns back into the 4 main mobs
Tank and spank until each one dies.

-- By Gastricpenguin ]]

--
-- BEGIN SCRIPT FOR MOBS
--

function Spirit_onDeath(Unit, event)
	Unit:SpawnCreature(100251, 5939.5, -1216, 384, 0.127, 17, 0);
end
RegisterUnitEvent(100255, 4, "Spirit_onDeath")

function Spirit2_onDeath(Unit, event)
	Unit:RegisterEvent("Respawn",60000, 0)
end
RegisterUnitEvent(100259, 4, "Spirit2_onDeath")

function Respawn(Unit)
		Unit:SpawnCreature(100252, 5961, -1212.9, 380.232, 3.31871, 17, 0);
		Unit:SpawnCreature(100253, 5953.05, -1207.6, 381.289, 4.80704, 17, 0);
		Unit:SpawnCreature(100254, 5955.05, -1220.82, 380.725, 1.72828, 17, 0);
		Unit:SpawnCreature(100255, 5946.37, -1214.87, 382.463, 0.096611, 17, 0);
end
-- 
-- BEGIN SCRIPT FOR TORKIN
--
function Torkin_Stomp(Unit)
	Unit:CastSpell(19129)
end

function Torkin_volley(Unit)
	Unit:CastSpell(37109)
end

function Torkin_volley2(Unit)
	Unit:CastSpell(21749)
end

function Torkin_Swoop(Unit)
	Unit:CastSpell(30035)
end

function Torkin_Phase1(Unit, event)
	if Unit:GetHealthPct() < 80 then
		Unit:RemoveEvents()
		Unit:SendChatMessage(12, 0, "This has gone on long enough!")
		Unit:SetModel(762)
		Unit:SetScale(4)
		Unit:CastSpell(41232)
		Unit:RegisterEvent("Torkin_Stomp",8000, 0)
		Unit:RegisterEvent("Torkin_Phase2",1000, 0)
	end
end

function Torkin_Phase2(Unit, event)
	if Unit:GetHealthPct() < 70 then
		Unit:RemoveEvents()
		Unit:SetModel(11362)
		Unit:SetScale(4)
		Unit:CastSpell(41232)
		Unit:RegisterEvent("Torkin_volley2",8000, 0)
		Unit:RegisterEvent("Torkin_Phase3",1000, 0)
	end
end

function Torkin_Phase3(Unit, event)
	if Unit:GetHealthPct() < 60 then
		Unit:RemoveEvents()
		Unit:SendChatMessage(12, 0, "Annoying Pests!")
		Unit:SetModel(17094)
		Unit:SetScale(4)
		Unit:CastSpell(41232)
		Unit:RegisterEvent("Torkin_Swoop",10000, 0)
		Unit:RegisterEvent("Torkin_Phase4",1000, 0)
	end
end

function Torkin_Phase4(Unit, event)
	if Unit:GetHealthPct() <= 50 then
		Unit:RemoveEvents()
		Unit:SetScale(4)
		Unit:SetModel(11362)
		Unit:CastSpell(41232)
		Unit:SendChatMessage(12, 0, "You shall all pay dearly!")
		Unit:RegisterEvent("Torkin_Stomp",8000, 0)
		Unit:RegisterEvent("Torkin_Phase5",1000, 0)
	end
end

function Torkin_Phase5(Unit, event)
	if Unit:GetHealthPct() <= 40 then
		Unit:RemoveEvents()
		Unit:SendChatMessage(12, 0, "My powers! I cannot control them anymore!")
		Unit:SetScale(3)
		Unit:CastSpell(40095)
		Unit:RegisterEvent("Torkin_Phase6",7000, 0)
	end
end

function Torkin_Phase6(Unit, event)
		Unit:RemoveEvents()
		x = Unit:GetX();
		y = Unit:GetY();
		z = Unit:GetZ();
		o = Unit:GetO();
		Unit:SpawnCreature(100256, x, y, z, o, 17, 0);
		Unit:SpawnCreature(100257, x, y, z, o, 17, 0);
		Unit:SpawnCreature(100258, x, y, z, o, 17, 0);
		Unit:SpawnCreature(100259, x, y, z, o, 17, 0);
		Unit:Despawn (1000, 0)
end

function Torkin_OnCombat(Unit, event)
	Unit:SendChatMessage(11, 0, "How dare you summon me!")
	Unit:RegisterEvent("Torkin_Phase1",1000, 0)
	Unit:RegisterEvent("Torkin_volley",9000, 0)
end

function Torkin_OnLeaveCombat(Unit) -- SPAWN ORIGINAL 4 MOBS, THEN DESPAWN
	Unit:RemoveEvents()
		Unit:SpawnCreature(100252, 5961, -1212.9, 380.232, 3.31871, 17, 0);
		Unit:SpawnCreature(100253, 5953.05, -1207.6, 381.289, 4.80704, 17, 0);
		Unit:SpawnCreature(100254, 5955.05, -1220.82, 380.725, 1.72828, 17, 0);
		Unit:SpawnCreature(100255, 5946.37, -1214.87, 382.463, 0.096611, 17, 0);
	Unit:Despawn (1000, 0)
end

function Torkin_OnKilledTarget(Unit)
	Unit:SendChatMessage(11, 0, "Conjoin with the nature!")
	Unit:CastSpell(36981)
end

function Torkin_Death(Unit)
	Unit:SendChatMessage(12, 0, "You cheated somehow :d  Torkin Shouldnt die >< - Gastricpenguin")
	Unit:Despawn (100, 0)
	Unit:RemoveEvents()
end

RegisterUnitEvent(100251, 1, "Torkin_OnCombat")
RegisterUnitEvent(100251, 2, "Torkin_OnLeaveCombat")
RegisterUnitEvent(100251, 3, "Torkin_OnKilledTarget")
RegisterUnitEvent(100251, 4, "Torkin_Death")