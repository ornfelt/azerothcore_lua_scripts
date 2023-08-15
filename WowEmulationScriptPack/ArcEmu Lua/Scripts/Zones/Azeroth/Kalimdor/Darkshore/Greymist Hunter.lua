--[[

	This is created by zdroid9770  :D

	© Copyright 2012

]]


function GreymistHunter_OnCombat(Unit, Event)
	Unit:RegisterEvent("GreymistHunter_Throw", 6000, 0)
end

function GreymistHunter_Throw(pUnit, Event) 
	pUnit:FullCastSpellOnTarget(10277, 	pUnit:GetMainTank()) 
end

function GreymistHunter_OnLeaveCombat(Unit, Event) 
	Unit:RemoveEvents() 
end

function GreymistHunter_OnDied(Unit, Event) 
	Unit:RemoveEvents()
end

RegisterUnitEvent(2206, 1, "GreymistHunter_OnCombat")
RegisterUnitEvent(2206, 2, "GreymistHunter_OnLeaveCombat")
RegisterUnitEvent(2206, 4, "GreymistHunter_OnDied")