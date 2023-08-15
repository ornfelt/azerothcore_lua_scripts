--//////////////////////////////////
--////   Holystone Productions  ////
--////       Copy Right         ////
--////  Blizzlike Repack v 1.0  ////
--//////////////////////////////////

local DeathspeakerAttendant = 36811

function DeathspeakerAttendant_OnCombat(punit, event)
    punit:RegisterEvent("DeathspeakerAttendant_ShadowBolt", 10000, 1)
end

function DeathspeakerAttendant_ShadowBolt(punit, event)
    punit:FullCastSpellOnTarget(71254, punit:GetRandomPlayer(0))
	punit:RegisterEvent("DeathspeakerAttendant_ShadowNova", 10000, 1)
end

function DeathspeakerAttendant_ShadowNova(punit, event)
    punit:CastSpell(69355)
	punit:RegisterEvent("DeathspeakerAttendant_ShadowBolt", 10000, 1)
end

function DeathspeakerAttendant_OnLeaveCombat(punit, event)
    punit:RemoveEvents()
end

RegisterUnitEvent(DeathspeakerAttendant, 1, "DeathspeakerAttendant_OnCombat")
RegisterUnitEvent(DeathspeakerAttendant, 2, "DeathspeakerAttendant_OnLeaveCombat")