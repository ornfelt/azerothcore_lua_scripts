--[[

	This is created by zdroid9770  :D

	© Copyright 2012

]]


function DeathbringerRevenant_OnCombat(Unit, Event)
Unit:RegisterEvent("DeathbringerRevenant_Strangulate", 8000, 0)
end

function DeathbringerRevenant_Strangulate(Unit, Event) 
Unit:FullCastSpellOnTarget(51131, Unit:GetMainTank()) 
end

function DeathbringerRevenant_OnLeaveCombat(Unit, Event) 
Unit:RemoveEvents() 
end

function DeathbringerRevenant_OnDied(Unit, Event) 
Unit:RemoveEvents()
end

function DeathbringerRevenant_OnKilledTarget(Unit, Event) 
end

RegisterUnitEvent(27382, 1, "DeathbringerRevenant_OnCombat")
RegisterUnitEvent(27382, 2, "DeathbringerRevenant_OnLeaveCombat")
RegisterUnitEvent(27382, 3, "DeathbringerRevenant_OnKilledTarget")
RegisterUnitEvent(27382, 4, "DeathbringerRevenant_OnDied")