--//////////////////////////////////
--////   Holystone Productions  ////
--////       Copy Right         ////
--////  Blizzlike Repack v 1.0  ////
--//////////////////////////////////

local DeathboundWard = 37007

function DeathboundWard_OnCombat(punit, event)
   punit:RegisterEvent("Disrupting_Shout", 10000, 1)
end

function Disrupting_Shout(punit, event)
   punit:FullCastSpell(71022)
   punit:RegisterEvent("Saber_Lash_InComing", 8000, 1)
end

function Saber_Lash_InComing(punit, event)
   punit:RegisterEvent("Saber_Lash", 1000, 1)
end

function Saber_Lash(punit, event)
   punit:CastSpellOnTarget(71021, punit:GetClosestPlayer())
   punit:RegisterEvent("Disrupting_Shout", 9000, 1)
end

function DeathboundWard_OnLeaveCombat(punit, event)
   punit:RemoveEvents()
end

RegisterUnitEvent(DeathboundWard, 1, "DeathboundWard_OnCombat")
RegisterUnitEvent(DeathboundWard, 2, "DeathboundWard_OnLeaveCombat")