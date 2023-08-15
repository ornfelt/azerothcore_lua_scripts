--[[

	This is created by zdroid9770  :D

	© Copyright 2012

]]


function GhostlyMarauder_OnCombat(Unit, Event)
	Unit:RegisterEvent("GhostlyMarauder_Strike", 6000, 0)
end

function GhostlyMarauder_Strike(Unit, Event) 
	Unit:FullCastSpellOnTarget(11976, 	Unit:GetMainTank()) 
end

function GhostlyMarauder_OnLeaveCombat(Unit, Event) 
	Unit:RemoveEvents() 
end

function GhostlyMarauder_OnDied(Unit, Event) 
	Unit:RemoveEvents()
end

function GhostlyMarauder_OnKilledTarget(Unit, Event) 
end

RegisterUnitEvent(11687, 1, "GhostlyMarauder_OnCombat")
RegisterUnitEvent(11687, 2, "GhostlyMarauder_OnLeaveCombat")
RegisterUnitEvent(11687, 3, "GhostlyMarauder_OnKilledTarget")
RegisterUnitEvent(11687, 4, "GhostlyMarauder_OnDied")