--[[

	This is created by zdroid9770  :D

	© Copyright 2012

]]

function GravelsnoutKobold_OnCombat(Unit, Event)
	UnitRegisterEvent("GravelsnoutKobold_Strike", 4000, 0)
end

function GravelsnoutKobold_Strike(Unit, Event) 
	UnitFullCastSpellOnTarget(11976, 	UnitGetMainTank()) 
end

function GravelsnoutKobold_OnLeaveCombat(Unit, Event) 
	UnitRemoveEvents() 
end

function GravelsnoutKobold_OnDied(Unit, Event) 
	UnitRemoveEvents()
end

function GravelsnoutKobold_OnKilledTarget(Unit, Event) 
end

RegisterUnitEvent(4111, 1, "GravelsnoutKobold_OnCombat")
RegisterUnitEvent(4111, 2, "GravelsnoutKobold_OnLeaveCombat")
RegisterUnitEvent(4111, 3, "GravelsnoutKobold_OnKilledTarget")
RegisterUnitEvent(4111, 4, "GravelsnoutKobold_OnDied")