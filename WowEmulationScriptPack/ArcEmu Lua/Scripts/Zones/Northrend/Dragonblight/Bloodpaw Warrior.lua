--[[

	This is created by zdroid9770  :D

	© Copyright 2012

]]


function BloodpawWarrior_OnCombat(Unit, Event)
Unit:RegisterEvent("BloodpawWarrior_Maul", 5000, 0)
end

function BloodpawWarrior_Maul(Unit, Event) 
Unit:FullCastSpellOnTarget(51875, Unit:GetMainTank()) 
end

function BloodpawWarrior_OnLeaveCombat(Unit, Event) 
Unit:RemoveEvents() 
end

function BloodpawWarrior_OnDied(Unit, Event) 
Unit:RemoveEvents()
end

function BloodpawWarrior_OnKilledTarget(Unit, Event) 
end

RegisterUnitEvent(27342, 1, "BloodpawWarrior_OnCombat")
RegisterUnitEvent(27342, 2, "BloodpawWarrior_OnLeaveCombat")
RegisterUnitEvent(27342, 3, "BloodpawWarrior_OnKilledTarget")
RegisterUnitEvent(27342, 4, "BloodpawWarrior_OnDied")