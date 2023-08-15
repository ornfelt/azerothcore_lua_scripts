--[[

	This is created by zdroid9770  :D

	© Copyright 2012

]]
function WitchwingSlayer_OnCombat(Unit, Event)
	Unit:RegisterEvent("WitchwingSlayer_DemoralizingShout", 3000, 1)
end

function WitchwingSlayer_DemoralizingShout(Unit, Event) 
	Unit:CastSpell(13730) 
end

function WitchwingSlayer_OnLeaveCombat(Unit, Event) 
	Unit:RemoveEvents() 
end

function WitchwingSlayer_OnDied(Unit, Event) 
	Unit:RemoveEvents()
end

function WitchwingSlayer_OnKilledTarget(Unit, Event) 
end

RegisterUnitEvent(3278, 1, "WitchwingSlayer_OnCombat")
RegisterUnitEvent(3278, 2, "WitchwingSlayer_OnLeaveCombat")
RegisterUnitEvent(3278, 3, "WitchwingSlayer_OnKilledTarget")
RegisterUnitEvent(3278, 4, "WitchwingSlayer_OnDied")