--[[

	This is created by zdroid9770  :D

	© Copyright 2012

]]


function GreatWavethrasher_OnCombat(Unit, Event)
	Unit:RegisterEvent("GreatWavethrasher_Thrash", 5000, 0)
end

function GreatWavethrasher_Thrash(pUnit, Event) 
	pUnit:FullCastSpellOnTarget(3391, 	pUnit:GetMainTank()) 
end

function GreatWavethrasher_OnLeaveCombat(Unit, Event) 
	Unit:RemoveEvents() 
end

function GreatWavethrasher_OnDied(Unit, Event) 
	Unit:RemoveEvents()
end

RegisterUnitEvent(6349, 1, "GreatWavethrasher_OnCombat")
RegisterUnitEvent(6349, 2, "GreatWavethrasher_OnLeaveCombat")
RegisterUnitEvent(6349, 4, "GreatWavethrasher_OnDied")