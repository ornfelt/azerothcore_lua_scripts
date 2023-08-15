--[[

	This is created by zdroid9770  :D

	© Copyright 2012

]]


function UnlivingSwine_OnCombat(Unit, Event)
Unit:RegisterEvent("UnlivingSwine_SwineFlu", 8000, 0)
end

function UnlivingSwine_SwineFlu(Unit, Event) 
Unit:FullCastSpellOnTarget(50303, Unit:GetMainTank()) 
end

function UnlivingSwine_OnLeaveCombat(Unit, Event) 
Unit:RemoveEvents() 
end

function UnlivingSwine_OnDied(Unit, Event) 
Unit:RemoveEvents()
end

function UnlivingSwine_OnKilledTarget(Unit, Event) 
end

RegisterUnitEvent(25600, 1, "UnlivingSwine_OnCombat")
RegisterUnitEvent(25600, 2, "UnlivingSwine_OnLeaveCombat")
RegisterUnitEvent(25600, 3, "UnlivingSwine_OnKilledTarget")
RegisterUnitEvent(25600, 4, "UnlivingSwine_OnDied")