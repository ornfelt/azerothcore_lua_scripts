--[[

	This is created by zdroid9770  :D

	© Copyright 2012

]]

function BlackwoodPathfinder_OnCombat(Unit, Event)
	Unit:RegisterEvent("BlackwoodPathfinder_FaerieFire", 4000, 1)
	Unit:RegisterEvent("BlackwoodPathfinder_Thrash", 6000, 0)
end

function BlackwoodPathfinder_FaerieFire(pUnit, Event) 
	pUnit:FullCastSpellOnTarget(6950, 	pUnit:GetMainTank()) 
end

function BlackwoodPathfinder_Thrash(pUnit, Event) 
	pUnit:FullCastSpellOnTarget(3391, 	pUnit:GetMainTank()) 
end

function BlackwoodPathfinder_OnLeaveCombat(Unit, Event) 
	Unit:RemoveEvents() 
end

function BlackwoodPathfinder_OnDied(Unit, Event) 
	Unit:RemoveEvents()
end

RegisterUnitEvent(2167, 1, "BlackwoodPathfinder_OnCombat")
RegisterUnitEvent(2167, 2, "BlackwoodPathfinder_OnLeaveCombat")
RegisterUnitEvent(2167, 4, "BlackwoodPathfinder_OnDied")