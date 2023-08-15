--[[

	This is created by zdroid9770  :D

	© Copyright 2012

]]


function ThistlefurPathfinder_OnCombat(Unit, Event)
	Unit:RegisterEvent("ThistlefurPathfinder_Shoot", 6000, 0)
end

function ThistlefurPathfinder_Shoot(pUnit, Event) 
	pUnit:FullCastSpellOnTarget(6660, 	pUnit:GetMainTank()) 
end

function ThistlefurPathfinder_OnLeaveCombat(Unit, Event) 
	Unit:RemoveEvents() 
end

function ThistlefurPathfinder_OnDied(Unit, Event) 
	Unit:RemoveEvents()
end

RegisterUnitEvent(3926, 1, "ThistlefurPathfinder_OnCombat")
RegisterUnitEvent(3926, 2, "ThistlefurPathfinder_OnLeaveCombat")
RegisterUnitEvent(3926, 4, "ThistlefurPathfinder_OnDied")