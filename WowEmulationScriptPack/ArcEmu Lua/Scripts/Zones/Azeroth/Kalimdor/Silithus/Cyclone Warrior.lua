--[[

	This is created by zdroid9770  :D

	© Copyright 2012

]]


function CycloneWarrior_OnCombat(Unit, Event)
	Unit:RegisterEvent("CycloneWarrior_Shock", 6000, 0)
end

function CycloneWarrior_Shock(Unit, Event) 
	Unit:FullCastSpellOnTarget(12553, 	Unit:GetMainTank()) 
end

function CycloneWarrior_OnLeaveCombat(Unit, Event) 
	Unit:RemoveEvents() 
end

function CycloneWarrior_OnDied(Unit, Event) 
	Unit:RemoveEvents()
end

function CycloneWarrior_OnKilledTarget(Unit, Event) 
end

RegisterUnitEvent(11745, 1, "CycloneWarrior_OnCombat")
RegisterUnitEvent(11745, 2, "CycloneWarrior_OnLeaveCombat")
RegisterUnitEvent(11745, 3, "CycloneWarrior_OnKilledTarget")
RegisterUnitEvent(11745, 4, "CycloneWarrior_OnDied")