--[[

	This is created by zdroid9770  :D

	© Copyright 2012

]]

function SpitelashScreamer_OnCombat(Unit, Event)
	Unit:RegisterEvent("SpitelashScreamer_DeafeningScreech", 12000, 0)
end

function SpitelashScreamer_DeafeningScreech(pUnit, Event) 
	pUnit:CastSpell(3589) 
end

function SpitelashScreamer_OnLeaveCombat(Unit, Event) 
	Unit:RemoveEvents() 
end

function SpitelashScreamer_OnDied(Unit, Event) 
	Unit:RemoveEvents()
end

RegisterUnitEvent(6193, 1, "SpitelashScreamer_OnCombat")
RegisterUnitEvent(6193, 2, "SpitelashScreamer_OnLeaveCombat")
RegisterUnitEvent(6193, 4, "SpitelashScreamer_OnDied")