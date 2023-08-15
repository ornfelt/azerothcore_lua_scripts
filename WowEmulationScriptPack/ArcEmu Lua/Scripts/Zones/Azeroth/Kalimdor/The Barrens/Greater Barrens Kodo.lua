--[[

	This is created by zdroid9770  :D

	© Copyright 2012

]]

function GreaterBarrensKodo_OnCombat(Unit, Event)
	Unit:RegisterEvent("GreaterBarrensKodo_RushingCharge", 8000, 0)
end

function GreaterBarrensKodo_RushingCharge(Unit, Event) 
	Unit:CastSpell(6268) 
end

function GreaterBarrensKodo_OnLeaveCombat(Unit, Event) 
	Unit:RemoveEvents() 
end

function GreaterBarrensKodo_OnDied(Unit, Event) 
	Unit:RemoveEvents()
end

function GreaterBarrensKodo_OnKilledTarget(Unit, Event) 
end

RegisterUnitEvent(3235, 1, "GreaterBarrensKodo_OnCombat")
RegisterUnitEvent(3235, 2, "GreaterBarrensKodo_OnLeaveCombat")
RegisterUnitEvent(3235, 3, "GreaterBarrensKodo_OnKilledTarget")
RegisterUnitEvent(3235, 4, "GreaterBarrensKodo_OnDied")