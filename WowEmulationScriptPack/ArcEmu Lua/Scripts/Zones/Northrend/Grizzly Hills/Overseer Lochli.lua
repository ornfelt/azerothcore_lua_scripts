--[[

	This is created by zdroid9770  :D

	© Copyright 2012

]]


function OverseerLochli_OnCombat(Unit, Event)
Unit:RegisterEvent("OverseerLochli_Thunderstorm", 11000, 0)
end

function OverseerLochli_Thunderstorm(Unit, Event) 
Unit:CastSpell(52717) 
end

function OverseerLochli_OnLeaveCombat(Unit, Event) 
Unit:RemoveEvents() 
end

function OverseerLochli_OnDied(Unit, Event) 
Unit:RemoveEvents()
end

function OverseerLochli_OnKilledTarget(Unit, Event) 
end

RegisterUnitEvent(26922, 1, "OverseerLochli_OnCombat")
RegisterUnitEvent(26922, 2, "OverseerLochli_OnLeaveCombat")
RegisterUnitEvent(26922, 3, "OverseerLochli_OnKilledTarget")
RegisterUnitEvent(26922, 4, "OverseerLochli_OnDied")