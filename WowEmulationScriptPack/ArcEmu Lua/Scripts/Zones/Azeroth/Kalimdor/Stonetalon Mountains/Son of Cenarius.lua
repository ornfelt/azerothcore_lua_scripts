--[[

	This is created by zdroid9770  :D

	© Copyright 2012

]]

function SonofCenarius_OnCombat(Unit, Event)
	UnitRegisterEvent("SonofCenarius_SummonTreantAlly", 4000, 1)
end

function SonofCenarius_SummonTreantAlly(Unit, Event) 
	UnitCastSpell(7993) 
end

function SonofCenarius_OnLeaveCombat(Unit, Event) 
	UnitRemoveEvents() 
end

function SonofCenarius_OnDied(Unit, Event) 
	UnitRemoveEvents()
end

function SonofCenarius_OnKilledTarget(Unit, Event) 
end

RegisterUnitEvent(4057, 1, "SonofCenarius_OnCombat")
RegisterUnitEvent(4057, 2, "SonofCenarius_OnLeaveCombat")
RegisterUnitEvent(4057, 3, "SonofCenarius_OnKilledTarget")
RegisterUnitEvent(4057, 4, "SonofCenarius_OnDied")