--[[

	This is created by zdroid9770  :D

	© Copyright 2012

]]


function UnboundDryad_OnCombat(Unit, Event)
Unit:RegisterEvent("UnboundDryad_ThrowSpear", 6000, 0)
end

function UnboundDryad_ThrowSpear(Unit, Event) 
Unit:FullCastSpellOnTarget(55217, Unit:GetMainTank()) 
end

function UnboundDryad_OnLeaveCombat(Unit, Event) 
Unit:RemoveEvents() 
end

function UnboundDryad_OnDied(Unit, Event) 
Unit:RemoveEvents()
end

function UnboundDryad_OnKilledTarget(Unit, Event) 
end

RegisterUnitEvent(30860, 1, "UnboundDryad_OnCombat")
RegisterUnitEvent(30860, 2, "UnboundDryad_OnLeaveCombat")
RegisterUnitEvent(30860, 3, "UnboundDryad_OnKilledTarget")
RegisterUnitEvent(30860, 4, "UnboundDryad_OnDied")