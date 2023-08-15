--[[

	This is created by zdroid9770  :D

	© Copyright 2012

]]


function HordeDeforester_OnCombat(Unit, Event)
	Unit:RegisterEvent("HordeDeforester_SunderArmor", 6000, 0)
end

function HordeDeforester_SunderArmor(pUnit, Event) 
	pUnit:FullCastSpellOnTarget(11971, 	pUnit:GetMainTank()) 
end

function HordeDeforester_OnLeaveCombat(Unit, Event) 
	Unit:RemoveEvents() 
end

function HordeDeforester_OnDied(Unit, Event) 
	Unit:RemoveEvents()
end

RegisterUnitEvent(11681, 1, "HordeDeforester_OnCombat")
RegisterUnitEvent(11681, 2, "HordeDeforester_OnLeaveCombat")
RegisterUnitEvent(11681, 4, "HordeDeforester_OnDied")