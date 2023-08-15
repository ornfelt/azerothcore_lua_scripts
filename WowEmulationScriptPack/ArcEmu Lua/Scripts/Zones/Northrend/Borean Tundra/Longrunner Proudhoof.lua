--[[

	This is created by zdroid9770  :D

	© Copyright 2012

]]


function LongrunnerProudhoof_OnCombat(Unit, Event)
Unit:RegisterEvent("LongrunnerProudhoof_DemoralizingShout", 2000, 2)
Unit:RegisterEvent("LongrunnerProudhoof_ForcefulCleave", 8000, 0)
end

function LongrunnerProudhoof_DemoralizingShout(Unit, Event) 
Unit:CastSpell(13730) 
end

function LongrunnerProudhoof_ForcefulCleave(Unit, Event) 
Unit:CastSpell(35473) 
end

function LongrunnerProudhoof_OnLeaveCombat(Unit, Event) 
Unit:RemoveEvents() 
end

function LongrunnerProudhoof_OnDied(Unit, Event) 
Unit:RemoveEvents()
end

function LongrunnerProudhoof_OnKilledTarget(Unit, Event) 
end

RegisterUnitEvent(25335, 1, "LongrunnerProudhoof_OnCombat")
RegisterUnitEvent(25335, 2, "LongrunnerProudhoof_OnLeaveCombat")
RegisterUnitEvent(25335, 3, "LongrunnerProudhoof_OnKilledTarget")
RegisterUnitEvent(25335, 4, "LongrunnerProudhoof_OnDied")