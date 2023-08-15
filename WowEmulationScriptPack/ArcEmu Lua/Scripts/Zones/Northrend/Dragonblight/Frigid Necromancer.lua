--[[

	This is created by zdroid9770  :D

	© Copyright 2012

]]

function FrigidNecromancer_OnCombat(Unit, Event)
Unit:RegisterEvent("FrigidNecromancer_BoneArmor", 2000, 1)
Unit:RegisterEvent("FrigidNecromancer_ShadowBolt", 7000, 0)
end

function FrigidNecromancer_BoneArmor(Unit, Event) 
Unit:CastSpell(50324) 
end

function FrigidNecromancer_ShadowBolt(Unit, Event) 
Unit:FullCastSpellOnTarget(9613, Unit:GetMainTank()) 
end

function FrigidNecromancer_OnLeaveCombat(Unit, Event) 
Unit:RemoveEvents() 
end

function FrigidNecromancer_OnDied(Unit, Event) 
Unit:RemoveEvents()
end

function FrigidNecromancer_OnKilledTarget(Unit, Event) 
end

RegisterUnitEvent(27539, 1, "FrigidNecromancer_OnCombat")
RegisterUnitEvent(27539, 2, "FrigidNecromancer_OnLeaveCombat")
RegisterUnitEvent(27539, 3, "FrigidNecromancer_OnKilledTarget")
RegisterUnitEvent(27539, 4, "FrigidNecromancer_OnDied")