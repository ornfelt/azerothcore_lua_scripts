--[[

	This is created by zdroid9770  :D

	© Copyright 2012

]]


function GelkisMauler_OnCombat(Unit, Event)
	Unit:RegisterEvent("GelkisMauler_Thrash", 5000, 0)
end

function GelkisMauler_Thrash(Unit, Event) 
	Unit:FullCastSpellOnTarget(3391, 	Unit:GetMainTank()) 
end

function GelkisMauler_OnLeaveCombat(Unit, Event) 
	Unit:RemoveEvents() 
end

function GelkisMauler_OnDied(Unit, Event) 
	Unit:RemoveEvents()
end

function GelkisMauler_OnKilledTarget(Unit, Event) 
end

RegisterUnitEvent(4652, 1, "GelkisMauler_OnCombat")
RegisterUnitEvent(4652, 2, "GelkisMauler_OnLeaveCombat")
RegisterUnitEvent(4652, 3, "GelkisMauler_OnKilledTarget")
RegisterUnitEvent(4652, 4, "GelkisMauler_OnDied")