--[[

	This is created by zdroid9770  :D

	© Copyright 2012

]]

function Thunderhead_OnCombat(Unit, Event)
	Unit:RegisterEvent("Thunderhead_LizardBolt", 6000, 0)
end

function Thunderhead_LizardBolt(Unit, Event) 
	Unit:FullCastSpellOnTarget(5401, 	Unit:GetMainTank()) 
end

function Thunderhead_OnLeaveCombat(Unit, Event) 
	Unit:RemoveEvents() 
end

function Thunderhead_OnDied(Unit, Event) 
	Unit:RemoveEvents()
end

function Thunderhead_OnKilledTarget(Unit, Event) 
end

RegisterUnitEvent(3239, 1, "Thunderhead_OnCombat")
RegisterUnitEvent(3239, 2, "Thunderhead_OnLeaveCombat")
RegisterUnitEvent(3239, 3, "Thunderhead_OnKilledTarget")
RegisterUnitEvent(3239, 4, "Thunderhead_OnDied")