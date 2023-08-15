--[[

	This is created by zdroid9770  :D

	© Copyright 2012

]]


function GnarlpineWarrior_OnCombat(Unit, Event)
	Unit:RegisterEvent("GnarlpineWarrior_Strike", 6000, 0)
end

function GnarlpineWarrior_Strike(Unit, Event) 
	Unit:FullCastSpellOnTarget(11976, 	Unit:GetMainTank()) 
end

function GnarlpineWarrior_OnLeaveCombat(Unit, Event) 
	Unit:RemoveEvents() 
end

function GnarlpineWarrior_OnDied(Unit, Event) 
	Unit:RemoveEvents()
end

function GnarlpineWarrior_OnKilledTarget(Unit, Event) 
end

RegisterUnitEvent(2008, 1, "GnarlpineWarrior_OnCombat")
RegisterUnitEvent(2008, 2, "GnarlpineWarrior_OnLeaveCombat")
RegisterUnitEvent(2008, 3, "GnarlpineWarrior_OnKilledTarget")
RegisterUnitEvent(2008, 4, "GnarlpineWarrior_OnDied")