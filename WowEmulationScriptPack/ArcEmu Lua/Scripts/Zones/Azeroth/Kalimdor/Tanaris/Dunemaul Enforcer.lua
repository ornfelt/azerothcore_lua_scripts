--[[

	This is created by zdroid9770  :D

	© Copyright 2012

]]
function DunemaulEnforcer_OnCombat(Unit, Event)
	Unit:RegisterEvent("DunemaulEnforcer_DemoralizingShout", 10000, 0)
end

function DunemaulEnforcer_DemoralizingShout(Unit, Event) 
	Unit:CastSpell(13730) 
end

function DunemaulEnforcer_OnLeaveCombat(Unit, Event) 
	Unit:RemoveEvents() 
end

function DunemaulEnforcer_OnDied(Unit, Event) 
	Unit:RemoveEvents()
end

function DunemaulEnforcer_OnKilledTarget(Unit, Event) 
end

RegisterUnitEvent(5472, 1, "DunemaulEnforcer_OnCombat")
RegisterUnitEvent(5472, 2, "DunemaulEnforcer_OnLeaveCombat")
RegisterUnitEvent(5472, 3, "DunemaulEnforcer_OnKilledTarget")
RegisterUnitEvent(5472, 4, "DunemaulEnforcer_OnDied")