--[[

	This is created by zdroid9770  :D

	© Copyright 2012

]]


function BloodsporeRoaster_OnCombat(Unit, Event)
Unit:RegisterEvent("BloodsporeRoaster_Roast", 8000, 0)
end

function BloodsporeRoaster_Roast(Unit, Event) 
Unit:FullCastSpellOnTarget(50402, Unit:GetMainTank()) 
end

function BloodsporeRoaster_OnLeaveCombat(Unit, Event) 
Unit:RemoveEvents() 
end

function BloodsporeRoaster_OnDied(Unit, Event) 
Unit:RemoveEvents()
end

function BloodsporeRoaster_OnKilledTarget(Unit, Event) 
end

RegisterUnitEvent(25468, 1, "BloodsporeRoaster_OnCombat")
RegisterUnitEvent(25468, 2, "BloodsporeRoaster_OnLeaveCombat")
RegisterUnitEvent(25468, 3, "BloodsporeRoaster_OnKilledTarget")
RegisterUnitEvent(25468, 4, "BloodsporeRoaster_OnDied")