--[[

	This is created by zdroid9770  :D

	© Copyright 2012

]]


function MarinerFarsight_OnCombat(Unit, Event)
	Unit:RegisterEvent("MarinerFarsight_Net", 10000, 0)
end

function MarinerFarsight_Net(pUnit, Event) 
	pUnit:FullCastSpellOnTarget(12024, 	pUnit:GetMainTank()) 
end

function MarinerFarsight_OnLeaveCombat(Unit, Event) 
	Unit:RemoveEvents() 
end

function MarinerFarsight_OnDied(Unit, Event) 
	Unit:RemoveEvents()
end

RegisterUnitEvent(24998, 1, "MarinerFarsight_OnCombat")
RegisterUnitEvent(24998, 2, "MarinerFarsight_OnLeaveCombat")
RegisterUnitEvent(24998, 4, "MarinerFarsight_OnDied")