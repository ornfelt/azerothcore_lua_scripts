--[[

	This is created by zdroid9770  :D

	© Copyright 2012

]]


function ElderThunderLizard_OnCombat(Unit, Event)
	Unit:RegisterEvent("ElderThunderLizard_LizardBolt", 8000, 0)
end

function ElderThunderLizard_LizardBolt(Unit, Event) 
	Unit:FullCastSpellOnTarget(5401, 	Unit:GetMainTank()) 
end

function ElderThunderLizard_OnLeaveCombat(Unit, Event) 
	Unit:RemoveEvents() 
end

function ElderThunderLizard_OnDied(Unit, Event) 
	Unit:RemoveEvents()
end

function ElderThunderLizard_OnKilledTarget(Unit, Event) 
end

RegisterUnitEvent(4727, 1, "ElderThunderLizard_OnCombat")
RegisterUnitEvent(4727, 2, "ElderThunderLizard_OnLeaveCombat")
RegisterUnitEvent(4727, 3, "ElderThunderLizard_OnKilledTarget")
RegisterUnitEvent(4727, 4, "ElderThunderLizard_OnDied")