--[[

	This is created by zdroid9770  :D

	© Copyright 2012

]]

function YoungPridewing_OnCombat(Unit, Event)
	UnitRegisterEvent("YoungPridewing_Poison", 10000, 0)
end

function YoungPridewing_Poison(Unit, Event) 
	UnitFullCastSpellOnTarget(744, 	UnitGetMainTank()) 
end

function YoungPridewing_OnLeaveCombat(Unit, Event) 
	UnitRemoveEvents() 
end

function YoungPridewing_OnDied(Unit, Event) 
	UnitRemoveEvents()
end

function YoungPridewing_OnKilledTarget(Unit, Event) 
end

RegisterUnitEvent(4005, 1, "YoungPridewing_OnCombat")
RegisterUnitEvent(4005, 2, "YoungPridewing_OnLeaveCombat")
RegisterUnitEvent(4005, 3, "YoungPridewing_OnKilledTarget")
RegisterUnitEvent(4005, 4, "YoungPridewing_OnDied")