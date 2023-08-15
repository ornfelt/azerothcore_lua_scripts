--[[

	This is created by zdroid9770  :D

	© Copyright 2012

]]

function CentipaarWorker_OnCombat(Unit, Event)
	Unit:RegisterEvent("CentipaarWorker_Thrash", 6000, 0)
end

function CentipaarWorker_OnLeaveCombat(Unit, Event) 
	Unit:RemoveEvents() 
end

function CentipaarWorker_OnDied(Unit, Event) 
	Unit:RemoveEvents()
end

function CentipaarWorker_OnKilledTarget(Unit, Event) 
end

RegisterUnitEvent(5458, 1, "CentipaarWorker_OnCombat")
RegisterUnitEvent(5458, 2, "CentipaarWorker_OnLeaveCombat")
RegisterUnitEvent(5458, 3, "CentipaarWorker_OnKilledTarget")
RegisterUnitEvent(5458, 4, "CentipaarWorker_OnDied")