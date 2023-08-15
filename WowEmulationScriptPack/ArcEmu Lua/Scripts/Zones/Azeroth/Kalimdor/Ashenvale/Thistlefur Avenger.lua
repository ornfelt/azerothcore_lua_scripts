--[[

	This is created by zdroid9770  :D

	© Copyright 2012

]]


function ThistlefurAvenger_OnCombat(Unit, Event)
	Unit:RegisterEvent("ThistlefurAvenger_Vengeance", 13000, 0)
end

function ThistlefurAvenger_Vengeance(pUnit, Event) 
	pUnit:CastSpell(8602) 
end

function ThistlefurAvenger_OnLeaveCombat(Unit, Event) 
	Unit:RemoveEvents() 
end

function ThistlefurAvenger_OnDied(Unit, Event) 
	Unit:RemoveEvents()
end

RegisterUnitEvent(3925, 1, "ThistlefurAvenger_OnCombat")
RegisterUnitEvent(3925, 2, "ThistlefurAvenger_OnLeaveCombat")
RegisterUnitEvent(3925, 4, "ThistlefurAvenger_OnDied")