--[[

	This is created by zdroid9770  :D

	© Copyright 2012

]]

function SorrowWing_OnCombat(Unit, Event)
	UnitRegisterEvent("SorrowWing_SoulRend", 6000, 1)
	UnitRegisterEvent("SorrowWing_DeadlyLeechPoison", 8000, 1)
end

function SorrowWing_SoulRend(Unit, Event) 
	UnitFullCastSpellOnTarget(3405, 	UnitGetMainTank()) 
end

function SorrowWing_DeadlyLeechPoison(Unit, Event) 
	UnitFullCastSpellOnTarget(3388, 	UnitGetMainTank()) 
end

function SorrowWing_OnLeaveCombat(Unit, Event) 
	UnitRemoveEvents() 
end

function SorrowWing_OnDied(Unit, Event) 
	UnitRemoveEvents()
end

function SorrowWing_OnKilledTarget(Unit, Event) 
end

RegisterUnitEvent(5928, 1, "SorrowWing_OnCombat")
RegisterUnitEvent(5928, 2, "SorrowWing_OnLeaveCombat")
RegisterUnitEvent(5928, 3, "SorrowWing_OnKilledTarget")
RegisterUnitEvent(5928, 4, "SorrowWing_OnDied")