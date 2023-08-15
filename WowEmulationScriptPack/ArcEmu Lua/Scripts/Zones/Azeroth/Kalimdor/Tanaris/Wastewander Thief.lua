--[[

	This is created by zdroid9770  :D

	© Copyright 2012

]]

function WastewanderThief_OnCombat(Unit, Event)
	Unit:RegisterEvent("WastewanderThief_Disarm", 10000, 0)
end

function WastewanderThief_Disarm(Unit, Event) 
	Unit:FullCastSpellOnTarget(6713, 	Unit:GetMainTank()) 
end

function WastewanderThief_OnLeaveCombat(Unit, Event) 
	Unit:RemoveEvents() 
end

function WastewanderThief_OnDied(Unit, Event) 
	Unit:RemoveEvents()
end

function WastewanderThief_OnKilledTarget(Unit, Event) 
end

RegisterUnitEvent(5616, 1, "WastewanderThief_OnCombat")
RegisterUnitEvent(5616, 2, "WastewanderThief_OnLeaveCombat")
RegisterUnitEvent(5616, 3, "WastewanderThief_OnKilledTarget")
RegisterUnitEvent(5616, 4, "WastewanderThief_OnDied")