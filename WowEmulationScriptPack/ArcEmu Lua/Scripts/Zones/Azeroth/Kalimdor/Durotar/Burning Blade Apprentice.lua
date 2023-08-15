--[[

	This is created by zdroid9770  :D

	© Copyright 2012

]]

function BurningBladeApprentice_OnCombat(Unit, Event)
	UnitRegisterEvent("BurningBladeApprentice_ShadowBolt", 8000, 0)
	UnitRegisterEvent("BurningBladeApprentice_SummonVoidwalker", 1000, 1)
end

function BurningBladeApprentice_ShadowBolt(Unit, Event) 
	UnitFullCastSpellOnTarget(20791, 	UnitGetMainTank()) 
end

function BurningBladeApprentice_SummonVoidwalker(Unit, Event) 
	UnitCastSpell(12746) 
end

function BurningBladeApprentice_OnLeaveCombat(Unit, Event) 
	UnitRemoveEvents() 
end

function BurningBladeApprentice_OnDied(Unit, Event) 
	UnitRemoveEvents()
end

function BurningBladeApprentice_OnKilledTarget(Unit, Event) 
end

RegisterUnitEvent(3198, 1, "BurningBladeApprentice_OnCombat")
RegisterUnitEvent(3198, 2, "BurningBladeApprentice_OnLeaveCombat")
RegisterUnitEvent(3198, 3, "BurningBladeApprentice_OnKilledTarget")
RegisterUnitEvent(3198, 4, "BurningBladeApprentice_OnDied")