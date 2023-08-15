--//////////////////////////////////
--////   Holystone Productions  ////
--////       Copy Right         ////
--////  Blizzlike Repack v 1.0  ////
--//////////////////////////////////

local AncientSkeletalSoldier = 37012

function AncientSkeletalSoldier_OnCombat(punit, event)
  punit:RegisterEvent("Shield_Bash", 13000, 0)
end

function Shield_Bash(punit, event)
  local target = punit:GetRandomPlayer(0)
  if (target ~= nil) then
   punit:FullCastSpellOnTarget(70964, target)
 end
end

function AncientSkeletalSoldier_OnLeaveCombat(punit, event)
   punit:RemoveEvents()
end

RegisterUnitEvent(AncientSkeletalSoldier, 1, "AncientSkeletalSoldier_OnCombat")
RegisterUnitEvent(AncientSkeletalSoldier, 2, "AncientSkeletalSoldier_OnLeaveCombat")