--[[

	This is created by zdroid9770  :D

	© Copyright 2012

]]


function TwilightMarauder_OnCombat(Unit, Event)
	Unit:RegisterEvent("TwilightMarauder_PiercingHowl", 10000, 0)
	Unit:RegisterEvent("TwilightMarauder_Enrage", 12000, 1)
end

function TwilightMarauder_PiercingHowl(Unit, Event) 
	Unit:CastSpell(23600) 
end

function TwilightMarauder_Enrage(Unit, Event) 
	Unit:CastSpell(8599) 
end

function TwilightMarauder_OnLeaveCombat(Unit, Event) 
	Unit:RemoveEvents() 
end

function TwilightMarauder_OnDied(Unit, Event) 
	Unit:RemoveEvents()
end

function TwilightMarauder_OnKilledTarget(Unit, Event) 
end

RegisterUnitEvent(15542, 1, "TwilightMarauder_OnCombat")
RegisterUnitEvent(15542, 2, "TwilightMarauder_OnLeaveCombat")
RegisterUnitEvent(15542, 3, "TwilightMarauder_OnKilledTarget")
RegisterUnitEvent(15542, 4, "TwilightMarauder_OnDied")