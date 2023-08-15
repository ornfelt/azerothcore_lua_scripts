--[[

	This is created by zdroid9770  :D

	© Copyright 2012

]]


function DarkspearSpearThrower_OnCombat(Unit, Event)
Unit:RegisterEvent("DarkspearSpearThrower_Net", 10000, 0)
Unit:RegisterEvent("DarkspearSpearThrower_Throw", 5000, 0)
end

function DarkspearSpearThrower_Net(Unit, Event) 
Unit:FullCastSpellOnTarget(12024, Unit:GetMainTank()) 
end

function DarkspearSpearThrower_Throw(Unit, Event) 
Unit:FullCastSpellOnTarget(38556, Unit:GetMainTank()) 
end

function DarkspearSpearThrower_OnLeaveCombat(Unit, Event) 
Unit:RemoveEvents() 
end

function DarkspearSpearThrower_OnDied(Unit, Event) 
Unit:RemoveEvents()
end

function DarkspearSpearThrower_OnKilledTarget(Unit, Event) 
end

RegisterUnitEvent(27560, 1, "DarkspearSpearThrower_OnCombat")
RegisterUnitEvent(27560, 2, "DarkspearSpearThrower_OnLeaveCombat")
RegisterUnitEvent(27560, 3, "DarkspearSpearThrower_OnKilledTarget")
RegisterUnitEvent(27560, 4, "DarkspearSpearThrower_OnDied")