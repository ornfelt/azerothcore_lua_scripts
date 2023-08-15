--[[

	This is created by zdroid9770  :D

	© Copyright 2012

]]

function Grizzlesnout_OnCombat(Unit, Event)
Unit:RegisterEvent("Grizzlesnout_GnawBone", 8000, 0)
end

function Grizzlesnout_GnawBone(Unit, Event) 
Unit:FullCastSpellOnTarget(50046, Unit:GetMainTank()) 
end

function Grizzlesnout_OnLeaveCombat(Unit, Event) 
Unit:RemoveEvents() 
end

function Grizzlesnout_OnDied(Unit, Event) 
Unit:RemoveEvents()
end

function Grizzlesnout_OnKilledTarget(Unit, Event) 
end

RegisterUnitEvent(27523, 1, "Grizzlesnout_OnCombat")
RegisterUnitEvent(27523, 2, "Grizzlesnout_OnLeaveCombat")
RegisterUnitEvent(27523, 3, "Grizzlesnout_OnKilledTarget")
RegisterUnitEvent(27523, 4, "Grizzlesnout_OnDied")