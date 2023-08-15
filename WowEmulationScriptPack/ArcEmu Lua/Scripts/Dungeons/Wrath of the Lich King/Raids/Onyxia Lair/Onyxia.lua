function Onyxia_PhaseOneSpells(pUnit, event)
     local randomspell=math.random(1, 4);
     if randomspell == 1 then
	     pUnit:FullCastSpellOnTarget(18435, pUnit:GetMainTank())
		pUnit:RegisterEvent("Onyxia_PhaseOneSpells", math.random(16000, 20000), 1)
     return;
     end
     if randomspell == 2 then
		pUnit:FullCastSpellOnTarget(18500, pUnit:GetMainTank())
		pUnit:RegisterEvent("Onyxia_PhaseOneSpells", math.random(16000, 20000), 1)
     return;
     end
     if randomspell == 3 then
		pUnit:FullCastSpellOnTarget(19983, pUnit:GetMainTank())
		pUnit:RegisterEvent("Onyxia_PhaseOneSpells", math.random(16000, 20000), 1)
     return;
     end

     if randomspell == 4 then
		pUnit:RegisterEvent("Onyxia_PhaseOneSpells", math.random(16000, 20000), 1)
		local tbl=pUnit:GetInRangePlayers();
		for k,v in pairs(tbl) do
			if v:IsInBack(pUnit) == true then
				local behindtargets={}
				if v:IsInBack(pUnit) == true then
					table.insert(behindtargets, v)
					local player=math.random(1, table.getn(behindtargets))
					pUnit:FullCastSpellOnTarget(15847,behindtargets[player])
				end
			end
		end
	end
end

function Onyxia_KnockAway(pUnit, event)
     local maintank=pUnit:GetMainTank();
     pUnit:FullCastSpellOnTarget(19633, maintank)
     --local threatcalc=pUnit:GetThreat(maintank) / (4);
     --local playerthreat=threatcalc * (3);
     --pUnit:ModThreat(maintank, playerthreat)
end

function Onyxia_BellowingRoar(pUnit, event)
     pUnit:FullCastSpell(18431)
end

function Onyxia_PhaseThree(pUnit, event)
     if pUnit:GetHealthPct() <= 40 then
		pUnit:RemoveEvents()
		pUnit:Land()
		pUnit:RegisterEvent("Onyxia_PhaseOneSpells", math.random(16000, 20000), 1)
		pUnit:RegisterEvent("Onyxia_KnockAway", 22000, 0)
		pUnit:RegisterEvent("Onyxia_BellowingRoar", 18000, 0)
     end
end

function Onyxia_PhaseTwo(pUnit, event)
     if pUnit:GetHealthPct() <= 65 then
		pUnit:RemoveEvents()
		pUnit:SetCombatTargetingCapable(1)
		pUnit:SetCombatMeleeCapable(1)
		pUnit:MoveTo(-75.945, -219.245, -83.375, 0.004947)
		pUnit:RegisterEvent("Onyxia_ReachedWaypoint", 11000, 1)
		pUnit:RegisterEvent("Onyxia_PhaseThree", 1000, 0)
     end
end

function Onyxia_OnEnterCombat(pUnit, event)
     pUnit:SendChatMessage(14, 0, "How fortuitous, usually I must leave my lair to feed!")
     pUnit:RegisterEvent("Onyxia_PhaseOneSpells", math.random(12000, 17000), 1)
     pUnit:RegisterEvent("Onyxia_KnockAway", 22000, 0)
     pUnit:RegisterEvent("Onyxia_PhaseTwo", 1000, 0)
end

RegisterUnitEvent(10184, 1, "Onyxia_OnEnterCombat")

function Onyxia_Fireball(pUnit, event)
     local player=pUnit:GetRandomPlayer(0);
     pUnit:CastSpellAoF(player:GetX(), player:GetY(), player:GetZ(), 18392)
end

function Onyxia_WaypointTwelve(pUnit, event)
	pUnit:RegisterEvent("Onyxia_Fireball", 5000, 4)
	pUnit:RegisterEvent("Onyxia_WaypointThree", 23001, 1)
	pUnit:SpawnCreature(11262, -30.812, -166.395, -89.000, 5.160, 14, 0)
	pUnit:SpawnCreature(11262, -30.233, -264.158, 89.896, 1.129, 14, 0)
	pUnit:SpawnCreature(11262, -30.812, -166.395, -89.000, 5.160, 14, 0)
	pUnit:SpawnCreature(11262, -30.233, -264.158, 89.896, 1.129, 14, 0)
	pUnit:SpawnCreature(11262, -36.104, -260.961, -90.600, 1.111, 14, 0)
	pUnit:SpawnCreature(11262, -34.643, -164.080, -90.000, 5.364, 14, 0)
	pUnit:SpawnCreature(11262, -36.104, -260.961, -90.600, 1.111, 14, 0)
	pUnit:SpawnCreature(11262, -34.643, -164.080, -90.000, 5.364, 14, 0)
