--[[

	This is created by zdroid9770  :D

	© Copyright 2012

]]


function RabidGrizzly_OnCombat(Unit, Event)
Unit:RegisterEvent("RabidGrizzly_Rabies", 8000, 0)
end

function RabidGrizzly_Rabies(Unit, Event) 
Unit:FullCastSpellOnTarget(51951, Unit:GetMainTank()) 
end

function RabidGrizzly_OnLeaveCombat(Unit, Event) 
Unit:RemoveEvents() 
end

function RabidGrizzly_OnDied(Unit, Event) 
Unit:RemoveEvents()
end

function RabidGrizzly_OnKilledTarget(Unit, Event) 
end

RegisterUnitEvent(26643, 1, "RabidGrizzly_OnCombat")
RegisterUnitEvent(26643, 2, "RabidGrizzly_OnLeaveCombat")
RegisterUnitEvent(26643, 3, "RabidGrizzly_OnKilledTarget")
RegisterUnitEvent(26643, 4, "RabidGrizzly_OnDied")