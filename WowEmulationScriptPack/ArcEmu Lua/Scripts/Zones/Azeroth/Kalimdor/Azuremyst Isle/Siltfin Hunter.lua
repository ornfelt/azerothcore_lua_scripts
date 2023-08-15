--[[

	This is created by zdroid9770  :D

	© Copyright 2012

]]


function SiltfinHunter_OnCombat(Unit, Event)
	Unit:RegisterEvent("SiltfinHunter_Throw", 4000, 0)
end

function SiltfinHunter_Throw(pUnit, Event) 
	pUnit:FullCastSpellOnTarget(10277, 	pUnit:GetMainTank()) 
end

function SiltfinHunter_OnLeaveCombat(Unit, Event) 
	Unit:RemoveEvents() 
end

function SiltfinHunter_OnDied(Unit, Event) 
	Unit:RemoveEvents()
end

RegisterUnitEvent(17192, 1, "SiltfinHunter_OnCombat")
RegisterUnitEvent(17192, 2, "SiltfinHunter_OnLeaveCombat")
RegisterUnitEvent(17192, 4, "SiltfinHunter_OnDied")