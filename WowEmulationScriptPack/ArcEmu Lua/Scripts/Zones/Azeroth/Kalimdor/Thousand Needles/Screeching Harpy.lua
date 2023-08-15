--[[

	This is created by zdroid9770  :D

	© Copyright 2012

]]

function ScreechingHarpy_OnCombat(Unit, Event)
	UnitRegisterEvent("ScreechingHarpy_DeafeningScreech", 10000, 0)
end

function ScreechingHarpy_DeafeningScreech(Unit, Event) 
	UnitFullCastSpellOnTarget(3589, 	UnitGetMainTank()) 
end

function ScreechingHarpy_OnLeaveCombat(Unit, Event) 
	UnitRemoveEvents() 
end

function ScreechingHarpy_OnDied(Unit, Event) 
	UnitRemoveEvents()
end

function ScreechingHarpy_OnKilledTarget(Unit, Event) 
end

RegisterUnitEvent(4100, 1, "ScreechingHarpy_OnCombat")
RegisterUnitEvent(4100, 2, "ScreechingHarpy_OnLeaveCombat")
RegisterUnitEvent(4100, 3, "ScreechingHarpy_OnKilledTarget")
RegisterUnitEvent(4100, 4, "ScreechingHarpy_OnDied")