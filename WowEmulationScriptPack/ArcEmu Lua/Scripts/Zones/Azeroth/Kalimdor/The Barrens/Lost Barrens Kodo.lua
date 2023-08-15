--[[

	This is created by zdroid9770  :D

	© Copyright 2012

]]

function LostBarrensKodo_OnCombat(Unit, Event)
	Unit:RegisterEvent("LostBarrensKodo_KodoStomp", 6000, 0)
end

function LostBarrensKodo_KodoStomp(Unit, Event) 
	Unit:CastSpell(6266) 
end

function LostBarrensKodo_OnLeaveCombat(Unit, Event) 
	Unit:RemoveEvents() 
end

function LostBarrensKodo_OnDied(Unit, Event) 
	Unit:RemoveEvents()
end

function LostBarrensKodo_OnKilledTarget(Unit, Event) 
end

RegisterUnitEvent(3236, 1, "LostBarrensKodo_OnCombat")
RegisterUnitEvent(3236, 2, "LostBarrensKodo_OnLeaveCombat")
RegisterUnitEvent(3236, 3, "LostBarrensKodo_OnKilledTarget")
RegisterUnitEvent(3236, 4, "LostBarrensKodo_OnDied")