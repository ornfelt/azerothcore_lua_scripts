--[[

	This is created by zdroid9770  :D

	© Copyright 2012

]]


function RorgishJowl_OnCombat(Unit, Event)
	Unit:RegisterEvent("RorgishJowl_Thrash", 5000, 0)
end

function RorgishJowl_Thrash(pUnit, Event) 
	pUnit:FullCastSpellOnTarget(3391, 	pUnit:GetMainTank()) 
end

function RorgishJowl_OnLeaveCombat(Unit, Event) 
	Unit:RemoveEvents() 
end

function RorgishJowl_OnDied(Unit, Event) 
	Unit:RemoveEvents()
end

RegisterUnitEvent(10639, 1, "RorgishJowl_OnCombat")
RegisterUnitEvent(10639, 2, "RorgishJowl_OnLeaveCombat")
RegisterUnitEvent(10639, 4, "RorgishJowl_OnDied")