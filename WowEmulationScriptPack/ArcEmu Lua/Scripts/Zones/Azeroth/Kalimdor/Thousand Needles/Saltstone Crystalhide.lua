--[[

	This is created by zdroid9770  :D

	© Copyright 2012

]]

function SaltstoneCrystalhide_OnCombat(Unit, Event)
	UnitRegisterEvent("SaltstoneCrystalhide_ManaBurn", 6000, 0)
end

function SaltstoneCrystalhide_ManaBurn(Unit, Event) 
	UnitFullCastSpellOnTarget(8129, 	UnitGetRandomPlayer(4)) 
end

function SaltstoneCrystalhide_OnLeaveCombat(Unit, Event) 
	UnitRemoveEvents() 
end

function SaltstoneCrystalhide_OnDied(Unit, Event) 
	UnitRemoveEvents()
end

function SaltstoneCrystalhide_OnKilledTarget(Unit, Event) 
end

RegisterUnitEvent(4151, 1, "SaltstoneCrystalhide_OnCombat")
RegisterUnitEvent(4151, 2, "SaltstoneCrystalhide_OnLeaveCombat")
RegisterUnitEvent(4151, 3, "SaltstoneCrystalhide_OnKilledTarget")
RegisterUnitEvent(4151, 4, "SaltstoneCrystalhide_OnDied")