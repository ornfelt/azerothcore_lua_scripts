--[[

	This is created by zdroid9770  :D

	© Copyright 2012

]]

function RazormaneGeomancer_OnCombat(Unit, Event)
	Unit:RegisterEvent("RazormaneGeomancer_Fireball", 8000, 0)
	Unit:RegisterEvent("RazormaneGeomancer_FrostArmor", 1000, 1)
end

function RazormaneGeomancer_FrostArmor(Unit, Event) 
	Unit:CastSpell(12544) 
end

function RazormaneGeomancer_Fireball(Unit, Event) 
	Unit:FullCastSpellOnTarget(20793, 	Unit:GetMainTank()) 
end

function RazormaneGeomancer_OnLeaveCombat(Unit, Event) 
	Unit:RemoveEvents() 
end

function RazormaneGeomancer_OnDied(Unit, Event) 
	Unit:RemoveEvents()
end

function RazormaneGeomancer_OnKilledTarget(Unit, Event) 
end

RegisterUnitEvent(3269, 1, "RazormaneGeomancer_OnCombat")
RegisterUnitEvent(3269, 2, "RazormaneGeomancer_OnLeaveCombat")
RegisterUnitEvent(3269, 3, "RazormaneGeomancer_OnKilledTarget")
RegisterUnitEvent(3269, 4, "RazormaneGeomancer_OnDied")