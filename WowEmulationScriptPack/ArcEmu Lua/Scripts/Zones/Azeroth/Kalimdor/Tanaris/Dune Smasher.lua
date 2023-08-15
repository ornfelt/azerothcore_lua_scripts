--[[

	This is created by zdroid9770  :D

	© Copyright 2012

]]

function DuneSmasher_OnCombat(Unit, Event)
	Unit:RegisterEvent("DuneSmasher_HeadCrack", 10000, 0)
end

function DuneSmasher_HeadCrack(Unit, Event) 
	Unit:FullCastSpellOnTarget(9791, 	Unit:GetMainTank()) 
end

function DuneSmasher_OnLeaveCombat(Unit, Event) 
	Unit:RemoveEvents() 
end

function DuneSmasher_OnDied(Unit, Event) 
	Unit:RemoveEvents()
end

function DuneSmasher_OnKilledTarget(Unit, Event) 
end

RegisterUnitEvent(5469, 1, "DuneSmasher_OnCombat")
RegisterUnitEvent(5469, 2, "DuneSmasher_OnLeaveCombat")
RegisterUnitEvent(5469, 3, "DuneSmasher_OnKilledTarget")
RegisterUnitEvent(5469, 4, "DuneSmasher_OnDied")