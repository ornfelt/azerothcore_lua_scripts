--[[

	This is created by zdroid9770  :D

	© Copyright 2012

]]


function FoulwealdDenWatcher_OnCombat(Unit, Event)
	Unit:RegisterEvent("FoulwealdDenWatcher_Thrash", 5000, 0)
end

function FoulwealdDenWatcher_Thrash(pUnit, Event) 
	pUnit:FullCastSpellOnTarget(3391, 	pUnit:GetMainTank()) 
end

function FoulwealdDenWatcher_OnLeaveCombat(Unit, Event) 
	Unit:RemoveEvents() 
end

function FoulwealdDenWatcher_OnDied(Unit, Event) 
	Unit:RemoveEvents()
end

RegisterUnitEvent(3746, 1, "FoulwealdDenWatcher_OnCombat")
RegisterUnitEvent(3746, 2, "FoulwealdDenWatcher_OnLeaveCombat")
RegisterUnitEvent(3746, 4, "FoulwealdDenWatcher_OnDied")