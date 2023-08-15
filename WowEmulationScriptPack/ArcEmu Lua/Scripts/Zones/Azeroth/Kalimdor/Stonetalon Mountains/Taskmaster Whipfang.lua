--[[

	This is created by zdroid9770  :D

	© Copyright 2012

]]

function TaskmasterWhipfang_OnCombat(Unit, Event)
	UnitRegisterEvent("TaskmasterWhipfang_IntimidatingRoar", 12000, 0)
end

function TaskmasterWhipfang_IntimidatingRoar(Unit, Event) 
	UnitFullCastSpellOnTarget(16508, 	UnitGetMainTank()) 
end

function TaskmasterWhipfang_OnLeaveCombat(Unit, Event) 
	UnitRemoveEvents() 
end

function TaskmasterWhipfang_OnDied(Unit, Event) 
	UnitRemoveEvents()
end

function TaskmasterWhipfang_OnKilledTarget(Unit, Event) 
end

RegisterUnitEvent(5932, 1, "TaskmasterWhipfang_OnCombat")
RegisterUnitEvent(5932, 2, "TaskmasterWhipfang_OnLeaveCombat")
RegisterUnitEvent(5932, 3, "TaskmasterWhipfang_OnKilledTarget")
RegisterUnitEvent(5932, 4, "TaskmasterWhipfang_OnDied")