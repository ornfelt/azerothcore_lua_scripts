--[[

	This is created by zdroid9770  :D

	© Copyright 2012

]]


function RoanaukIcemist_OnCombat(Unit, Event)
Unit:RegisterEvent("RoanaukIcemist_GloryoftheAncestors", 5000, 1)
Unit:RegisterEvent("RoanaukIcemist_IcemistsBlessing", 10000, 0)
end

function RoanaukIcemist_GloryoftheAncestors(Unit, Event) 
Unit:CastSpell(47378) 
end

function RoanaukIcemist_IcemistsBlessing(Unit, Event) 
Unit:CastSpell(47379) 
end

function RoanaukIcemist_OnLeaveCombat(Unit, Event) 
Unit:RemoveEvents() 
end

function RoanaukIcemist_OnDied(Unit, Event) 
Unit:RemoveEvents()
end

function RoanaukIcemist_OnKilledTarget(Unit, Event) 
end

RegisterUnitEvent(26654, 1, "RoanaukIcemist_OnCombat")
RegisterUnitEvent(26654, 2, "RoanaukIcemist_OnLeaveCombat")
RegisterUnitEvent(26654, 3, "RoanaukIcemist_OnKilledTarget")
RegisterUnitEvent(26654, 4, "RoanaukIcemist_OnDied")