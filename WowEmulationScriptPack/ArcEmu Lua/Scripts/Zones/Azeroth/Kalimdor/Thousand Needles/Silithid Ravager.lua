--[[

	This is created by zdroid9770  :D

	© Copyright 2012

]]

function SilithidRavager_OnCombat(Unit, Event)
	UnitRegisterEvent("SilithidRavager_StrongCleave", 5000, 0)
end

function SilithidRavager_StrongCleave(Unit, Event) 
	UnitCastSpell(8255) 
end

function SilithidRavager_OnLeaveCombat(Unit, Event) 
	UnitRemoveEvents() 
end

function SilithidRavager_OnDied(Unit, Event) 
	UnitRemoveEvents()
end

function SilithidRavager_OnKilledTarget(Unit, Event) 
end

RegisterUnitEvent(4132, 1, "SilithidRavager_OnCombat")
RegisterUnitEvent(4132, 2, "SilithidRavager_OnLeaveCombat")
RegisterUnitEvent(4132, 3, "SilithidRavager_OnKilledTarget")
RegisterUnitEvent(4132, 4, "SilithidRavager_OnDied")