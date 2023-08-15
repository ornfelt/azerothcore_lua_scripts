--[[

	This is created by zdroid9770  :D

	© Copyright 2012

]]

function InfectedWildkin_OnCombat(Unit, Event)
	Unit:RegisterEvent("InfectedWildkin_InfectedWound", 10000, 0)
end

function InfectedWildkin_InfectedWound(pUnit, Event) 
	pUnit:FullCastSpellOnTarget(31282, 	pUnit:GetMainTank()) 
end

function InfectedWildkin_OnLeaveCombat(Unit, Event) 
	Unit:RemoveEvents() 
end

function InfectedWildkin_OnDied(Unit, Event) 
	Unit:RemoveEvents()
end

RegisterUnitEvent(17322, 1, "InfectedWildkin_OnCombat")
RegisterUnitEvent(17322, 2, "InfectedWildkin_OnLeaveCombat")
RegisterUnitEvent(17322, 4, "InfectedWildkin_OnDied")