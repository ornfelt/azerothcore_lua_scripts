--//////////////////////////////////
--////   Holystone Productions  ////
--////       Copy Right         ////
--////  Blizzlike Repack v 1.0  ////
--//////////////////////////////////

local DeathspeakerZealot = 36808

function DeathspeakerZealot_OnCombat(punit, event)
    punit:RegisterEvent("DeathspeakerZealot_ShadowCleave", 10000, 0)
end

function DeathspeakerZealot_ShadowCleave(punit, event)
    punit:CastSpellOnTarget(69492, punit:GetClosestPlayer())
end

function DeathspeakerZealot_OnLeaveCombat(punit, event)
    punit:RemoveEvents()
end

RegisterUnitEvent(DeathspeakerZealot, 1, "DeathspeakerZealot_OnCombat")
RegisterUnitEvent(DeathspeakerZealot, 2, "DeathspeakerZealot_OnLeaveCombat")