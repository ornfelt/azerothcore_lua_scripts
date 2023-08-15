--[[

	This is created by zdroid9770  :D

	© Copyright 2012

]]


function ForgemasterDamrath_OnCombat(Unit, Event)
Unit:RegisterEvent("ForgemasterDamrath_ForgeForce", 7000, 0)
end

function ForgemasterDamrath_ForgeForce(Unit, Event) 
Unit:CastSpell(52640) 
end

function ForgemasterDamrath_OnLeaveCombat(Unit, Event) 
Unit:RemoveEvents() 
end

function ForgemasterDamrath_OnDied(Unit, Event) 
Unit:RemoveEvents()
end

function ForgemasterDamrath_OnKilledTarget(Unit, Event) 
end

RegisterUnitEvent(26334, 1, "ForgemasterDamrath_OnCombat")
RegisterUnitEvent(26334, 2, "ForgemasterDamrath_OnLeaveCombat")
RegisterUnitEvent(26334, 3, "ForgemasterDamrath_OnKilledTarget")
RegisterUnitEvent(26334, 4, "ForgemasterDamrath_OnDied")