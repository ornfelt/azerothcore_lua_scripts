--[[

	This is created by zdroid9770  :D

	© Copyright 2012

]]

function GalakAssassin_OnCombat(Unit, Event)
	UnitRegisterEvent("GalakAssassin_Net", 10000, 0)
end

function GalakAssassin_Net(Unit, Event) 
	UnitFullCastSpellOnTarget(6533, 	UnitGetMainTank()) 
end

function GalakAssassin_OnLeaveCombat(Unit, Event) 
	UnitRemoveEvents() 
end

function GalakAssassin_OnDied(Unit, Event) 
	UnitRemoveEvents()
end

function GalakAssassin_OnKilledTarget(Unit, Event) 
end

RegisterUnitEvent(10720, 1, "GalakAssassin_OnCombat")
RegisterUnitEvent(10720, 2, "GalakAssassin_OnLeaveCombat")
RegisterUnitEvent(10720, 3, "GalakAssassin_OnKilledTarget")
RegisterUnitEvent(10720, 4, "GalakAssassin_OnDied")