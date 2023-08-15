--[[

	This is created by zdroid9770  :D

	© Copyright 2012

]]

function KulTirasSailor_OnCombat(Unit, Event)
	Unit:RegisterEvent("KulTirasSailor_RushingCharge", 8000, 0)
end

function KulTirasSailor_RushingCharge(Unit, Event) 
	Unit:CastSpell(6268) 
end

function KulTirasSailor_OnLeaveCombat(Unit, Event) 
	Unit:RemoveEvents() 
end

function KulTirasSailor_OnDied(Unit, Event) 
	Unit:RemoveEvents()
end

function KulTirasSailor_OnKilledTarget(Unit, Event) 
end

RegisterUnitEvent(3128, 1, "KulTirasSailor_OnCombat")
RegisterUnitEvent(3128, 2, "KulTirasSailor_OnLeaveCombat")
RegisterUnitEvent(3128, 3, "KulTirasSailor_OnKilledTarget")
RegisterUnitEvent(3128, 4, "KulTirasSailor_OnDied")