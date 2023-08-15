--[[

	This is created by zdroid9770  :D

	© Copyright 2012

]]

function BloodcursedNaga_OnCombat(Unit, Event)
	Unit:RegisterEvent("BloodcursedNaga_FrostArmor", 2000, 1)
	Unit:RegisterEvent("BloodcursedNaga_Frostbolt", 8000, 0)
end

function BloodcursedNaga_FrostArmor(pUnit, Event) 
	pUnit:CastSpell(12544) 
end

function BloodcursedNaga_Frostbolt(pUnit, Event) 
	pUnit:FullCastSpellOnTarget(20792, 	pUnit:GetMainTank()) 
end

function BloodcursedNaga_OnLeaveCombat(Unit, Event) 
	Unit:RemoveEvents() 
end

function BloodcursedNaga_OnDied(Unit, Event) 
	Unit:RemoveEvents()
end

RegisterUnitEvent(17713, 1, "BloodcursedNaga_OnCombat")
RegisterUnitEvent(17713, 2, "BloodcursedNaga_OnLeaveCombat")
RegisterUnitEvent(17713, 4, "BloodcursedNaga_OnDied")