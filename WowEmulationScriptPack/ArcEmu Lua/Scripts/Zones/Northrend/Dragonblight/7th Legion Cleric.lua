--[[

	This is created by zdroid9770  :D

	© Copyright 2012

]]


function thLegionCleric_OnCombat(Unit, Event)
Unit:RegisterEvent("thLegionCleric_Heal", 14000, 0)
Unit:RegisterEvent("thLegionCleric_HolySmite", 6000, 0)
end

function thLegionCleric_Heal(Unit, Event) 
Unit:CastSpell(31739) 
end

function thLegionCleric_HolySmite(Unit, Event) 
Unit:FullCastSpellOnTarget(25054, Unit:GetMainTank()) 
end

function thLegionCleric_OnLeaveCombat(Unit, Event) 
Unit:RemoveEvents() 
end

function thLegionCleric_OnDied(Unit, Event) 
Unit:RemoveEvents()
end

function thLegionCleric_OnKilledTarget(Unit, Event) 
end

RegisterUnitEvent(26780, 1, "thLegionCleric_OnCombat")
RegisterUnitEvent(26780, 2, "thLegionCleric_OnLeaveCombat")
RegisterUnitEvent(26780, 3, "thLegionCleric_OnKilledTarget")
RegisterUnitEvent(26780, 4, "thLegionCleric_OnDied")