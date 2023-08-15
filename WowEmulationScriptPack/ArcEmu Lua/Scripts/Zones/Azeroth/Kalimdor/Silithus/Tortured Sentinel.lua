--[[

	This is created by zdroid9770  :D

	© Copyright 2012

]]

function TorturedSentinel_OnCombat(Unit, Event)
	Unit:RegisterEvent("TorturedSentinel_SummonHiveAshiDrones", 2000, 1)
end

function TorturedSentinel_SummonHiveAshiDrones(Unit, Event) 
	Unit:CastSpell(21327) 
end

function TorturedSentinel_OnLeaveCombat(Unit, Event) 
	Unit:RemoveEvents() 
end

function TorturedSentinel_OnDied(Unit, Event) 
	Unit:RemoveEvents()
end

function TorturedSentinel_OnKilledTarget(Unit, Event) 
end

RegisterUnitEvent(12179, 1, "TorturedSentinel_OnCombat")
RegisterUnitEvent(12179, 2, "TorturedSentinel_OnLeaveCombat")
RegisterUnitEvent(12179, 3, "TorturedSentinel_OnKilledTarget")
RegisterUnitEvent(12179, 4, "TorturedSentinel_OnDied")