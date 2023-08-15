--[[

	This is created by zdroid9770  :D

	© Copyright 2012

]]


function HulkingJormungar_OnCombat(Unit, Event)
Unit:RegisterEvent("HulkingJormungar_CorrosivePoison", 4000, 1)
Unit:RegisterEvent("HulkingJormungar_CorrosiveSpit", 6000, 1)
end

function HulkingJormungar_CorrosivePoison(Unit, Event) 
Unit:FullCastSpellOnTarget(50293, Unit:GetMainTank()) 
end

function HulkingJormungar_CorrosiveSpit(Unit, Event) 
Unit:FullCastSpellOnTarget(47611, Unit:GetMainTank()) 
end

function HulkingJormungar_OnLeaveCombat(Unit, Event) 
Unit:RemoveEvents() 
end

function HulkingJormungar_OnDied(Unit, Event) 
Unit:RemoveEvents()
end

function HulkingJormungar_OnKilledTarget(Unit, Event) 
end

RegisterUnitEvent(26293, 1, "HulkingJormungar_OnCombat")
RegisterUnitEvent(26293, 2, "HulkingJormungar_OnLeaveCombat")
RegisterUnitEvent(26293, 3, "HulkingJormungar_OnKilledTarget")
RegisterUnitEvent(26293, 4, "HulkingJormungar_OnDied")