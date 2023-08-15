--[[

	This is created by zdroid9770  :D

	© Copyright 2012

]]

function HarbFoulmountain_OnCombat(Unit, Event)
	UnitRegisterEvent("HarbFoulmountain_Thrash", 6000, 0)
	UnitRegisterEvent("HarbFoulmountain_WarStomp", 8000, 0)
end

function HarbFoulmountain_Thrash(Unit, Event) 
	UnitFullCastSpellOnTarget(3391, 	UnitGetMainTank()) 
end

function HarbFoulmountain_WarStomp(Unit, Event) 
	UnitFullCastSpellOnTarget(45, 	UnitGetMainTank()) 
end

function HarbFoulmountain_OnLeaveCombat(Unit, Event) 
	UnitRemoveEvents() 
end

function HarbFoulmountain_OnDied(Unit, Event) 
	UnitRemoveEvents()
end

function HarbFoulmountain_OnKilledTarget(Unit, Event) 
end

RegisterUnitEvent(14426, 1, "HarbFoulmountain_OnCombat")
RegisterUnitEvent(14426, 2, "HarbFoulmountain_OnLeaveCombat")
RegisterUnitEvent(14426, 3, "HarbFoulmountain_OnKilledTarget")
RegisterUnitEvent(14426, 4, "HarbFoulmountain_OnDied")