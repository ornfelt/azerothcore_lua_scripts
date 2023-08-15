--[[

	This is created by zdroid9770  :D

	© Copyright 2012

]]


function VentureCoEvacuee_OnCombat(Unit, Event)
Unit:RegisterEvent("VentureCoEvacuee_QuickFeet", 5000, 0)
end

function VentureCoEvacuee_QuickFeet(Unit, Event) 
Unit:CastSpell(50054) 
end

function VentureCoEvacuee_OnLeaveCombat(Unit, Event) 
Unit:RemoveEvents() 
end

function VentureCoEvacuee_OnDied(Unit, Event) 
Unit:RemoveEvents()
end

function VentureCoEvacuee_OnKilledTarget(Unit, Event) 
end

RegisterUnitEvent(27830, 1, "VentureCoEvacuee_OnCombat")
RegisterUnitEvent(27830, 2, "VentureCoEvacuee_OnLeaveCombat")
RegisterUnitEvent(27830, 3, "VentureCoEvacuee_OnKilledTarget")
RegisterUnitEvent(27830, 4, "VentureCoEvacuee_OnDied")