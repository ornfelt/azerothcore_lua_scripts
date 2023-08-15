--[[

	This is created by zdroid9770  :D

	© Copyright 2012

]]

function ForemanRigger_OnCombat(Unit, Event)
	UnitRegisterEvent("ForemanRigger_Net", 10000, 0)
	UnitRegisterEvent("ForemanRigger_PierceArmor", 12000, 1)
end

function ForemanRigger_Net(Unit, Event) 
	UnitFullCastSpellOnTarget(6533, 	UnitGetRandomPlayer(4)) 
end

function ForemanRigger_PierceArmor(Unit, Event) 
	UnitFullCastSpellOnTarget(6016, 	UnitGetMainTank()) 
end

function ForemanRigger_OnLeaveCombat(Unit, Event) 
	UnitRemoveEvents() 
end

function ForemanRigger_OnDied(Unit, Event) 
	UnitRemoveEvents()
end

function ForemanRigger_OnKilledTarget(Unit, Event) 
end

RegisterUnitEvent(5931, 1, "ForemanRigger_OnCombat")
RegisterUnitEvent(5931, 2, "ForemanRigger_OnLeaveCombat")
RegisterUnitEvent(5931, 3, "ForemanRigger_OnKilledTarget")
RegisterUnitEvent(5931, 4, "ForemanRigger_OnDied")