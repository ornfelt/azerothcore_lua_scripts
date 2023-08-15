--[[

	This is created by zdroid9770  :D

	© Copyright 2012

]]

function BarrensKodo_OnCombat(Unit, Event)
	Unit:RegisterEvent("BarrensKodo_KodoStomp", 6000, 0)
end

function BarrensKodo_KodoStomp(Unit, Event) 
	Unit:CastSpell(6266) 
end

function BarrensKodo_OnLeaveCombat(Unit, Event) 
	Unit:RemoveEvents() 
end

function BarrensKodo_OnDied(Unit, Event) 
	Unit:RemoveEvents()
end

function BarrensKodo_OnKilledTarget(Unit, Event) 
end

RegisterUnitEvent(3236, 1, "BarrensKodo_OnCombat")
RegisterUnitEvent(3236, 2, "BarrensKodo_OnLeaveCombat")
RegisterUnitEvent(3236, 3, "BarrensKodo_OnKilledTarget")
RegisterUnitEvent(3236, 4, "BarrensKodo_OnDied")