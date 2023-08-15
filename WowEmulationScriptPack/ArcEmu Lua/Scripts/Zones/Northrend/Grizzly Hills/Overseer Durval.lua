--[[

	This is created by zdroid9770  :D

	© Copyright 2012

]]


function OverseerDurval_OnCombat(Unit, Event)
Unit:RegisterEvent("OverseerDurval_RuneofDestruction", 8000, 0)
end

function OverseerDurval_RuneofDestruction(Unit, Event) 
Unit:FullCastSpellOnTarget(52715, Unit:GetMainTank()) 
end

function OverseerDurval_OnLeaveCombat(Unit, Event) 
Unit:RemoveEvents() 
end

function OverseerDurval_OnDied(Unit, Event) 
Unit:RemoveEvents()
end

function OverseerDurval_OnKilledTarget(Unit, Event) 
end

RegisterUnitEvent(26920, 1, "OverseerDurval_OnCombat")
RegisterUnitEvent(26920, 2, "OverseerDurval_OnLeaveCombat")
RegisterUnitEvent(26920, 3, "OverseerDurval_OnKilledTarget")
RegisterUnitEvent(26920, 4, "OverseerDurval_OnDied")