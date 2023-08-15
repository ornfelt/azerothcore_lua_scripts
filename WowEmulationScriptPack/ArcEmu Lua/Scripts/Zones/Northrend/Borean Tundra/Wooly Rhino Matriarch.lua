--[[

	This is created by zdroid9770  :D

	© Copyright 2012

]]


function WoolyRhinoMatriarch_OnCombat(Unit, Event)
Unit:RegisterEvent("WoolyRhinoMatriarch_ThickHide", 4000, 1)
end

function WoolyRhinoMatriarch_ThickHide(Unit, Event) 
Unit:CastSpell(50502) 
end

function WoolyRhinoMatriarch_OnLeaveCombat(Unit, Event) 
Unit:RemoveEvents() 
end

function WoolyRhinoMatriarch_OnDied(Unit, Event) 
Unit:RemoveEvents()
end

function WoolyRhinoMatriarch_OnKilledTarget(Unit, Event) 
end

RegisterUnitEvent(25487, 1, "WoolyRhinoMatriarch_OnCombat")
RegisterUnitEvent(25487, 2, "WoolyRhinoMatriarch_OnLeaveCombat")
RegisterUnitEvent(25487, 3, "WoolyRhinoMatriarch_OnKilledTarget")
RegisterUnitEvent(25487, 4, "WoolyRhinoMatriarch_OnDied")