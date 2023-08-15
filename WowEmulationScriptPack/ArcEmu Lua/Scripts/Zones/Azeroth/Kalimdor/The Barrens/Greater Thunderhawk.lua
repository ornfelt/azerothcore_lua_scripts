--[[

	This is created by zdroid9770  :D

	© Copyright 2012

]]

function GreaterThunderhawk_OnCombat(Unit, Event)
	Unit:RegisterEvent("GreaterThunderhawk_ThunderClap", 10000, 0)
end

function GreaterThunderhawk_ThunderClap(Unit, Event) 
	Unit:CastSpell(8078) 
end

function GreaterThunderhawk_OnLeaveCombat(Unit, Event) 
	Unit:RemoveEvents() 
end

function GreaterThunderhawk_OnDied(Unit, Event) 
	Unit:RemoveEvents()
end

function GreaterThunderhawk_OnKilledTarget(Unit, Event) 
end

RegisterUnitEvent(3249, 1, "GreaterThunderhawk_OnCombat")
RegisterUnitEvent(3249, 2, "GreaterThunderhawk_OnLeaveCombat")
RegisterUnitEvent(3249, 3, "GreaterThunderhawk_OnKilledTarget")
RegisterUnitEvent(3249, 4, "GreaterThunderhawk_OnDied")