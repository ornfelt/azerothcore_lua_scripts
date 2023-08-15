function Deathmaw_EnterCombat (pUnit, event)
		pUnit:SendChatMessage(14, 0, "Ever so slowly the coldness brings your death!")
	    pUnit:RegisterEvent("Deathmaw_Freeze", 7000, 0)
        pUnit:RegisterEvent("Deathmaw_Blizzard", 6000, 0)           
        pUnit:RegisterEvent("Deathmaw_Falter", 5000, 0)
        pUnit:RegisterEvent("Deathmaw_Phase2", 1000, 0)
end

function Deathmaw_Falter (pUnit, event)
         pUnit:FullCastSpellOnTarget(43108, pUnit:GetClosestPlayer())
end

function Deathmaw_Blizzard (pUnit, event)
         pUnit:FullCastSpellOnTarget(49549, pUnit:GetClosestPlayer())
end

function Deathmaw_Freeze (pUnit, event)
         pUnit:FullCastSpellOnTarget(47772, pUnit:GetMainTank())
end

function Deathmaw_Phase2 (pUnit, event)
     if pUnit:GetHealthPct() < 76 then
     pUnit:RemoveEvents()
	 pUnit:ClearThreatList()

	 pUnit:SendChatMessage(14, 0, "Yes! YES! Scream as the flesh is melted from your bones!")
	 pUnit:RegisterEvent("Deathmaw_Torrent", 8000, 0)
	 pUnit:RegisterEvent("Deathmaw_Incinerate", 10000, 0)
	 pUnit:RegisterEvent("Deathmaw_Spawns", 6000, 0)
	 pUnit:RegisterEvent("Deathmaw_Flame", 30000, 0)
	 pUnit:RegisterEvent("Deathmaw_Flight", 40000, 0)
	 pUnit:RegisterEvent("Deathmaw_Phase3", 1000, 0) 
  end
end

function Deathmaw_Spawns (pUnit,event)
	 X = pUnit:GetX();
	 Y = pUnit:GetY();
	 Z = pUnit:GetZ();
	 O = pUnit:GetO();
	 X = X + 4
	 Y = Y + 4
	 pUnit:SpawnCreature(21004, X, Y, Z, O, 73, 0);
	 X = pUnit:GetX();
	 Y = pUnit:GetY();
	 Z = pUnit:GetZ();
	 O = pUnit:GetO();
	 X = X - 4
	 Y = Y + 4
	 pUnit:SpawnCreature(21004, X, Y, Z, O, 73, 0);
	 X = pUnit:GetX();
	 Y = pUnit:GetY();
	 Z = pUnit:GetZ();
	 O = pUnit:GetO();
	 X = X + 4
	 Y = Y - 4
	 pUnit:SpawnCreature(21004, X, Y, Z, O, 73, 0);
	 X = pUnit:GetX();
	 Y = pUnit:GetY();
	 Z = pUnit:GetZ();
	 O = pUnit:GetO();
	 X = X - 4
	 Y = Y - 4
	 pUnit:SpawnCreature(21004, X, Y, Z, O, 73, 0);
	 X = pUnit:GetX();
	 Y = pUnit:GetY();
	 Z = pUnit:GetZ();
	 O = pUnit:GetO();
	 X = X + 6
	 Y = Y + 6
	 pUnit:SpawnCreature(21004, X, Y, Z, O, 73, 0);
	 X = pUnit:GetX();
	 Y = pUnit:GetY();
	 Z = pUnit:GetZ();
	 O = pUnit:GetO();
	 X = X - 6
	 Y = Y - 6
	 pUnit:SpawnCreature(21004, X, Y, Z, O, 73, 0);
end
	  
function Deathmaw_Flight (pUnit, event)
	  pUnit:SetFlying()
	  pUnit:SetCombatCapable(1)
	  pUnit:CreateWayPoint(x,y,z,8000,768,0)
	     X = pUnit:GetX();
		 Y = pUnit:GetY();
		 Z = pUnit:GetZ();
		 O = pUnit:GetO();
		 X = X
		 Y = Y
	 	 Z = Z
	 pUnit:CreateWayPoint(x,y,z,7000,768,0)
		 X = pUnit:GetX();
		 Y = pUnit:GetY();
		 Z = pUnit:GetZ();
		 O = pUnit:GetO();
		 X = X
		 Y = Y
	 	 Z = Z + 24
	 pUnit:MovetoWayPoint(2)
	 pUnit:MoveToWaypoint(1)
	 pUnit:SetCombatCapable(0)
	 pUnit:Land()
end

function Deathmaw_Torrent (pUnit, event)
         pUnit:FullCastSpellOnTarget(48246, pUnit:GetMainTank())
end

function Deathmaw_Incinerate (pUnit, event)
         pUnit:FullCastSpellOnTarget(20019, pUnit:GetMainTank())
end

function Deathmaw_Flame (pUnit, event)
         pUnit:CastSpell(15636)
end

function Deathmaw_Phase3 (pUnit, event)
      if pUnit:GetHealthPct() < 49 then
         pUnit:RemoveEvents()
	 pUnit:ClearThreatList()        
	 pUnit:SendChatMessage(14, 0, "Death is your only option!") 
	     pUnit:RegisterEvent("Deathmaw_Toxin", 5000, 0)            
	     pUnit:RegisterEvent("Deathmaw_Sludge", 4000, 0)
	     pUnit:RegisterEvent("Deathmaw_Infect", 9000, 0)
	     pUnit:RegisterEvent("Deathmaw_Ooze", 8000, 0)
	     pUnit:RegisterEvent("Deathmaw_Phase4", 1000, 0)

  end
end

function Deathmaw_Toxin (pUnit, event)
         pUnit:FullCastSpellOnTarget(25989, pUnit:GetMainTank())
end

function Deathmaw_Sludge (pUnit, event)
         pUnit:FullCastSpellOnTarget(36694, pUnit:GetMainTank())
end

function Deathmaw_Ooze (pUnit, event)
         pUnit:FullCastSpellOnTarget(57617, pUnit:GetMainTank())
end

function Deathmaw_Infect (pUnit, event)
         pUnit:FullCastSpellOnTarget(38811, pUnit:GetRandomPlayer(0))
end

function Deathmaw_Phase4 (pUnit, event)
      if pUnit:GetHealthPct() < 20 then
	 pUnit:ClearThreatList()
         pUnit:RemoveEvents()
         pUnit:SendChatMessage(14, 0, "Even in the face of annihilation you ask for more...So be it")
         pUnit:FullCastSpellOnTarget(43353, pUnit:GetMainTank())
  end
end

function Deathmaw_LeaveCombat (pUnit, event)
         pUnit:RemoveEvents()
end

function Deathmaw_Die (pUnit, event)
         pUnit:RemoveEvents()
         pUnit:SendChatMessage(14, 0, "I've seen your demise, it is coming...")     
end

RegisterUnitEvent(98871, 1, "Deathmaw_EnterCombat")
RegisterUnitEvent(98871, 2, "Deathmaw_LeaveCombat")
RegisterUnitEvent(98871, 4, "Deathmaw_Die")