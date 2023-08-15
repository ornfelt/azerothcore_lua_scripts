--[[

	This is created by zdroid9770  :D

	© Copyright 2012

]]

function GravelsnoutForager_OnCombat(Unit, Event)
	UnitRegisterEvent("GravelsnoutForager_CorrosiveAcid", 10000, 0)
end

function GravelsnoutForager_CorrosiveAcid(Unit, Event) 
	UnitFullCastSpellOnTarget(8245, 	UnitGetMainTank()) 
end

function GravelsnoutForager_OnLeaveCombat(Unit, Event) 
	UnitRemoveEvents() 
end

function GravelsnoutForager_OnDied(Unit, Event) 
	UnitRemoveEvents()
end

function GravelsnoutForager_OnKilledTarget(Unit, Event) 
end

RegisterUnitEvent(4114, 1, "GravelsnoutForager_OnCombat")
RegisterUnitEvent(4114, 2, "GravelsnoutForager_OnLeaveCombat")
RegisterUnitEvent(4114, 3, "GravelsnoutForager_OnKilledTarget")
RegisterUnitEvent(4114, 4, "GravelsnoutForager_OnDied")