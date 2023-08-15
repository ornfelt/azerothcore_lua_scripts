--[[

	This is created by zdroid9770  :D

	© Copyright 2012

]]

function GalakScout_OnCombat(Unit, Event)
	UnitRegisterEvent("GalakScout_Shot", 6000, 0)
end

function GalakScout_Shot(Unit, Event) 
	UnitFullCastSpellOnTarget(6660, 	UnitGetMainTank()) 
end

function GalakScout_OnLeaveCombat(Unit, Event) 
	UnitRemoveEvents() 
end

function GalakScout_OnDied(Unit, Event) 
	UnitRemoveEvents()
end

function GalakScout_OnKilledTarget(Unit, Event) 
end

RegisterUnitEvent(4094, 1, "GalakScout_OnCombat")
RegisterUnitEvent(4094, 2, "GalakScout_OnLeaveCombat")
RegisterUnitEvent(4094, 3, "GalakScout_OnKilledTarget")
RegisterUnitEvent(4094, 4, "GalakScout_OnDied")