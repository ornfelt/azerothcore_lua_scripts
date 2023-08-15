--[[

	This is created by zdroid9770  :D

	© Copyright 2012

]]

function DeepmossVenomspitter_OnCombat(Unit, Event)
	UnitRegisterEvent("DeepmossVenomspitter_ToxicSpit", 10000, 0)
end

function DeepmossVenomspitter_ToxicSpit(Unit, Event) 
	UnitFullCastSpellOnTarget(7951, 	UnitGetMainTank()) 
end

function DeepmossVenomspitter_OnLeaveCombat(Unit, Event) 
	UnitRemoveEvents() 
end

function DeepmossVenomspitter_OnDied(Unit, Event) 
	UnitRemoveEvents()
end

function DeepmossVenomspitter_OnKilledTarget(Unit, Event) 
end

RegisterUnitEvent(4007, 1, "DeepmossVenomspitter_OnCombat")
RegisterUnitEvent(4007, 2, "DeepmossVenomspitter_OnLeaveCombat")
RegisterUnitEvent(4007, 3, "DeepmossVenomspitter_OnKilledTarget")
RegisterUnitEvent(4007, 4, "DeepmossVenomspitter_OnDied")