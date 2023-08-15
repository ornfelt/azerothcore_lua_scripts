--[[

	This is created by zdroid9770  :D

	© Copyright 2012

]]

function SparkleshellBorer_OnCombat(Unit, Event)
	UnitRegisterEvent("SparkleshellBorer_PierceArmor", 10000, 0)
end

function SparkleshellBorer_PierceArmor(Unit, Event) 
	UnitFullCastSpellOnTarget(6016, 	UnitGetMainTank()) 
end

function SparkleshellBorer_OnLeaveCombat(Unit, Event) 
	UnitRemoveEvents() 
end

function SparkleshellBorer_OnDied(Unit, Event) 
	UnitRemoveEvents()
end

function SparkleshellBorer_OnKilledTarget(Unit, Event) 
end

RegisterUnitEvent(4144, 1, "SparkleshellBorer_OnCombat")
RegisterUnitEvent(4144, 2, "SparkleshellBorer_OnLeaveCombat")
RegisterUnitEvent(4144, 3, "SparkleshellBorer_OnKilledTarget")
RegisterUnitEvent(4144, 4, "SparkleshellBorer_OnDied")