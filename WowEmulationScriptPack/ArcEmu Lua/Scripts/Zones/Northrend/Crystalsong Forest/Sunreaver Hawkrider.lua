--[[

	This is created by zdroid9770  :D

	© Copyright 2012

]]


function SunreaverHawkrider_OnCombat(Unit, Event)
Unit:RegisterEvent("SunreaverHawkrider_Shoot", 6000, 0)
end

function SunreaverHawkrider_Shoot(Unit, Event) 
Unit:FullCastSpellOnTarget(6660, Unit:GetMainTank()) 
end

function SunreaverHawkrider_OnLeaveCombat(Unit, Event) 
Unit:RemoveEvents() 
end

function SunreaverHawkrider_OnDied(Unit, Event) 
Unit:RemoveEvents()
end

function SunreaverHawkrider_OnKilledTarget(Unit, Event) 
end

RegisterUnitEvent(30265, 1, "SunreaverHawkrider_OnCombat")
RegisterUnitEvent(30265, 2, "SunreaverHawkrider_OnLeaveCombat")
RegisterUnitEvent(30265, 3, "SunreaverHawkrider_OnKilledTarget")
RegisterUnitEvent(30265, 4, "SunreaverHawkrider_OnDied")