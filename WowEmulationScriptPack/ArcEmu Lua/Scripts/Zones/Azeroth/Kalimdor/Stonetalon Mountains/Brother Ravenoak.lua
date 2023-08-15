--[[

	This is created by zdroid9770  :D

	© Copyright 2012

]]

function BrotherRavenoak_OnCombat(Unit, Event)
	UnitRegisterEvent("BrotherRavenoak_LowSwipe", 10000, 0)
	UnitRegisterEvent("BrotherRavenoak_Maul", 6000, 0)
end

function BrotherRavenoak_LowSwipe(Unit, Event) 
	UnitFullCastSpellOnTarget(8716, 	UnitGetMainTank()) 
end

function BrotherRavenoak_Maul(Unit, Event) 
	UnitFullCastSpellOnTarget(12161, 	UnitGetMainTank()) 
end

function BrotherRavenoak_OnLeaveCombat(Unit, Event) 
	UnitRemoveEvents() 
end

function BrotherRavenoak_OnDied(Unit, Event) 
	UnitRemoveEvents()
end

function BrotherRavenoak_OnKilledTarget(Unit, Event) 
end

RegisterUnitEvent(5915, 1, "BrotherRavenoak_OnCombat")
RegisterUnitEvent(5915, 2, "BrotherRavenoak_OnLeaveCombat")
RegisterUnitEvent(5915, 3, "BrotherRavenoak_OnKilledTarget")
RegisterUnitEvent(5915, 4, "BrotherRavenoak_OnDied")