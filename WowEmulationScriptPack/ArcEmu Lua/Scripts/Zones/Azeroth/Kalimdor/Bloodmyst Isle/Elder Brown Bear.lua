--[[

	This is created by zdroid9770  :D

	© Copyright 2012

]]

function ElderBrownBear_OnCombat(Unit, Event)
	Unit:RegisterEvent("ElderBrownBear_Swipe", 8000, 0)
end

function ElderBrownBear_Swipe(pUnit, Event) 
	pUnit:FullCastSpellOnTarget(31279, 	pUnit:GetMainTank()) 
end

function ElderBrownBear_OnLeaveCombat(Unit, Event) 
	Unit:RemoveEvents() 
end

function ElderBrownBear_OnDied(Unit, Event) 
	Unit:RemoveEvents()
end

RegisterUnitEvent(17348, 1, "ElderBrownBear_OnCombat")
RegisterUnitEvent(17348, 2, "ElderBrownBear_OnLeaveCombat")
RegisterUnitEvent(17348, 4, "ElderBrownBear_OnDied")