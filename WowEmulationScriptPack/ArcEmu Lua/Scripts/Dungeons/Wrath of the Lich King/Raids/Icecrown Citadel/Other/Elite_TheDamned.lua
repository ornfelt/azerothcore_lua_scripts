--//////////////////////////////////
--////   Holystone Productions  ////
--////       Copy Right         ////
--////  Blizzlike Repack v 1.0  ////
--//////////////////////////////////

local TheDamned = 37011

function TheDamned_OnCombat(punit, event)
   punit:RegisterEvent("Bone_Flurry", 10000, 1)
end

function Bone_Flurry(punit, event)
   punit:FullCastSpell(70960)
   punit:RegisterEvent("Shattered_Bones", 15000, 1)
end

function Shattered_Bones(punit, event)
   punit:CastSpellOnTarget(70961, punit:GetClosestPlayer())
   punit:RegisterEvent("Bone_Flurry", 10000, 1)
end

function TheDamned_OnLeaveCombat(punit, event)
   punit:RemoveEvents()
end

RegisterUnitEvent(TheDamned, 1, "TheDamned_OnCombat")
RegisterUnitEvent(TheDamned, 2, "TheDamned_OnLeaveCombat")