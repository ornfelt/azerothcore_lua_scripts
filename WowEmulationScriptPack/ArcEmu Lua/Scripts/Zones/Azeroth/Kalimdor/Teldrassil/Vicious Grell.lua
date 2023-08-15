--[[

	This is created by zdroid9770  :D

	© Copyright 2012

]]

function ViciousGrell_OnCombat(Unit, Event)
	Unit:RegisterEvent("ViciousGrell_Savagery", 8000, 0)
end

function ViciousGrell_Savagery(Unit, Event) 
	Unit:CastSpell(5515) 
end

function ViciousGrell_OnLeaveCombat(Unit, Event) 
	Unit:RemoveEvents() 
end

function ViciousGrell_OnDied(Unit, Event) 
	Unit:RemoveEvents()
end

function ViciousGrell_OnKilledTarget(Unit, Event) 
end

RegisterUnitEvent(2005, 1, "ViciousGrell_OnCombat")
RegisterUnitEvent(2005, 2, "ViciousGrell_OnLeaveCombat")
RegisterUnitEvent(2005, 3, "ViciousGrell_OnKilledTarget")
RegisterUnitEvent(2005, 4, "ViciousGrell_OnDied")