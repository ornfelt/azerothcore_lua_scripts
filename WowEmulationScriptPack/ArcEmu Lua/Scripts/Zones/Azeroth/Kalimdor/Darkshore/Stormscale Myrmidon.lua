--[[

	This is created by zdroid9770  :D

	© Copyright 2012

]]


function StormscaleMyrmidon_OnCombat(Unit, Event)
	Unit:RegisterEvent("StormscaleMyrmidon_Knockdown", 8000, 0)
end

function StormscaleMyrmidon_Knockdown(pUnit, Event) 
	pUnit:FullCastSpellOnTarget(5164, 	pUnit:GetMainTank()) 
end

function StormscaleMyrmidon_OnLeaveCombat(Unit, Event) 
	Unit:RemoveEvents() 
end

function StormscaleMyrmidon_OnDied(Unit, Event) 
	Unit:RemoveEvents()
end

RegisterUnitEvent(2181, 1, "StormscaleMyrmidon_OnCombat")
RegisterUnitEvent(2181, 2, "StormscaleMyrmidon_OnLeaveCombat")
RegisterUnitEvent(2181, 4, "StormscaleMyrmidon_OnDied")