--[[

	This is created by zdroid9770  :D

	© Copyright 2012

]]


function PlagueEruptor_OnCombat(Unit, Event)
Unit:RegisterEvent("PlagueEruptor_PlagueCloud", 10000, 0)
end

function PlagueEruptor_PlagueCloud(Unit, Event) 
Unit:FullCastSpellOnTarget(49350, Unit:GetMainTank()) 
end

function PlagueEruptor_OnLeaveCombat(Unit, Event) 
Unit:RemoveEvents() 
end

function PlagueEruptor_OnDied(Unit, Event) 
Unit:RemoveEvents()
end

function PlagueEruptor_OnKilledTarget(Unit, Event) 
end

RegisterUnitEvent(27611, 1, "PlagueEruptor_OnCombat")
RegisterUnitEvent(27611, 2, "PlagueEruptor_OnLeaveCombat")
RegisterUnitEvent(27611, 3, "PlagueEruptor_OnKilledTarget")
RegisterUnitEvent(27611, 4, "PlagueEruptor_OnDied")