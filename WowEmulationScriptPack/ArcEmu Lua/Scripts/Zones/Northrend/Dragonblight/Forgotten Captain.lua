--[[

	This is created by zdroid9770  :D

	© Copyright 2012

]]


function ForgottenCaptain_OnCombat(Unit, Event)
Unit:RegisterEvent("ForgottenCaptain_Stormhammer", 9000, 0)
end

function ForgottenCaptain_Stormhammer(Unit, Event) 
Unit:FullCastSpellOnTarget(51591, Unit:GetMainTank()) 
end

function ForgottenCaptain_OnLeaveCombat(Unit, Event) 
Unit:RemoveEvents() 
end

function ForgottenCaptain_OnDied(Unit, Event) 
Unit:RemoveEvents()
end

function ForgottenCaptain_OnKilledTarget(Unit, Event) 
end

RegisterUnitEvent(27220, 1, "ForgottenCaptain_OnCombat")
RegisterUnitEvent(27220, 2, "ForgottenCaptain_OnLeaveCombat")
RegisterUnitEvent(27220, 3, "ForgottenCaptain_OnKilledTarget")
RegisterUnitEvent(27220, 4, "ForgottenCaptain_OnDied")