--[[

	This is created by zdroid9770  :D

	© Copyright 2012

]]


function HiveRegalHiveLord_OnCombat(Unit, Event)
	Unit:RegisterEvent("HiveRegalHiveLord_BerserkerCharge", 6000, 0)
end

function HiveRegalHiveLord_BerserkerCharge(Unit, Event) 
	Unit:FullCastSpellOnTarget(19471, 	Unit:GetRandomPlayer(0)) 
end

function HiveRegalHiveLord_OnLeaveCombat(Unit, Event) 
	Unit:RemoveEvents() 
end

function HiveRegalHiveLord_OnDied(Unit, Event) 
	Unit:RemoveEvents()
end

function HiveRegalHiveLord_OnKilledTarget(Unit, Event) 
end

RegisterUnitEvent(11734, 1, "HiveRegalHiveLord_OnCombat")
RegisterUnitEvent(11734, 2, "HiveRegalHiveLord_OnLeaveCombat")
RegisterUnitEvent(11734, 3, "HiveRegalHiveLord_OnKilledTarget")
RegisterUnitEvent(11734, 4, "HiveRegalHiveLord_OnDied")