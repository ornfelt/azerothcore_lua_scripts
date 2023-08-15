--[[

	This is created by zdroid9770  :D

	© Copyright 2012

]]


function AnubarUnderlord_OnCombat(Unit, Event)
Unit:RegisterEvent("AnubarUnderlord_RearingStomp", 8000, 0)
end

function AnubarUnderlord_RearingStomp(Unit, Event) 
Unit:CastSpell(51681) 
end

function AnubarUnderlord_OnLeaveCombat(Unit, Event) 
Unit:RemoveEvents() 
end

function AnubarUnderlord_OnDied(Unit, Event) 
Unit:RemoveEvents()
end

function AnubarUnderlord_OnKilledTarget(Unit, Event) 
end

RegisterUnitEvent(26605, 1, "AnubarUnderlord_OnCombat")
RegisterUnitEvent(26605, 2, "AnubarUnderlord_OnLeaveCombat")
RegisterUnitEvent(26605, 3, "AnubarUnderlord_OnKilledTarget")
RegisterUnitEvent(26605, 4, "AnubarUnderlord_OnDied")