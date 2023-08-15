--[[

	This is created by zdroid9770  :D

	© Copyright 2012

]]

function SparkleshellSnapper_OnCombat(Unit, Event)
	UnitRegisterEvent("SparkleshellSnapper_HeadButt", 10000, 0)
end

function SparkleshellSnapper_HeadButt(Unit, Event) 
	UnitFullCastSpellOnTarget(6730, 	UnitGetClosestPlayer()) 
end

function SparkleshellSnapper_OnLeaveCombat(Unit, Event) 
	UnitRemoveEvents() 
end

function SparkleshellSnapper_OnDied(Unit, Event) 
	UnitRemoveEvents()
end

function SparkleshellSnapper_OnKilledTarget(Unit, Event) 
end

RegisterUnitEvent(4143, 1, "SparkleshellSnapper_OnCombat")
RegisterUnitEvent(4143, 2, "SparkleshellSnapper_OnLeaveCombat")
RegisterUnitEvent(4143, 3, "SparkleshellSnapper_OnKilledTarget")
RegisterUnitEvent(4143, 4, "SparkleshellSnapper_OnDied")