--[[

	This is created by zdroid9770  :D

	© Copyright 2012

]]


function ForestOoze_OnCombat(Unit, Event)
	Unit:RegisterEvent("ForestOoze_DiseasedSlime", 2000, 2)
end

function ForestOoze_DiseasedSlime(pUnit, Event) 
	pUnit:FullCastSpellOnTarget(6907, 	pUnit:GetMainTank()) 
end

function ForestOoze_OnLeaveCombat(Unit, Event) 
	Unit:RemoveEvents() 
end

function ForestOoze_OnDied(Unit, Event) 
	Unit:RemoveEvents()
end

RegisterUnitEvent(8766, 1, "ForestOoze_OnCombat")
RegisterUnitEvent(8766, 2, "ForestOoze_OnLeaveCombat")
RegisterUnitEvent(8766, 4, "ForestOoze_OnDied")