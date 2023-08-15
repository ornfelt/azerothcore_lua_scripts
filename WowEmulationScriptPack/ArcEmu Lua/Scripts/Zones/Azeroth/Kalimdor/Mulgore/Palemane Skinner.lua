--[[

	This is created by zdroid9770  :D

	© Copyright 2012

]]
function PalemaneSkinner_OnCombat(Unit, Event)
Unit:RegisterEvent("PalemaneSkinner_Rejuvenation", 10000, 0)
end

function PalemaneSkinner_Rejuvenation(pUnit, Event) 
pUnit:CastSpell(774) 
end

function PalemaneSkinner_OnLeaveCombat(Unit, Event) 
Unit:RemoveEvents() 
end

function PalemaneSkinner_OnDied(Unit, Event) 
Unit:RemoveEvents()
end

function PalemaneSkinner_OnKilledTarget(Unit, Event) 
end

RegisterUnitEvent(2950, 1, "PalemaneSkinner_OnCombat")
RegisterUnitEvent(2950, 2, "PalemaneSkinner_OnLeaveCombat")
RegisterUnitEvent(2950, 3, "PalemaneSkinner_OnKilledTarget")
RegisterUnitEvent(2950, 4, "PalemaneSkinner_OnDied")