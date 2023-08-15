--[[

	This is created by zdroid9770  :D

	© Copyright 2012

]]

function GalakMarauder_OnCombat(Unit, Event)
	UnitRegisterEvent("GalakMarauder_RushingCharge", 7000, 0)
end

function GalakMarauder_RushingCharge(Unit, Event) 
	UnitCastSpell(6268) 
end

function GalakMarauder_OnLeaveCombat(Unit, Event) 
	UnitRemoveEvents() 
end

function GalakMarauder_OnDied(Unit, Event) 
	UnitRemoveEvents()
end

function GalakMarauder_OnKilledTarget(Unit, Event) 
end

RegisterUnitEvent(4099, 1, "GalakMarauder_OnCombat")
RegisterUnitEvent(4099, 2, "GalakMarauder_OnLeaveCombat")
RegisterUnitEvent(4099, 3, "GalakMarauder_OnKilledTarget")
RegisterUnitEvent(4099, 4, "GalakMarauder_OnDied")