--[[

	This is created by zdroid9770  :D

	© Copyright 2012

]]


function NedarLordofRhinos_OnCombat(Unit, Event)
Unit:RegisterEvent("NedarLordofRhinos_Shoot", 6000, 0)
end

function NedarLordofRhinos_Shoot(Unit, Event) 
Unit:FullCastSpellOnTarget(41440, Unit:GetMainTank()) 
end

function NedarLordofRhinos_OnLeaveCombat(Unit, Event) 
Unit:RemoveEvents() 
end

function NedarLordofRhinos_OnDied(Unit, Event) 
Unit:RemoveEvents()
end

function NedarLordofRhinos_OnKilledTarget(Unit, Event) 
end

RegisterUnitEvent(25801, 1, "NedarLordofRhinos_OnCombat")
RegisterUnitEvent(25801, 2, "NedarLordofRhinos_OnLeaveCombat")
RegisterUnitEvent(25801, 3, "NedarLordofRhinos_OnKilledTarget")
RegisterUnitEvent(25801, 4, "NedarLordofRhinos_OnDied")