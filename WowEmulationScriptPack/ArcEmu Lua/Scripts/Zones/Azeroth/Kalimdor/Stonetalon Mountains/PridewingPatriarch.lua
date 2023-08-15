--[[

	This is created by zdroid9770  :D

	© Copyright 2012

]]

function PridewingPatriarch_OnCombat(Unit, Event)
	UnitRegisterEvent("PridewingPatriarch_CorrosivePoison", 10000, 0)
end

function PridewingPatriarch_CorrosivePoison(Unit, Event) 
	UnitFullCastSpellOnTarget(3397, 	UnitGetMainTank()) 
end

function PridewingPatriarch_OnLeaveCombat(Unit, Event) 
	UnitRemoveEvents() 
end

function PridewingPatriarch_OnDied(Unit, Event) 
	UnitRemoveEvents()
end

function PridewingPatriarch_OnKilledTarget(Unit, Event) 
end

RegisterUnitEvent(4015, 1, "PridewingPatriarch_OnCombat")
RegisterUnitEvent(4015, 2, "PridewingPatriarch_OnLeaveCombat")
RegisterUnitEvent(4015, 3, "PridewingPatriarch_OnKilledTarget")
RegisterUnitEvent(4015, 4, "PridewingPatriarch_OnDied")