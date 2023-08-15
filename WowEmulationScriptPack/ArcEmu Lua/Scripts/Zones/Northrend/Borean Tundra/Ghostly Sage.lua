--[[

	This is created by zdroid9770  :D

	© Copyright 2012

]]


function GhostlySage_OnCombat(Unit, Event)
Unit:RegisterEvent("GhostlySage_Moonfire", 6000, 0)
Unit:RegisterEvent("GhostlySage_Wrath", 8000, 0)
end

function GhostlySage_Moonfire(Unit, Event) 
Unit:FullCastSpellOnTarget(15798, Unit:GetMainTank()) 
end

function GhostlySage_Wrath(Unit, Event) 
Unit:FullCastSpellOnTarget(9739, Unit:GetMainTank()) 
end

function GhostlySage_OnLeaveCombat(Unit, Event) 
Unit:RemoveEvents() 
end

function GhostlySage_OnDied(Unit, Event) 
Unit:RemoveEvents()
end

function GhostlySage_OnKilledTarget(Unit, Event) 
end

RegisterUnitEvent(25351, 1, "GhostlySage_OnCombat")
RegisterUnitEvent(25351, 2, "GhostlySage_OnLeaveCombat")
RegisterUnitEvent(25351, 3, "GhostlySage_OnKilledTarget")
RegisterUnitEvent(25351, 4, "GhostlySage_OnDied")