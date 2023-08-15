--[[

	This is created by zdroid9770  :D

	© Copyright 2012

]]


function ForgottenPeasant_OnCombat(Unit, Event)
Unit:RegisterEvent("ForgottenPeasant_Bonk", 6000, 0)
end

function ForgottenPeasant_Bonk(Unit, Event) 
Unit:FullCastSpellOnTarget(51601, Unit:GetMainTank()) 
end

function ForgottenPeasant_OnLeaveCombat(Unit, Event) 
Unit:RemoveEvents() 
end

function ForgottenPeasant_OnDied(Unit, Event) 
Unit:RemoveEvents()
end

function ForgottenPeasant_OnKilledTarget(Unit, Event) 
end

RegisterUnitEvent(27226, 1, "ForgottenPeasant_OnCombat")
RegisterUnitEvent(27226, 2, "ForgottenPeasant_OnLeaveCombat")
RegisterUnitEvent(27226, 3, "ForgottenPeasant_OnKilledTarget")
RegisterUnitEvent(27226, 4, "ForgottenPeasant_OnDied")