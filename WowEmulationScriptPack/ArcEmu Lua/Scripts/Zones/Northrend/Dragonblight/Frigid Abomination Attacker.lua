--[[

	This is created by zdroid9770  :D

	© Copyright 2012

]]


function FrigidAbominationAttacker_OnCombat(Unit, Event)
Unit:RegisterEvent("FrigidAbominationAttacker_Cleave", 8000, 0)
end

function FrigidAbominationAttacker_Cleave(Unit, Event) 
Unit:CastSpell(40504) 
end

function FrigidAbominationAttacker_OnLeaveCombat(Unit, Event) 
Unit:RemoveEvents() 
end

function FrigidAbominationAttacker_OnDied(Unit, Event) 
Unit:RemoveEvents()
end

function FrigidAbominationAttacker_OnKilledTarget(Unit, Event) 
end

RegisterUnitEvent(27531, 1, "FrigidAbominationAttacker_OnCombat")
RegisterUnitEvent(27531, 2, "FrigidAbominationAttacker_OnLeaveCombat")
RegisterUnitEvent(27531, 3, "FrigidAbominationAttacker_OnKilledTarget")
RegisterUnitEvent(27531, 4, "FrigidAbominationAttacker_OnDied")