--[[

	This is created by zdroid9770  :D

	© Copyright 2012

]]


function Uruson_OnCombat(Unit, Event)
	Unit:RegisterEvent("Uruson_DemoralizingRoar", 10000, 0)
end

function Uruson_DemoralizingRoar(Unit, Event) 
	Unit:CastSpell(15971) 
end

function Uruson_OnLeaveCombat(Unit, Event) 
	Unit:RemoveEvents() 
end

function Uruson_OnDied(Unit, Event) 
	Unit:RemoveEvents()
end

function Uruson_OnKilledTarget(Unit, Event) 
end

RegisterUnitEvent(14428, 1, "Uruson_OnCombat")
RegisterUnitEvent(14428, 2, "Uruson_OnLeaveCombat")
RegisterUnitEvent(14428, 3, "Uruson_OnKilledTarget")
RegisterUnitEvent(14428, 4, "Uruson_OnDied")