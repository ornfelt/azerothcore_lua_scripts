--[[

	This is created by zdroid9770  :D

	© Copyright 2012

]]


function GhostpawHowler_OnCombat(Unit, Event)
	Unit:RegisterEvent("GhostpawHowler_BloodHowl", 1000, 0)
end

function GhostpawHowler_BloodHowl(pUnit, Event) 
	pUnit:CastSpell(3264) 
end

function GhostpawHowler_OnLeaveCombat(Unit, Event) 
	Unit:RemoveEvents() 
end

function GhostpawHowler_OnDied(Unit, Event) 
	Unit:RemoveEvents()
end

RegisterUnitEvent(3824, 1, "GhostpawHowler_OnCombat")
RegisterUnitEvent(3824, 2, "GhostpawHowler_OnLeaveCombat")
RegisterUnitEvent(3824, 4, "GhostpawHowler_OnDied")