--[[

	This is created by zdroid9770  :D

	© Copyright 2012

]]


function FrigidGhoulAttacker_OnCombat(Unit, Event)
Unit:RegisterEvent("FrigidGhoulAttacker_RotArmor", 8000, 0)
end

function FrigidGhoulAttacker_RotArmor(Unit, Event) 
Unit:FullCastSpellOnTarget(50361, Unit:GetMainTank()) 
end

function FrigidGhoulAttacker_OnLeaveCombat(Unit, Event) 
Unit:RemoveEvents() 
end

function FrigidGhoulAttacker_OnDied(Unit, Event) 
Unit:RemoveEvents()
end

function FrigidGhoulAttacker_OnKilledTarget(Unit, Event) 
end

RegisterUnitEvent(27685, 1, "FrigidGhoulAttacker_OnCombat")
RegisterUnitEvent(27685, 2, "FrigidGhoulAttacker_OnLeaveCombat")
RegisterUnitEvent(27685, 3, "FrigidGhoulAttacker_OnKilledTarget")
RegisterUnitEvent(27685, 4, "FrigidGhoulAttacker_OnDied")