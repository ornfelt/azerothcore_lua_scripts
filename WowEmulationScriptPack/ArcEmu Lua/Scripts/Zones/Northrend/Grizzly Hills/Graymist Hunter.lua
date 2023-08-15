--[[

	This is created by zdroid9770  :D

	© Copyright 2012

]]


function GraymistHunter_OnCombat(Unit, Event)
Unit:RegisterEvent("GraymistHunter_Gore", 10000, 0)
end

function GraymistHunter_Gore(Unit, Event) 
Unit:FullCastSpellOnTarget(32019, Unit:GetMainTank()) 
end

function GraymistHunter_OnLeaveCombat(Unit, Event) 
Unit:RemoveEvents() 
end

function GraymistHunter_OnDied(Unit, Event) 
Unit:RemoveEvents()
end

function GraymistHunter_OnKilledTarget(Unit, Event) 
end

RegisterUnitEvent(26592, 1, "GraymistHunter_OnCombat")
RegisterUnitEvent(26592, 2, "GraymistHunter_OnLeaveCombat")
RegisterUnitEvent(26592, 3, "GraymistHunter_OnKilledTarget")
RegisterUnitEvent(26592, 4, "GraymistHunter_OnDied")