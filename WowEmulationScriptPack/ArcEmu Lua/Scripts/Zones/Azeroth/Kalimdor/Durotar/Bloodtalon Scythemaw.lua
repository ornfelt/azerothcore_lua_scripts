--[[

	This is created by zdroid9770  :D

	© Copyright 2012

]]

function BloodtalonScythemaw_OnCombat(Unit, Event)
	UnitRegisterEvent("BloodtalonScythemaw_RushingCharge", 8000, 0)
end

function BloodtalonScythemaw_RushingCharge(Unit, Event) 
	UnitCastSpell(6268) 
end

function BloodtalonScythemaw_OnLeaveCombat(Unit, Event) 
	UnitRemoveEvents() 
end

function BloodtalonScythemaw_OnDied(Unit, Event) 
	UnitRemoveEvents()
end

function BloodtalonScythemaw_OnKilledTarget(Unit, Event) 
end

RegisterUnitEvent(3123, 1, "BloodtalonScythemaw_OnCombat")
RegisterUnitEvent(3123, 2, "BloodtalonScythemaw_OnLeaveCombat")
RegisterUnitEvent(3123, 3, "BloodtalonScythemaw_OnKilledTarget")
RegisterUnitEvent(3123, 4, "BloodtalonScythemaw_OnDied")