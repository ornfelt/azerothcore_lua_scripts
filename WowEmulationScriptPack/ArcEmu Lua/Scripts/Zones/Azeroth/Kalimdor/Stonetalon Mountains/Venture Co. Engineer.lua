--[[

	This is created by zdroid9770  :D

	© Copyright 2012

]]

function VentureCoEngineer_OnCombat(Unit, Event)
	UnitRegisterEvent("VentureCoEngineer_ThrowDynamite", 8000, 0)
end

function VentureCoEngineer_ThrowDynamite(Unit, Event) 
	UnitCastSpell(7978) 
end

function VentureCoEngineer_OnLeaveCombat(Unit, Event) 
	UnitRemoveEvents() 
end

function VentureCoEngineer_OnDied(Unit, Event) 
	UnitRemoveEvents()
end

function VentureCoEngineer_OnKilledTarget(Unit, Event) 
end

RegisterUnitEvent(3992, 1, "VentureCoEngineer_OnCombat")
RegisterUnitEvent(3992, 2, "VentureCoEngineer_OnLeaveCombat")
RegisterUnitEvent(3992, 3, "VentureCoEngineer_OnKilledTarget")
RegisterUnitEvent(3992, 4, "VentureCoEngineer_OnDied")