--[[

	This is created by zdroid9770  :D

	© Copyright 2012

]]


function BurningBladeInvoker_OnCombat(Unit, Event)
	Unit:RegisterEvent("BurningBladeInvoker_FlameBuffet", 8000, 0)
end

function BurningBladeInvoker_FlameBuffet(Unit, Event) 
	Unit:FullCastSpellOnTarget(9658, 	Unit:GetMainTank()) 
end

function BurningBladeInvoker_OnLeaveCombat(Unit, Event) 
	Unit:RemoveEvents() 
end

function BurningBladeInvoker_OnDied(Unit, Event) 
	Unit:RemoveEvents()
end

RegisterUnitEvent(4705, 1, "BurningBladeInvoker_OnCombat")
RegisterUnitEvent(4705, 2, "BurningBladeInvoker_OnLeaveCombat")
RegisterUnitEvent(4705, 4, "BurningBladeInvoker_OnDied")