--[[

	This is created by zdroid9770  :D

	© Copyright 2012

]]


function ThistlefurDenWatcher_OnCombat(Unit, Event)
	Unit:RegisterEvent("ThistlefurDenWatcher_FrenziedRage", 8000, 0)
end

function ThistlefurDenWatcher_FrenziedRage(pUnit, Event) 
	pUnit:CastSpell(3940) 
end

function ThistlefurDenWatcher_OnLeaveCombat(Unit, Event) 
	Unit:RemoveEvents() 
end

function ThistlefurDenWatcher_OnDied(Unit, Event) 
	Unit:RemoveEvents()
end

RegisterUnitEvent(3923, 1, "ThistlefurDenWatcher_OnCombat")
RegisterUnitEvent(3923, 2, "ThistlefurDenWatcher_OnLeaveCombat")
RegisterUnitEvent(3923, 4, "ThistlefurDenWatcher_OnDied")