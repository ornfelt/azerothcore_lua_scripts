--[[

	This is created by zdroid9770  :D

	© Copyright 2012

]]

function GoggerGeomancer_OnCombat(Unit, Event)
	UnitRegisterEvent("GoggerGeomancer_Fireball", 8000, 0)
	UnitRegisterEvent("GoggerGeomancer_RainofFire", 11000, 1)
end

function GoggerGeomancer_Fireball(Unit, Event) 
	UnitFullCastSpellOnTarget(20793, 	UnitGetMainTank()) 
end

function GoggerGeomancer_RainofFire(Unit, Event) 
	UnitCastSpell(11990) 
end

function GoggerGeomancer_OnLeaveCombat(Unit, Event) 
	UnitRemoveEvents() 
end

function GoggerGeomancer_OnDied(Unit, Event) 
	UnitRemoveEvents()
end

function GoggerGeomancer_OnKilledTarget(Unit, Event) 
end

RegisterUnitEvent(11917, 1, "GoggerGeomancer_OnCombat")
RegisterUnitEvent(11917, 2, "GoggerGeomancer_OnLeaveCombat")
RegisterUnitEvent(11917, 3, "GoggerGeomancer_OnKilledTarget")
RegisterUnitEvent(11917, 4, "GoggerGeomancer_OnDied")