--[[

	This is created by zdroid9770  :D

	© Copyright 2012

]]

function HighperchConsort_OnCombat(Unit, Event)
	UnitRegisterEvent("HighperchConsort_Poison", 12000, 0)
end

function HighperchConsort_Poison(Unit, Event) 
	UnitFullCastSpellOnTarget(744, 	UnitGetMainTank()) 
end

function HighperchConsort_OnLeaveCombat(Unit, Event) 
	UnitRemoveEvents() 
end

function HighperchConsort_OnDied(Unit, Event) 
	UnitRemoveEvents()
end

function HighperchConsort_OnKilledTarget(Unit, Event) 
end

RegisterUnitEvent(4109, 1, "HighperchConsort_OnCombat")
RegisterUnitEvent(4109, 2, "HighperchConsort_OnLeaveCombat")
RegisterUnitEvent(4109, 3, "HighperchConsort_OnKilledTarget")
RegisterUnitEvent(4109, 4, "HighperchConsort_OnDied")