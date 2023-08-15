--[[

	This is created by zdroid9770  :D

	© Copyright 2012

]]

function VentureCoDeforester_OnCombat(Unit, Event)
	UnitRegisterEvent("VentureCoDeforester_Fireball", 8000, 0)
end

function VentureCoDeforester_Fireball(Unit, Event) 
	UnitFullCastSpellOnTarget(20793, 	UnitGetMainTank()) 
end

function VentureCoDeforester_OnLeaveCombat(Unit, Event) 
	UnitRemoveEvents() 
end

function VentureCoDeforester_OnDied(Unit, Event) 
	UnitRemoveEvents()
end

function VentureCoDeforester_OnKilledTarget(Unit, Event) 
end

RegisterUnitEvent(3991, 1, "VentureCoDeforester_OnCombat")
RegisterUnitEvent(3991, 2, "VentureCoDeforester_OnLeaveCombat")
RegisterUnitEvent(3991, 3, "VentureCoDeforester_OnKilledTarget")
RegisterUnitEvent(3991, 4, "VentureCoDeforester_OnDied")