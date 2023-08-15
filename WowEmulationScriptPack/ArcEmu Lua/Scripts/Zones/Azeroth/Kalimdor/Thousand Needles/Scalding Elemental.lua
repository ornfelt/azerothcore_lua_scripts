--[[

	This is created by zdroid9770  :D

	© Copyright 2012

]]

function ScaldingElemental_OnCombat(Unit, Event)
	UnitRegisterEvent("ScaldingElemental_Scald", 10000, 0)
end

function ScaldingElemental_Scald(Unit, Event) 
	UnitFullCastSpellOnTarget(17276, 	UnitGetMainTank()) 
end

function ScaldingElemental_OnLeaveCombat(Unit, Event) 
	UnitRemoveEvents() 
end

function ScaldingElemental_OnDied(Unit, Event) 
	UnitRemoveEvents()
end

function ScaldingElemental_OnKilledTarget(Unit, Event) 
end

RegisterUnitEvent(10756, 1, "ScaldingElemental_OnCombat")
RegisterUnitEvent(10756, 2, "ScaldingElemental_OnLeaveCombat")
RegisterUnitEvent(10756, 3, "ScaldingElemental_OnKilledTarget")
RegisterUnitEvent(10756, 4, "ScaldingElemental_OnDied")