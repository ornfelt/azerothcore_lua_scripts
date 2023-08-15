--[[

	This is created by zdroid9770  :D

	© Copyright 2012

]]

function AzureManashaper_OnCombat(Unit, Event)
Unit:RegisterEvent("AzureManashaper_ArcaneBlast", 8000, 0)
Unit:RegisterEvent("AzureManashaper_Slow", 7000, 0)
end

function AzureManashaper_ArcaneBlast(Unit, Event) 
Unit:FullCastSpellOnTarget(10833, Unit:GetMainTank()) 
end

function AzureManashaper_Slow(Unit, Event) 
Unit:FullCastSpellOnTarget(25603, Unit:GetMainTank()) 
end

function AzureManashaper_OnLeaveCombat(Unit, Event) 
Unit:RemoveEvents() 
end

function AzureManashaper_OnDied(Unit, Event) 
Unit:RemoveEvents()
end

function AzureManashaper_OnKilledTarget(Unit, Event) 
end

RegisterUnitEvent(31401, 1, "AzureManashaper_OnCombat")
RegisterUnitEvent(31401, 2, "AzureManashaper_OnLeaveCombat")
RegisterUnitEvent(31401, 3, "AzureManashaper_OnKilledTarget")
RegisterUnitEvent(31401, 4, "AzureManashaper_OnDied")