--[[

	This is created by zdroid9770  :D

	© Copyright 2012

]]

function MirkfallonKeeper_OnCombat(Unit, Event)
	UnitRegisterEvent("MirkfallonKeeper_MirkfallonFungus", 10000, 1)
end

function MirkfallonKeeper_MirkfallonFungus(Unit, Event) 
	UnitFullCastSpellOnTarget(8138, 	UnitGetMainTank()) 
end

function MirkfallonKeeper_OnLeaveCombat(Unit, Event) 
	UnitRemoveEvents() 
end

function MirkfallonKeeper_OnDied(Unit, Event) 
	UnitRemoveEvents()
end

function MirkfallonKeeper_OnKilledTarget(Unit, Event) 
end

RegisterUnitEvent(4056, 1, "MirkfallonKeeper_OnCombat")
RegisterUnitEvent(4056, 2, "MirkfallonKeeper_OnLeaveCombat")
RegisterUnitEvent(4056, 3, "MirkfallonKeeper_OnKilledTarget")
RegisterUnitEvent(4056, 4, "MirkfallonKeeper_OnDied")