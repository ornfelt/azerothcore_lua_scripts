--[[

	This is created by zdroid9770  :D

	© Copyright 2012

]]


function BloodsporeHarvester_OnCombat(Unit, Event)
	Unit:RegisterEvent("BloodsporeHarvester_BloodsporeHaze", 10000, 0)
end

function BloodsporeHarvester_BloodsporeHaze(Unit, Event) 
	Unit:FullCastSpellOnTarget(50380, 	Unit:GetMainTank()) 
end

function BloodsporeHarvester_OnLeaveCombat(Unit, Event) 
	Unit:RemoveEvents() 
end

function BloodsporeHarvester_OnDied(Unit, Event) 
	Unit:RemoveEvents()
end

function BloodsporeHarvester_OnKilledTarget(Unit, Event) 
end

RegisterUnitEvent(25467, 1, "BloodsporeHarvester_OnCombat")
RegisterUnitEvent(25467, 2, "BloodsporeHarvester_OnLeaveCombat")
RegisterUnitEvent(25467, 3, "BloodsporeHarvester_OnKilledTarget")
RegisterUnitEvent(25467, 4, "BloodsporeHarvester_OnDied")