--[[

	This is created by zdroid9770  :D

	© Copyright 2012

]]


function SplintertreeRaider_OnCombat(Unit, Event)
	Unit:RegisterEvent("SplintertreeRaider_Enrage", 10000, 0)
end

function SplintertreeRaider_Enrage(pUnit, Event) 
	pUnit:CastSpell(8599) 
end

function SplintertreeRaider_OnLeaveCombat(Unit, Event) 
	Unit:RemoveEvents() 
end

function SplintertreeRaider_OnDied(Unit, Event) 
	Unit:RemoveEvents()
end

RegisterUnitEvent(12859, 1, "SplintertreeRaider_OnCombat")
RegisterUnitEvent(12859, 2, "SplintertreeRaider_OnLeaveCombat")
RegisterUnitEvent(12859, 4, "SplintertreeRaider_OnDied")