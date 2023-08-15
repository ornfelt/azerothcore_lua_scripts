--[[

	This is created by zdroid9770  :D

	© Copyright 2012

]]


function HulkingAtrocity_OnCombat(Unit, Event)
Unit:RegisterEvent("HulkingAtrocity_InfectedBite", 7000, 0)
end

function HulkingAtrocity_InfectedBite(Unit, Event) 
Unit:FullCastSpellOnTarget(49861, Unit:GetMainTank()) 
end

function HulkingAtrocity_OnLeaveCombat(Unit, Event) 
Unit:RemoveEvents() 
end

function HulkingAtrocity_OnDied(Unit, Event) 
Unit:RemoveEvents()
end

function HulkingAtrocity_OnKilledTarget(Unit, Event) 
end

RegisterUnitEvent(26948, 1, "HulkingAtrocity_OnCombat")
RegisterUnitEvent(26948, 2, "HulkingAtrocity_OnLeaveCombat")
RegisterUnitEvent(26948, 3, "HulkingAtrocity_OnKilledTarget")
RegisterUnitEvent(26948, 4, "HulkingAtrocity_OnDied")