--[[

	This is created by zdroid9770  :D

	© Copyright 2012

]]


function VentureCoStraggler_OnCombat(Unit, Event)
Unit:RegisterEvent("VentureCoStraggler_Chop", 5000, 0)
end

function VentureCoStraggler_Chop(Unit, Event) 
Unit:FullCastSpellOnTarget(43410, Unit:GetMainTank()) 
end

function VentureCoStraggler_OnLeaveCombat(Unit, Event) 
Unit:RemoveEvents() 
end

function VentureCoStraggler_OnDied(Unit, Event) 
Unit:RemoveEvents()
end

function VentureCoStraggler_OnKilledTarget(Unit, Event) 
end

RegisterUnitEvent(27570, 1, "VentureCoStraggler_OnCombat")
RegisterUnitEvent(27570, 2, "VentureCoStraggler_OnLeaveCombat")
RegisterUnitEvent(27570, 3, "VentureCoStraggler_OnKilledTarget")
RegisterUnitEvent(27570, 4, "VentureCoStraggler_OnDied")