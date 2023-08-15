--[[

	This is created by zdroid9770  :D

	© Copyright 2012

]]


function thLegionWyrmHunter_OnCombat(Unit, Event)
Unit:RegisterEvent("thLegionWyrmHunter_Shoot", 6000, 0)
end

function thLegionWyrmHunter_Shoot(Unit, Event) 
Unit:FullCastSpellOnTarget(15620, Unit:GetMainTank()) 
end

function thLegionWyrmHunter_OnLeaveCombat(Unit, Event) 
Unit:RemoveEvents() 
end

function thLegionWyrmHunter_OnDied(Unit, Event) 
Unit:RemoveEvents()
end

function thLegionWyrmHunter_OnKilledTarget(Unit, Event) 
end

RegisterUnitEvent(26779, 1, "thLegionWyrmHunter_OnCombat")
RegisterUnitEvent(26779, 2, "thLegionWyrmHunter_OnLeaveCombat")
RegisterUnitEvent(26779, 3, "thLegionWyrmHunter_OnKilledTarget")
RegisterUnitEvent(26779, 4, "thLegionWyrmHunter_OnDied")