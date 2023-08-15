--[[

	This is created by zdroid9770  :D

	© Copyright 2012

]]


function DevoutBodyguard_OnCombat(Unit, Event)
Unit:RegisterEvent("DevoutBodyguard_PiercingHowl", 8000, 0)
end

function DevoutBodyguard_PiercingHowl(Unit, Event) 
Unit:CastSpell(38256) 
end

function DevoutBodyguard_OnLeaveCombat(Unit, Event) 
Unit:RemoveEvents() 
end

function DevoutBodyguard_OnDied(Unit, Event) 
Unit:RemoveEvents()
end

function DevoutBodyguard_OnKilledTarget(Unit, Event) 
end

RegisterUnitEvent(27247, 1, "DevoutBodyguard_OnCombat")
RegisterUnitEvent(27247, 2, "DevoutBodyguard_OnLeaveCombat")
RegisterUnitEvent(27247, 3, "DevoutBodyguard_OnKilledTarget")
RegisterUnitEvent(27247, 4, "DevoutBodyguard_OnDied")