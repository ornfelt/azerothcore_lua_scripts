--[[

	This is created by zdroid9770  :D

	© Copyright 2012

]]


function WildGrell_OnCombat(Unit, Event)
	Unit:RegisterEvent("WildGrell_Crazed", 10000, 1)
end

function WildGrell_Crazed(pUnit, Event) 
	pUnit:FullCastSpellOnTarget(5915, 	pUnit:GetMainTank()) 
end

function WildGrell_OnLeaveCombat(Unit, Event) 
	Unit:RemoveEvents() 
end

function WildGrell_OnDied(Unit, Event) 
	Unit:RemoveEvents()
end

RegisterUnitEvent(2190, 1, "WildGrell_OnCombat")
RegisterUnitEvent(2190, 2, "WildGrell_OnLeaveCombat")
RegisterUnitEvent(2190, 4, "WildGrell_OnDied")