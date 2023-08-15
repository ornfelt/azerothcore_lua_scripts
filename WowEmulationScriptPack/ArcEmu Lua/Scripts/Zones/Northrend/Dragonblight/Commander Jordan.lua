--[[

	This is created by zdroid9770  :D

	© Copyright 2012

]]


function CommanderJordan_OnCombat(Unit, Event)
Unit:RegisterEvent("CommanderJordan_AvengingWrath", 6000, 1)
Unit:RegisterEvent("CommanderJordan_Consecration", 7000, 0)
end

function CommanderJordan_AvengingWrath(Unit, Event) 
Unit:CastSpell(50837) 
end

function CommanderJordan_Consecration(Unit, Event) 
Unit:CastSpell(32773) 
end

function CommanderJordan_OnLeaveCombat(Unit, Event) 
Unit:RemoveEvents() 
end

function CommanderJordan_OnDied(Unit, Event) 
Unit:RemoveEvents()
end

function CommanderJordan_OnKilledTarget(Unit, Event) 
end

RegisterUnitEvent(27237, 1, "CommanderJordan_OnCombat")
RegisterUnitEvent(27237, 2, "CommanderJordan_OnLeaveCombat")
RegisterUnitEvent(27237, 3, "CommanderJordan_OnKilledTarget")
RegisterUnitEvent(27237, 4, "CommanderJordan_OnDied")