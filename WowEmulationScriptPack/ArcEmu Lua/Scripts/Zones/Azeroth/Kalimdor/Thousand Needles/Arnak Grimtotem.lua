--[[

	This is created by zdroid9770  :D

	© Copyright 2012

]]

function ArnakGrimtotem_OnCombat(Unit, Event)
	UnitRegisterEvent("ArnakGrimtotem_Rend", 10000, 0)
	UnitRegisterEvent("ArnakGrimtotem_Uppercut", 6000, 0)
end

function ArnakGrimtotem_Rend(Unit, Event) 
	UnitFullCastSpellOnTarget(11977, 	UnitGetMainTank()) 
end

function ArnakGrimtotem_Uppercut(Unit, Event) 
	UnitFullCastSpellOnTarget(10966, 	UnitGetMainTank()) 
end

function ArnakGrimtotem_OnLeaveCombat(Unit, Event) 
	UnitRemoveEvents() 
end

function ArnakGrimtotem_OnDied(Unit, Event) 
	UnitRemoveEvents()
end

function ArnakGrimtotem_OnKilledTarget(Unit, Event) 
end

RegisterUnitEvent(10896, 1, "ArnakGrimtotem_OnCombat")
RegisterUnitEvent(10896, 2, "ArnakGrimtotem_OnLeaveCombat")
RegisterUnitEvent(10896, 3, "ArnakGrimtotem_OnKilledTarget")
RegisterUnitEvent(10896, 4, "ArnakGrimtotem_OnDied")