--[[

	This is created by zdroid9770  :D

	© Copyright 2012

]]


function AzureDrake_OnCombat(Unit, Event)
Unit:RegisterEvent("AzureDrake_FrostBreath", 10000, 1)
end

function AzureDrake_FrostBreath(Unit, Event) 
Unit:FullCastSpellOnTarget(49111, Unit:GetMainTank()) 
end

function AzureDrake_OnLeaveCombat(Unit, Event) 
Unit:RemoveEvents() 
end

function AzureDrake_OnDied(Unit, Event) 
Unit:RemoveEvents()
end

function AzureDrake_OnKilledTarget(Unit, Event) 
end

RegisterUnitEvent(27682, 1, "AzureDrake_OnCombat")
RegisterUnitEvent(27682, 2, "AzureDrake_OnLeaveCombat")
RegisterUnitEvent(27682, 3, "AzureDrake_OnKilledTarget")
RegisterUnitEvent(27682, 4, "AzureDrake_OnDied")