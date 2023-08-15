--[[

	This is created by zdroid9770  :D

	© Copyright 2012

]]

function ScreechingWindcaller_OnCombat(Unit, Event)
	UnitRegisterEvent("ScreechingWindcaller_GustofWind", 10000, 0)
end

function ScreechingWindcaller_GustofWind(Unit, Event) 
	UnitFullCastSpellOnTarget(6982, 	UnitGetMainTank()) 
end

function ScreechingWindcaller_OnLeaveCombat(Unit, Event) 
	UnitRemoveEvents() 
end

function ScreechingWindcaller_OnDied(Unit, Event) 
	UnitRemoveEvents()
end

function ScreechingWindcaller_OnKilledTarget(Unit, Event) 
end

RegisterUnitEvent(4104, 1, "ScreechingWindcaller_OnCombat")
RegisterUnitEvent(4104, 2, "ScreechingWindcaller_OnLeaveCombat")
RegisterUnitEvent(4104, 3, "ScreechingWindcaller_OnKilledTarget")
RegisterUnitEvent(4104, 4, "ScreechingWindcaller_OnDied")