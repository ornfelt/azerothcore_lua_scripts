--//////////////////////////////////
--//// © Holystone Productions  ////
--////     Cronic & Warfrost    ////
--////       Copy Right         ////
--////  Blizzlike Repack v 2.5  ////
--//////////////////////////////////

--//////////////////////////////////
--////   					    ////
--////       		            ////
--////    Svala Sorrowgrave		////
--////  					    ////
--///	       					////
--//////////////////////////////////

-- This is the cinematic with Arthas & Svala
function Svala_OnSpawn (Unit, Event)
Unit:RegisterEvent("Svala_Check", 1000, 0)
end

function Svala_Check(Unit, Event)
local target = Unit:GetClosestPlayer()
  if Unit:GetDistanceYards(target) < 30 then
	Unit:RemoveEvents()
	Unit:RegisterEvent("Svala_StartChat", 1000, 1)
	else
	
  end
end

function Svala_StartChat (Unit, Event)
	Unit:SpawnCreature(29280, 295.853394, -363.257111, 92.640297, 1.541769, 14, 0)
	Unit:SendChatMessage(14, 0, "My liege! I have done as you asked, and now beseech you for your blessing!")
	Unit:PlaySoundToSet(13856)
	Unit:RegisterEvent("Svala_StartChat1", 19000, 1)
end

function Svala_StartChat1 (Unit, Event)
	Unit:Despawn(1000, 0)
		local X = Unit:GetX()
		local Y = Unit:GetY()
		local Z = Unit:GetZ()
		local O = Unit:GetO()
	Unit:SpawnCreature(26668, X, Y, Z, O, 14, 0)
end

RegisterUnitEvent(29281, 18, "Svala_OnSpawn")	

-- Sorrowgrave fight starts here
function Sorrowgrave_OnSpawn (Unit, Event)
	Unit:SetLevel(80)
	Unit:SetFaction(35)
	Unit:SendChatMessage(14, 0, "The sensation is... beyond my imagining. I am yours to command, my king.")
	Unit:PlaySoundToSet(13857)
	Unit:RegisterEvent("Sorrowgrave_StartChat", 12000, 1)
	end
	
function Sorrowgrave_StartChat (Unit, Event)
	Unit:SendChatMessage(14, 0, "I will be happy to slaughter them in your name! Come, enemies of the Scourge! I will show you the might of the Lich King!")
	Unit:PlaySoundToSet(13858)
	Unit:RegisterEvent("Sorrowgrave_OnCombat", 10000, 1)
	end
	
function Sorrowgrave_OnCombat (Unit, Event)
	Unit:SetFaction(14)
	Unit:PlaySoundToSet(13842)
	Unit:SendChatMessage(14, 0, "I will vanquish your soul!")
end

function Sorrowgrave_OnKillPlr (Unit, Event)
	Unit:SendChatMessage(14, 0, "You were a fool to challenge the power of the Lich King!")
	Unit:PlaySoundToSet(13845)
end

function Sorrowgrave_OnLeaveCombat (Unit, Event)
	Unit:RemoveEvents()
end

function Sorrowgrave_OnDeath (Unit, Event)
	Unit:SendChatMessage(14, 0, "Nooo! I did not come this far... to...")
	Unit:PlaySoundToSet(13855)
end

RegisterUnitEvent(26668, 18, "Sorrowgrave_OnSpawn")
RegisterUnitEvent(26668, 1, "Sorrowgrave_OnCombat")
RegisterUnitEvent(26668, 2, "Sorrowgrave_OnLeaveCombat")
RegisterUnitEvent(26668, 3, "Sorrowgrave_OnKillPlr")
RegisterUnitEvent(26668, 4, "Sorrowgrave_OnDeath")

function Arthas_OnSpawn (Unit, Event)
	Unit:ModUInt32Value(59, 2)
	Unit:RegisterEvent("Arthas_Talk", 7000, 1)
end

function Arthas_Talk (Unit, Event)
	Unit:SendChatMessage(14, 0, "Your sacrifice is a testament to your obedience. Indeed you are worthy of this charge. Arise, and forever be known as Svala Sorrowgrave!")
	Unit:PlaySoundToSet(14732)
	Unit:RegisterEvent("Arthas_Talk1", 11000, 1)
end
	
function Arthas_Talk1 (Unit, Event)
	Unit:SendChatMessage(14, 0, "Your first test awaits you. Destroy our uninvited guests.")
	Unit:PlaySoundToSet(14733)
	Unit:RegisterEvent("Arthas_Despawn", 3000, 1)
end

function Arthas_Despawn (Unit, Event)
	Unit:Despawn(1200, 0)
end

RegisterUnitEvent(29280, 18, "Arthas_OnSpawn")

--//////////////////////////////////
--////   					    ////
--////       		            ////
--////    Gortok Palehoof		////
--////  					    ////
--///	       					////
--//////////////////////////////////
-- Issues: NOT WORKING, WILL ATTEMPT AT A LATER TIME


