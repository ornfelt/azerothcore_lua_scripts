--[[

	This is created by zdroid9770  :D

	© Copyright 2012

]]


function NecrolordAmarion_OnCombat(Unit, Event)
Unit:RegisterEvent("NecrolordAmarion_Decimate", 5500, 0)
end

function NecrolordAmarion_Decimate(Unit, Event) 
Unit:FullCastSpellOnTarget(51339, Unit:GetMainTank()) 
end

function NecrolordAmarion_OnLeaveCombat(Unit, Event) 
Unit:RemoveEvents() 
end

function NecrolordAmarion_OnDied(Unit, Event) 
Unit:RemoveEvents()
end

function NecrolordAmarion_OnKilledTarget(Unit, Event) 
end

RegisterUnitEvent(27508, 1, "NecrolordAmarion_OnCombat")
RegisterUnitEvent(27508, 2, "NecrolordAmarion_OnLeaveCombat")
RegisterUnitEvent(27508, 3, "NecrolordAmarion_OnKilledTarget")
RegisterUnitEvent(27508, 4, "NecrolordAmarion_OnDied")