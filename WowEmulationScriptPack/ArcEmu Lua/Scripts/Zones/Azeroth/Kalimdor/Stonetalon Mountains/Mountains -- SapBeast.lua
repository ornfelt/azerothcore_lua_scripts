--[[

	This is created by zdroid9770  :D

	© Copyright 2012

]]

function SapBeast_OnCombat(Unit, Event)
	UnitRegisterEvent("SapBeast_Sap_Might", 10000, 0)
end

function SapBeast_Sap_Might(Unit, Event) 
	UnitFullCastSpellOnTarget(7997, 	UnitGetMainTank()) 
end

function SapBeast_OnLeaveCombat(Unit, Event) 
	UnitRemoveEvents() 
end

function SapBeast_OnDied(Unit, Event) 
	UnitRemoveEvents()
end

function SapBeast_OnKilledTarget(Unit, Event) 
end

RegisterUnitEvent(4020, 1, "SapBeast_OnCombat")
RegisterUnitEvent(4020, 2, "SapBeast_OnLeaveCombat")
RegisterUnitEvent(4020, 3, "SapBeast_OnKilledTarget")
RegisterUnitEvent(4020, 4, "SapBeast_OnDied")