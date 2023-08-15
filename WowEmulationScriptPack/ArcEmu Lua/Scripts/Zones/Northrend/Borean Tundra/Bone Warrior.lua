--[[

	This is created by zdroid9770  :D

	© Copyright 2012

]]


function BoneWarrior_OnCombat(Unit, Event)
Unit:RegisterEvent("BoneWarrior_SunderArmor", 6000, 0)
end

function BoneWarrior_SunderArmor(Unit, Event) 
Unit:FullCastSpellOnTarget(50370, Unit:GetMainTank()) 
end

function BoneWarrior_OnLeaveCombat(Unit, Event) 
Unit:RemoveEvents() 
end

function BoneWarrior_OnDied(Unit, Event) 
Unit:RemoveEvents()
end

function BoneWarrior_OnKilledTarget(Unit, Event) 
end

RegisterUnitEvent(26126, 1, "BoneWarrior_OnCombat")
RegisterUnitEvent(26126, 2, "BoneWarrior_OnLeaveCombat")
RegisterUnitEvent(26126, 3, "BoneWarrior_OnKilledTarget")
RegisterUnitEvent(26126, 4, "BoneWarrior_OnDied")