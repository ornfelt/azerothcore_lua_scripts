--[[

	This is created by zdroid9770  :D

	© Copyright 2012

]]


function NexusWatcher_OnCombat(Unit, Event)
Unit:RegisterEvent("NexusWatcher_IntangiblePresence", 10000, 0)
Unit:RegisterEvent("NexusWatcher_Netherbreath", 7500, 0)
end

function NexusWatcher_IntangiblePresence(Unit, Event) 
Unit:CastSpell(36513) 
end

function NexusWatcher_Netherbreath(Unit, Event) 
Unit:CastSpell(36631) 
end

function NexusWatcher_OnLeaveCombat(Unit, Event) 
Unit:RemoveEvents() 
end

function NexusWatcher_OnDied(Unit, Event) 
Unit:RemoveEvents()
end

function NexusWatcher_OnKilledTarget(Unit, Event) 
end

RegisterUnitEvent(24770, 1, "NexusWatcher_OnCombat")
RegisterUnitEvent(24770, 2, "NexusWatcher_OnLeaveCombat")
RegisterUnitEvent(24770, 3, "NexusWatcher_OnKilledTarget")
RegisterUnitEvent(24770, 4, "NexusWatcher_OnDied")