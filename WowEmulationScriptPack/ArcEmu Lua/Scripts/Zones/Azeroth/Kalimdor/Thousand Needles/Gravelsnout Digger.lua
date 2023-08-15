--[[

	This is created by zdroid9770  :D

	© Copyright 2012

]]

function GravelsnoutDigger_OnCombat(Unit, Event)
	UnitRegisterEvent("GravelsnoutDigger_SkullCrack", 8000, 0)
end

function GravelsnoutDigger_SkullCrack(Unit, Event) 
	UnitCastSpell(3551) 
end

function GravelsnoutDigger_OnLeaveCombat(Unit, Event) 
	UnitRemoveEvents() 
end

function GravelsnoutDigger_OnDied(Unit, Event) 
	UnitRemoveEvents()
end

function GravelsnoutDigger_OnKilledTarget(Unit, Event) 
end

RegisterUnitEvent(4113, 1, "GravelsnoutDigger_OnCombat")
RegisterUnitEvent(4113, 2, "GravelsnoutDigger_OnLeaveCombat")
RegisterUnitEvent(4113, 3, "GravelsnoutDigger_OnKilledTarget")
RegisterUnitEvent(4113, 4, "GravelsnoutDigger_OnDied")