--[[

	This is created by zdroid9770  :D

	© Copyright 2012

]]


function DrakkariDefender_OnCombat(Unit, Event)
Unit:RegisterEvent("DrakkariDefender_Cleave", 8000, 0)
end

function DrakkariDefender_Cleave(Unit, Event) 
Unit:CastSpell(15496) 
end

function DrakkariDefender_OnLeaveCombat(Unit, Event) 
Unit:RemoveEvents() 
end

function DrakkariDefender_OnDied(Unit, Event) 
Unit:RemoveEvents()
end

function DrakkariDefender_OnKilledTarget(Unit, Event) 
end

RegisterUnitEvent(26704, 1, "DrakkariDefender_OnCombat")
RegisterUnitEvent(26704, 2, "DrakkariDefender_OnLeaveCombat")
RegisterUnitEvent(26704, 3, "DrakkariDefender_OnKilledTarget")
RegisterUnitEvent(26704, 4, "DrakkariDefender_OnDied")