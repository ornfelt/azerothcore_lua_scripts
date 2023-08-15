--//////////////////////////////////
--//// © Holystone Productions  ////
--////     Cronic & Warfrost    ////
--////       Copy Right         ////
--////  Blizzlike Repack v 2.5  ////
--//////////////////////////////////

local Volkhan = 28587
local MoltenGolem = 28695

function Volkhan_OnCombat(punit, event)
   punit:RegisterEvent("Phase_One", 1000, 1)
end

function Phase_One(punit, event)
   punit:RegisterEvent("Volkhan_ShatteringStomp", 20000, 0)
   punit:RegisterEvent("Volkhan_Heat", 60000, 0)
   punit:RegisterEvent("Volkhan_Phase_Two", 1000, 0)
end

function Volkhan_ShatteringStomp(punit, event)
   local target = punit:GetAITargets()
     punit:FullCastSpellOnTarget(52237, target)
end

function Volkhan_Heat(punit, event)
   punit:CastSpell(52387)
end

function Volkhan_Phase_Two(punit, event)
  if punit:GetHealthPct() <= 80 then
   punit:RemoveEvents()
    punit:RegisterEvent("Volkhan_Move_Unvil", 500, 1)
	punit:RegisterEvent("Volkhan_SpawnAdds", 10000, 1)
    punit:RegisterEvent("Volkhan_ShatteringStomp", 20000, 0)
    punit:RegisterEvent("Volkhan_Heat", 60000, 0)
	punit:RegisterEvent("Volkhan_Phase_Twee", 1000, 0)
  end
end

function Volkhan_Move_Unvil(punit, event)
   punit:MoveTo(1328.150024, -95.666222, 56.716076, 2.270505)
end

function Volkhan_SpawnAdds(punit, event)
   local plr = punit:GetMainTank()
    local x = plr:GetX()
	local y = plr:GetY()
	local z = plr:GetZ()
	local o = plr:GetO()
   punit:SpawnCreature(28695, x, y, z, o, 14, 360000)
end

function Volkhan_ShatteringStomp(punit, event)
   local target = punit:GetAITargets()
     punit:FullCastSpellOnTarget(52237, target)
end

function Volkhan_Heat(punit, event)
   punit:CastSpell(52387)
end

function Volkhan_Phase_Tree(punit, event)
  if punit:GetHealthPct() <= 60 then
   punit:RemoveEvents()
    punit:RegisterEvent("Volkhan_Move_Unvil", 500, 1)
	punit:RegisterEvent("Volkhan_SpawnAdds", 10000, 1)
    punit:RegisterEvent("Volkhan_ShatteringStomp", 20000, 0)
    punit:RegisterEvent("Volkhan_Heat", 60000, 0)
	punit:RegisterEvent("Volkhan_Phase_For", 1000, 0)
  end
end

function Volkhan_Move_Unvil(punit, event)
   punit:MoveTo(1328.150024, -95.666222, 56.716076, 2.270505)
end

function Volkhan_SpawnAdds(punit, event)
   local plr = punit:GetMainTank()
    local x = plr:GetX()
	local y = plr:GetY()
	local z = plr:GetZ()
	local o = plr:GetO()
   punit:SpawnCreature(28695, x, y, z, o, 14, 360000)
end

function Volkhan_ShatteringStomp(punit, event)
   local target = punit:GetAITargets()
     punit:FullCastSpellOnTarget(52237, target)
end

function Volkhan_Heat(punit, event)
   punit:CastSpell(52387)
end

function Volkhan_Phase_For(punit, event)
  if punit:GetHealthPct() <= 40 then
   punit:RemoveEvents()
    punit:RegisterEvent("Volkhan_Move_Unvil", 500, 1)
	punit:RegisterEvent("Volkhan_SpawnAdds", 10000, 1)
    punit:RegisterEvent("Volkhan_ShatteringStomp", 20000, 0)
    punit:RegisterEvent("Volkhan_Heat", 60000, 0)
	punit:RegisterEvent("Volkhan_Phase_Five", 1000, 0)
  end
end

function Volkhan_Move_Unvil(punit, event)
   punit:MoveTo(1328.150024, -95.666222, 56.716076, 2.270505)
end

function Volkhan_SpawnAdds(punit, event)
   local plr = punit:GetMainTank()
    local x = plr:GetX()
	local y = plr:GetY()
	local z = plr:GetZ()
	local o = plr:GetO()
   punit:SpawnCreature(28695, x, y, z, o, 14, 360000)
end

function Volkhan_ShatteringStomp(punit, event)
   local target = punit:GetAITargets()
     punit:FullCastSpellOnTarget(52237, target)
end

function Volkhan_Heat(punit, event)
   punit:CastSpell(52387)
end

function Volkhan_Phase_Five(punit, event)
  if punit:GetHealthPct() <= 20 then
   punit:RemoveEvents()
    punit:RegisterEvent("Volkhan_Move_Unvil", 500, 1)
	punit:RegisterEvent("Volkhan_SpawnAdds", 10000, 1)
    punit:RegisterEvent("Volkhan_ShatteringStomp", 20000, 0)
    punit:RegisterEvent("Volkhan_Heat", 60000, 0)
  end
end

function Volkhan_Move_Unvil(punit, event)
   punit:MoveTo(1328.150024, -95.666222, 56.716076, 2.270505)
end

function Volkhan_SpawnAdds(punit, event)
   local plr = punit:GetMainTank()
    local x = plr:GetX()
	local y = plr:GetY()
	local z = plr:GetZ()
	local o = plr:GetO()
   punit:SpawnCreature(28695, x, y, z, o, 14, 360000)
end

function Volkhan_ShatteringStomp(punit, event)
   local target = punit:GetAITargets()
     punit:FullCastSpellOnTarget(52237, target)
end

function Volkhan_Heat(punit, event)
   punit:CastSpell(52387)
end

RegisterUnitEvent(Volkhan, 1, "Volkhan_OnCombat")