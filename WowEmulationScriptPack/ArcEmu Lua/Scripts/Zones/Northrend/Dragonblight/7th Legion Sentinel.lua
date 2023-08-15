--[[

	This is created by zdroid9770  :D

	© Copyright 2012

]]


function thLegionSentinel_OnCombat(Unit, Event)
Unit:RegisterEvent("thLegionSentinel_GlaiveThrow", 8000, 0)
Unit:RegisterEvent("thLegionSentinel_Shoot", 6000, 0)
Unit:RegisterEvent("thLegionSentinel_ShootMagicArrow", 7000, 0)
end

function thLegionSentinel_GlaiveThrow(Unit, Event) 
Unit:FullCastSpellOnTarget(49481, Unit:GetMainTank()) 
end

function thLegionSentinel_Shoot(Unit, Event) 
Unit:FullCastSpellOnTarget(15547, Unit:GetMainTank()) 
end

function thLegionSentinel_ShootMagicArrow(Unit, Event) 
Unit:FullCastSpellOnTarget(48530, Unit:GetMainTank()) 
end

function thLegionSentinel_OnLeaveCombat(Unit, Event) 
Unit:RemoveEvents() 
end

function thLegionSentinel_OnDied(Unit, Event) 
Unit:RemoveEvents()
end

function thLegionSentinel_OnKilledTarget(Unit, Event) 
end

RegisterUnitEvent(27162, 1, "thLegionSentinel_OnCombat")
RegisterUnitEvent(27162, 2, "thLegionSentinel_OnLeaveCombat")
RegisterUnitEvent(27162, 3, "thLegionSentinel_OnKilledTarget")
RegisterUnitEvent(27162, 4, "thLegionSentinel_OnDied")