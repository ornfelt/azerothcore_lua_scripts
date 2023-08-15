--[[

	This is created by zdroid9770  :D

	© Copyright 2012

]]

function WindshearGeomancer_OnCombat(Unit, Event)
	UnitRegisterEvent("WindshearGeomancer_Frostbolt", 8000, 0)
end

function WindshearGeomancer_Frostbolt(Unit, Event) 
	UnitFullCastSpellOnTarget(20792, 	UnitGetMainTank()) 
end

function WindshearGeomancer_OnLeaveCombat(Unit, Event) 
	UnitRemoveEvents() 
end

function WindshearGeomancer_OnDied(Unit, Event) 
	UnitRemoveEvents()
end

function WindshearGeomancer_OnKilledTarget(Unit, Event) 
end

RegisterUnitEvent(4003, 1, "WindshearGeomancer_OnCombat")
RegisterUnitEvent(4003, 2, "WindshearGeomancer_OnLeaveCombat")
RegisterUnitEvent(4003, 3, "WindshearGeomancer_OnKilledTarget")
RegisterUnitEvent(4003, 4, "WindshearGeomancer_OnDied")