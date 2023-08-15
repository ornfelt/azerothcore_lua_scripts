--[[

	This is created by zdroid9770  :D

	© Copyright 2012

]]


function MarinerStillglider_OnCombat(Unit, Event)
	Unit:RegisterEvent("MarinerStillglider_Net", 10000, 0)
end

function MarinerStillglider_Net(pUnit, Event) 
	pUnit:FullCastSpellOnTarget(12024, 	pUnit:GetMainTank()) 
end

function MarinerStillglider_OnLeaveCombat(Unit, Event) 
	Unit:RemoveEvents() 
end

function MarinerStillglider_OnDied(Unit, Event) 
	Unit:RemoveEvents()
end

RegisterUnitEvent(25056, 1, "MarinerStillglider_OnCombat")
RegisterUnitEvent(25056, 2, "MarinerStillglider_OnLeaveCombat")
RegisterUnitEvent(25056, 4, "MarinerStillglider_OnDied")