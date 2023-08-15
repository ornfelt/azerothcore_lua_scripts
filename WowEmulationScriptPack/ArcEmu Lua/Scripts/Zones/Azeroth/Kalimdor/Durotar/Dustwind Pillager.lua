--[[

	This is created by zdroid9770  :D

	© Copyright 2012

]]
function DustwindPillager_OnCombat(Unit, Event)
	UnitRegisterEvent("DustwindPillager_RendFlesh", 8000, 0)
end

function DustwindPillager_RendFlesh(Unit, Event) 
	UnitFullCastSpellOnTarget(3147, 	UnitGetMainTank()) 
end

function DustwindPillager_OnLeaveCombat(Unit, Event) 
	UnitRemoveEvents() 
end

function DustwindPillager_OnDied(Unit, Event) 
	UnitRemoveEvents()
end

function DustwindPillager_OnKilledTarget(Unit, Event) 
end

RegisterUnitEvent(3116, 1, "DustwindPillager_OnCombat")
RegisterUnitEvent(3116, 2, "DustwindPillager_OnLeaveCombat")
RegisterUnitEvent(3116, 3, "DustwindPillager_OnKilledTarget")
RegisterUnitEvent(3116, 4, "DustwindPillager_OnDied")