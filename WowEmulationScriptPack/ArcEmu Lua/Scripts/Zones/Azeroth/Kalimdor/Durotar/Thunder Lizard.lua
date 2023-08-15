--[[

	This is created by zdroid9770  :D

	© Copyright 2012

]]

function ThunderLizard_OnCombat(Unit, Event)
	Unit:RegisterEvent("ThunderLizard_LizardBolt", 5000, 0)
end

function ThunderLizard_LizardBolt(Unit, Event) 
	Unit:FullCastSpellOnTarget(5401, 	Unit:GetMainTank()) 
end

function ThunderLizard_OnLeaveCombat(Unit, Event) 
	Unit:RemoveEvents() 
end

function ThunderLizard_OnDied(Unit, Event) 
	Unit:RemoveEvents()
end

function ThunderLizard_OnKilledTarget(Unit, Event) 
end

RegisterUnitEvent(3130, 1, "ThunderLizard_OnCombat")
RegisterUnitEvent(3130, 2, "ThunderLizard_OnLeaveCombat")
RegisterUnitEvent(3130, 3, "ThunderLizard_OnKilledTarget")
RegisterUnitEvent(3130, 4, "ThunderLizard_OnDied")