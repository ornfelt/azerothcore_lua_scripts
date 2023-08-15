--[[

	This is created by zdroid9770  :D

	© Copyright 2012

]]


function FrigidGhoul_OnCombat(Unit, Event)
Unit:RegisterEvent("FrigidGhoul_RotArmor", 8000, 0)
end

function FrigidGhoul_RotArmor(Unit, Event) 
Unit:FullCastSpellOnTarget(50361, Unit:GetMainTank()) 
end

function FrigidGhoul_OnLeaveCombat(Unit, Event) 
Unit:RemoveEvents() 
end

function FrigidGhoul_OnDied(Unit, Event) 
Unit:RemoveEvents()
end

function FrigidGhoul_OnKilledTarget(Unit, Event) 
end

RegisterUnitEvent(27534, 1, "FrigidGhoul_OnCombat")
RegisterUnitEvent(27534, 2, "FrigidGhoul_OnLeaveCombat")
RegisterUnitEvent(27534, 3, "FrigidGhoul_OnKilledTarget")
RegisterUnitEvent(27534, 4, "FrigidGhoul_OnDied")