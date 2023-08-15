--[[

	This is created by zdroid9770  :D

	© Copyright 2012

]]

function WrathscaleMarauder_OnCombat(Unit, Event)
	Unit:RegisterEvent("WrathscaleMarauder_Pummel", 8000, 0)
end

function WrathscaleMarauder_Pummel(pUnit, Event) 
	pUnit:FullCastSpellOnTarget(12555, 	pUnit:GetMainTank()) 
end

function WrathscaleMarauder_OnLeaveCombat(Unit, Event) 
	Unit:RemoveEvents() 
end

function WrathscaleMarauder_OnDied(Unit, Event) 
	Unit:RemoveEvents()
end

RegisterUnitEvent(17334, 1, "WrathscaleMarauder_OnCombat")
RegisterUnitEvent(17334, 2, "WrathscaleMarauder_OnLeaveCombat")
RegisterUnitEvent(17334, 4, "WrathscaleMarauder_OnDied")