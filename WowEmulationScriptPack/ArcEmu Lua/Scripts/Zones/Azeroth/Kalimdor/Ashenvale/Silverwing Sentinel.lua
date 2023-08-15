--[[

	This is created by zdroid9770  :D

	© Copyright 2012

]]


function SilverwingSentinel_OnCombat(Unit, Event)
	Unit:RegisterEvent("SilverwingSentinel_Shoot", 6000, 0)
end

function SilverwingSentinel_Shoot(pUnit, Event) 
	pUnit:FullCastSpellOnTarget(6660, 	pUnit:GetMainTank()) 
end

function SilverwingSentinel_OnLeaveCombat(Unit, Event) 
	Unit:RemoveEvents() 
end

function SilverwingSentinel_OnDied(Unit, Event) 
	Unit:RemoveEvents()
end

RegisterUnitEvent(12896, 1, "SilverwingSentinel_OnCombat")
RegisterUnitEvent(12896, 2, "SilverwingSentinel_OnLeaveCombat")
RegisterUnitEvent(12896, 4, "SilverwingSentinel_OnDied")