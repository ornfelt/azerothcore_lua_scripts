--[[

	This is created by zdroid9770  :D

	© Copyright 2012

]]

function BurningBladeCultist_OnCombat(Unit, Event)
	UnitRegisterEvent("BurningBladeCultist_Immolate", 8000, 0)
end

function BurningBladeCultist_Immolate(Unit, Event) 
	UnitFullCastSpellOnTarget(11962, 	UnitGetMainTank()) 
end

function BurningBladeCultist_OnLeaveCombat(Unit, Event) 
	UnitRemoveEvents() 
end

function BurningBladeCultist_OnDied(Unit, Event) 
	UnitRemoveEvents()
end

function BurningBladeCultist_OnKilledTarget(Unit, Event) 
end

RegisterUnitEvent(3199, 1, "BurningBladeCultist_OnCombat")
RegisterUnitEvent(3199, 2, "BurningBladeCultist_OnLeaveCombat")
RegisterUnitEvent(3199, 3, "BurningBladeCultist_OnKilledTarget")
RegisterUnitEvent(3199, 4, "BurningBladeCultist_OnDied")