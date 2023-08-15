--[[

	This is created by zdroid9770  :D

	© Copyright 2012

]]


function SaroniteHorror_OnCombat(Unit, Event)
Unit:RegisterEvent("SaroniteHorror_SeethingEvil", 3000, 1)
end

function SaroniteHorror_SeethingEvil(Unit, Event) 
Unit:CastSpell(52342) 
end

function SaroniteHorror_OnLeaveCombat(Unit, Event) 
Unit:RemoveEvents() 
end

function SaroniteHorror_OnDied(Unit, Event) 
Unit:RemoveEvents()
end

function SaroniteHorror_OnKilledTarget(Unit, Event) 
end

RegisterUnitEvent(26646, 1, "SaroniteHorror_OnCombat")
RegisterUnitEvent(26646, 2, "SaroniteHorror_OnLeaveCombat")
RegisterUnitEvent(26646, 3, "SaroniteHorror_OnKilledTarget")
RegisterUnitEvent(26646, 4, "SaroniteHorror_OnDied")