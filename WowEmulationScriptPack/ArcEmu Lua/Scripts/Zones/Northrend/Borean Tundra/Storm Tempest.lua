--[[

	This is created by zdroid9770  :D

	© Copyright 2012

]]


function StormTempest_OnCombat(Unit, Event)
Unit:RegisterEvent("StormTempest_ChainLightning", 8000, 0)
Unit:RegisterEvent("StormTempest_WindShock", 6000, 0)
end

function StormTempest_ChainLightning(Unit, Event) 
Unit:FullCastSpellOnTarget(15659, Unit:GetMainTank()) 
end

function StormTempest_WindShock(Unit, Event) 
Unit:FullCastSpellOnTarget(31272, Unit:GetMainTank()) 
end

function StormTempest_OnLeaveCombat(Unit, Event) 
Unit:RemoveEvents() 
end

function StormTempest_OnDied(Unit, Event) 
Unit:RemoveEvents()
end

function StormTempest_OnKilledTarget(Unit, Event) 
end

RegisterUnitEvent(26045, 1, "StormTempest_OnCombat")
RegisterUnitEvent(26045, 2, "StormTempest_OnLeaveCombat")
RegisterUnitEvent(26045, 3, "StormTempest_OnKilledTarget")
RegisterUnitEvent(26045, 4, "StormTempest_OnDied")