--[[

	This is created by zdroid9770  :D

	© Copyright 2012

]]

function BloodtalonTaillasher_OnCombat(Unit, Event)
	UnitRegisterEvent("BloodtalonTaillasher_RushingCharge", 8000, 0)
end

function BloodtalonTaillasher_RushingCharge(Unit, Event) 
	UnitCastSpell(6268) 
end

function BloodtalonTaillasher_OnLeaveCombat(Unit, Event) 
	UnitRemoveEvents() 
end

function BloodtalonTaillasher_OnDied(Unit, Event) 
	UnitRemoveEvents()
end

function BloodtalonTaillasher_OnKilledTarget(Unit, Event) 
end

RegisterUnitEvent(3122, 1, "BloodtalonTaillasher_OnCombat")
RegisterUnitEvent(3122, 2, "BloodtalonTaillasher_OnLeaveCombat")
RegisterUnitEvent(3122, 3, "BloodtalonTaillasher_OnKilledTarget")
RegisterUnitEvent(3122, 4, "BloodtalonTaillasher_OnDied")