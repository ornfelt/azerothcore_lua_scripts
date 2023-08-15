--[[

	This is created by zdroid9770  :D

	© Copyright 2012

]]

function SnorttheHeckler_OnCombat(Unit, Event)
	Unit:RegisterEvent("SnorttheHeckler_ToxicSpit", 6000, 0)
end

function SnorttheHeckler_ToxicSpit(Unit, Event) 
	Unit:FullCastSpellOnTarget(7951, 	Unit:GetMainTank()) 
end

function SnorttheHeckler_OnLeaveCombat(Unit, Event) 
	Unit:RemoveEvents() 
end

function SnorttheHeckler_OnDied(Unit, Event) 
	Unit:RemoveEvents()
end

function SnorttheHeckler_OnKilledTarget(Unit, Event) 
end

RegisterUnitEvent(5829, 1, "SnorttheHeckler_OnCombat")
RegisterUnitEvent(5829, 2, "SnorttheHeckler_OnLeaveCombat")
RegisterUnitEvent(5829, 3, "SnorttheHeckler_OnKilledTarget")
RegisterUnitEvent(5829, 4, "SnorttheHeckler_OnDied")