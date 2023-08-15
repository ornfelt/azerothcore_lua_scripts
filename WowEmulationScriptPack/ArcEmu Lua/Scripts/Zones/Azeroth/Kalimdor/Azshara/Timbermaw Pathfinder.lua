--[[

	This is created by zdroid9770  :D

	© Copyright 2012

]]


function TimbermawPathfinder_OnCombat(Unit, Event)
	Unit:RegisterEvent("TimbermawPathfinder_FaerieFire", 10000, 0)
end

function TimbermawPathfinder_FaerieFire(pUnit, Event) 
	pUnit:FullCastSpellOnTarget(16498, 	pUnit:GetMainTank()) 
end

function TimbermawPathfinder_OnLeaveCombat(Unit, Event) 
	Unit:RemoveEvents() 
end

function TimbermawPathfinder_OnDied(Unit, Event) 
	Unit:RemoveEvents()
end

RegisterUnitEvent(6184, 1, "TimbermawPathfinder_OnCombat")
RegisterUnitEvent(6184, 2, "TimbermawPathfinder_OnLeaveCombat")
RegisterUnitEvent(6184, 4, "TimbermawPathfinder_OnDied")