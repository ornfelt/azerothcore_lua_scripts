--[[

	This is created by zdroid9770  :D

	© Copyright 2012

]]


function MarshCaribou_OnCombat(Unit, Event)
Unit:RegisterEvent("MarshCaribou_Gore", 8000, 0)
end

function MarshCaribou_Gore(Unit, Event) 
Unit:FullCastSpellOnTarget(32019, Unit:GetMainTank()) 
end

function MarshCaribou_OnLeaveCombat(Unit, Event) 
Unit:RemoveEvents() 
end

function MarshCaribou_OnDied(Unit, Event) 
Unit:RemoveEvents()
end

function MarshCaribou_OnKilledTarget(Unit, Event) 
end

RegisterUnitEvent(25680, 1, "MarshCaribou_OnCombat")
RegisterUnitEvent(25680, 2, "MarshCaribou_OnLeaveCombat")
RegisterUnitEvent(25680, 3, "MarshCaribou_OnKilledTarget")
RegisterUnitEvent(25680, 4, "MarshCaribou_OnDied")