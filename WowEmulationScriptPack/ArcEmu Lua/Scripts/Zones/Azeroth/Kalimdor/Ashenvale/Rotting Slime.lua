--[[

	This is created by zdroid9770  :D

	© Copyright 2012

]]


function RottingSlime_OnCombat(Unit, Event)
	Unit:RegisterEvent("RottingSlime_DiseasedSlime", 10000, 0)
end

function RottingSlime_DiseasedSlime(pUnit, Event) 
	pUnit:FullCastSpellOnTarget(6907, 	pUnit:GetMainTank()) 
end

function RottingSlime_OnLeaveCombat(Unit, Event) 
	Unit:RemoveEvents() 
end

function RottingSlime_OnDied(Unit, Event) 
	Unit:RemoveEvents()
end

RegisterUnitEvent(3928, 1, "RottingSlime_OnCombat")
RegisterUnitEvent(3928, 2, "RottingSlime_OnLeaveCombat")
RegisterUnitEvent(3928, 4, "RottingSlime_OnDied")