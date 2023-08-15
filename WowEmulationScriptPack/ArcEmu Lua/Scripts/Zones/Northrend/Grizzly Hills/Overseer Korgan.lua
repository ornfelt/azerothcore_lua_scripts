--[[

	This is created by zdroid9770  :D

	© Copyright 2012

]]


function OverseerKorgan_OnCombat(Unit, Event)
Unit:RegisterEvent("OverseerKorgan_CallLightning", 6000, 0)
Unit:RegisterEvent("OverseerKorgan_RevitalizingRune", 10000, 0)
end

function OverseerKorgan_CallLightning(Unit, Event) 
Unit:FullCastSpellOnTarget(32018, Unit:GetMainTank()) 
end

function OverseerKorgan_RevitalizingRune(Unit, Event) 
Unit:CastSpell(52714) 
end

function OverseerKorgan_OnLeaveCombat(Unit, Event) 
Unit:RemoveEvents() 
end

function OverseerKorgan_OnDied(Unit, Event) 
Unit:RemoveEvents()
end

function OverseerKorgan_OnKilledTarget(Unit, Event) 
end

RegisterUnitEvent(26921, 1, "OverseerKorgan_OnCombat")
RegisterUnitEvent(26921, 2, "OverseerKorgan_OnLeaveCombat")
RegisterUnitEvent(26921, 3, "OverseerKorgan_OnKilledTarget")
RegisterUnitEvent(26921, 4, "OverseerKorgan_OnDied")