end

function Onyxia_WaypointEleven(pUnit, event)
     pUnit:MoveTo(-4.868, -217.171, -86.710, 3.141590)
     pUnit:RegisterEvent("Onyxia_WaypointTwelve", 10000, 1)
end

function Onyxia_WaypointTen(pUnit, event)
	pUnit:RegisterEvent("Onyxia_Fireball", 5000, 4)
	pUnit:RegisterEvent("Onyxia_WaypointEleven", 23001, 1)
	pUnit:SpawnCreature(11262, -30.812, -166.395, -89.000, 5.160, 14, 0)
	pUnit:SpawnCreature(11262, -30.233, -264.158, 89.896, 1.129, 14, 0)
	pUnit:SpawnCreature(11262, -30.812, -166.395, -89.000, 5.160, 14, 0)
	pUnit:SpawnCreature(11262, -30.233, -264.158, 89.896, 1.129, 14, 0)
	pUnit:SpawnCreature(11262, -36.104, -260.961, -90.600, 1.111, 14, 0)
	pUnit:SpawnCreature(11262, -34.643, -164.080, -90.000, 5.364, 14, 0)
	pUnit:SpawnCreature(11262, -36.104, -260.961, -90.600, 1.111, 14, 0)
	pUnit:SpawnCreature(11262, -34.643, -164.080, -90.000, 5.364, 14, 0)
end

function Onyxia_WaypointNine(pUnit, event)
     pUnit:MoveTo(27.875, -178.547, -66.041, 3.908957)
     pUnit:RegisterEvent("Onyxia_WaypointTen", 10000, 1)
end

function Onyxia_WaypointEight(pUnit, event)
	pUnit:RegisterEvent("Onyxia_Fireball", 5000, 4)
	pUnit:RegisterEvent("Onyxia_WaypointNine", 23001, 1)
	pUnit:SpawnCreature(11262, -30.812, -166.395, -89.000, 5.160, 14, 0)
	pUnit:SpawnCreature(11262, -30.233, -264.158, 89.896, 1.129, 14, 0)
	pUnit:SpawnCreature(11262, -30.812, -166.395, -89.000, 5.160, 14, 0)
	pUnit:SpawnCreature(11262, -30.233, -264.158, 89.896, 1.129, 14, 0)
	pUnit:SpawnCreature(11262, -36.104, -260.961, -90.600, 1.111, 14, 0)
	pUnit:SpawnCreature(11262, -34.643, -164.080, -90.000, 5.364, 14, 0)
	pUnit:SpawnCreature(11262, -36.104, -260.961, -90.600, 1.111, 14, 0)
	pUnit:SpawnCreature(11262, -34.643, -164.080, -90.000, 5.364, 14, 0)
end

function Onyxia_WaypointSeven(pUnit, event)
     pUnit:MoveTo(-80.257, -174.240, -69.293, 5.695741)
     pUnit:RegisterEvent("Onyxia_WaypointEight", 10000, 1)
end

function Onyxia_WaypointSix(pUnit, event)
	pUnit:RegisterEvent("Onyxia_Fireball", 5000, 4)
	pUnit:RegisterEvent("Onyxia_WaypointSeven", 23001, 1)
	pUnit:SpawnCreature(11262, -30.812, -166.395, -89.000, 5.160, 14, 0)
	pUnit:SpawnCreature(11262, -30.233, -264.158, 89.896, 1.129, 14, 0)
	pUnit:SpawnCreature(11262, -30.812, -166.395, -89.000, 5.160, 14, 0)
	pUnit:SpawnCreature(11262, -30.233, -264.158, 89.896, 1.129, 14, 0)
	pUnit:SpawnCreature(11262, -36.104, -260.961, -90.600, 1.111, 14, 0)
	pUnit:SpawnCreature(11262, -34.643, -164.080, -90.000, 5.364, 14, 0)
	pUnit:SpawnCreature(11262, -36.104, -260.961, -90.600, 1.111, 14, 0)
	pUnit:SpawnCreature(11262, -34.643, -164.080, -90.000, 5.364, 14, 0)
end

function Onyxia_WaypointFive(pUnit, event)
     pUnit:MoveTo(-79.020, -252.374, -68.965, 0.885179)
     pUnit:RegisterEvent("Onyxia_WaypointSix", 10000, 1)
end

function Onyxia_WaypointFour(pUnit, event)
	pUnit:RegisterEvent("Onyxia_Fireball", 5000, 4)
	pUnit:RegisterEvent("Onyxia_WaypointFive", 23001, 1)
	pUnit:SpawnCreature(11262, -30.812, -166.395, -89.000, 5.160, 14, 0)
	pUnit:SpawnCreature(11262, -30.233, -264.158, 89.896, 1.129, 14, 0)
	pUnit:SpawnCreature(11262, -30.812, -166.395, -89.000, 5.160, 14, 0)
	pUnit:SpawnCreature(11262, -30.233, -264.158, 89.896, 1.129, 14, 0)
	pUnit:SpawnCreature(11262, -36.104, -260.961, -90.600, 1.111, 14, 0)
	pUnit:SpawnCreature(11262, -34.643, -164.080, -90.000, 5.364, 14, 0)
	pUnit:SpawnCreature(11262, -36.104, -260.961, -90.600, 1.111, 14, 0)
	pUnit:SpawnCreature(11262, -34.643, -164.080, -90.000, 5.364, 14, 0)
