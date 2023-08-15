--[[

	This is created by zdroid9770  :D

	© Copyright 2012

]]


function OnslaughtDeckhand_OnCombat(Unit, Event)
Unit:RegisterEvent("OnslaughtDeckhand_SideKick", 6000, 0)
end

function OnslaughtDeckhand_SideKick(Unit, Event) 
Unit:FullCastSpellOnTarget(50854, Unit:GetMainTank()) 
end

function OnslaughtDeckhand_OnLeaveCombat(Unit, Event) 
Unit:RemoveEvents() 
end

function OnslaughtDeckhand_OnDied(Unit, Event) 
Unit:RemoveEvents()
end

function OnslaughtDeckhand_OnKilledTarget(Unit, Event) 
end

RegisterUnitEvent(27233, 1, "OnslaughtDeckhand_OnCombat")
RegisterUnitEvent(27233, 2, "OnslaughtDeckhand_OnLeaveCombat")
RegisterUnitEvent(27233, 3, "OnslaughtDeckhand_OnKilledTarget")
RegisterUnitEvent(27233, 4, "OnslaughtDeckhand_OnDied")