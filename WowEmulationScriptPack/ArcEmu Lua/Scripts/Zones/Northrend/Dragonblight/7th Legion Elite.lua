--[[

	This is created by zdroid9770  :D

	© Copyright 2012

]]


function thLegionElite_OnCombat(Unit, Event)
Unit:RegisterEvent("thLegionElite_Net", 8000, 0)
Unit:RegisterEvent("thLegionElite_Shoot", 6000, 0)
end

function thLegionElite_Net(Unit, Event) 
Unit:FullCastSpellOnTarget(6533, Unit:GetMainTank()) 
end

function thLegionElite_Shoot(Unit, Event) 
Unit:FullCastSpellOnTarget(50092, Unit:GetMainTank()) 
end

function thLegionElite_OnLeaveCombat(Unit, Event) 
Unit:RemoveEvents() 
end

function thLegionElite_OnDied(Unit, Event) 
Unit:RemoveEvents()
end

function thLegionElite_OnKilledTarget(Unit, Event) 
end

RegisterUnitEvent(27588, 1, "thLegionElite_OnCombat")
RegisterUnitEvent(27588, 2, "thLegionElite_OnLeaveCombat")
RegisterUnitEvent(27588, 3, "thLegionElite_OnKilledTarget")
RegisterUnitEvent(27588, 4, "thLegionElite_OnDied")