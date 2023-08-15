--[[

	This is created by zdroid9770  :D

	© Copyright 2012

]]

function thLegionElitetwo_OnCombat(Unit, Event)
Unit:RegisterEvent("thLegionElitetwo_Net", 8000, 0)
Unit:RegisterEvent("thLegionElitetwo_Shoot", 6000, 0)
end

function thLegionElitetwo_Net(Unit, Event) 
Unit:FullCastSpellOnTarget(6533, Unit:GetMainTank()) 
end

function thLegionElitetwo_Shoot(Unit, Event) 
Unit:FullCastSpellOnTarget(50092, Unit:GetMainTank()) 
end

function thLegionElitetwo_OnLeaveCombat(Unit, Event) 
Unit:RemoveEvents() 
end

function thLegionElitetwo_OnDied(Unit, Event) 
Unit:RemoveEvents()
end

function thLegionElitetwo_OnKilledTarget(Unit, Event) 
end

RegisterUnitEvent(27713, 1, "thLegionElitetwo_OnCombat")
RegisterUnitEvent(27713, 2, "thLegionElitetwo_OnLeaveCombat")
RegisterUnitEvent(27713, 3, "thLegionElitetwo_OnKilledTarget")
RegisterUnitEvent(27713, 4, "thLegionElitetwo_OnDied")