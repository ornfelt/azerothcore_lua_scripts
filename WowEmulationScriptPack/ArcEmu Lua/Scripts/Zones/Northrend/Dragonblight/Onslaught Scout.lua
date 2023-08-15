--[[

	This is created by zdroid9770  :D

	© Copyright 2012

]]


function OnslaughtScout_OnCombat(Unit, Event)
Unit:RegisterEvent("OnslaughtScout_Sprint", 4000, 1)
end

function OnslaughtScout_Sprint(Unit, Event) 
Unit:CastSpell(48594) 
end

function OnslaughtScout_OnLeaveCombat(Unit, Event) 
Unit:RemoveEvents() 
end

function OnslaughtScout_OnDied(Unit, Event) 
Unit:RemoveEvents()
end

function OnslaughtScout_OnKilledTarget(Unit, Event) 
end

RegisterUnitEvent(27332, 1, "OnslaughtScout_OnCombat")
RegisterUnitEvent(27332, 2, "OnslaughtScout_OnLeaveCombat")
RegisterUnitEvent(27332, 3, "OnslaughtScout_OnKilledTarget")
RegisterUnitEvent(27332, 4, "OnslaughtScout_OnDied")