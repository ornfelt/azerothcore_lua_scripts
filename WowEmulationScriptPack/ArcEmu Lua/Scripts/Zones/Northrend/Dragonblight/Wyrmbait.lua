--[[

	This is created by zdroid9770  :D

	© Copyright 2012

]]


function Wyrmbait_OnCombat(Unit, Event)
Unit:RegisterEvent("Wyrmbait_Shoot", 6000, 0)
end

function Wyrmbait_Shoot(Unit, Event) 
Unit:FullCastSpellOnTarget(15620, Unit:GetMainTank()) 
end

function Wyrmbait_OnLeaveCombat(Unit, Event) 
Unit:RemoveEvents() 
end

function Wyrmbait_OnDied(Unit, Event) 
Unit:RemoveEvents()
end

function Wyrmbait_OnKilledTarget(Unit, Event) 
end

RegisterUnitEvent(27843, 1, "Wyrmbait_OnCombat")
RegisterUnitEvent(27843, 2, "Wyrmbait_OnLeaveCombat")
RegisterUnitEvent(27843, 3, "Wyrmbait_OnKilledTarget")
RegisterUnitEvent(27843, 4, "Wyrmbait_OnDied")