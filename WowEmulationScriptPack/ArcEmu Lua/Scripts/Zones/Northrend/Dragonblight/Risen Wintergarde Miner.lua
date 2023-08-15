--[[

	This is created by zdroid9770  :D

	© Copyright 2012

]]


function RisenWintergardeMiner_OnCombat(Unit, Event)
Unit:RegisterEvent("RisenWintergardeMiner_PunctureWound", 7000, 0)
end

function RisenWintergardeMiner_PunctureWound(Unit, Event) 
Unit:FullCastSpellOnTarget(48374, Unit:GetMainTank()) 
end

function RisenWintergardeMiner_OnLeaveCombat(Unit, Event) 
Unit:RemoveEvents() 
end

function RisenWintergardeMiner_OnDied(Unit, Event) 
Unit:RemoveEvents()
end

function RisenWintergardeMiner_OnKilledTarget(Unit, Event) 
end

RegisterUnitEvent(27401, 1, "RisenWintergardeMiner_OnCombat")
RegisterUnitEvent(27401, 2, "RisenWintergardeMiner_OnLeaveCombat")
RegisterUnitEvent(27401, 3, "RisenWintergardeMiner_OnKilledTarget")
RegisterUnitEvent(27401, 4, "RisenWintergardeMiner_OnDied")