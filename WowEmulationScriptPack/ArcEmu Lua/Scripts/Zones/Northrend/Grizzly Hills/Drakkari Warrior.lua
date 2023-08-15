--[[

	This is created by zdroid9770  :D

	© Copyright 2012

]]


function DrakkariWarrior_OnCombat(Unit, Event)
Unit:RegisterEvent("DrakkariWarrior_WarriorsWill", 4000, 1)
end

function DrakkariWarrior_WarriorsWill(Unit, Event) 
Unit:CastSpell(52309) 
end

function DrakkariWarrior_OnLeaveCombat(Unit, Event) 
Unit:RemoveEvents() 
end

function DrakkariWarrior_OnDied(Unit, Event) 
Unit:RemoveEvents()
end

function DrakkariWarrior_OnKilledTarget(Unit, Event) 
end

RegisterUnitEvent(26425, 1, "DrakkariWarrior_OnCombat")
RegisterUnitEvent(26425, 2, "DrakkariWarrior_OnLeaveCombat")
RegisterUnitEvent(26425, 3, "DrakkariWarrior_OnKilledTarget")
RegisterUnitEvent(26425, 4, "DrakkariWarrior_OnDied")