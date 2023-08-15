--[[

	This is created by zdroid9770  :D

	© Copyright 2012

]]

function RazormaneQuilboar_OnCombat(Unit, Event)
	Unit:RegisterEvent("RazormaneQuilboar_RazorMane", 2000, 2)
end

function RazormaneQuilboar_RazorMane(Unit, Event) 
	Unit:CastSpell(5280) 
end

function RazormaneQuilboar_OnLeaveCombat(Unit, Event) 
	Unit:RemoveEvents() 
end

function RazormaneQuilboar_OnDied(Unit, Event) 
	Unit:RemoveEvents()
end

function RazormaneQuilboar_OnKilledTarget(Unit, Event) 
end

RegisterUnitEvent(3111, 1, "RazormaneQuilboar_OnCombat")
RegisterUnitEvent(3111, 2, "RazormaneQuilboar_OnLeaveCombat")
RegisterUnitEvent(3111, 3, "RazormaneQuilboar_OnKilledTarget")
RegisterUnitEvent(3111, 4, "RazormaneQuilboar_OnDied")