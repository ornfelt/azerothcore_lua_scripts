--[[

	This is created by zdroid9770  :D

	© Copyright 2012

]]


function FoulwealdPathfinder_OnCombat(Unit, Event)
	Unit:RegisterEvent("FoulwealdPathfinder_Shoot", 6000, 0)
end

function FoulwealdPathfinder_Shoot(pUnit, Event) 
	pUnit:FullCastSpellOnTarget(6660, 	pUnit:GetMainTank()) 
end

function FoulwealdPathfinder_OnLeaveCombat(Unit, Event) 
	Unit:RemoveEvents() 
end

function FoulwealdPathfinder_OnDied(Unit, Event) 
	Unit:RemoveEvents()
end

RegisterUnitEvent(3745, 1, "FoulwealdPathfinder_OnCombat")
RegisterUnitEvent(3745, 2, "FoulwealdPathfinder_OnLeaveCombat")
RegisterUnitEvent(3745, 4, "FoulwealdPathfinder_OnDied")