--[[

	This is created by zdroid9770  :D

	© Copyright 2012

]]

function HiveRegalAmbusher_OnCombat(Unit, Event)
	Unit:RegisterEvent("HiveRegalAmbusher_Poison", 10000, 0)
end

function HiveRegalAmbusher_Poison(Unit, Event) 
	Unit:FullCastSpellOnTarget(744, 	Unit:GetRandomPlayer(0)) 
end

function HiveRegalAmbusher_OnLeaveCombat(Unit, Event) 
	Unit:RemoveEvents() 
end

function HiveRegalAmbusher_OnDied(Unit, Event) 
	Unit:RemoveEvents()
end

function HiveRegalAmbusher_OnKilledTarget(Unit, Event) 
end

RegisterUnitEvent(11730, 1, "HiveRegalAmbusher_OnCombat")
RegisterUnitEvent(11730, 2, "HiveRegalAmbusher_OnLeaveCombat")
RegisterUnitEvent(11730, 3, "HiveRegalAmbusher_OnKilledTarget")
RegisterUnitEvent(11730, 4, "HiveRegalAmbusher_OnDied")