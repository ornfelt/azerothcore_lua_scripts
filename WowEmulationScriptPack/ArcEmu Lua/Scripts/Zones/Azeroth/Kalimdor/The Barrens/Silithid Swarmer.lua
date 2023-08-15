--[[

	This is created by zdroid9770  :D

	© Copyright 2012

]]

function SilithidSwarmer_OnCombat(Unit, Event)
	Unit:RegisterEvent("SilithidSwarmer_SilithidSwarm", 3000, 1)
end

function SilithidSwarmer_SilithidSwarm(Unit, Event) 
	Unit:CastSpell(6589) 
end

function SilithidSwarmer_OnLeaveCombat(Unit, Event) 
	Unit:RemoveEvents() 
end

function SilithidSwarmer_OnDied(Unit, Event) 
	Unit:RemoveEvents()
end

function SilithidSwarmer_OnKilledTarget(Unit, Event) 
end

RegisterUnitEvent(3252, 1, "SilithidSwarmer_OnCombat")
RegisterUnitEvent(3252, 2, "SilithidSwarmer_OnLeaveCombat")
RegisterUnitEvent(3252, 3, "SilithidSwarmer_OnKilledTarget")
RegisterUnitEvent(3252, 4, "SilithidSwarmer_OnDied")