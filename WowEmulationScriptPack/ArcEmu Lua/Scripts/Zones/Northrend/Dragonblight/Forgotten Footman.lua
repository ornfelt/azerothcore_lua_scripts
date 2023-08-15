--[[

	This is created by zdroid9770  :D

	© Copyright 2012

]]


function ForgottenFootman_OnCombat(Unit, Event)
Unit:RegisterEvent("ForgottenFootman_ShieldBlock", 5000, 0)
end

function ForgottenFootman_ShieldBlock(Unit, Event) 
Unit:CastSpell(32587) 
end

function ForgottenFootman_OnLeaveCombat(Unit, Event) 
Unit:RemoveEvents() 
end

function ForgottenFootman_OnDied(Unit, Event) 
Unit:RemoveEvents()
end

function ForgottenFootman_OnKilledTarget(Unit, Event) 
end

RegisterUnitEvent(27229, 1, "ForgottenFootman_OnCombat")
RegisterUnitEvent(27229, 2, "ForgottenFootman_OnLeaveCombat")
RegisterUnitEvent(27229, 3, "ForgottenFootman_OnKilledTarget")
RegisterUnitEvent(27229, 4, "ForgottenFootman_OnDied")