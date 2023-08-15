--[[

	This is created by zdroid9770  :D

	© Copyright 2012

]]

function VentureCoLogger_OnCombat(Unit, Event)
	UnitRegisterEvent("VentureCoLogger_Throw", 6000, 0)
end

function VentureCoLogger_Throw(Unit, Event) 
	UnitFullCastSpellOnTarget(10277, 	UnitGetMainTank()) 
end

function VentureCoLogger_OnLeaveCombat(Unit, Event) 
	UnitRemoveEvents() 
end

function VentureCoLogger_OnDied(Unit, Event) 
	UnitRemoveEvents()
end

function VentureCoLogger_OnKilledTarget(Unit, Event) 
end

RegisterUnitEvent(3989, 1, "VentureCoLogger_OnCombat")
RegisterUnitEvent(3989, 2, "VentureCoLogger_OnLeaveCombat")
RegisterUnitEvent(3989, 3, "VentureCoLogger_OnKilledTarget")
RegisterUnitEvent(3989, 4, "VentureCoLogger_OnDied")