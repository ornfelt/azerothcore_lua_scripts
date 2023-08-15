--[[

	This is created by zdroid9770  :D

	© Copyright 2012

]]


function AzureTemplar_OnCombat(Unit, Event)
	Unit:RegisterEvent("AzureTemplar_FrostNova", 8000, 0)
	Unit:RegisterEvent("AzureTemplar_FrostShock", 6000, 0)
end

function AzureTemplar_FrostNova(Unit, Event) 
	Unit:CastSpell(14907) 
end

function AzureTemplar_FrostShock(Unit, Event) 
	Unit:FullCastSpellOnTarget(12548, 	Unit:GetMainTank()) 
end

function AzureTemplar_OnLeaveCombat(Unit, Event) 
	Unit:RemoveEvents() 
end

function AzureTemplar_OnDied(Unit, Event) 
	Unit:RemoveEvents()
end

function AzureTemplar_OnKilledTarget(Unit, Event) 
end

RegisterUnitEvent(15211, 1, "AzureTemplar_OnCombat")
RegisterUnitEvent(15211, 2, "AzureTemplar_OnLeaveCombat")
RegisterUnitEvent(15211, 3, "AzureTemplar_OnKilledTarget")
RegisterUnitEvent(15211, 4, "AzureTemplar_OnDied")