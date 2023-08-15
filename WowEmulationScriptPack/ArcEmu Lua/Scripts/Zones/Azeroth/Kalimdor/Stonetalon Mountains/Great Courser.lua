--[[

	This is created by zdroid9770  :D

	© Copyright 2012

]]

function GreatCourser_OnCombat(Unit, Event)
	UnitRegisterEvent("GreatCourser_RushingCharge", 8000, 0)
end

function GreatCourser_RushingCharge(Unit, Event) 
	UnitCastSpell(6268) 
end

function GreatCourser_OnLeaveCombat(Unit, Event) 
	UnitRemoveEvents() 
end

function GreatCourser_OnDied(Unit, Event) 
	UnitRemoveEvents()
end

function GreatCourser_OnKilledTarget(Unit, Event) 
end

RegisterUnitEvent(4019, 1, "GreatCourser_OnCombat")
RegisterUnitEvent(4019, 2, "GreatCourser_OnLeaveCombat")
RegisterUnitEvent(4019, 3, "GreatCourser_OnKilledTarget")
RegisterUnitEvent(4019, 4, "GreatCourser_OnDied")