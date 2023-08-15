--[[

	This is created by zdroid9770  :D

	© Copyright 2012

]]


function CliffThunderer_OnCombat(Unit, Event)
	Unit:RegisterEvent("CliffThunderer_Thunderclap", 8000, 0)
end

function CliffThunderer_Thunderclap(pUnit, Event) 
	pUnit:CastSpell(8147) 
end

function CliffThunderer_OnLeaveCombat(Unit, Event) 
	Unit:RemoveEvents() 
end

function CliffThunderer_OnDied(Unit, Event) 
	Unit:RemoveEvents()
end

RegisterUnitEvent(6147, 1, "CliffThunderer_OnCombat")
RegisterUnitEvent(6147, 2, "CliffThunderer_OnLeaveCombat")
RegisterUnitEvent(6147, 4, "CliffThunderer_OnDied")