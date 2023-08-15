--[[

	This is created by zdroid9770  :D

	© Copyright 2012

]]


function SunreaverScout_OnCombat(Unit, Event)
Unit:RegisterEvent("SunreaverScout_MultiShot", 8000, 0)
Unit:RegisterEvent("SunreaverScout_Shoot", 6000, 0)
end

function SunreaverScout_MultiShot(Unit, Event) 
Unit:FullCastSpellOnTarget(14443, Unit:GetMainTank()) 
end

function SunreaverScout_Shoot(Unit, Event) 
Unit:FullCastSpellOnTarget(6660, Unit:GetMainTank()) 
end

function SunreaverScout_OnLeaveCombat(Unit, Event) 
Unit:RemoveEvents() 
end

function SunreaverScout_OnDied(Unit, Event) 
Unit:RemoveEvents()
end

function SunreaverScout_OnKilledTarget(Unit, Event) 
end

RegisterUnitEvent(30233, 1, "SunreaverScout_OnCombat")
RegisterUnitEvent(30233, 2, "SunreaverScout_OnLeaveCombat")
RegisterUnitEvent(30233, 3, "SunreaverScout_OnKilledTarget")
RegisterUnitEvent(30233, 4, "SunreaverScout_OnDied")