--[[

	This is created by zdroid9770  :D

	© Copyright 2012

]]


function OnslaughtWorkman_OnCombat(Unit, Event)
Unit:RegisterEvent("OnslaughtWorkman_Chop", 7000, 0)
end

function OnslaughtWorkman_Chop(Unit, Event) 
Unit:FullCastSpellOnTarget(43410, Unit:GetMainTank()) 
end

function OnslaughtWorkman_OnLeaveCombat(Unit, Event) 
Unit:RemoveEvents() 
end

function OnslaughtWorkman_OnDied(Unit, Event) 
Unit:RemoveEvents()
end

function OnslaughtWorkman_OnKilledTarget(Unit, Event) 
end

RegisterUnitEvent(27207, 1, "OnslaughtWorkman_OnCombat")
RegisterUnitEvent(27207, 2, "OnslaughtWorkman_OnLeaveCombat")
RegisterUnitEvent(27207, 3, "OnslaughtWorkman_OnKilledTarget")
RegisterUnitEvent(27207, 4, "OnslaughtWorkman_OnDied")