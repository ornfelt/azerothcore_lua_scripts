--[[

	This is created by zdroid9770  :D

	© Copyright 2012

]]


function DeathRavager_OnCombat(Unit, Event)
	Unit:RegisterEvent("DeathRavager_EnragingBite", 6000, 0)
	Unit:RegisterEvent("DeathRavager_Rend", 8000, 0)
end

function DeathRavager_EnragingBite(pUnit, Event) 
	pUnit:FullCastSpellOnTarget(30736, 	pUnit:GetMainTank()) 
end

function DeathRavager_Rend(pUnit, Event) 
	pUnit:FullCastSpellOnTarget(13443, 	pUnit:GetMainTank()) 
end

function DeathRavager_OnLeaveCombat(Unit, Event) 
	Unit:RemoveEvents() 
end

function DeathRavager_OnDied(Unit, Event) 
	Unit:RemoveEvents()
end

RegisterUnitEvent(17556, 1, "DeathRavager_OnCombat")
RegisterUnitEvent(17556, 2, "DeathRavager_OnLeaveCombat")
RegisterUnitEvent(17556, 4, "DeathRavager_OnDied")