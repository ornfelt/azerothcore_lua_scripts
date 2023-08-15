--[[

	This is created by zdroid9770  :D

	© Copyright 2012

]]

function RazormanePathfinder_OnCombat(Unit, Event)
	Unit:RegisterEvent("RazormanePathfinder_Shoot", 6000, 0)
	Unit:RegisterEvent("RazormanePathfinder_Thrash", 4000, 1)
end

function RazormanePathfinder_Shoot(Unit, Event) 
	Unit:FullCastSpellOnTarget(6660, 	Unit:GetMainTank()) 
end

function RazormanePathfinder_Thrash(Unit, Event) 
	Unit:FullCastSpellOnTarget(3391, 	Unit:GetMainTank()) 
end

function RazormanePathfinder_OnLeaveCombat(Unit, Event) 
	Unit:RemoveEvents() 
end

function RazormanePathfinder_OnDied(Unit, Event) 
	Unit:RemoveEvents()
end

function RazormanePathfinder_OnKilledTarget(Unit, Event) 
end

RegisterUnitEvent(3456, 1, "RazormanePathfinder_OnCombat")
RegisterUnitEvent(3456, 2, "RazormanePathfinder_OnLeaveCombat")
RegisterUnitEvent(3456, 3, "RazormanePathfinder_OnKilledTarget")
RegisterUnitEvent(3456, 4, "RazormanePathfinder_OnDied")