end

function Onyxia_WaypointThree(pUnit, event)
     pUnit:MoveTo(12.270, -254.694, -67.997, 2.395585)
     pUnit:RegisterEvent("Onyxia_WaypointFour", 10000, 1)
end

function Onyxia_WaypointTwo(pUnit, event)
	pUnit:RegisterEvent("Onyxia_Fireball", 5000, 4)
	pUnit:RegisterEvent("Onyxia_WaypointThree", 23001, 1)
	pUnit:SpawnCreature(11262, -30.812, -166.395, -89.000, 5.160, 14, 0)
	pUnit:SpawnCreature(11262, -30.233, -264.158, 89.896, 1.129, 14, 0)
	pUnit:SpawnCreature(11262, -35.813, -169.427, -90.000, 5.384, 14, 0)
	pUnit:SpawnCreature(11262, -30.812, -166.395, -89.000, 5.160, 14, 0)
	pUnit:SpawnCreature(11262, -30.233, -264.158, 89.896, 1.129, 14, 0)
	pUnit:SpawnCreature(11262, -35.813, -169.427, -90.000, 5.384, 14, 0)
	pUnit:SpawnCreature(11262, -30.812, -166.395, -89.000, 5.160, 14, 0)
	pUnit:SpawnCreature(11262, -30.233, -264.158, 89.896, 1.129, 14, 0)
	pUnit:SpawnCreature(11262, -35.813, -169.427, -90.000, 5.384, 14, 0)
	pUnit:SpawnCreature(11262, -36.104, -260.961, -90.600, 1.111, 14, 0)
	pUnit:SpawnCreature(11262, -34.643, -164.080, -90.000, 5.364, 14, 0)
	pUnit:SpawnCreature(11262, -35.377, -267.320, -91.000, 1.111, 14, 0)
	pUnit:SpawnCreature(11262, -36.104, -260.961, -90.600, 1.111, 14, 0)
	pUnit:SpawnCreature(11262, -34.643, -164.080, -90.000, 5.364, 14, 0)
	pUnit:SpawnCreature(11262, -35.377, -267.320, -91.000, 1.111, 14, 0)
	pUnit:SpawnCreature(11262, -36.104, -260.961, -90.600, 1.111, 14, 0)
	pUnit:SpawnCreature(11262, -34.643, -164.080, -90.000, 5.364, 14, 0)
	pUnit:SpawnCreature(11262, -35.377, -267.320, -91.000, 1.111, 14, 0)
end

function Onyxia_ReachedWaypoint(pUnit, event)
     pUnit:SetCombatTargetingCapable(0)
     pUnit:SetFlying()
     pUnit:MoveTo(42.621, -217.195, -66.056, 3.014011)
     pUnit:RegisterEvent("Onyxia_WaypointTwo", 10000, 1)
end

function Onyxia_OnWipe(pUnit, event)
	 if pUnit:IsAlive() == true then
		pUnit:Land()
		pUnit:RemoveEvents()
	 else
		pUnit:RemoveEvents()
	 end
end

RegisterUnitEvent(10184, 2, "Onyxia_OnWipe")

function Whelps_OnSpawn(pUnit, event)
	 local player=pUnit:GetClosestPlayer();
	 pUnit:ModifyWalkSpeed(8)
	 pUnit:SetOutOfCombatRange(10000)
	 pUnit:MoveTo(player:GetX(), player:GetY(), player:GetZ(), player:GetO())
end

RegisterUnitEvent(11262, 18, "Whelps_OnSpawn")


--Onyxia Warder AI
function Warder_FireNova(pUnit, event)
	pUnit:FullCastSpell(38728)
	pUnit:RegisterEvent("Warder_FireNova", math.random(8000, 11000), 1)
end

function Warder_FlameLash(pUnit, event)
	pUnit:FullCastSpell(18958)
	pUnit:RegisterEvent("Warder_FlameLash", math.random(7000, 14000), 1)
end

function Warder_OnEnterCombat(pUnit, event)
	pUnit:RegisterEvent("Warder_FireNova", math.random(8000, 11000), 1)
	pUnit:RegisterEvent("Warder_FlameLash", math.random(7000, 14000), 1)
end

RegisterUnitEvent(12129, 1, "Warder_OnEnterCombat")

function Warder_OnWipe(pUnit, event)
     pUnit:RemoveEvents()
end

RegisterUnitEvent(12129, 2, "Warder_OnWipe")