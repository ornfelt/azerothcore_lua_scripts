--[[

	This is created by zdroid9770  :D

	© Copyright 2012

]]


function ReconstructedFrostWyrm_OnCombat(Unit, Event)
Unit:RegisterEvent("ReconstructedFrostWyrm_FrostBreath", 6500, 0)
end

function ReconstructedFrostWyrm_FrostBreath(Unit, Event) 
Unit:FullCastSpellOnTarget(47425, Unit:GetMainTank()) 
end

function ReconstructedFrostWyrm_OnLeaveCombat(Unit, Event) 
Unit:RemoveEvents() 
end

function ReconstructedFrostWyrm_OnDied(Unit, Event) 
Unit:RemoveEvents()
end

function ReconstructedFrostWyrm_OnKilledTarget(Unit, Event) 
end

RegisterUnitEvent(27285, 1, "ReconstructedFrostWyrm_OnCombat")
RegisterUnitEvent(27285, 2, "ReconstructedFrostWyrm_OnLeaveCombat")
RegisterUnitEvent(27285, 3, "ReconstructedFrostWyrm_OnKilledTarget")
RegisterUnitEvent(27285, 4, "ReconstructedFrostWyrm_OnDied")