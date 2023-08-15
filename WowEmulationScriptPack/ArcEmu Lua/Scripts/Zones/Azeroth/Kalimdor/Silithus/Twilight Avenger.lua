--[[

	This is created by zdroid9770  :D

	© Copyright 2012

]]


function TwilightAvenger_OnCombat(Unit, Event)
	Unit:RegisterEvent("TwilightAvenger_Enrage", 10000, 1)
end

function TwilightAvenger_Enrage(Unit, Event) 
	Unit:CastSpell(8599) 
end

function TwilightAvenger_OnLeaveCombat(Unit, Event) 
	Unit:RemoveEvents() 
end

function TwilightAvenger_OnDied(Unit, Event) 
	Unit:RemoveEvents()
end

function TwilightAvenger_OnKilledTarget(Unit, Event) 
end

RegisterUnitEvent(11880, 1, "TwilightAvenger_OnCombat")
RegisterUnitEvent(11880, 2, "TwilightAvenger_OnLeaveCombat")
RegisterUnitEvent(11880, 3, "TwilightAvenger_OnKilledTarget")
RegisterUnitEvent(11880, 4, "TwilightAvenger_OnDied")