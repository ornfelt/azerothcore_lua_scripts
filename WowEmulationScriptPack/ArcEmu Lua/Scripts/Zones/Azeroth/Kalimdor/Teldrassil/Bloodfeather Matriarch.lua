--[[

	This is created by zdroid9770  :D

	© Copyright 2012

]]


function BloodfeatherMatriarch_OnCombat(Unit, Event)
	Unit:RegisterEvent("BloodfeatherMatriarch_HealingWave", 12000, 0)
	Unit:RegisterEvent("BloodfeatherMatriarch_LightningBolt", 8000, 0)
end

function BloodfeatherMatriarch_HealingWave(Unit, Event) 
	Unit:CastSpell(332) 
end

function BloodfeatherMatriarch_LightningBolt(Unit, Event) 
	Unit:FullCastSpellOnTarget(9532, 	Unit:GetMainTank()) 
end

function BloodfeatherMatriarch_OnLeaveCombat(Unit, Event) 
	Unit:RemoveEvents() 
end

function BloodfeatherMatriarch_OnDied(Unit, Event) 
	Unit:RemoveEvents()
end

function BloodfeatherMatriarch_OnKilledTarget(Unit, Event) 
end

RegisterUnitEvent(2021, 1, "BloodfeatherMatriarch_OnCombat")
RegisterUnitEvent(2021, 2, "BloodfeatherMatriarch_OnLeaveCombat")
RegisterUnitEvent(2021, 3, "BloodfeatherMatriarch_OnKilledTarget")
RegisterUnitEvent(2021, 4, "BloodfeatherMatriarch_OnDied")