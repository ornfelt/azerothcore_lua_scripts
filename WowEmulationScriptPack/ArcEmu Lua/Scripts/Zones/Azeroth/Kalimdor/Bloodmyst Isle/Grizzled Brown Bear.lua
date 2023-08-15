--[[

	This is created by zdroid9770  :D

	© Copyright 2012

]]

function GrizzledBrownBear_OnCombat(Unit, Event)
	Unit:RegisterEvent("GrizzledBrownBear_Swipe", 8000, 0)
end

function GrizzledBrownBear_Swipe(pUnit, Event) 
	pUnit:FullCastSpellOnTarget(31279, 	pUnit:GetMainTank()) 
end

function GrizzledBrownBear_OnLeaveCombat(Unit, Event) 
	Unit:RemoveEvents() 
end

function GrizzledBrownBear_OnDied(Unit, Event) 
	Unit:RemoveEvents()
end

RegisterUnitEvent(17347, 1, "GrizzledBrownBear_OnCombat")
RegisterUnitEvent(17347, 2, "GrizzledBrownBear_OnLeaveCombat")
RegisterUnitEvent(17347, 4, "GrizzledBrownBear_OnDied")