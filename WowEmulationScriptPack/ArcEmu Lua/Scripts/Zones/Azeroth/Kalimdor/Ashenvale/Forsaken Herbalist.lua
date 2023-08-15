--[[

	This is created by zdroid9770  :D

	© Copyright 2012

]]


function ForsakenHerbalist_OnCombat(Unit, Event)
	Unit:RegisterEvent("ForsakenHerbalist_ContagionofRot", 2000, 2)
end

function ForsakenHerbalist_ContagionofRot(pUnit, Event) 
	pUnit:FullCastSpellOnTarget(7102, 	pUnit:GetMainTank()) 
end

function ForsakenHerbalist_OnLeaveCombat(Unit, Event) 
	Unit:RemoveEvents() 
end

function ForsakenHerbalist_OnDied(Unit, Event) 
	Unit:RemoveEvents()
end

RegisterUnitEvent(3733, 1, "ForsakenHerbalist_OnCombat")
RegisterUnitEvent(3733, 2, "ForsakenHerbalist_OnLeaveCombat")
RegisterUnitEvent(3733, 4, "ForsakenHerbalist_OnDied")