--[[

	This is created by zdroid9770  :D

	© Copyright 2012

]]

function MutatedTangler_OnCombat(Unit, Event)
	Unit:RegisterEvent("MutatedTangler_EntanglingRoots", 10000, 0)
end

function MutatedTangler_EntanglingRoots(pUnit, Event) 
	pUnit:FullCastSpellOnTarget(31287, 	pUnit:GetMainTank()) 
end

function MutatedTangler_OnLeaveCombat(Unit, Event) 
	Unit:RemoveEvents() 
end

function MutatedTangler_OnDied(Unit, Event) 
	Unit:RemoveEvents()
end

RegisterUnitEvent(17346, 1, "MutatedTangler_OnCombat")
RegisterUnitEvent(17346, 2, "MutatedTangler_OnLeaveCombat")
RegisterUnitEvent(17346, 4, "MutatedTangler_OnDied")