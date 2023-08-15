--[[

	This is created by zdroid9770  :D

	© Copyright 2012

]]


function YoungWavethrasher_OnCombat(Unit, Event)
	Unit:RegisterEvent("YoungWavethrasher_Thrash", 5000, 0)
end

function YoungWavethrasher_Thrash(pUnit, Event) 
	pUnit:FullCastSpellOnTarget(3391, 	pUnit:GetMainTank()) 
end

function YoungWavethrasher_OnLeaveCombat(Unit, Event) 
	Unit:RemoveEvents() 
end

function YoungWavethrasher_OnDied(Unit, Event) 
	Unit:RemoveEvents()
end

RegisterUnitEvent(6347, 1, "YoungWavethrasher_OnCombat")
RegisterUnitEvent(6347, 2, "YoungWavethrasher_OnLeaveCombat")
RegisterUnitEvent(6347, 4, "YoungWavethrasher_OnDied")