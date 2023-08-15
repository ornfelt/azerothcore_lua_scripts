--[[

	This is created by zdroid9770  :D

	© Copyright 2012

]]


function SpitelashWarrior_OnCombat(Unit, Event)
	Unit:RegisterEvent("SpitelashWarrior_Disarm", 8000, 0)
end

function SpitelashWarrior_Disarm(pUnit, Event) 
	pUnit:FullCastSpellOnTarget(6713, 	pUnit:GetMainTank()) 
end

function SpitelashWarrior_OnLeaveCombat(Unit, Event) 
	Unit:RemoveEvents() 
end

function SpitelashWarrior_OnDied(Unit, Event) 
	Unit:RemoveEvents()
end

RegisterUnitEvent(6190, 1, "SpitelashWarrior_OnCombat")
RegisterUnitEvent(6190, 2, "SpitelashWarrior_OnLeaveCombat")
RegisterUnitEvent(6190, 4, "SpitelashWarrior_OnDied")