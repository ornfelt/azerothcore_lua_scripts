--[[

	This is created by zdroid9770  :D

	© Copyright 2012

]]


function HiveAshiDefender_OnCombat(Unit, Event)
	Unit:RegisterEvent("HiveAshiDefender_Disarm", 9000, 0)
end

function HiveAshiDefender_Disarm(Unit, Event) 
	Unit:FullCastSpellOnTarget(6713, 	Unit:GetMainTank()) 
end

function HiveAshiDefender_OnLeaveCombat(Unit, Event) 
	Unit:RemoveEvents() 
end

function HiveAshiDefender_OnDied(Unit, Event) 
	Unit:RemoveEvents()
end

function HiveAshiDefender_OnKilledTarget(Unit, Event) 
end

RegisterUnitEvent(11722, 1, "HiveAshiDefender_OnCombat")
RegisterUnitEvent(11722, 2, "HiveAshiDefender_OnLeaveCombat")
RegisterUnitEvent(11722, 3, "HiveAshiDefender_OnKilledTarget")
RegisterUnitEvent(11722, 4, "HiveAshiDefender_OnDied")