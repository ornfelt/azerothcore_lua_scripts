--[[

	This is created by zdroid9770  :D

	© Copyright 2012

]]

function CharredAncient_OnCombat(Unit, Event)
	UnitRegisterEvent("CharredAncient_EntanglingRoots", 10000, 0)
end

function CharredAncient_EntanglingRoots(Unit, Event) 
	UnitFullCastSpellOnTarget(12747, 	UnitGetMainTank()) 
end

function CharredAncient_OnLeaveCombat(Unit, Event) 
	UnitRemoveEvents() 
end

function CharredAncient_OnDied(Unit, Event) 
	UnitRemoveEvents()
end

function CharredAncient_OnKilledTarget(Unit, Event) 
end

RegisterUnitEvent(4028, 1, "CharredAncient_OnCombat")
RegisterUnitEvent(4028, 2, "CharredAncient_OnLeaveCombat")
RegisterUnitEvent(4028, 3, "CharredAncient_OnKilledTarget")
RegisterUnitEvent(4028, 4, "CharredAncient_OnDied")