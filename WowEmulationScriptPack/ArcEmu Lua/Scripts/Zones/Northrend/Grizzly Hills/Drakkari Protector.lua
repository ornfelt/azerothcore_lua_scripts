--[[

	This is created by zdroid9770  :D

	© Copyright 2012

]]


function DrakkariProtector_OnCombat(Unit, Event)
Unit:RegisterEvent("DrakkariProtector_HeadTrauma", 7000, 0)
end

function DrakkariProtector_HeadTrauma(Unit, Event) 
Unit:FullCastSpellOnTarget(52425, Unit:GetMainTank()) 
end

function DrakkariProtector_OnLeaveCombat(Unit, Event) 
Unit:RemoveEvents() 
end

function DrakkariProtector_OnDied(Unit, Event) 
Unit:RemoveEvents()
end

function DrakkariProtector_OnKilledTarget(Unit, Event) 
end

RegisterUnitEvent(26797, 1, "DrakkariProtector_OnCombat")
RegisterUnitEvent(26797, 2, "DrakkariProtector_OnLeaveCombat")
RegisterUnitEvent(26797, 3, "DrakkariProtector_OnKilledTarget")
RegisterUnitEvent(26797, 4, "DrakkariProtector_OnDied")