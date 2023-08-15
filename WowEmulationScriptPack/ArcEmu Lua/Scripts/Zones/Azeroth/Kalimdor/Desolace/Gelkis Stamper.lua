--[[

	This is created by zdroid9770  :D

	© Copyright 2012

]]


function GelkisStamper_OnCombat(Unit, Event)
	Unit:RegisterEvent("GelkisStamper_Trample", 6000, 0)
end

function GelkisStamper_Trample(Unit, Event) 
	Unit:CastSpell(5568) 
end

function GelkisStamper_OnLeaveCombat(Unit, Event) 
	Unit:RemoveEvents() 
end

function GelkisStamper_OnDied(Unit, Event) 
	Unit:RemoveEvents()
end

function GelkisStamper_OnKilledTarget(Unit, Event) 
end

RegisterUnitEvent(4648, 1, "GelkisStamper_OnCombat")
RegisterUnitEvent(4648, 2, "GelkisStamper_OnLeaveCombat")
RegisterUnitEvent(4648, 3, "GelkisStamper_OnKilledTarget")
RegisterUnitEvent(4648, 4, "GelkisStamper_OnDied")