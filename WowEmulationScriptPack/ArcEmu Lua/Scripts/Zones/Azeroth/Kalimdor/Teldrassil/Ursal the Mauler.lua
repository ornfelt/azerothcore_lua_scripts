--[[

	This is created by zdroid9770  :D

	© Copyright 2012

]]

function UrsaltheMauler_OnCombat(Unit, Event)
	Unit:RegisterEvent("UrsaltheMauler_Maul", 6000, 0)
end

function UrsaltheMauler_Maul(Unit, Event) 
	Unit:FullCastSpellOnTarget(15793, 	Unit:GetMainTank()) 
end

function UrsaltheMauler_OnLeaveCombat(Unit, Event) 
	Unit:RemoveEvents() 
end

function UrsaltheMauler_OnDied(Unit, Event) 
	Unit:RemoveEvents()
end

function UrsaltheMauler_OnKilledTarget(Unit, Event) 
end

RegisterUnitEvent(2039, 1, "UrsaltheMauler_OnCombat")
RegisterUnitEvent(2039, 2, "UrsaltheMauler_OnLeaveCombat")
RegisterUnitEvent(2039, 3, "UrsaltheMauler_OnKilledTarget")
RegisterUnitEvent(2039, 4, "UrsaltheMauler_OnDied")