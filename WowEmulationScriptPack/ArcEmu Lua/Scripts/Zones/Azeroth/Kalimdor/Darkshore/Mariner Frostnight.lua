--[[

	This is created by zdroid9770  :D

	© Copyright 2012

]]


function MarinerFrostnight_OnCombat(Unit, Event)
	Unit:RegisterEvent("MarinerFrostnight_Net", 10000, 0)
end

function MarinerFrostnight_Net(pUnit, Event) 
	pUnit:FullCastSpellOnTarget(12024, 	pUnit:GetMainTank()) 
end

function MarinerFrostnight_OnLeaveCombat(Unit, Event) 
	Unit:RemoveEvents() 
end

function MarinerFrostnight_OnDied(Unit, Event) 
	Unit:RemoveEvents()
end

RegisterUnitEvent(25055, 1, "MarinerFrostnight_OnCombat")
RegisterUnitEvent(25055, 2, "MarinerFrostnight_OnLeaveCombat")
RegisterUnitEvent(25055, 4, "MarinerFrostnight_OnDied")