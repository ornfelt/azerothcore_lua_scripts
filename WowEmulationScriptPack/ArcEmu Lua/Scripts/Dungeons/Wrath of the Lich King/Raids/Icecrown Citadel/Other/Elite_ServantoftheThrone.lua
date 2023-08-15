--//////////////////////////////////
--////   Holystone Productions  ////
--////       Copy Right         ////
--////  Blizzlike Repack v 1.0  ////
--//////////////////////////////////

local ServantoftheThrone = 36724

function ServantoftheThrone_OnCombat(punit, event)
  punit:RegisterEvent("Glacial_Blast", 10000, 0)
end

function Glacial_Blast(punit, event)
   punit:FullCastSpell(71029)
  end


function ServantoftheThrone_OnLeaveCombat(punit, event)
   punit:RemoveEvents()
end

RegisterUnitEvent(ServantoftheThrone, 1, "ServantoftheThrone_OnCombat")
RegisterUnitEvent(ServantoftheThrone, 2, "ServantoftheThrone_OnLeaveCombat")