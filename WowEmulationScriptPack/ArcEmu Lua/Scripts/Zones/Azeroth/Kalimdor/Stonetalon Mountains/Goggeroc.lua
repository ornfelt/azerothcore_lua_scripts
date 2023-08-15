--[[

	This is created by zdroid9770  :D

	© Copyright 2012

]]

function Goggeroc_OnCombat(Unit, Event)
	UnitRegisterEvent("Goggeroc_SnapKick", 6000, 0)
	UnitRegisterEvent("Goggeroc_Uppercut", 1000, 0)
end

function Goggeroc_SnapKick(Unit, Event) 
	UnitFullCastSpellOnTarget(8646, 	UnitGetMainTank()) 
end

function Goggeroc_Uppercut(Unit, Event) 
	UnitFullCastSpellOnTarget(10966, 	UnitGetMainTank()) 
end

function Goggeroc_OnLeaveCombat(Unit, Event) 
	UnitRemoveEvents() 
end

function Goggeroc_OnDied(Unit, Event) 
	UnitRemoveEvents()
end

function Goggeroc_OnKilledTarget(Unit, Event) 
end

RegisterUnitEvent(11920, 1, "Goggeroc_OnCombat")
RegisterUnitEvent(11920, 2, "Goggeroc_OnLeaveCombat")
RegisterUnitEvent(11920, 3, "Goggeroc_OnKilledTarget")
RegisterUnitEvent(11920, 4, "Goggeroc_OnDied")