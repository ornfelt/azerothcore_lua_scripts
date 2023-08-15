--[[

	This is created by zdroid9770  :D

	© Copyright 2012

]]


function BishopStreet_OnCombat(Unit, Event)
Unit:RegisterEvent("BishopStreet_HolySmite", 5000, 0)
Unit:RegisterEvent("BishopStreet_PowerWordShield", 2000, 1)
end

function BishopStreet_HolySmite(Unit, Event) 
Unit:FullCastSpellOnTarget(20820, Unit:GetMainTank()) 
end

function BishopStreet_PowerWordShield(Unit, Event) 
Unit:CastSpell(11974) 
end

function BishopStreet_OnLeaveCombat(Unit, Event) 
Unit:RemoveEvents() 
end

function BishopStreet_OnDied(Unit, Event) 
Unit:RemoveEvents()
end

function BishopStreet_OnKilledTarget(Unit, Event) 
end

RegisterUnitEvent(27246, 1, "BishopStreet_OnCombat")
RegisterUnitEvent(27246, 2, "BishopStreet_OnLeaveCombat")
RegisterUnitEvent(27246, 3, "BishopStreet_OnKilledTarget")
RegisterUnitEvent(27246, 4, "BishopStreet_OnDied")