--[[

	This is created by zdroid9770  :D

	© Copyright 2012

]]

function CorruptedMottledBoar_OnCombat(Unit, Event)
	UnitRegisterEvent("CorruptedMottledBoar_CorruptedIntellect", 10000, 0)
	UnitRegisterEvent("CorruptedMottledBoar_BoarCharge", 6000, 0)
end

function CorruptedMottledBoar_CorruptedIntellect(Unit, Event) 
	UnitFullCastSpellOnTarget(6818, 	UnitGetMainTank()) 
end

function CorruptedMottledBoar_BoarCharge(Unit, Event) 
	UnitCastSpell(3385) 
end

function CorruptedMottledBoar_OnLeaveCombat(Unit, Event) 
	UnitRemoveEvents() 
end

function CorruptedMottledBoar_OnDied(Unit, Event) 
	UnitRemoveEvents()
end

function CorruptedMottledBoar_OnKilledTarget(Unit, Event) 
end

RegisterUnitEvent(3225, 1, "CorruptedMottledBoar_OnCombat")
RegisterUnitEvent(3225, 2, "CorruptedMottledBoar_OnLeaveCombat")
RegisterUnitEvent(3225, 3, "CorruptedMottledBoar_OnKilledTarget")
RegisterUnitEvent(3225, 4, "CorruptedMottledBoar_OnDied")