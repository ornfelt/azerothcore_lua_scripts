--[[

	This is created by zdroid9770  :D

	© Copyright 2012

]]
function MystLeecher_OnCombat(Unit, Event)
	Unit:RegisterEvent("MystLeecher_LeechPoison", 10000, 0)
end

function MystLeecher_LeechPoison(pUnit, Event) 
	pUnit:FullCastSpellOnTarget(31288, 	pUnit:GetMainTank()) 
end

function MystLeecher_OnLeaveCombat(Unit, Event) 
	Unit:RemoveEvents() 
end

function MystLeecher_OnDied(Unit, Event) 
	Unit:RemoveEvents()
end

RegisterUnitEvent(17523, 1, "MystLeecher_OnCombat")
RegisterUnitEvent(17523, 2, "MystLeecher_OnLeaveCombat")
RegisterUnitEvent(17523, 4, "MystLeecher_OnDied")