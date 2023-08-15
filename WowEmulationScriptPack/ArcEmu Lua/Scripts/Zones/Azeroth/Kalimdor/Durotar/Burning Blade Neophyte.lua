--[[

	This is created by zdroid9770  :D

	© Copyright 2012

]]

function BurningBladeNeophyte_OnCombat(Unit, Event)
	UnitRegisterEvent("BurningBladeNeophyte_Inmolate", 8000, 0)
end

function BurningBladeNeophyte_Inmolate(Unit, Event) 
	UnitFullCastSpellOnTarget(348, 	UnitGetMainTank()) 
end

function BurningBladeNeophyte_OnLeaveCombat(Unit, Event) 
	UnitRemoveEvents() 
end

function BurningBladeNeophyte_OnDied(Unit, Event) 
	UnitRemoveEvents()
end

function BurningBladeNeophyte_OnKilledTarget(Unit, Event) 
end

RegisterUnitEvent(3196, 1, "BurningBladeNeophyte_OnCombat")
RegisterUnitEvent(3196, 2, "BurningBladeNeophyte_OnLeaveCombat")
RegisterUnitEvent(3196, 3, "BurningBladeNeophyte_OnKilledTarget")
RegisterUnitEvent(3196, 4, "BurningBladeNeophyte_OnDied")