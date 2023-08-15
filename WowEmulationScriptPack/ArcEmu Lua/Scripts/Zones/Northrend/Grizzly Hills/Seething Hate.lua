--[[

	This is created by zdroid9770  :D

	© Copyright 2012

]]


function SeethingHate_OnCombat(Unit, Event)
Unit:RegisterEvent("SeethingHate_SeethingEvil", 3000, 1)
end

function SeethingHate_SeethingEvil(Unit, Event) 
Unit:CastSpell(52342) 
end

function SeethingHate_OnLeaveCombat(Unit, Event) 
Unit:RemoveEvents() 
end

function SeethingHate_OnDied(Unit, Event) 
Unit:RemoveEvents()
end

function SeethingHate_OnKilledTarget(Unit, Event) 
end

RegisterUnitEvent(32429, 1, "SeethingHate_OnCombat")
RegisterUnitEvent(32429, 2, "SeethingHate_OnLeaveCombat")
RegisterUnitEvent(32429, 3, "SeethingHate_OnKilledTarget")
RegisterUnitEvent(32429, 4, "SeethingHate_OnDied")