--[[

	This is created by zdroid9770  :D

	© Copyright 2012

]]


function WrathscaleNaga_OnCombat(Unit, Event)
	Unit:RegisterEvent("WrathscaleNaga_Hamstring", 8000, 0)
end

function WrathscaleNaga_Hamstring(pUnit, Event) 
	pUnit:FullCastSpellOnTarget(9080, 	pUnit:GetMainTank()) 
end

function WrathscaleNaga_OnLeaveCombat(Unit, Event) 
	Unit:RemoveEvents() 
end

function WrathscaleNaga_OnDied(Unit, Event) 
	Unit:RemoveEvents()
end

RegisterUnitEvent(17193, 1, "WrathscaleNaga_OnCombat")
RegisterUnitEvent(17193, 2, "WrathscaleNaga_OnLeaveCombat")
RegisterUnitEvent(17193, 4, "WrathscaleNaga_OnDied")