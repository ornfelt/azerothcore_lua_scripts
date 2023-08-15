--[[

	This is created by zdroid9770  :D

	© Copyright 2012

]]

function DethryllSatyr_OnCombat(Unit, Event)
	Unit:RegisterEvent("DethryllSatyr_Shoot", 6000, 0)
end

function DethryllSatyr_Shoot(pUnit, Event) 
	pUnit:FullCastSpellOnTarget(6660, 	pUnit:GetMainTank()) 
end

function DethryllSatyr_OnLeaveCombat(Unit, Event) 
	Unit:RemoveEvents() 
end

function DethryllSatyr_OnDied(Unit, Event) 
	Unit:RemoveEvents()
end

RegisterUnitEvent(2212, 1, "DethryllSatyr_OnCombat")
RegisterUnitEvent(2212, 2, "DethryllSatyr_OnLeaveCombat")
RegisterUnitEvent(2212, 4, "DethryllSatyr_OnDied")