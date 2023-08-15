--[[

	This is created by zdroid9770  :D

	© Copyright 2012

]]

function RazormaneScout_OnCombat(Unit, Event)
	Unit:RegisterEvent("RazormaneScout_Shoot", 6000, 0)
end

function RazormaneScout_Shoot(Unit, Event) 
	Unit:FullCastSpellOnTarget(6660, 	Unit:GetMainTank()) 
end

function RazormaneScout_OnLeaveCombat(Unit, Event) 
	Unit:RemoveEvents() 
end

function RazormaneScout_OnDied(Unit, Event) 
	Unit:RemoveEvents()
end

function RazormaneScout_OnKilledTarget(Unit, Event) 
end

RegisterUnitEvent(3112, 1, "RazormaneScout_OnCombat")
RegisterUnitEvent(3112, 2, "RazormaneScout_OnLeaveCombat")
RegisterUnitEvent(3112, 3, "RazormaneScout_OnKilledTarget")
RegisterUnitEvent(3112, 4, "RazormaneScout_OnDied")