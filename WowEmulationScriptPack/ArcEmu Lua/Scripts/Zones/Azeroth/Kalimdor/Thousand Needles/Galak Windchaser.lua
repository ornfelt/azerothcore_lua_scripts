--[[

	This is created by zdroid9770  :D

	© Copyright 2012

]]

function GalakWindchaser_OnCombat(Unit, Event)
	UnitRegisterEvent("GalakWindchaser_EnvelopingWinds", 13000, 0)
	UnitRegisterEvent("GalakWindchaser_HealingWave", 8000, 0)
end

function GalakWindchaser_EnvelopingWinds(Unit, Event) 
	UnitFullCastSpellOnTarget(6728, 	UnitGetMainTank()) 
end

function GalakWindchaser_HealingWave(Unit, Event) 
	UnitCastSpell(939) 
end

function GalakWindchaser_OnLeaveCombat(Unit, Event) 
	UnitRemoveEvents() 
end

function GalakWindchaser_OnDied(Unit, Event) 
	UnitRemoveEvents()
end

function GalakWindchaser_OnKilledTarget(Unit, Event) 
end

RegisterUnitEvent(4096, 1, "GalakWindchaser_OnCombat")
RegisterUnitEvent(4096, 2, "GalakWindchaser_OnLeaveCombat")
RegisterUnitEvent(4096, 3, "GalakWindchaser_OnKilledTarget")
RegisterUnitEvent(4096, 4, "GalakWindchaser_OnDied")