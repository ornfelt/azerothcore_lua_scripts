--[[

	This is created by zdroid9770  :D

	© Copyright 2012

]]

function GalakMauler_OnCombat(Unit, Event)
	UnitRegisterEvent("GalakMauler_DemoralizingShout", 10000, 0)
end

function GalakMauler_DemoralizingShout(Unit, Event) 
	UnitCastSpell(13730) 
end

function GalakMauler_OnLeaveCombat(Unit, Event) 
	UnitRemoveEvents() 
end

function GalakMauler_OnDied(Unit, Event) 
	UnitRemoveEvents()
end

function GalakMauler_OnKilledTarget(Unit, Event) 
end

RegisterUnitEvent(4095, 1, "GalakMauler_OnCombat")
RegisterUnitEvent(4095, 2, "GalakMauler_OnLeaveCombat")
RegisterUnitEvent(4095, 3, "GalakMauler_OnKilledTarget")
RegisterUnitEvent(4095, 4, "GalakMauler_OnDied")