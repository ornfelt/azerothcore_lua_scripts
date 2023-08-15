--[[

	This is created by zdroid9770  :D

	© Copyright 2012

]]


function AngratharAberration_OnCombat(Unit, Event)
Unit:RegisterEvent("AngratharAberration_Enrage", 1000, 1)
end

function AngratharAberration_Enrage(Unit, Event) 
Unit:CastSpell(31540) 
end

function AngratharAberration_OnLeaveCombat(Unit, Event) 
Unit:RemoveEvents() 
end

function AngratharAberration_OnDied(Unit, Event) 
Unit:RemoveEvents()
end

function AngratharAberration_OnKilledTarget(Unit, Event) 
end

RegisterUnitEvent(27631, 1, "AngratharAberration_OnCombat")
RegisterUnitEvent(27631, 2, "AngratharAberration_OnLeaveCombat")
RegisterUnitEvent(27631, 3, "AngratharAberration_OnKilledTarget")
RegisterUnitEvent(27631, 4, "AngratharAberration_OnDied")