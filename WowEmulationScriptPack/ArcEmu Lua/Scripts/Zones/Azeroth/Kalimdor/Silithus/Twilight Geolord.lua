--[[

	This is created by zdroid9770  :D

	© Copyright 2012

]]


function TwilightGeolord_OnCombat(Unit, Event)
	Unit:RegisterEvent("TwilightGeolord_Boulder", 6000, 0)
	Unit:RegisterEvent("TwilightGeolord_EarthShock", 8000, 0)
end

function TwilightGeolord_Boulder(Unit, Event) 
	Unit:FullCastSpellOnTarget(9483, 	Unit:GetMainTank()) 
end

function TwilightGeolord_EarthShock(Unit, Event) 
	Unit:FullCastSpellOnTarget(13728, 	Unit:GetMainTank()) 
end

function TwilightGeolord_OnLeaveCombat(Unit, Event) 
	Unit:RemoveEvents() 
end

function TwilightGeolord_OnDied(Unit, Event) 
	Unit:RemoveEvents()
end

function TwilightGeolord_OnKilledTarget(Unit, Event) 
end

RegisterUnitEvent(11881, 1, "TwilightGeolord_OnCombat")
RegisterUnitEvent(11881, 2, "TwilightGeolord_OnLeaveCombat")
RegisterUnitEvent(11881, 3, "TwilightGeolord_OnKilledTarget")
RegisterUnitEvent(11881, 4, "TwilightGeolord_OnDied")