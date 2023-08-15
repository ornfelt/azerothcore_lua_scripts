--[[

	This is created by zdroid9770  :D

	© Copyright 2012

]]


function OnslaughtBloodhound_OnCombat(Unit, Event)
Unit:RegisterEvent("OnslaughtBloodhound_Maul", 5000, 0)
end

function OnslaughtBloodhound_Maul(Unit, Event) 
Unit:FullCastSpellOnTarget(51875, Unit:GetMainTank()) 
end

function OnslaughtBloodhound_OnLeaveCombat(Unit, Event) 
Unit:RemoveEvents() 
end

function OnslaughtBloodhound_OnDied(Unit, Event) 
Unit:RemoveEvents()
end

function OnslaughtBloodhound_OnKilledTarget(Unit, Event) 
end

RegisterUnitEvent(27329, 1, "OnslaughtBloodhound_OnCombat")
RegisterUnitEvent(27329, 2, "OnslaughtBloodhound_OnLeaveCombat")
RegisterUnitEvent(27329, 3, "OnslaughtBloodhound_OnKilledTarget")
RegisterUnitEvent(27329, 4, "OnslaughtBloodhound_OnDied")