--//////////////////////////////////
--////   					    ////
--////       		            ////
--////    Skadi the Ruthless	////
--////  					    ////
--///	       					////
--//////////////////////////////////
-- Issues: Harpoons are not working so we are going to make him fly on his drake for 1 Minute before he'll dismount and attack.
-- Find a way for mobs to automaticly come after players since they can basically skip the trash.

function Skadi_OnCombat (Unit, Event)
Unit:SendChatMessage(14, 0, "What mongrels dare intrude here? Look alive, my brothers! A feast for the one that brings me their heads!")
Unit:PlaySoundToSet(13497)
Unit:SpawnAndEnterVehicle(26893, 0)
Unit:RegisterEvent("Skadi_SpawnWave", 3000, 1)
Unit:RegisterEvent("Skadi_Waves", 15000, 4)
Unit:RegisterEvent("Skadi_Dismount", 62000, 1)
end

function Skadi_SpawnWave (Unit, Event)
Unit:SpawnCreature(26690, 364.686, -508.682, 104.670, 3.092, 14, 40000)
Unit:SpawnCreature(26690, 366.317, -516.607, 104.783173, 2.860, 14, 40000)
Unit:SpawnCreature(26690, 383.051, -511.504, 104.807, 3.148, 14, 40000)
Unit:SpawnCreature(26690, 398.592, -516.697, 104.723, 3.021, 14, 40000)
Unit:SpawnCreature(26690, 410.976, -507.662, 104.987, 3.215, 14, 40000)
Unit:SpawnCreature(26690, 428.562, -520.734, 104.820, 3.108, 14, 40000)
end

function Skadi_Waves (Unit, Event)
Unit:SpawnCreature(26690, 364.686, -508.682, 104.670, 3.092, 14, 40000)
Unit:SpawnCreature(26690, 366.317, -516.607, 104.783173, 2.860, 14, 40000)
Unit:SpawnCreature(26690, 383.051, -511.504, 104.807, 3.148, 14, 40000)
Unit:SpawnCreature(26690, 398.592, -516.697, 104.723, 3.021, 14, 40000)
Unit:SpawnCreature(26690, 410.976, -507.662, 104.987, 3.215, 14, 40000)
Unit:SpawnCreature(26690, 428.562, -520.734, 104.820, 3.108, 14, 40000)
end

function Skadi_Dismount (Unit, Event)
Unit:ExitVehicle()
Unit:TeleportCreature(478.622, -510.462, 104.722)
Unit:RegisterEvent("Skadi_Fight", 3000, 1)
end

function Skadi_Fight (Unit, Event)
Unit:SendChatMessage(14, 0, "You motherless knaves! Your corpses will make fine morsels for my new drake!")
Unit:PlaySoundToSet(13507)
Unit:RegisterEvent("Skadi_Crush", 11000, 3)
Unit:RegisterEvent("Skadi_Whirlwind", 14000, 3)
end

function Skadi_Crush (Unit, Event)
Unit:FullCastSpellOnTarget(50234, Unit:GetMainTank())
end

function Skadi_Whirlwind (Unit, Event)
Unit:FullCastSpellOnTarget(50228, Unit:GetMainTank())
end

function Skadi_OnLeaveCombat (Unit, Event)
Unit:Despawn(1500, 10000)
Unit:RemoveEvents()
end

function Skadi_OnKillPlr (Unit, Event)
Unit:SendChatMessage(14, 0, "I'll mount your skull from the highest tower!")
Unit:PlaySoundToSet(13505)
end

function Skadi_OnDeath (Unit, Event)
Unit:SendChatMessage(14, 0, "ARGH! You call that... an attack? I'll... show... aghhhh...")
Unit:PlaySoundToSet(13506)
Unit:RemoveEvents()
end

RegisterUnitEvent(26693, 1, "Skadi_OnCombat")
RegisterUnitEvent(26693, 2, "Skadi_OnLeaveCombat")
RegisterUnitEvent(26693, 3, "Skadi_OnKillPlr")
RegisterUnitEvent(26693, 4, "Skadi_OnDeath")

function OnReachWaypoint (Unit, Event, WaypointId)
	if (WaypointId == 1) then
		Unit:MoveToWaypoint(4)
	end
	if (WaypointId == 2) then
		Unit:MoveToWaypoint(3)
	end
	if (WaypointId == 3) then
		Unit:MoveToWaypoint(2)
	end
	if (WaypointId == 4) then
		Unit:MoveToWaypoint(1)
	end
end

function Grafu_OnSpawn (Unit, Event)
Unit:SetFlying()
Unit:ModifyFlySpeed(7)
Unit:MoveTo(283.043, -512.903, 141.140, 3.092)
Unit:RegisterEvent("Grafu_Move2", 10000, 1)
Unit:RegisterEvent("Grafu_Delete", 63000, 1)
end

function Grafu_Move2 (Unit, Event)
Unit:MoveTo(319.607, -548.336, 128.634, 3.092)
Unit:RegisterEvent("Grafu_Move3", 10000, 1)
end

function Grafu_Move3 (Unit, Event)
Unit:MoveTo(529.736, -540.288, 126.295, 3.092)
Unit:RegisterEvent("Grafu_Move4", 10000, 1)
end

