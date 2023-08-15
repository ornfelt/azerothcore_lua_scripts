--[[

	This is created by zdroid9770  :D

	© Copyright 2012

]]


function Wavethrasher_OnCombat(Unit, Event)
	Unit:RegisterEvent("Wavethrasher_Thrash", 5000, 0)
end

function Wavethrasher_Thrash(pUnit, Event) 
	pUnit:FullCastSpellOnTarget(3391, 	pUnit:GetMainTank()) 
end

function Wavethrasher_OnLeaveCombat(Unit, Event) 
	Unit:RemoveEvents() 
end

function Wavethrasher_OnDied(Unit, Event) 
	Unit:RemoveEvents()
end

RegisterUnitEvent(6348, 1, "Wavethrasher_OnCombat")
RegisterUnitEvent(6348, 2, "Wavethrasher_OnLeaveCombat")
RegisterUnitEvent(6348, 4, "Wavethrasher_OnDied")