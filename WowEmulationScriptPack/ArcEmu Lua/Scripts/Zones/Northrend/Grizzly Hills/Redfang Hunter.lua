--[[

	This is created by zdroid9770  :D

	© Copyright 2012

]]


function RedfangHunter_OnCombat(Unit, Event)
Unit:RegisterEvent("RedfangHunter_CarnivorousBite", 10000, 0)
Unit:RegisterEvent("RedfangHunter_Net", 11000, 0)
Unit:RegisterEvent("RedfangHunter_Shoot", 6000, 0)
end

function RedfangHunter_CarnivorousBite(Unit, Event) 
Unit:FullCastSpellOnTarget(30639, Unit:GetMainTank()) 
end

function RedfangHunter_Net(Unit, Event) 
Unit:FullCastSpellOnTarget(12024, Unit:GetMainTank()) 
end

function RedfangHunter_Shoot(Unit, Event) 
Unit:FullCastSpellOnTarget(6660, Unit:GetMainTank()) 
end

function RedfangHunter_OnLeaveCombat(Unit, Event) 
Unit:RemoveEvents() 
end

function RedfangHunter_OnDied(Unit, Event) 
Unit:RemoveEvents()
end

function RedfangHunter_OnKilledTarget(Unit, Event) 
end

RegisterUnitEvent(26356, 1, "RedfangHunter_OnCombat")
RegisterUnitEvent(26356, 2, "RedfangHunter_OnLeaveCombat")
RegisterUnitEvent(26356, 3, "RedfangHunter_OnKilledTarget")
RegisterUnitEvent(26356, 4, "RedfangHunter_OnDied")