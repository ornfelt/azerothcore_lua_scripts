--//////////////////////////////////
--////   Holystone Productions  ////
--////       Copy Right         ////
--////  Blizzlike Repack v 1.0  ////
--//////////////////////////////////

local DeathspeakerDisciple = 36807

function DeathspeakerDisciple_OnCombat(punit, event)
    punit:RegisterEvent("DeathspeakerDisciple_ShadowBolt", 10000, 1)
end

function DeathspeakerDisciple_ShadowBolt(punit, event)
    punit:FullCastSpellOnTarget(71254, punit:GetRandomPlayer(0))
	punit:RegisterEvent("DeathspeakerDisciple_ShadowMend", 10000, 1)
end

function DeathspeakerDisciple_ShadowMend(punit, event)
     local target = punit:GetRandomFriend()
      if (target ~= nil) then
     punit:FullCastSpellOnTarget(69389, target)
	punit:RegisterEvent("DeathspeakerDisciple_DarkBlessing", 5000, 1)
  end
end

function DeathspeakerDisciple_DarkBlessing(punit, event)
     local target = punit:GetRandomFriend()
      if (target ~= nil) then
     punit:FullCastSpellOnTarget(69391, target)
	punit:RegisterEvent("DeathspeakerDisciple_ShadowBolt", 5000, 1)
  end
end

function DeathspeakerDisciple_OnLeaveCombat(punit, event)
    punit:RemoveEvents()
end

RegisterUnitEvent(DeathspeakerDisciple, 1, "DeathspeakerDisciple_OnCombat")
RegisterUnitEvent(DeathspeakerDisciple, 2, "DeathspeakerDisciple_OnLeaveCombat")