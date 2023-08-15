--[[

	This is created by zdroid9770  :D

	© Copyright 2012

]]

function DeepmossCreeper_OnCombat(Unit, Event)
	UnitRegisterEvent("DeepmossCreeper_Poison", 10000, 0)
end

function DeepmossCreeper_Poison(Unit, Event) 
	UnitFullCastSpellOnTarget(744, 	UnitGetMainTank()) 
end

function DeepmossCreeper_OnLeaveCombat(Unit, Event) 
	UnitRemoveEvents() 
end

function DeepmossCreeper_OnDied(Unit, Event) 
	UnitRemoveEvents()
end

function DeepmossCreeper_OnKilledTarget(Unit, Event) 
end

RegisterUnitEvent(4005, 1, "DeepmossCreeper_OnCombat")
RegisterUnitEvent(4005, 2, "DeepmossCreeper_OnLeaveCombat")
RegisterUnitEvent(4005, 3, "DeepmossCreeper_OnKilledTarget")
RegisterUnitEvent(4005, 4, "DeepmossCreeper_OnDied")