--[[

	This is created by zdroid9770  :D

	© Copyright 2012

]]


function TwilightKeeperExeter_OnCombat(Unit, Event)
	Unit:RegisterEvent("TwilightKeeperExeter_ConcussionBlow", 10000, 0)
	Unit:RegisterEvent("TwilightKeeperExeter_MortalStrike", 8000, 0)
end

function TwilightKeeperExeter_ConcussionBlow(Unit, Event) 
	Unit:FullCastSpellOnTarget(22427, 	Unit:GetMainTank()) 
end

function TwilightKeeperExeter_MortalStrike(Unit, Event) 
	Unit:FullCastSpellOnTarget(16856, 	Unit:GetMainTank()) 
end

function TwilightKeeperExeter_OnLeaveCombat(Unit, Event) 
	Unit:RemoveEvents() 
end

function TwilightKeeperExeter_OnDied(Unit, Event) 
	Unit:RemoveEvents()
end

function TwilightKeeperExeter_OnKilledTarget(Unit, Event) 
end

RegisterUnitEvent(11803, 1, "TwilightKeeperExeter_OnCombat")
RegisterUnitEvent(11803, 2, "TwilightKeeperExeter_OnLeaveCombat")
RegisterUnitEvent(11803, 3, "TwilightKeeperExeter_OnKilledTarget")
RegisterUnitEvent(11803, 4, "TwilightKeeperExeter_OnDied")