--[[

	This is created by zdroid9770  :D

	© Copyright 2012

]]


function TimbermawWarrior_OnCombat(Unit, Event)
	Unit:RegisterEvent("TimbermawWarrior_Rend", 10000, 0)
	Unit:RegisterEvent("TimbermawWarrior_Strike", 6000, 0)
end

function TimbermawWarrior_Rend(pUnit, Event) 
	pUnit:FullCastSpellOnTarget(11977, 	pUnit:GetMainTank()) 
end

function TimbermawWarrior_Strike(pUnit, Event) 
	pUnit:FullCastSpellOnTarget(11976, 	pUnit:GetMainTank()) 
end

function TimbermawWarrior_OnLeaveCombat(Unit, Event) 
	Unit:RemoveEvents() 
end

function TimbermawWarrior_OnDied(Unit, Event) 
	Unit:RemoveEvents()
end

RegisterUnitEvent(6185, 1, "TimbermawWarrior_OnCombat")
RegisterUnitEvent(6185, 2, "TimbermawWarrior_OnLeaveCombat")
RegisterUnitEvent(6185, 4, "TimbermawWarrior_OnDied")