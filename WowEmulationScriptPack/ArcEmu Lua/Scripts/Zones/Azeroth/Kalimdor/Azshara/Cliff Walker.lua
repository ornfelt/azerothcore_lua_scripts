--[[

	This is created by zdroid9770  :D

	© Copyright 2012

]]


function CliffWalker_OnCombat(Unit, Event)
	Unit:RegisterEvent("CliffWalker_WarStomp", 8000, 0)
end

function CliffWalker_WarStomp(pUnit, Event) 
	pUnit:CastSpell(11876) 
end

function CliffWalker_OnLeaveCombat(Unit, Event) 
	Unit:RemoveEvents() 
end

function CliffWalker_OnDied(Unit, Event) 
	Unit:RemoveEvents()
end

RegisterUnitEvent(6148, 1, "CliffWalker_OnCombat")
RegisterUnitEvent(6148, 2, "CliffWalker_OnLeaveCombat")
RegisterUnitEvent(6148, 4, "CliffWalker_OnDied")