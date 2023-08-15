--[[

	This is created by zdroid9770  :D

	© Copyright 2012

]]


function UrsusMauler_OnCombat(Unit, Event)
Unit:RegisterEvent("UrsusMauler_Maul", 5000, 0)
end

function UrsusMauler_Maul(Unit, Event) 
Unit:FullCastSpellOnTarget(12161, Unit:GetMainTank()) 
end

function UrsusMauler_OnLeaveCombat(Unit, Event) 
Unit:RemoveEvents() 
end

function UrsusMauler_OnDied(Unit, Event) 
Unit:RemoveEvents()
end

function UrsusMauler_OnKilledTarget(Unit, Event) 
end

RegisterUnitEvent(26644, 1, "UrsusMauler_OnCombat")
RegisterUnitEvent(26644, 2, "UrsusMauler_OnLeaveCombat")
RegisterUnitEvent(26644, 3, "UrsusMauler_OnKilledTarget")
RegisterUnitEvent(26644, 4, "UrsusMauler_OnDied")