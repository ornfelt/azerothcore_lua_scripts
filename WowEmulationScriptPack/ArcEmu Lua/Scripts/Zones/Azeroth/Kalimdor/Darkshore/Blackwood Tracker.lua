--[[

	This is created by zdroid9770  :D

	© Copyright 2012

]]

function BlackwoodTracker_OnCombat(Unit, Event)
	Unit:RegisterEvent("BlackwoodTracker_FaerieFire", 3000, 1)
	Unit:RegisterEvent("BlackwoodTracker_Thrash", 5000, 0)
end

function BlackwoodTracker_FaerieFire(pUnit, Event) 
	pUnit:FullCastSpellOnTarget(6950, 	pUnit:GetMainTank()) 
end

function BlackwoodTracker_Thrash(pUnit, Event) 
	pUnit:FullCastSpellOnTarget(3391, 	pUnit:GetMainTank()) 
end

function BlackwoodTracker_OnLeaveCombat(Unit, Event) 
	Unit:RemoveEvents() 
end

function BlackwoodTracker_OnDied(Unit, Event) 
	Unit:RemoveEvents()
end

RegisterUnitEvent(11713, 1, "BlackwoodTracker_OnCombat")
RegisterUnitEvent(11713, 2, "BlackwoodTracker_OnLeaveCombat")
RegisterUnitEvent(11713, 4, "BlackwoodTracker_OnDied")