--[[

	This is created by zdroid9770  :D

	© Copyright 2012

]]

function MirkfallonDryad_OnCombat(Unit, Event)
	UnitRegisterEvent("MirkfallonDryad_SlowingPoison", 10000, 0)
	UnitRegisterEvent("MirkfallonDryad_Throw", 6000, 0)
end

function MirkfallonDryad_SlowingPoison(Unit, Event) 
	UnitFullCastSpellOnTarget(7992, 	UnitGetMainTank()) 
end

function MirkfallonDryad_Throw(Unit, Event) 
	UnitFullCastSpellOnTarget(10277, 	UnitGetMainTank()) 
end

function MirkfallonDryad_OnLeaveCombat(Unit, Event) 
	UnitRemoveEvents() 
end

function MirkfallonDryad_OnDied(Unit, Event) 
	UnitRemoveEvents()
end

function MirkfallonDryad_OnKilledTarget(Unit, Event) 
end

RegisterUnitEvent(4061, 1, "MirkfallonDryad_OnCombat")
RegisterUnitEvent(4061, 2, "MirkfallonDryad_OnLeaveCombat")
RegisterUnitEvent(4061, 3, "MirkfallonDryad_OnKilledTarget")
RegisterUnitEvent(4061, 4, "MirkfallonDryad_OnDied")