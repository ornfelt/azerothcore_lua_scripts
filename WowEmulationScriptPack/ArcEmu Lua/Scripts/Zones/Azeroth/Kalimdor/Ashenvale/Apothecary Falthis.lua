--[[

	This is created by zdroid9770  :D

	© Copyright 2012

]]


function ApothecaryFalthis_OnCombat(Unit, Event)
	Unit:RegisterEvent("ApothecaryFalthis_ShadowBolt", 8000, 0)
end

function ApothecaryFalthis_ShadowBolt(pUnit, Event) 
	pUnit:FullCastSpellOnTarget(20791, 	pUnit:GetMainTank()) 
end

function ApothecaryFalthis_OnLeaveCombat(Unit, Event) 
	Unit:RemoveEvents() 
end

function ApothecaryFalthis_OnDied(Unit, Event) 
	Unit:RemoveEvents()
end

RegisterUnitEvent(3735, 1, "ApothecaryFalthis_OnCombat")
RegisterUnitEvent(3735, 2, "ApothecaryFalthis_OnLeaveCombat")
RegisterUnitEvent(3735, 4, "ApothecaryFalthis_OnDied")