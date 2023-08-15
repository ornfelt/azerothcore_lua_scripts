--[[

	This is created by zdroid9770  :D

	© Copyright 2012

]]
function GravelsnoutSurveyor_OnCombat(Unit, Event)
	UnitRegisterEvent("GravelsnoutSurveyor_Frostbolt", 6000, 0)
end

function GravelsnoutSurveyor_Frostbolt(Unit, Event) 
	UnitFullCastSpellOnTarget(20806, 	UnitGetMainTank()) 
end

function GravelsnoutSurveyor_OnLeaveCombat(Unit, Event) 
	UnitRemoveEvents() 
end

function GravelsnoutSurveyor_OnDied(Unit, Event) 
	UnitRemoveEvents()
end

function GravelsnoutSurveyor_OnKilledTarget(Unit, Event) 
end

RegisterUnitEvent(4116, 1, "GravelsnoutSurveyor_OnCombat")
RegisterUnitEvent(4116, 2, "GravelsnoutSurveyor_OnLeaveCombat")
RegisterUnitEvent(4116, 3, "GravelsnoutSurveyor_OnKilledTarget")
RegisterUnitEvent(4116, 4, "GravelsnoutSurveyor_OnDied")