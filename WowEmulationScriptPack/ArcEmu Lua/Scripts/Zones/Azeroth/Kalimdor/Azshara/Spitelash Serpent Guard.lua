--[[

	This is created by zdroid9770  :D

	© Copyright 2012

]]


function SpitelashSerpentGuard_OnCombat(Unit, Event)
	Unit:RegisterEvent("SpitelashSerpentGuard_FrostShock", 6000, 0)
end

function SpitelashSerpentGuard_FrostShock(pUnit, Event) 
	pUnit:FullCastSpellOnTarget(12548, 	pUnit:GetMainTank()) 
end

function SpitelashSerpentGuard_OnLeaveCombat(Unit, Event) 
	Unit:RemoveEvents() 
end

function SpitelashSerpentGuard_OnDied(Unit, Event) 
	Unit:RemoveEvents()
end

RegisterUnitEvent(6194, 1, "SpitelashSerpentGuard_OnCombat")
RegisterUnitEvent(6194, 2, "SpitelashSerpentGuard_OnLeaveCombat")
RegisterUnitEvent(6194, 4, "SpitelashSerpentGuard_OnDied")