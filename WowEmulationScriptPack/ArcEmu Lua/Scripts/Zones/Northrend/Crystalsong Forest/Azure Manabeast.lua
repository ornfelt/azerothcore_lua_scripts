--[[

	This is created by zdroid9770  :D

	© Copyright 2012

]]


function AzureManabeast_OnCombat(Unit, Event)
Unit:RegisterEvent("AzureManabeast_ManaBite", 8000, 0)
end

function AzureManabeast_ManaBite(Unit, Event) 
Unit:FullCastSpellOnTarget(59105, Unit:GetMainTank()) 
end

function AzureManabeast_OnLeaveCombat(Unit, Event) 
Unit:RemoveEvents() 
end

function AzureManabeast_OnDied(Unit, Event) 
Unit:RemoveEvents()
end

function AzureManabeast_OnKilledTarget(Unit, Event) 
end

RegisterUnitEvent(31404, 1, "AzureManabeast_OnCombat")
RegisterUnitEvent(31404, 2, "AzureManabeast_OnLeaveCombat")
RegisterUnitEvent(31404, 3, "AzureManabeast_OnKilledTarget")
RegisterUnitEvent(31404, 4, "AzureManabeast_OnDied")