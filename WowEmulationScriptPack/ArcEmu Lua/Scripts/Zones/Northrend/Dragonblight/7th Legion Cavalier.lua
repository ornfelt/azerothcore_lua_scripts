--[[

	This is created by zdroid9770  :D

	© Copyright 2012

]]

function thLegionCavalier_OnCombat(Unit, Event)
Unit:RegisterEvent("thLegionCavalier_MortalStrike", 8000, 0)
Unit:RegisterEvent("thLegionCavalier_SnapKick", 6000, 0)
end

function thLegionCavalier_MortalStrike(Unit, Event) 
Unit:FullCastSpellOnTarget(19643, Unit:GetMainTank()) 
end

function thLegionCavalier_SnapKick(Unit, Event) 
Unit:FullCastSpellOnTarget(15618, Unit:GetMainTank()) 
end

function thLegionCavalier_OnLeaveCombat(Unit, Event) 
Unit:RemoveEvents() 
end

function thLegionCavalier_OnDied(Unit, Event) 
Unit:RemoveEvents()
end

function thLegionCavalier_OnKilledTarget(Unit, Event) 
end

RegisterUnitEvent(27161, 1, "thLegionCavalier_OnCombat")
RegisterUnitEvent(27161, 2, "thLegionCavalier_OnLeaveCombat")
RegisterUnitEvent(27161, 3, "thLegionCavalier_OnKilledTarget")
RegisterUnitEvent(27161, 4, "thLegionCavalier_OnDied")