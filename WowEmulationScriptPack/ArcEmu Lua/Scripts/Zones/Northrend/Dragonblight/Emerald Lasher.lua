--[[

	This is created by zdroid9770  :D

	© Copyright 2012

]]


function EmeraldLasher_OnCombat(Unit, Event)
Unit:RegisterEvent("EmeraldLasher_DreamLash", 7000, 0)
end

function EmeraldLasher_DreamLash(Unit, Event) 
Unit:FullCastSpellOnTarget(51901, Unit:GetMainTank()) 
end

function EmeraldLasher_OnLeaveCombat(Unit, Event) 
Unit:RemoveEvents() 
end

function EmeraldLasher_OnDied(Unit, Event) 
Unit:RemoveEvents()
end

function EmeraldLasher_OnKilledTarget(Unit, Event) 
end

RegisterUnitEvent(27254, 1, "EmeraldLasher_OnCombat")
RegisterUnitEvent(27254, 2, "EmeraldLasher_OnLeaveCombat")
RegisterUnitEvent(27254, 3, "EmeraldLasher_OnKilledTarget")
RegisterUnitEvent(27254, 4, "EmeraldLasher_OnDied")