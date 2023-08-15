--//////////////////////////////////
--////   Holystone Productions  ////
--////       Copy Right         ////
--////  Blizzlike Repack v 1.0  ////
--//////////////////////////////////

local DeathspeakerServant = 36805

function DeathspeakerServant_OnCombat(punit, event)
   punit:RegisterEvent("DeathspeakerServant_ChaosBolt", 10000, 1)
end

function DeathspeakerServant_ChaosBolt(punit, event)
   punit:FullCastSpellOnTarget(69576, punit:GetRandomPlayer(0))
   punit:RegisterEvent("DeathspeakerServant_ConsumingShadows", 5000, 1)
end

function DeathspeakerServant_ConsumingShadows(punit, event)
   local target = punit:GetRandomFriend()
      if (target ~= nil) then
	punit:FullCastSpellOnTarget(69405, target)
	punit:RegisterEvent("DeathspeakerServant_CurseofAgony", 8000, 1)
 end
end

function DeathspeakerServant_CurseofAgony(punit, event)
   local target = punit:GetRandomFriend()
      if (target ~= nil) then
	punit:CastSpellOnTarget(69404, target)
    punit:RegisterEvent("DeathspeakerServant_ChaosBolt", 5000, 1)
 end
end

function DeathspeakerServant_OnLeaveCombat(punit, event)
    punit:RemoveEvents()
end

RegisterUnitEvent(DeathspeakerServant, 1, "DeathspeakerServant_OnCombat")
RegisterUnitEvent(DeathspeakerServant, 2, "DeathspeakerServant_OnLeaveCombat")