--[[

	This is created by zdroid9770  :D

	© Copyright 2012

]]


function ThistlefurTotemic_OnCombat(Unit, Event)
	Unit:RegisterEvent("ThistlefurTotemic_HealingWard", 12000, 0)
end

function ThistlefurTotemic_HealingWard(pUnit, Event) 
	pUnit:CastSpell(6274) 
end

function ThistlefurTotemic_OnLeaveCombat(Unit, Event) 
	Unit:RemoveEvents() 
end

function ThistlefurTotemic_OnDied(Unit, Event) 
	Unit:RemoveEvents()
end

RegisterUnitEvent(3922, 1, "ThistlefurTotemic_OnCombat")
RegisterUnitEvent(3922, 2, "ThistlefurTotemic_OnLeaveCombat")
RegisterUnitEvent(3922, 4, "ThistlefurTotemic_OnDied")