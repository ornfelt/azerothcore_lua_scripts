--[[

	This is created by zdroid9770  :D

	© Copyright 2012

]]

function AntleredCourser_OnCombat(Unit, Event)
	UnitRegisterEvent("AntleredCourser_RushingCharge", 8000, 0)
end

function AntleredCourser_RushingCharge(Unit, Event) 
	UnitCastSpell(6268) 
end

function AntleredCourser_OnLeaveCombat(Unit, Event) 
	UnitRemoveEvents() 
end

function AntleredCourser_OnDied(Unit, Event) 
	UnitRemoveEvents()
end

function AntleredCourser_OnKilledTarget(Unit, Event) 
end

RegisterUnitEvent(4018, 1, "AntleredCourser_OnCombat")
RegisterUnitEvent(4018, 2, "AntleredCourser_OnLeaveCombat")
RegisterUnitEvent(4018, 3, "AntleredCourser_OnKilledTarget")
RegisterUnitEvent(4018, 4, "AntleredCourser_OnDied")