function Grafu_Move4 (Unit, Event)
Unit:MoveTo(487.276, -514.725, 121.741, 3.092)
RegisterUnitEvent(26893, 18, "Grafu_Restart")
end

function Grafu_Restart (Unit, Event)
Unit:MoveTo(283.043, -512.903, 141.140, 3.092)
Unit:RegisterEvent("Grafu_Move2", 14000, 1)
end

function Grafu_Delete (Unit, Event)
Unit:Despawn(1500, 0)
end

RegisterUnitEvent(26893, 18, "Grafu_OnSpawn")

--//////////////////////////////////
--////   					    ////
--////       		            ////
--////    	King Ymiron			////
--////  					    ////
--///	       					////
--//////////////////////////////////
-- Issues: The four kings cannot be spawned cause they have no Display.

function King_OnCombat (Unit, Event)
Unit:SendChatMessage(14, 0, "You invade my home and then dare to challenge me? I will tear the hearts from your chests and offer them as gifts to the death god! Rualg nja gaborr!")
Unit:PlaySoundToSet(13609)
Unit:RegisterEvent("King_Bane", 13000, 0)
Unit:RegisterEvent("King_Burst", 8000, 0)
Unit:RegisterEvent("King_SOTD", 1000, 0)
end

function King_Bane (Unit, Event)
Unit:CastSpell(48294)
end

function King_Burst (Unit, Event)
Unit:FullCastSpellOnTarget(48529, Unit:GetRandomPlayer(0))
end

function King_SOTD (Unit, Event)
if Unit:GetHealthPct() <= 80 then
Unit:RemoveEvents()
Unit:CastSpellOnTarget(51750, Unit:GetMainTank())
Unit:MoveTo(411.801, -308.807, 104.773)
Unit:SendChatMessage(14, 0, "Bjorn of the Black Storm! Honor me now with your presence!")
Unit:PlaySoundToSet(13610)
Unit:RegisterEvent("King_Events", 1000, 1)
end
end

function King_Events (Unit, Event)
Unit:RegisterEvent("King_Bane", 13000, 0)
Unit:RegisterEvent("King_Burst", 8000, 0)
Unit:RegisterEvent("King_SOTD2", 1000, 0)
end

function King_SOTD2 (Unit, Event)
if Unit:GetHealthPct() <= 60 then
Unit:RemoveEvents()
Unit:CastSpellOnTarget(51750, Unit:GetMainTank())
Unit:MoveTo(411.801, -308.807, 104.773)
Unit:SendChatMessage(14, 0, "Haldor of the Rocky Cliffs, grant me your strength!")
Unit:PlaySoundToSet(13611)
Unit:RegisterEvent("King_Events2", 1000, 1)
end
end

function King_Events2 (Unit, Event)
Unit:RegisterEvent("King_Bane", 13000, 0)
Unit:RegisterEvent("King_Burst", 8000, 0)
Unit:RegisterEvent("King_SOTD3", 1000, 0)
end

function King_SOTD3 (Unit, Event)
if Unit:GetHealthPct() <= 40 then
Unit:RemoveEvents()
Unit:CastSpellOnTarget(51750, Unit:GetMainTank())
Unit:MoveTo(411.801, -308.807, 104.773)
Unit:SendChatMessage(14, 0, "Ranulf of the Screaming Abyss, snuff these maggots with darkest night!")
Unit:PlaySoundToSet(13612)
Unit:RegisterEvent("King_Events3", 1000, 1)
end
end

function King_Events3 (Unit, Event)
Unit:RegisterEvent("King_Bane", 13000, 0)
Unit:RegisterEvent("King_Burst", 8000, 0)
Unit:RegisterEvent("King_SOTD4", 1000, 0)
end

function King_SOTD4 (Unit, Event)
if Unit:GetHealthPct() <= 20 then
Unit:RemoveEvents()
Unit:CastSpellOnTarget(51750, Unit:GetMainTank())
Unit:MoveTo(411.801, -308.807, 104.773)
Unit:SendChatMessage(14, 0, "Tor of the Brutal Siege! Bestow your might upon me!")
Unit:PlaySoundToSet(13613)
Unit:RegisterEvent("King_Events4", 1000, 1)
end
end

function King_Events4 (Unit, Event)
Unit:RegisterEvent("King_Bane", 13000, 0)
Unit:RegisterEvent("King_Burst", 8000, 0)
end

function King_OnLeaveCombat (Unit, Event)
Unit:Despawn(1500, 10000)
Unit:RemoveEvents()
end

function King_OnKillPlr (Unit, Event)
Unit:SendChatMessage(14, 0, "Bleed no more!")
Unit:PlaySoundToSet(13617)
end

function King_OnDeath (Unit, Event)
Unit:SendChatMessage(14, 0, "What... awaits me... now?")
Unit:PlaySoundToSet(13618)
Unit:RemoveEvents()
end

RegisterUnitEvent(26861, 1, "King_OnCombat")
RegisterUnitEvent(26861, 2, "King_OnLeaveCombat")
RegisterUnitEvent(26861, 3, "King_OnKillPlr")
RegisterUnitEvent(26861, 4, "King_OnDeath")