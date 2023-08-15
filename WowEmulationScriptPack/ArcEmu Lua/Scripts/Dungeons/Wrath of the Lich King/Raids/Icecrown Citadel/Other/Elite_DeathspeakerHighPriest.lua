--//////////////////////////////////
--////   Holystone Productions  ////
--////       Copy Right         ////
--////  Blizzlike Repack v 1.0  ////
--//////////////////////////////////

local DeathspeakerHighPriest = 36829

function DeathspeakerHighPriest_OnCombat(punit, event)
    punit:RegisterEvent("DeathspeakerHighPriest_AuraofDarkness", 15000, 1)
end

function DeathspeakerHighPriest_AuraofDarkness(punit, event)
    local target = punit:GetClosestPlayer()
      if (target ~= nil) then
	 target:AddAura(69491, 60000)
	 punit:RegisterEvent("DeathspeakerHighPriest_DarkReckoning", 5000, 1)
 end
end

function DeathspeakerHighPriest_DarkReckoning(punit, event)
    local target = punit:GetRandomPlayer(0)
      if (target ~= nil) then
	 punit:FullCastSpellOnTarget(69483, target)
	 punit:RegisterEvent("DeathspeakerHighPriest_AuraofDarkness", 8000, 1)
 end
end

function DeathspeakerHighPriest_OnLeaveCombat(punit, event)
     punit:RemoveEvents()
end

RegisterUnitEvent(DeathspeakerHighPriest, 1, "DeathspeakerHighPriest_OnCombat")
RegisterUnitEvent(DeathspeakerHighPriest, 2, "DeathspeakerHighPriest_OnLeaveCombat")