--[[

	This is created by zdroid9770  :D

	© Copyright 2012

]]


function thLegionRifleman_OnCombat(Unit, Event)
Unit:RegisterEvent("thLegionRifleman_Net", 8000, 0)
Unit:RegisterEvent("thLegionRifleman_Shoot", 6000, 0)
end

function thLegionRifleman_Net(Unit, Event) 
Unit:FullCastSpellOnTarget(6533, Unit:GetMainTank()) 
end

function thLegionRifleman_Shoot(Unit, Event) 
Unit:FullCastSpellOnTarget(50092, Unit:GetMainTank()) 
end

function thLegionRifleman_OnLeaveCombat(Unit, Event) 
Unit:RemoveEvents() 
end

function thLegionRifleman_OnDied(Unit, Event) 
Unit:RemoveEvents()
end

function thLegionRifleman_OnKilledTarget(Unit, Event) 
end

RegisterUnitEvent(27791, 1, "thLegionRifleman_OnCombat")
RegisterUnitEvent(27791, 2, "thLegionRifleman_OnLeaveCombat")
RegisterUnitEvent(27791, 3, "thLegionRifleman_OnKilledTarget")
RegisterUnitEvent(27791, 4, "thLegionRifleman_OnDied")