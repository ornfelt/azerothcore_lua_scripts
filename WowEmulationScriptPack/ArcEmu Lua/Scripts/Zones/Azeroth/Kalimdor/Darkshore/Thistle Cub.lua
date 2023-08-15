--[[

	This is created by zdroid9770  :D

	© Copyright 2012

]]


function ThistleCub_OnCombat(Unit, Event)
	Unit:RegisterEvent("ThistleCub_Ravage", 9000, 0)
end

function ThistleCub_Ravage(pUnit, Event) 
	pUnit:FullCastSpellOnTarget(3242, 	pUnit:GetMainTank()) 
end

function ThistleCub_OnLeaveCombat(Unit, Event) 
	Unit:RemoveEvents() 
end

function ThistleCub_OnDied(Unit, Event) 
	Unit:RemoveEvents()
end

RegisterUnitEvent(6789, 1, "ThistleCub_OnCombat")
RegisterUnitEvent(6789, 2, "ThistleCub_OnLeaveCombat")
RegisterUnitEvent(6789, 4, "ThistleCub_OnDied")