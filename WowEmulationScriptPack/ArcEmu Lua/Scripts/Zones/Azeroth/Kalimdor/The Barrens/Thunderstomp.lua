--[[

	This is created by zdroid9770  :D

	© Copyright 2012

]]

function Thunderstomp_OnCombat(Unit, Event)
	Unit:RegisterEvent("Thunderstomp_ChainedBolt", 6000, 0)
end

function Thunderstomp_ChainedBolt(Unit, Event) 
	Unit:FullCastSpellOnTarget(6254, 	Unit:GetMainTank()) 
end

function Thunderstomp_OnLeaveCombat(Unit, Event) 
	Unit:RemoveEvents() 
end

function Thunderstomp_OnDied(Unit, Event) 
	Unit:RemoveEvents()
end

function Thunderstomp_OnKilledTarget(Unit, Event) 
end

RegisterUnitEvent(5832, 1, "Thunderstomp_OnCombat")
RegisterUnitEvent(5832, 2, "Thunderstomp_OnLeaveCombat")
RegisterUnitEvent(5832, 3, "Thunderstomp_OnKilledTarget")
RegisterUnitEvent(5832, 4, "Thunderstomp_OnDied")