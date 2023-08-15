--[[

	This is created by zdroid9770  :D

	© Copyright 2012

]]

function EnkilahNecrolord_OnCombat(Unit, Event)
Unit:RegisterEvent("EnkilahNecrolord_BoneArmor", 2000, 1)
Unit:RegisterEvent("EnkilahNecrolord_SharpenedBone", 6000, 0)
end

function EnkilahNecrolord_BoneArmor(Unit, Event) 
Unit:CastSpell(50324) 
end

function EnkilahNecrolord_SharpenedBone(Unit, Event) 
Unit:FullCastSpellOnTarget(50323, Unit:GetMainTank()) 
end

function EnkilahNecrolord_OnLeaveCombat(Unit, Event) 
Unit:RemoveEvents() 
end

function EnkilahNecrolord_OnDied(Unit, Event) 
Unit:RemoveEvents()
end

function EnkilahNecrolord_OnKilledTarget(Unit, Event) 
end

RegisterUnitEvent(25609, 1, "EnkilahNecrolord_OnCombat")
RegisterUnitEvent(25609, 2, "EnkilahNecrolord_OnLeaveCombat")
RegisterUnitEvent(25609, 3, "EnkilahNecrolord_OnKilledTarget")
RegisterUnitEvent(25609, 4, "EnkilahNecrolord_OnDied")