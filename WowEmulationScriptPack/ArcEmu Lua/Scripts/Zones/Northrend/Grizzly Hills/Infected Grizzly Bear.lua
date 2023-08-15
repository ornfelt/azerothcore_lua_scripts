--[[

	This is created by zdroid9770  :D

	© Copyright 2012

]]


function InfectedGrizzlyBear_OnCombat(Unit, Event)
Unit:RegisterEvent("InfectedGrizzlyBear_InfectedBite", 8000, 0)
end

function InfectedGrizzlyBear_InfectedBite(Unit, Event) 
Unit:FullCastSpellOnTarget(49861, Unit:GetMainTank()) 
end

function InfectedGrizzlyBear_OnLeaveCombat(Unit, Event) 
Unit:RemoveEvents() 
end

function InfectedGrizzlyBear_OnDied(Unit, Event) 
Unit:RemoveEvents()
end

function InfectedGrizzlyBear_OnKilledTarget(Unit, Event) 
end

RegisterUnitEvent(26706, 1, "InfectedGrizzlyBear_OnCombat")
RegisterUnitEvent(26706, 2, "InfectedGrizzlyBear_OnLeaveCombat")
RegisterUnitEvent(26706, 3, "InfectedGrizzlyBear_OnKilledTarget")
RegisterUnitEvent(26706, 4, "InfectedGrizzlyBear_OnDied")