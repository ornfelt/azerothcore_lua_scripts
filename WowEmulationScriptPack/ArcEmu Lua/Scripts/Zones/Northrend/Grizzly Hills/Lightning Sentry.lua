--[[

	This is created by zdroid9770  :D

	© Copyright 2012

]]


function LightningSentry_OnCombat(Unit, Event)
Unit:RegisterEvent("LightningSentry_ChargedSentryTotem", 4000, 1)
end

function LightningSentry_ChargedSentryTotem(Unit, Event) 
Unit:CastSpell(52703) 
end

function LightningSentry_OnLeaveCombat(Unit, Event) 
Unit:RemoveEvents() 
end

function LightningSentry_OnDied(Unit, Event) 
Unit:RemoveEvents()
end

function LightningSentry_OnKilledTarget(Unit, Event) 
end

RegisterUnitEvent(26407, 1, "LightningSentry_OnCombat")
RegisterUnitEvent(26407, 2, "LightningSentry_OnLeaveCombat")
RegisterUnitEvent(26407, 3, "LightningSentry_OnKilledTarget")
RegisterUnitEvent(26407, 4, "LightningSentry_OnDied")