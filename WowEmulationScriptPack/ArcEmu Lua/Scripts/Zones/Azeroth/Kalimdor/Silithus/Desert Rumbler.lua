--[[

	This is created by zdroid9770  :D

	© Copyright 2012

]]


function DesertRumbler_OnCombat(Unit, Event)
	Unit:RegisterEvent("DesertRumbler_Trample", 6000, 0)
end

function DesertRumbler_Trample(Unit, Event) 
	Unit:CastSpell(5568) 
end

function DesertRumbler_OnLeaveCombat(Unit, Event) 
	Unit:RemoveEvents() 
end

function DesertRumbler_OnDied(Unit, Event) 
	Unit:RemoveEvents()
end

function DesertRumbler_OnKilledTarget(Unit, Event) 
end

RegisterUnitEvent(11746, 1, "DesertRumbler_OnCombat")
RegisterUnitEvent(11746, 2, "DesertRumbler_OnLeaveCombat")
RegisterUnitEvent(11746, 3, "DesertRumbler_OnKilledTarget")
RegisterUnitEvent(11746, 4, "DesertRumbler_OnDied")