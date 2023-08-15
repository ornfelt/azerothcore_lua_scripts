--[[

	This is created by zdroid9770  :D

	© Copyright 2012

]]

function BristlelimbWarrior_OnCombat(Unit, Event)
	Unit:RegisterEvent("BristlelimbWarrior_Strike", 6000, 0)
end

function BristlelimbWarrior_Strike(pUnit, Event) 
	pUnit:FullCastSpellOnTarget(11976, 	pUnit:GetMainTank()) 
end

function BristlelimbWarrior_OnLeaveCombat(Unit, Event) 
	Unit:RemoveEvents() 
end

function BristlelimbWarrior_OnDied(Unit, Event) 
	Unit:RemoveEvents()
end

RegisterUnitEvent(17321, 1, "BristlelimbWarrior_OnCombat")
RegisterUnitEvent(17321, 2, "BristlelimbWarrior_OnLeaveCombat")
RegisterUnitEvent(17321, 4, "BristlelimbWarrior_OnDied")