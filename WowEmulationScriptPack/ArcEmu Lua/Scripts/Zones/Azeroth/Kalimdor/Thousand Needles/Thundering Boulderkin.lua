--[[

	This is created by zdroid9770  :D

	© Copyright 2012

]]

function ThunderingBoulderkin_OnCombat(Unit, Event)
	UnitRegisterEvent("ThunderingBoulderkin_GroundTremor", 10000, 0)
end

function ThunderingBoulderkin_GroundTremor(Unit, Event) 
	UnitCastSpell(6524) 
end

function ThunderingBoulderkin_OnLeaveCombat(Unit, Event) 
	UnitRemoveEvents() 
end

function ThunderingBoulderkin_OnDied(Unit, Event) 
	UnitRemoveEvents()
end

function ThunderingBoulderkin_OnKilledTarget(Unit, Event) 
end

RegisterUnitEvent(4120, 1, "ThunderingBoulderkin_OnCombat")
RegisterUnitEvent(4120, 2, "ThunderingBoulderkin_OnLeaveCombat")
RegisterUnitEvent(4120, 3, "ThunderingBoulderkin_OnKilledTarget")
RegisterUnitEvent(4120, 4, "ThunderingBoulderkin_OnDied")