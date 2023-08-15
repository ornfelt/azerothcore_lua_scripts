--[[

	This is created by zdroid9770  :D

	© Copyright 2012

]]

function GalakStormer_OnCombat(Unit, Event)
	UnitRegisterEvent("GalakStormer_LightningBolt", 8000, 0)
end

function GalakStormer_LightningBolt(Unit, Event) 
	UnitFullCastSpellOnTarget(9532, 	UnitGetMainTank()) 
end

function GalakStormer_OnLeaveCombat(Unit, Event) 
	UnitRemoveEvents() 
end

function GalakStormer_OnDied(Unit, Event) 
	UnitRemoveEvents()
end

function GalakStormer_OnKilledTarget(Unit, Event) 
end

RegisterUnitEvent(4097, 1, "GalakStormer_OnCombat")
RegisterUnitEvent(4097, 2, "GalakStormer_OnLeaveCombat")
RegisterUnitEvent(4097, 3, "GalakStormer_OnKilledTarget")
RegisterUnitEvent(4097, 4, "GalakStormer_OnDied")