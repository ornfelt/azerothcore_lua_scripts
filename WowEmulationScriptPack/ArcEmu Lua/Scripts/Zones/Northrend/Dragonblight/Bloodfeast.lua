--[[

	This is created by zdroid9770  :D

	© Copyright 2012

]]


function Bloodfeast_OnCombat(Unit, Event)
Unit:RegisterEvent("Bloodfeast_InciteMaggots", 4000, 1)
end

function Bloodfeast_InciteMaggots(Unit, Event) 
Unit:CastSpell(52126) 
end

function Bloodfeast_OnLeaveCombat(Unit, Event) 
Unit:RemoveEvents() 
end

function Bloodfeast_OnDied(Unit, Event) 
Unit:RemoveEvents()
end

function Bloodfeast_OnKilledTarget(Unit, Event) 
end

RegisterUnitEvent(27008, 1, "Bloodfeast_OnCombat")
RegisterUnitEvent(27008, 2, "Bloodfeast_OnLeaveCombat")
RegisterUnitEvent(27008, 3, "Bloodfeast_OnKilledTarget")
RegisterUnitEvent(27008, 4, "Bloodfeast_OnDied")