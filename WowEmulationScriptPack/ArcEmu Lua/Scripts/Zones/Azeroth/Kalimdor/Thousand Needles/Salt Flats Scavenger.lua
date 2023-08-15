--[[

	This is created by zdroid9770  :D

	© Copyright 2012

]]

function SaltFlatsScavenger_OnCombat(Unit, Event)
	UnitRegisterEvent("SaltFlatsScavenger_Execute", 6000, 0)
end

function SaltFlatsScavenger_Execute(Unit, Event) 
if 	UnitGetHealthEnemy() < 20 then
	UnitFullCastSpellOnTarget(7160, 	UnitGetMainTank()) 
end
end

function SaltFlatsScavenger_OnLeaveCombat(Unit, Event) 
	UnitRemoveEvents() 
end

function SaltFlatsScavenger_OnDied(Unit, Event) 
	UnitRemoveEvents()
end

function SaltFlatsScavenger_OnKilledTarget(Unit, Event) 
end

RegisterUnitEvent(4154, 1, "SaltFlatsScavenger_OnCombat")
RegisterUnitEvent(4154, 2, "SaltFlatsScavenger_OnLeaveCombat")
RegisterUnitEvent(4154, 3, "SaltFlatsScavenger_OnKilledTarget")
RegisterUnitEvent(4154, 4, "SaltFlatsScavenger_OnDied")