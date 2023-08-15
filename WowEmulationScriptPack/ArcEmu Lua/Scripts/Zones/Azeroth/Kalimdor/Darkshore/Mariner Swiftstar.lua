--[[

	This is created by zdroid9770  :D

	© Copyright 2012

]]


function MarinerSwiftstar_OnCombat(Unit, Event)
	Unit:RegisterEvent("MarinerSwiftstar_Net", 10000, 0)
end

function MarinerSwiftstar_Net(pUnit, Event) 
	pUnit:FullCastSpellOnTarget(12024, 	pUnit:GetMainTank()) 
end

function MarinerSwiftstar_OnLeaveCombat(Unit, Event) 
	Unit:RemoveEvents() 
end

function MarinerSwiftstar_OnDied(Unit, Event) 
	Unit:RemoveEvents()
end

RegisterUnitEvent(24997, 1, "MarinerSwiftstar_OnCombat")
RegisterUnitEvent(24997, 2, "MarinerSwiftstar_OnLeaveCombat")
RegisterUnitEvent(24997, 4, "MarinerSwiftstar_OnDied")