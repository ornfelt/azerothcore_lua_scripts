function Thirhaly_EnterCombat (pUnit, event)
         pUnit:SendChatMessage(14, 0, "HEY FUCKER, COME HERE")
         pUnit:RegisterEvent("Thirhaly_Deathstrike", 1000, 1)
         pUnit:RegisterEvent("Thirhaly_Asunder", 24000, 0) 
         pUnit:RegisterEvent("Thirhaly_Direnova", 20000, 0) 
         pUnit:RegisterEvent("Thirhaly_Phase2", 1000, 0)
end
function Thirhaly_Deathstrike (pUnit, event)
         pUnit:FullCastSpellOnTarget(25322, pUnit:GetClosestPlayer())
end
function Thirhaly_Asunder (pUnit, event)
         pUnit:CastSpell(28733)
end
function Thirhaly_Direnova (pUnit, event)
         pUnit:FullCastSpellOnTarget(38739, pUnit:GetMainTank())
end
function Thirhaly_Phase2 (pUnit, event)
      if pUnit:GetHealthPct() < 76 then
         pUnit:RemoveEvents()        
         pUnit:SendChatMessage(14, 0, "DIE CUTIE")
         pUnit:RegisterEvent("Thirhaly_Doomslice", 50000, 0)
         pUnit:RegisterEvent("Thirhaly_Harbringer", 15000, 0)
         pUnit:RegisterEvent("Thirhaly_Defensive", 17000, 0)
         pUnit:RegisterEvent("Thirhaly_Phase3", 1000, 0)
  end
end
function Thirhaly_Doomslice (pUnit, event)
         pUnit:FullCastSpellOnTarget(40481, pUnit:GetMainTank())
end
function Thirhaly_Harbringer (pUnit, event)
         pUnit:FullCastSpellOnTarget(36836, pUnit:GetMainTank())
end
function Thirhaly_Defensive (pUnit, event)
         pUnit:CastSpell(33479)
end
function Thirhaly_Phase3 (pUnit, event)
      if pUnit:GetHealthPct() < 49 then
         pUnit:RemoveEvents()        
         pUnit:RegisterEvent("Thirhaly_Blast", 20000, 0)
         pUnit:RegisterEvent("Thirhaly_Disorient", 15000, 0)
         pUnit:RegisterEvent("Thirhaly_Shelter", 50000, 0) 
         pUnit:RegisterEvent("Thirhaly_Frailty", 35000, 0)
         pUnit:RegisterEvent("Thirhaly_Phase4", 1000, 0)
  end
end
function Thirhaly_Blast (pUnit, event)
         pUnit:CastSpell(32907)
end
function Thirhaly_Disorient (pUnit, event)
         pUnit:FullCastSpellOnTarget(19369, pUnit:GetMainTank())
end
function Thirhaly_Shelter (pUnit, event)
         pUnit:CastSpell(36481)
end
function Thirhaly_Frailty (pUnit, event)
         pUnit:FullCastSpellOnTarget(19372, pUnit:GetRandomPlayer(0))
end
function Thirhaly_Phase4 (pUnit, event)
      if pUnit:GetHealthPct() < 20 then
         pUnit:RemoveEvents()
         pUnit:SendChatMessage(14, 0, "HASTA LAVISTA BABY!")
         pUnit:CastSpell(33130)
  end
end
function Thirhaly_LeaveCombat (pUnit, event)
         pUnit:RemoveEvents()
end
function Thirhaly_Die (pUnit, event)
         pUnit:RemoveEvents()
         pUnit:SendChatMessage(14, 0, "DAMN YOU FUCKER")     
end
RegisterUnitEvent(353505, 1, "Thirhaly_EnterCombat")
RegisterUnitEvent(353505, 2, "Thirhaly_LeaveCombat")
RegisterUnitEvent(353505, 4, "Thirhaly_Die")
