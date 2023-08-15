--[[

	This is created by zdroid9770  :D

	© Copyright 2012

]]


function WrathscaleMyrmidon_OnCombat(Unit, Event)
	Unit:RegisterEvent("WrathscaleMyrmidon_Strike", 6000, 0)
end

function WrathscaleMyrmidon_Strike(pUnit, Event) 
	pUnit:FullCastSpellOnTarget(11976, 	pUnit:GetMainTank()) 
end

function WrathscaleMyrmidon_OnLeaveCombat(Unit, Event) 
	Unit:RemoveEvents() 
end

function WrathscaleMyrmidon_OnDied(Unit, Event) 
	Unit:RemoveEvents()
end

RegisterUnitEvent(17194, 1, "WrathscaleMyrmidon_OnCombat")
RegisterUnitEvent(17194, 2, "WrathscaleMyrmidon_OnLeaveCombat")
RegisterUnitEvent(17194, 4, "WrathscaleMyrmidon_OnDied")