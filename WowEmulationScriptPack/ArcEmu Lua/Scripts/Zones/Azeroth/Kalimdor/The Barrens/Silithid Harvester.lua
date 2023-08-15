--[[

	This is created by zdroid9770  :D

	© Copyright 2012

]]

function SilithidHarvester_OnCombat(Unit, Event)
	Unit:RegisterEvent("SilithidHarvester_HarvestSwarm", 6000, 0)
	Unit:RegisterEvent("SilithidHarvester_SummonHarvesterSwarm", 3000, 1)
end

function SilithidHarvester_HarvestSwarm(Unit, Event) 
	Unit:FullCastSpellOnTarget(7277, 	Unit:GetMainTank()) 
end

function SilithidHarvester_SummonHarvesterSwarm(Unit, Event) 
	Unit:CastSpell(7278) 
end

function SilithidHarvester_OnLeaveCombat(Unit, Event) 
	Unit:RemoveEvents() 
end

function SilithidHarvester_OnDied(Unit, Event) 
	Unit:RemoveEvents()
end

function SilithidHarvester_OnKilledTarget(Unit, Event) 
end

RegisterUnitEvent(3253, 1, "SilithidHarvester_OnCombat")
RegisterUnitEvent(3253, 2, "SilithidHarvester_OnLeaveCombat")
RegisterUnitEvent(3253, 3, "SilithidHarvester_OnKilledTarget")
RegisterUnitEvent(3253, 4, "SilithidHarvester_OnDied")