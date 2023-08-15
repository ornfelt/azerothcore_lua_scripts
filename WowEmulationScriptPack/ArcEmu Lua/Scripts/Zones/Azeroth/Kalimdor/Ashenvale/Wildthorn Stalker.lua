--[[

	This is created by zdroid9770  :D

	© Copyright 2012

]]


function WildthornStalker_OnCombat(Unit, Event)
	Unit:RegisterEvent("WildthornStalker_Web", 10000, 0)
end

function WildthornStalker_Web(pUnit, Event) 
	pUnit:FullCastSpellOnTarget(12023, 	pUnit:GetMainTank()) 
end

function WildthornStalker_OnLeaveCombat(Unit, Event) 
	Unit:RemoveEvents() 
end

function WildthornStalker_OnDied(Unit, Event) 
	Unit:RemoveEvents()
end

RegisterUnitEvent(3819, 1, "WildthornStalker_OnCombat")
RegisterUnitEvent(3819, 2, "WildthornStalker_OnLeaveCombat")
RegisterUnitEvent(3819, 4, "WildthornStalker_OnDied")