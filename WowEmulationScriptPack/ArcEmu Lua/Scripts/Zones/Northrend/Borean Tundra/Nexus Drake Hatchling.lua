--[[

	This is created by zdroid9770  :D

	© Copyright 2012

]]

function NexusDrakeHatchling_OnCombat(Unit, Event)
Unit:RegisterEvent("NexusDrakeHatchling_IntangiblePresence", 10000, 0)
Unit:RegisterEvent("NexusDrakeHatchling_Netherbreath", 7500, 0)
end

function NexusDrakeHatchling_IntangiblePresence(Unit, Event) 
Unit:CastSpell(36513) 
end

function NexusDrakeHatchling_Netherbreath(Unit, Event) 
Unit:CastSpell(36631) 
end

function NexusDrakeHatchling_OnLeaveCombat(Unit, Event) 
Unit:RemoveEvents() 
end

function NexusDrakeHatchling_OnDied(Unit, Event) 
Unit:RemoveEvents()
end

function NexusDrakeHatchling_OnKilledTarget(Unit, Event) 
end

RegisterUnitEvent(26127, 1, "NexusDrakeHatchling_OnCombat")
RegisterUnitEvent(26127, 2, "NexusDrakeHatchling_OnLeaveCombat")
RegisterUnitEvent(26127, 3, "NexusDrakeHatchling_OnKilledTarget")
RegisterUnitEvent(26127, 4, "NexusDrakeHatchling_OnDied")