--[[

	This is created by zdroid9770  :D

	© Copyright 2012

]]

function PridewingSkyhunter_OnCombat(Unit, Event)
	UnitRegisterEvent("PridewingSkyhunter_Poison", 10000, 0)
	UnitRegisterEvent("PridewingSkyhunter_Swoop", 6000, 0)
end

function PridewingSkyhunter_Poison(Unit, Event) 
	UnitFullCastSpellOnTarget(744, 	UnitGetMainTank()) 
end

function PridewingSkyhunter_Swoop(Unit, Event) 
	UnitFullCastSpellOnTarget(5708, 	UnitGetMainTank()) 
end

function PridewingSkyhunter_OnLeaveCombat(Unit, Event) 
	UnitRemoveEvents() 
end

function PridewingSkyhunter_OnDied(Unit, Event) 
	UnitRemoveEvents()
end

function PridewingSkyhunter_OnKilledTarget(Unit, Event) 
end

RegisterUnitEvent(4013, 1, "PridewingSkyhunter_OnCombat")
RegisterUnitEvent(4013, 2, "PridewingSkyhunter_OnLeaveCombat")
RegisterUnitEvent(4013, 3, "PridewingSkyhunter_OnKilledTarget")
RegisterUnitEvent(4013, 4, "PridewingSkyhunter_OnDied")