--[[

	This is created by zdroid9770  :D

	© Copyright 2012

]]

function BristlebackGeomancer_OnCombat(Unit, Event)
	Unit:RegisterEvent("BristlebackGeomancer_QuickFlameWard", 11000, 0)
	Unit:RegisterEvent("BristlebackGeomancer_Flamestrike", 10000, 0)
	Unit:RegisterEvent("BristlebackGeomancer_Fireball", 8000, 0)
end

function BristlebackGeomancer_QuickFlameWard(Unit, Event) 
	Unit:CastSpell(4979) 
end

function BristlebackGeomancer_Flamestrike(Unit, Event) 
	Unit:CastSpell(20794) 
end

function BristlebackGeomancer_Fireball(Unit, Event) 
	Unit:FullCastSpellOnTarget(20793, 	Unit:GetMainTank()) 
end

function BristlebackGeomancer_OnLeaveCombat(Unit, Event) 
	Unit:RemoveEvents() 
end

function BristlebackGeomancer_OnDied(Unit, Event) 
	Unit:RemoveEvents()
end

function BristlebackGeomancer_OnKilledTarget(Unit, Event) 
end

RegisterUnitEvent(3263, 1, "BristlebackGeomancer_OnCombat")
RegisterUnitEvent(3263, 2, "BristlebackGeomancer_OnLeaveCombat")
RegisterUnitEvent(3263, 3, "BristlebackGeomancer_OnKilledTarget")
RegisterUnitEvent(3263, 4, "BristlebackGeomancer_OnDied")