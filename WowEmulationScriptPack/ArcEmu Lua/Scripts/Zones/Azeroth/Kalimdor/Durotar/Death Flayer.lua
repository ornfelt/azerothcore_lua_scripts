--[[

	This is created by zdroid9770  :D

	© Copyright 2012

]]

function DeathFlayer_OnCombat(Unit, Event)
	UnitRegisterEvent("DeathFlayer_VenomSting", 8000, 0)
end

function DeathFlayer_VenomSting(Unit, Event) 
	UnitFullCastSpellOnTarget(5416, 	UnitGetMainTank()) 
end

function DeathFlayer_OnLeaveCombat(Unit, Event) 
	UnitRemoveEvents() 
end

function DeathFlayer_OnDied(Unit, Event) 
	UnitRemoveEvents()
end

function DeathFlayer_OnKilledTarget(Unit, Event) 
end

RegisterUnitEvent(5823, 1, "DeathFlayer_OnCombat")
RegisterUnitEvent(5823, 2, "DeathFlayer_OnLeaveCombat")
RegisterUnitEvent(5823, 3, "DeathFlayer_OnKilledTarget")
RegisterUnitEvent(5823, 4, "DeathFlayer_OnDied")