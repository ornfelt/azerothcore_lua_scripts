--[[

	This is created by zdroid9770  :D

	© Copyright 2012

]]


function WildBuck_OnCombat(Unit, Event)
	Unit:RegisterEvent("WildBuck_RushingCharge", 8000, 0)
end

function WildBuck_RushingCharge(pUnit, Event) 
	pUnit:CastSpell(6268) 
end

function WildBuck_OnLeaveCombat(Unit, Event) 
	Unit:RemoveEvents() 
end

function WildBuck_OnDied(Unit, Event) 
	Unit:RemoveEvents()
end

RegisterUnitEvent(3816, 1, "WildBuck_OnCombat")
RegisterUnitEvent(3816, 2, "WildBuck_OnLeaveCombat")
RegisterUnitEvent(3816, 4, "WildBuck_OnDied")