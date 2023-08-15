--[[

	This is created by zdroid9770  :D

	© Copyright 2012

]]

function FrigidNecromancerAttacker_OnCombat(Unit, Event)
Unit:RegisterEvent("FrigidNecromancerAttacker_BoneArmor", 2000, 1)
Unit:RegisterEvent("FrigidNecromancerAttacker_ShadowBolt", 7000, 0)
end

function FrigidNecromancerAttacker_BoneArmor(Unit, Event) 
Unit:CastSpell(50324) 
end

function FrigidNecromancerAttacker_ShadowBolt(Unit, Event) 
Unit:FullCastSpellOnTarget(9613, Unit:GetMainTank()) 
end

function FrigidNecromancerAttacker_OnLeaveCombat(Unit, Event) 
Unit:RemoveEvents() 
end

function FrigidNecromancerAttacker_OnDied(Unit, Event) 
Unit:RemoveEvents()
end

function FrigidNecromancerAttacker_OnKilledTarget(Unit, Event) 
end

RegisterUnitEvent(27687, 1, "FrigidNecromancerAttacker_OnCombat")
RegisterUnitEvent(27687, 2, "FrigidNecromancerAttacker_OnLeaveCombat")
RegisterUnitEvent(27687, 3, "FrigidNecromancerAttacker_OnKilledTarget")
RegisterUnitEvent(27687, 4, "FrigidNecromancerAttacker_OnDied")