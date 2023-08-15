--[[

	This is created by zdroid9770  :D

	© Copyright 2012

]]


function MarinerKeenstar_OnCombat(Unit, Event)
	Unit:RegisterEvent("MarinerKeenstar_Net", 10000, 0)
end

function MarinerKeenstar_Net(pUnit, Event) 
	pUnit:FullCastSpellOnTarget(12024, 	pUnit:GetMainTank()) 
end

function MarinerKeenstar_OnLeaveCombat(Unit, Event) 
	Unit:RemoveEvents() 
end

function MarinerKeenstar_OnDied(Unit, Event) 
	Unit:RemoveEvents()
end

RegisterUnitEvent(25054, 1, "MarinerKeenstar_OnCombat")
RegisterUnitEvent(25054, 2, "MarinerKeenstar_OnLeaveCombat")
RegisterUnitEvent(25054, 4, "MarinerKeenstar_OnDied")