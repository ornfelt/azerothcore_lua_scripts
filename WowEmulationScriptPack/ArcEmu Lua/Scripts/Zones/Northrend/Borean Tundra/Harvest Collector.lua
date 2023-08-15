--[[

	This is created by zdroid9770  :D

	© Copyright 2012

]]


function HarvestCollector_OnCombat(Unit, Event)
Unit:RegisterEvent("HarvestCollector_ClawSlash", 6000, 0)
end

function HarvestCollector_ClawSlash(Unit, Event) 
Unit:FullCastSpellOnTarget(54185, Unit:GetMainTank()) 
end

function HarvestCollector_OnLeaveCombat(Unit, Event) 
Unit:RemoveEvents() 
end

function HarvestCollector_OnDied(Unit, Event) 
Unit:RemoveEvents()
end

function HarvestCollector_OnKilledTarget(Unit, Event) 
end

RegisterUnitEvent(25623, 1, "HarvestCollector_OnCombat")
RegisterUnitEvent(25623, 2, "HarvestCollector_OnLeaveCombat")
RegisterUnitEvent(25623, 3, "HarvestCollector_OnKilledTarget")
RegisterUnitEvent(25623, 4, "HarvestCollector_OnDied")