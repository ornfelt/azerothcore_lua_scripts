--[[

	This is created by zdroid9770  :D

	© Copyright 2012

]]


function MarinerEvenmist_OnCombat(Unit, Event)
	Unit:RegisterEvent("MarinerEvenmist_Net", 10000, 0)
end

function MarinerEvenmist_Net(pUnit, Event) 
	pUnit:FullCastSpellOnTarget(12024, 	pUnit:GetMainTank()) 
end

function MarinerEvenmist_OnLeaveCombat(Unit, Event) 
	Unit:RemoveEvents() 
end

function MarinerEvenmist_OnDied(Unit, Event) 
	Unit:RemoveEvents()
end

RegisterUnitEvent(25007, 1, "MarinerEvenmist_OnCombat")
RegisterUnitEvent(25007, 2, "MarinerEvenmist_OnLeaveCombat")
RegisterUnitEvent(25007, 4, "MarinerEvenmist_OnDied")