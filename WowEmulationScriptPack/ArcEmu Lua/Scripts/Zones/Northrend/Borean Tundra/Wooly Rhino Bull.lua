--[[

	This is created by zdroid9770  :D

	© Copyright 2012

]]


function WoolyRhinoBull_OnCombat(Unit, Event)
Unit:RegisterEvent("WoolyRhinoBull_ThickHide", 4000, 1)
end

function WoolyRhinoBull_ThickHide(Unit, Event) 
Unit:CastSpell(50502) 
end

function WoolyRhinoBull_OnLeaveCombat(Unit, Event) 
Unit:RemoveEvents() 
end

function WoolyRhinoBull_OnDied(Unit, Event) 
Unit:RemoveEvents()
end

function WoolyRhinoBull_OnKilledTarget(Unit, Event) 
end

RegisterUnitEvent(25489, 1, "WoolyRhinoBull_OnCombat")
RegisterUnitEvent(25489, 2, "WoolyRhinoBull_OnLeaveCombat")
RegisterUnitEvent(25489, 3, "WoolyRhinoBull_OnKilledTarget")
RegisterUnitEvent(25489, 4, "WoolyRhinoBull_OnDied")