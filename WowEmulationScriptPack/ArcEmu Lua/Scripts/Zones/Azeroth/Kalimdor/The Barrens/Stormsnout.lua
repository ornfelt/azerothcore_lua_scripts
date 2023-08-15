--[[

	This is created by zdroid9770  :D

	© Copyright 2012

]]

function Stormsnout_OnCombat(Unit, Event)
	Unit:RegisterEvent("Stormsnout_LizardBolt", 6000, 0)
end

function Stormsnout_LizardBolt(Unit, Event) 
	Unit:FullCastSpellOnTarget(5401, 	Unit:GetMainTank()) 
end

function Stormsnout_OnLeaveCombat(Unit, Event) 
	Unit:RemoveEvents() 
end

function Stormsnout_OnDied(Unit, Event) 
	Unit:RemoveEvents()
end

function Stormsnout_OnKilledTarget(Unit, Event) 
end

RegisterUnitEvent(3240, 1, "Stormsnout_OnCombat")
RegisterUnitEvent(3240, 2, "Stormsnout_OnLeaveCombat")
RegisterUnitEvent(3240, 3, "Stormsnout_OnKilledTarget")
RegisterUnitEvent(3240, 4, "Stormsnout_OnDied")