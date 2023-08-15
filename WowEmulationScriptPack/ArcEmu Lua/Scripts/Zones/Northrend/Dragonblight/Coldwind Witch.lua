--[[

	This is created by zdroid9770  :D

	© Copyright 2012

]]


function ColdwindWitch_OnCombat(Unit, Event)
Unit:RegisterEvent("ColdwindWitch_ColdwindBlast", 7000, 0)
end

function ColdwindWitch_ColdwindBlast(Unit, Event) 
Unit:FullCastSpellOnTarget(51877, Unit:GetMainTank()) 
end

function ColdwindWitch_OnLeaveCombat(Unit, Event) 
Unit:RemoveEvents() 
end

function ColdwindWitch_OnDied(Unit, Event) 
Unit:RemoveEvents()
end

function ColdwindWitch_OnKilledTarget(Unit, Event) 
end

RegisterUnitEvent(26577, 1, "ColdwindWitch_OnCombat")
RegisterUnitEvent(26577, 2, "ColdwindWitch_OnLeaveCombat")
RegisterUnitEvent(26577, 3, "ColdwindWitch_OnKilledTarget")
RegisterUnitEvent(26577, 4, "ColdwindWitch_OnDied")