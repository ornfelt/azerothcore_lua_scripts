--[[

	This is created by zdroid9770  :D

	© Copyright 2012

]]


function ForgottenKnight_OnCombat(Unit, Event)
Unit:RegisterEvent("ForgottenKnight_Throw", 5000, 0)
end

function ForgottenKnight_Throw(Unit, Event) 
Unit:FullCastSpellOnTarget(38556, Unit:GetMainTank()) 
end

function ForgottenKnight_OnLeaveCombat(Unit, Event) 
Unit:RemoveEvents() 
end

function ForgottenKnight_OnDied(Unit, Event) 
Unit:RemoveEvents()
end

function ForgottenKnight_OnKilledTarget(Unit, Event) 
end

RegisterUnitEvent(27224, 1, "ForgottenKnight_OnCombat")
RegisterUnitEvent(27224, 2, "ForgottenKnight_OnLeaveCombat")
RegisterUnitEvent(27224, 3, "ForgottenKnight_OnKilledTarget")
RegisterUnitEvent(27224, 4, "ForgottenKnight_OnDied")