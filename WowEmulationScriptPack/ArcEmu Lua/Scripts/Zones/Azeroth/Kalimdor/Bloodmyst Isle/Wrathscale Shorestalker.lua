--[[

	This is created by zdroid9770  :D

	© Copyright 2012

]]

function WrathscaleShorestalker_OnCombat(Unit, Event)
	Unit:RegisterEvent("WrathscaleShorestalker_Strike", 6000, 0)
end

function WrathscaleShorestalker_Strike(pUnit, Event) 
	pUnit:FullCastSpellOnTarget(11976, 	pUnit:GetMainTank()) 
end

function WrathscaleShorestalker_OnLeaveCombat(Unit, Event) 
	Unit:RemoveEvents() 
end

function WrathscaleShorestalker_OnDied(Unit, Event) 
	Unit:RemoveEvents()
end

RegisterUnitEvent(17331, 1, "WrathscaleShorestalker_OnCombat")
RegisterUnitEvent(17331, 2, "WrathscaleShorestalker_OnLeaveCombat")
RegisterUnitEvent(17331, 4, "WrathscaleShorestalker_OnDied")