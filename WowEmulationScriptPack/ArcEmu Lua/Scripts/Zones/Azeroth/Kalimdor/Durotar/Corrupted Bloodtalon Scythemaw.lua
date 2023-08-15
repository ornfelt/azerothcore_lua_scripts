--[[

	This is created by zdroid9770  :D

	© Copyright 2012

]]

function CorruptedBloodtalonScythemaw_OnCombat(Unit, Event)
	UnitRegisterEvent("CorruptedBloodtalonScythemaw_RushingCharge", 8000, 0)
end

function CorruptedBloodtalonScythemaw_RushingCharge(Unit, Event) 
	UnitCastSpell(6268) 
end

function CorruptedBloodtalonScythemaw_OnLeaveCombat(Unit, Event) 
	UnitRemoveEvents() 
end

function CorruptedBloodtalonScythemaw_OnDied(Unit, Event) 
	UnitRemoveEvents()
end

function CorruptedBloodtalonScythemaw_OnKilledTarget(Unit, Event) 
end

RegisterUnitEvent(3227, 1, "CorruptedBloodtalonScythemaw_OnCombat")
RegisterUnitEvent(3227, 2, "CorruptedBloodtalonScythemaw_OnLeaveCombat")
RegisterUnitEvent(3227, 3, "CorruptedBloodtalonScythemaw_OnKilledTarget")
RegisterUnitEvent(3227, 4, "CorruptedBloodtalonScythemaw_OnDied")