--[[

	This is created by zdroid9770  :D

	© Copyright 2012

]]


function AzureDragon_OnCombat(Unit, Event)
Unit:RegisterEvent("AzureDragon_FrostBreath", 10000, 1)
end

function AzureDragon_FrostBreath(Unit, Event) 
Unit:FullCastSpellOnTarget(49111, Unit:GetMainTank()) 
end

function AzureDragon_OnLeaveCombat(Unit, Event) 
Unit:RemoveEvents() 
end

function AzureDragon_OnDied(Unit, Event) 
Unit:RemoveEvents()
end

function AzureDragon_OnKilledTarget(Unit, Event) 
end

RegisterUnitEvent(27608, 1, "AzureDragon_OnCombat")
RegisterUnitEvent(27608, 2, "AzureDragon_OnLeaveCombat")
RegisterUnitEvent(27608, 3, "AzureDragon_OnKilledTarget")
RegisterUnitEvent(27608, 4, "AzureDragon_OnDied")