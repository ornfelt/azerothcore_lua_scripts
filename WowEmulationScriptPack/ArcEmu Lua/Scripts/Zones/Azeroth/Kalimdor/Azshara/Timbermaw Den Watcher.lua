--[[

	This is created by zdroid9770  :D

	© Copyright 2012

]]


function TimbermawDenWatcher_OnCombat(Unit, Event)
	Unit:RegisterEvent("TimbermawDenWatcher_BattleShout", 5000, 0)
end

function TimbermawDenWatcher_BattleShout(pUnit, Event) 
	pUnit:CastSpell(9128) 
end

function TimbermawDenWatcher_OnLeaveCombat(Unit, Event) 
	Unit:RemoveEvents() 
end

function TimbermawDenWatcher_OnDied(Unit, Event) 
	Unit:RemoveEvents()
end

RegisterUnitEvent(6187, 1, "TimbermawDenWatcher_OnCombat")
RegisterUnitEvent(6187, 2, "TimbermawDenWatcher_OnLeaveCombat")
RegisterUnitEvent(6187, 4, "TimbermawDenWatcher_OnDied")