--[[

	This is created by zdroid9770  :D

	© Copyright 2012

]]


function ForsakenDarkStalker_OnCombat(Unit, Event)
	Unit:RegisterEvent("ForsakenDarkStalker_Throw", 6000, 0)
end

function ForsakenDarkStalker_Throw(pUnit, Event) 
	pUnit:FullCastSpellOnTarget(10277, 	pUnit:GetMainTank()) 
end

function ForsakenDarkStalker_OnLeaveCombat(Unit, Event) 
	Unit:RemoveEvents() 
end

function ForsakenDarkStalker_OnDied(Unit, Event) 
	Unit:RemoveEvents()
end

RegisterUnitEvent(3808, 1, "ForsakenDarkStalker_OnCombat")
RegisterUnitEvent(3808, 2, "ForsakenDarkStalker_OnLeaveCombat")
RegisterUnitEvent(3808, 4, "ForsakenDarkStalker_OnDied")