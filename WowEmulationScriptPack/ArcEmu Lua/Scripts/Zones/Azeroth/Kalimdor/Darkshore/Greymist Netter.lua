--[[

	This is created by zdroid9770  :D

	© Copyright 2012

]]


function GreymistNetter_OnCombat(Unit, Event)
	Unit:RegisterEvent("GreymistNetter_Net", 10000, 0)
end

function GreymistNetter_Net(pUnit, Event) 
	pUnit:FullCastSpellOnTarget(12024, 	pUnit:GetMainTank()) 
end

function GreymistNetter_OnLeaveCombat(Unit, Event) 
	Unit:RemoveEvents() 
end

function GreymistNetter_OnDied(Unit, Event) 
	Unit:RemoveEvents()
end

RegisterUnitEvent(2204, 1, "GreymistNetter_OnCombat")
RegisterUnitEvent(2204, 2, "GreymistNetter_OnLeaveCombat")
RegisterUnitEvent(2204, 4, "GreymistNetter_OnDied")