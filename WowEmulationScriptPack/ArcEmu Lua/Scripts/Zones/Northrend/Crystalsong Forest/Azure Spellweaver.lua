--[[

	This is created by zdroid9770  :D

	© Copyright 2012

]]


function AzureSpellweaver_OnCombat(Unit, Event)
Unit:RegisterEvent("AzureSpellweaver_ArcaneMissiles", 6000, 0)
end

function AzureSpellweaver_ArcaneMissiles(Unit, Event) 
Unit:FullCastSpellOnTarget(34447, Unit:GetMainTank()) 
end

function AzureSpellweaver_OnLeaveCombat(Unit, Event) 
Unit:RemoveEvents() 
end

function AzureSpellweaver_OnDied(Unit, Event) 
Unit:RemoveEvents()
end

function AzureSpellweaver_OnKilledTarget(Unit, Event) 
end

RegisterUnitEvent(31403, 1, "AzureSpellweaver_OnCombat")
RegisterUnitEvent(31403, 2, "AzureSpellweaver_OnLeaveCombat")
RegisterUnitEvent(31403, 3, "AzureSpellweaver_OnKilledTarget")
RegisterUnitEvent(31403, 4, "AzureSpellweaver_OnDied")