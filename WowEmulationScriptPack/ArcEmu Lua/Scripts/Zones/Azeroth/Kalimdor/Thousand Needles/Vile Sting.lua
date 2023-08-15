--[[

	This is created by zdroid9770  :D

	© Copyright 2012

]]

function VileSting_OnCombat(Unit, Event)
	UnitRegisterEvent("VileSting_VenomSting", 10000, 0)
end

function VileSting_VenomSting(Unit, Event) 
	UnitFullCastSpellOnTarget(8257, 	UnitGetMainTank()) 
end

function VileSting_OnLeaveCombat(Unit, Event) 
	UnitRemoveEvents() 
end

function VileSting_OnDied(Unit, Event) 
	UnitRemoveEvents()
end

function VileSting_OnKilledTarget(Unit, Event) 
end

RegisterUnitEvent(5937, 1, "VileSting_OnCombat")
RegisterUnitEvent(5937, 2, "VileSting_OnLeaveCombat")
RegisterUnitEvent(5937, 3, "VileSting_OnKilledTarget")
RegisterUnitEvent(5937, 4, "VileSting_OnDied")