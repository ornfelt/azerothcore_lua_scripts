--[[

	This is created by zdroid9770  :D

	© Copyright 2012

]]

function GalakWrangler_OnCombat(Unit, Event)
	UnitRegisterEvent("GalakWrangler_Shot", 6000, 0)
	UnitRegisterEvent("GalakWrangler_Net", 8000, 0)
end

function GalakWrangler_Shot(Unit, Event) 
	UnitFullCastSpellOnTarget(6660, 	UnitGetMainTank()) 
end

function GalakWrangler_Net(Unit, Event) 
	UnitFullCastSpellOnTarget(6533, 	UnitGetMainTank()) 
end

function GalakWrangler_OnLeaveCombat(Unit, Event) 
	UnitRemoveEvents() 
end

function GalakWrangler_OnDied(Unit, Event) 
	UnitRemoveEvents()
end

function GalakWrangler_OnKilledTarget(Unit, Event) 
end

RegisterUnitEvent(4093, 1, "GalakWrangler_OnCombat")
RegisterUnitEvent(4093, 2, "GalakWrangler_OnLeaveCombat")
RegisterUnitEvent(4093, 3, "GalakWrangler_OnKilledTarget")
RegisterUnitEvent(4093, 4, "GalakWrangler_OnDied")