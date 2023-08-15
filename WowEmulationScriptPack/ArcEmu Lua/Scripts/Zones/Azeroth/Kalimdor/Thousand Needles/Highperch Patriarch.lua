--[[

	This is created by zdroid9770  :D

	© Copyright 2012

]]

function HighperchPatriarch_OnCombat(Unit, Event)
	UnitRegisterEvent("HighperchPatriarch_Poison", 12000, 0)
end

function HighperchPatriarch_Poison(Unit, Event) 
	UnitFullCastSpellOnTarget(744, 	UnitGetMainTank()) 
end

function HighperchPatriarch_OnLeaveCombat(Unit, Event) 
	UnitRemoveEvents() 
end

function HighperchPatriarch_OnDied(Unit, Event) 
	UnitRemoveEvents()
end

function HighperchPatriarch_OnKilledTarget(Unit, Event) 
end

RegisterUnitEvent(4110, 1, "HighperchPatriarch_OnCombat")
RegisterUnitEvent(4110, 2, "HighperchPatriarch_OnLeaveCombat")
RegisterUnitEvent(4110, 3, "HighperchPatriarch_OnKilledTarget")
RegisterUnitEvent(4110, 4, "HighperchPatriarch_OnDied")