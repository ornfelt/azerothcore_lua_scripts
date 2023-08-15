--[[

	This is created by zdroid9770  :D

	© Copyright 2012

]]


function HiveRegalSpitfire_OnCombat(Unit, Event)
	Unit:RegisterEvent("HiveRegalSpitfire_CorrosiveAcidSpit", 8000, 0)
end

function HiveRegalSpitfire_CorrosiveAcidSpit(Unit, Event) 
	Unit:FullCastSpellOnTarget(21047, 	Unit:GetRandomPlayer(0)) 
end

function HiveRegalSpitfire_OnLeaveCombat(Unit, Event) 
	Unit:RemoveEvents() 
end

function HiveRegalSpitfire_OnDied(Unit, Event) 
	Unit:RemoveEvents()
end

function HiveRegalSpitfire_OnKilledTarget(Unit, Event) 
end

RegisterUnitEvent(11732, 1, "HiveRegalSpitfire_OnCombat")
RegisterUnitEvent(11732, 2, "HiveRegalSpitfire_OnLeaveCombat")
RegisterUnitEvent(11732, 3, "HiveRegalSpitfire_OnKilledTarget")
RegisterUnitEvent(11732, 4, "HiveRegalSpitfire_OnDied")