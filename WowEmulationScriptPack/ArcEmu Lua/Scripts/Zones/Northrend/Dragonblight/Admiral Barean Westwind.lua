--[[

	This is created by zdroid9770  :D

	© Copyright 2012

]]


function AdmiralBareanWestwind_OnCombat(Unit, Event)
Unit:RegisterEvent("AdmiralBareanWestwind_ProtectionSphere", 15000, 0)
end

function AdmiralBareanWestwind_ProtectionSphere(Unit, Event) 
Unit:CastSpell(50161) 
end

function AdmiralBareanWestwind_OnLeaveCombat(Unit, Event) 
Unit:RemoveEvents() 
end

function AdmiralBareanWestwind_OnDied(Unit, Event) 
Unit:RemoveEvents()
end

function AdmiralBareanWestwind_OnKilledTarget(Unit, Event) 
end

RegisterUnitEvent(27951, 1, "AdmiralBareanWestwind_OnCombat")
RegisterUnitEvent(27951, 2, "AdmiralBareanWestwind_OnLeaveCombat")
RegisterUnitEvent(27951, 3, "AdmiralBareanWestwind_OnKilledTarget")
RegisterUnitEvent(27951, 4, "AdmiralBareanWestwind_OnDied")