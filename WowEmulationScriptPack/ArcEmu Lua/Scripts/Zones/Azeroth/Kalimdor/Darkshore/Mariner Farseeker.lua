--[[

	This is created by zdroid9770  :D

	© Copyright 2012

]]


function MarinerFarseeker_OnCombat(Unit, Event)
	Unit:RegisterEvent("MarinerFarseeker_Net", 10000, 0)
end

function MarinerFarseeker_Net(pUnit, Event) 
	pUnit:FullCastSpellOnTarget(12024, 	pUnit:GetMainTank()) 
end

function MarinerFarseeker_OnLeaveCombat(Unit, Event) 
	Unit:RemoveEvents() 
end

function MarinerFarseeker_OnDied(Unit, Event) 
	Unit:RemoveEvents()
end

RegisterUnitEvent(25053, 1, "MarinerFarseeker_OnCombat")
RegisterUnitEvent(25053, 2, "MarinerFarseeker_OnLeaveCombat")
RegisterUnitEvent(25053, 4, "MarinerFarseeker_OnDied")