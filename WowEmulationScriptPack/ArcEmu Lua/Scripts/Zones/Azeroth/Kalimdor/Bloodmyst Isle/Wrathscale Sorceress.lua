--[[

	This is created by zdroid9770  :D

	© Copyright 2012

]]

function WrathscaleSorceress_OnCombat(Unit, Event)
	Unit:RegisterEvent("WrathscaleSorceress_Frostbolt", 8000, 0)
end

function WrathscaleSorceress_Frostbolt(pUnit, Event) 
	pUnit:FullCastSpellOnTarget(9672, 	pUnit:GetMainTank()) 
end

function WrathscaleSorceress_OnLeaveCombat(Unit, Event) 
	Unit:RemoveEvents() 
end

function WrathscaleSorceress_OnDied(Unit, Event) 
	Unit:RemoveEvents()
end

RegisterUnitEvent(17336, 1, "WrathscaleSorceress_OnCombat")
RegisterUnitEvent(17336, 2, "WrathscaleSorceress_OnLeaveCombat")
RegisterUnitEvent(17336, 4, "WrathscaleSorceress_OnDied")