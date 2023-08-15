--[[

	This is created by zdroid9770  :D

	© Copyright 2012

]]


function MistwingRavager_OnCombat(Unit, Event)
	Unit:RegisterEvent("MistwingRavager_PoisonedShot", 10000, 0)
end

function MistwingRavager_PoisonedShot(pUnit, Event) 
	pUnit:FullCastSpellOnTarget(8806, 	pUnit:GetMainTank()) 
end

function MistwingRavager_OnLeaveCombat(Unit, Event) 
	Unit:RemoveEvents() 
end

function MistwingRavager_OnDied(Unit, Event) 
	Unit:RemoveEvents()
end

RegisterUnitEvent(8764, 1, "MistwingRavager_OnCombat")
RegisterUnitEvent(8764, 2, "MistwingRavager_OnLeaveCombat")
RegisterUnitEvent(8764, 4, "MistwingRavager_OnDied")