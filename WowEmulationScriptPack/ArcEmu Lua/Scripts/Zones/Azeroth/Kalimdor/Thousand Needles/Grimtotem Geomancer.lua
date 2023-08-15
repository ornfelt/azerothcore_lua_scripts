--[[

	This is created by zdroid9770  :D

	© Copyright 2012

]]

function GrimtotemGeomancer_OnCombat(Unit, Event)
	UnitRegisterEvent("GrimtotemGeomancer_Slow", 15000, 0)
	UnitRegisterEvent("GrimtotemGeomancer_Flamestrike", 10000, 0)
	UnitRegisterEvent("GrimtotemGeomancer_Fireball", 5000, 0)
end

function GrimtotemGeomancer_Slow(Unit, Event) 
	UnitFullCastSpellOnTarget(11436, 	UnitGetMainTank()) 
end

function GrimtotemGeomancer_Flamestrike(Unit, Event) 
	UnitCastSpell(20813) 
end

function GrimtotemGeomancer_Fireball(Unit, Event) 
	UnitFullCastSpellOnTarget(20811, 	UnitGetMainTank()) 
end

function GrimtotemGeomancer_OnLeaveCombat(Unit, Event) 
	UnitRemoveEvents() 
end

function GrimtotemGeomancer_OnDied(Unit, Event) 
	UnitRemoveEvents()
end

function GrimtotemGeomancer_OnKilledTarget(Unit, Event) 
end

RegisterUnitEvent(10760, 1, "GrimtotemGeomancer_OnCombat")
RegisterUnitEvent(10760, 2, "GrimtotemGeomancer_OnLeaveCombat")
RegisterUnitEvent(10760, 3, "GrimtotemGeomancer_OnKilledTarget")
RegisterUnitEvent(10760, 4, "GrimtotemGeomancer_OnDied")