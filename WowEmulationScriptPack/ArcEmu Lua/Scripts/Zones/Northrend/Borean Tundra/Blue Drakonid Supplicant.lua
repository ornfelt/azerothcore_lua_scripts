--[[

	This is created by zdroid9770  :D

	© Copyright 2012

]]


function BlueDrakonidSupplicant_OnCombat(Unit, Event)
Unit:RegisterEvent("BlueDrakonidSupplicant_PowerSap", 8000, 0)
end

function BlueDrakonidSupplicant_PowerSap(Unit, Event) 
Unit:FullCastSpellOnTarget(50534, pUnit:GetMainTank()) 
end

function BlueDrakonidSupplicant_OnLeaveCombat(Unit, Event) 
Unit:RemoveEvents() 
end

function BlueDrakonidSupplicant_OnDied(Unit, Event) 
Unit:RemoveEvents()
end

function BlueDrakonidSupplicant_OnKilledTarget(Unit, Event) 
end

RegisterUnitEvent(25713, 1, "BlueDrakonidSupplicant_OnCombat")
RegisterUnitEvent(25713, 2, "BlueDrakonidSupplicant_OnLeaveCombat")
RegisterUnitEvent(25713, 3, "BlueDrakonidSupplicant_OnKilledTarget")
RegisterUnitEvent(25713, 4, "BlueDrakonidSupplicant_OnDied")