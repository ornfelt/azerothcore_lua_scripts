--[[

	This is created by zdroid9770  :D

	© Copyright 2012

]]


function ReanimatedFrostWyrm_OnCombat(Unit, Event)
Unit:RegisterEvent("ReanimatedFrostWyrm_FrostBreath", 6500, 0)
end

function ReanimatedFrostWyrm_FrostBreath(Unit, Event) 
Unit:FullCastSpellOnTarget(47425, Unit:GetMainTank()) 
end

function ReanimatedFrostWyrm_OnLeaveCombat(Unit, Event) 
Unit:RemoveEvents() 
end

function ReanimatedFrostWyrm_OnDied(Unit, Event) 
Unit:RemoveEvents()
end

function ReanimatedFrostWyrm_OnKilledTarget(Unit, Event) 
end

RegisterUnitEvent(26841, 1, "ReanimatedFrostWyrm_OnCombat")
RegisterUnitEvent(26841, 2, "ReanimatedFrostWyrm_OnLeaveCombat")
RegisterUnitEvent(26841, 3, "ReanimatedFrostWyrm_OnKilledTarget")
RegisterUnitEvent(26841, 4, "ReanimatedFrostWyrm_OnDied")