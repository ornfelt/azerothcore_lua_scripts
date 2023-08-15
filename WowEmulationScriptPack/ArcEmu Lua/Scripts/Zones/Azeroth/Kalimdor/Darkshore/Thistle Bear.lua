--[[

	This is created by zdroid9770  :D

	© Copyright 2012

]]


function ThistleBear_OnCombat(Unit, Event)
	Unit:RegisterEvent("ThistleBear_Claw", 5000, 0)
	Unit:RegisterEvent("ThistleBear_Ravage", 10000, 0)
	Unit:RegisterEvent("ThistleBear_Swipe", 8000, 0)
end

function ThistleBear_Claw(pUnit, Event) 
	pUnit:FullCastSpellOnTarget(16828, 	pUnit:GetMainTank()) 
end

function ThistleBear_Ravage(pUnit, Event) 
	pUnit:FullCastSpellOnTarget(3242, 	pUnit:GetMainTank()) 
end

function ThistleBear_Swipe(pUnit, Event) 
	pUnit:FullCastSpellOnTarget(50256, 	pUnit:GetMainTank()) 
end

function ThistleBear_OnLeaveCombat(Unit, Event) 
	Unit:RemoveEvents() 
end

function ThistleBear_OnDied(Unit, Event) 
	Unit:RemoveEvents()
end

RegisterUnitEvent(2163, 1, "ThistleBear_OnCombat")
RegisterUnitEvent(2163, 2, "ThistleBear_OnLeaveCombat")
RegisterUnitEvent(2163, 4, "ThistleBear_OnDied")