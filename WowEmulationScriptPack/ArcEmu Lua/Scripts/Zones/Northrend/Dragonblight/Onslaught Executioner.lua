--[[

	This is created by zdroid9770  :D

	© Copyright 2012

]]


function OnslaughtExecutioner_OnCombat(Unit, Event)
Unit:RegisterEvent("OnslaughtExecutioner_Hamstring", 8000, 0)
Unit:RegisterEvent("OnslaughtExecutioner_MightyBlow", 9000, 0)
end

function OnslaughtExecutioner_Hamstring(Unit, Event) 
Unit:FullCastSpellOnTarget(9080, Unit:GetMainTank()) 
end

function OnslaughtExecutioner_MightyBlow(Unit, Event) 
Unit:FullCastSpellOnTarget(43673, Unit:GetMainTank()) 
end

function OnslaughtExecutioner_OnLeaveCombat(Unit, Event) 
Unit:RemoveEvents() 
end

function OnslaughtExecutioner_OnDied(Unit, Event) 
Unit:RemoveEvents()
end

function OnslaughtExecutioner_OnKilledTarget(Unit, Event) 
end

RegisterUnitEvent(27211, 1, "OnslaughtExecutioner_OnCombat")
RegisterUnitEvent(27211, 2, "OnslaughtExecutioner_OnLeaveCombat")
RegisterUnitEvent(27211, 3, "OnslaughtExecutioner_OnKilledTarget")
RegisterUnitEvent(27211, 4, "OnslaughtExecutioner_OnDied")