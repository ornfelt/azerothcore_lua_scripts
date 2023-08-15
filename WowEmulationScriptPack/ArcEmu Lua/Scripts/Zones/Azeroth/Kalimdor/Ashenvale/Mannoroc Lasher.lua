--[[

	This is created by zdroid9770  :D

	© Copyright 2012

]]

function MannorocLasher_OnCombat(Unit, Event)
	Unit:RegisterEvent("MannorocLasher_ShadowBolt", 8000, 0)
end

function MannorocLasher_ShadowBolt(pUnit, Event) 
	pUnit:FullCastSpellOnTarget(9613, 	pUnit:GetMainTank()) 
end

function MannorocLasher_OnLeaveCombat(Unit, Event) 
	Unit:RemoveEvents() 
end

function MannorocLasher_OnDied(Unit, Event) 
	Unit:RemoveEvents()
end

RegisterUnitEvent(11697, 1, "MannorocLasher_OnCombat")
RegisterUnitEvent(11697, 2, "MannorocLasher_OnLeaveCombat")
RegisterUnitEvent(11697, 4, "MannorocLasher_OnDied")