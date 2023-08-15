--[[

	This is created by zdroid9770  :D

	© Copyright 2012

]]


function MaroshtheDevious_OnCombat(Unit, Event)
	Unit:RegisterEvent("MaroshtheDevious_FaerieFire", 4000, 1)
	Unit:RegisterEvent("MaroshtheDevious_Thrash", 6000, 0)
end

function MaroshtheDevious_FaerieFire(pUnit, Event) 
	pUnit:FullCastSpellOnTarget(6950, 	pUnit:GetMainTank()) 
end

function MaroshtheDevious_Thrash(pUnit, Event) 
	pUnit:FullCastSpellOnTarget(3391, 	pUnit:GetMainTank()) 
end

function MaroshtheDevious_OnLeaveCombat(Unit, Event) 
	Unit:RemoveEvents() 
end

function MaroshtheDevious_OnDied(Unit, Event) 
	Unit:RemoveEvents()
end

RegisterUnitEvent(11714, 1, "MaroshtheDevious_OnCombat")
RegisterUnitEvent(11714, 2, "MaroshtheDevious_OnLeaveCombat")
RegisterUnitEvent(11714, 4, "MaroshtheDevious_OnDied")