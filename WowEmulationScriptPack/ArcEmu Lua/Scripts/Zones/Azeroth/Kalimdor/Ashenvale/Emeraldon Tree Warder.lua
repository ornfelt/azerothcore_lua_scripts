--[[

	This is created by zdroid9770  :D

	© Copyright 2012

]]


function EmeraldonTreeWarder_OnCombat(Unit, Event)
	Unit:RegisterEvent("EmeraldonTreeWarder_FaerieFire", 2000, 2)
	Unit:RegisterEvent("EmeraldonTreeWarder_EntanglingRoots", 8000, 0)
end

function EmeraldonTreeWarder_FaerieFire(pUnit, Event) 
	pUnit:FullCastSpellOnTarget(20656, 	pUnit:GetMainTank()) 
end

function EmeraldonTreeWarder_EntanglingRoots(pUnit, Event) 
	pUnit:FullCastSpellOnTarget(20654, 	pUnit:GetMainTank()) 
end

function EmeraldonTreeWarder_OnLeaveCombat(Unit, Event) 
	Unit:RemoveEvents() 
end

function EmeraldonTreeWarder_OnDied(Unit, Event) 
	Unit:RemoveEvents()
end

RegisterUnitEvent(12475, 1, "EmeraldonTreeWarder_OnCombat")
RegisterUnitEvent(12475, 2, "EmeraldonTreeWarder_OnLeaveCombat")
RegisterUnitEvent(12475, 4, "EmeraldonTreeWarder_OnDied")