--[[

	This is created by zdroid9770  :D

	© Copyright 2012

]]

function CragStalker_OnCombat(Unit, Event)
	UnitRegisterEvent("CragStalker_SurpriseAttack", 8000, 0)
end

function CragStalker_SurpriseAttack(Unit, Event) 
	UnitFullCastSpellOnTarget(8151, 	UnitGetMainTank()) 
end

function CragStalker_OnLeaveCombat(Unit, Event) 
	UnitRemoveEvents() 
end

function CragStalker_OnDied(Unit, Event) 
	UnitRemoveEvents()
end

function CragStalker_OnKilledTarget(Unit, Event) 
end

RegisterUnitEvent(4126, 1, "CragStalker_OnCombat")
RegisterUnitEvent(4126, 2, "CragStalker_OnLeaveCombat")
RegisterUnitEvent(4126, 3, "CragStalker_OnKilledTarget")
RegisterUnitEvent(4126, 4, "CragStalker_OnDied")