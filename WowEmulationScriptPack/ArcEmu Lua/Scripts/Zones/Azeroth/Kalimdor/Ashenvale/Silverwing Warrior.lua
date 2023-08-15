--[[

	This is created by zdroid9770  :D

	© Copyright 2012

]]


function SilverwingWarrior_OnCombat(Unit, Event)
	Unit:RegisterEvent("SilverwingWarrior_Rend", 10000, 0)
end

function SilverwingWarrior_Rend(pUnit, Event) 
	pUnit:FullCastSpellOnTarget(13445, 	pUnit:GetMainTank()) 
end

function SilverwingWarrior_OnLeaveCombat(Unit, Event) 
	Unit:RemoveEvents() 
end

function SilverwingWarrior_OnDied(Unit, Event) 
	Unit:RemoveEvents()
end

RegisterUnitEvent(12897, 1, "SilverwingWarrior_OnCombat")
RegisterUnitEvent(12897, 2, "SilverwingWarrior_OnLeaveCombat")
RegisterUnitEvent(12897, 4, "SilverwingWarrior_OnDied")