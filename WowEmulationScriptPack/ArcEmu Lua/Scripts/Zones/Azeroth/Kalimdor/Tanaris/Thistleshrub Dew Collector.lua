--[[

	This is created by zdroid9770  :D

	© Copyright 2012

]]

function ThistleshrubDewCollector_OnCombat(Unit, Event)
	Unit:RegisterEvent("ThistleshrubDewCollector_EntanglingRoots", 10000, 0)
end

function ThistleshrubDewCollector_EntanglingRoots(Unit, Event) 
	Unit:FullCastSpellOnTarget(11922, 	Unit:GetMainTank()) 
end

function ThistleshrubDewCollector_OnLeaveCombat(Unit, Event) 
	Unit:RemoveEvents() 
end

function ThistleshrubDewCollector_OnDied(Unit, Event) 
	Unit:RemoveEvents()
end

function ThistleshrubDewCollector_OnKilledTarget(Unit, Event) 
end

RegisterUnitEvent(5481, 1, "ThistleshrubDewCollector_OnCombat")
RegisterUnitEvent(5481, 2, "ThistleshrubDewCollector_OnLeaveCombat")
RegisterUnitEvent(5481, 3, "ThistleshrubDewCollector_OnKilledTarget")
RegisterUnitEvent(5481, 4, "ThistleshrubDewCollector_OnDied")