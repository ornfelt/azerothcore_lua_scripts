--[[

	This is created by zdroid9770  :D

	© Copyright 2012

]]

function GravelsnoutVermin_OnCombat(Unit, Event)
	UnitRegisterEvent("GravelsnoutVermin_InfectedWound", 10000, 0)
end

function GravelsnoutVermin_InfectedWound(Unit, Event) 
	UnitFullCastSpellOnTarget(3427, 	UnitGetMainTank()) 
end

function GravelsnoutVermin_OnLeaveCombat(Unit, Event) 
	UnitRemoveEvents() 
end

function GravelsnoutVermin_OnDied(Unit, Event) 
	UnitRemoveEvents()
end

function GravelsnoutVermin_OnKilledTarget(Unit, Event) 
end

RegisterUnitEvent(4112, 1, "GravelsnoutVermin_OnCombat")
RegisterUnitEvent(4112, 2, "GravelsnoutVermin_OnLeaveCombat")
RegisterUnitEvent(4112, 3, "GravelsnoutVermin_OnKilledTarget")
RegisterUnitEvent(4112, 4, "GravelsnoutVermin_OnDied")