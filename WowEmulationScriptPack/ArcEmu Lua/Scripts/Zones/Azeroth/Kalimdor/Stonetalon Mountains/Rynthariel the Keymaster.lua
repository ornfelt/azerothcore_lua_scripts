--[[

	This is created by zdroid9770  :D

	© Copyright 2012

]]

function RyntharieltheKeymaster_OnCombat(Unit, Event)
	UnitRegisterEvent("RyntharieltheKeymaster_SlowingPoison", 10000, 0)
	UnitRegisterEvent("RyntharieltheKeymaster_Throw", 6000, 0)
end

function RyntharieltheKeymaster_SlowingPoison(Unit, Event) 
	UnitFullCastSpellOnTarget(7992, 	UnitGetMainTank()) 
end

function RyntharieltheKeymaster_Throw(Unit, Event) 
	UnitFullCastSpellOnTarget(10277, 	UnitGetMainTank()) 
end

function RyntharieltheKeymaster_OnLeaveCombat(Unit, Event) 
	UnitRemoveEvents() 
end

function RyntharieltheKeymaster_OnDied(Unit, Event) 
	UnitRemoveEvents()
end

function RyntharieltheKeymaster_OnKilledTarget(Unit, Event) 
end

RegisterUnitEvent(8518, 1, "RyntharieltheKeymaster_OnCombat")
RegisterUnitEvent(8518, 2, "RyntharieltheKeymaster_OnLeaveCombat")
RegisterUnitEvent(8518, 3, "RyntharieltheKeymaster_OnKilledTarget")
RegisterUnitEvent(8518, 4, "RyntharieltheKeymaster_OnDied")