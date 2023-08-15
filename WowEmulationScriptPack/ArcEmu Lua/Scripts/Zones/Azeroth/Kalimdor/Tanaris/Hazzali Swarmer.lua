--[[

	This is created by zdroid9770  :D

	© Copyright 2012

]]

function HazzaliSwarmer_OnCombat(Unit, Event)
	Unit:RegisterEvent("HazzaliSwarmer_SilithidSwarm", 10000, 1)
end

function HazzaliSwarmer_SilithidSwarm(Unit, Event) 
	Unit:CastSpell(6589) 
end

function HazzaliSwarmer_OnLeaveCombat(Unit, Event) 
	Unit:RemoveEvents() 
end

function HazzaliSwarmer_OnDied(Unit, Event) 
	Unit:RemoveEvents()
end

function HazzaliSwarmer_OnKilledTarget(Unit, Event) 
end

RegisterUnitEvent(5451, 1, "HazzaliSwarmer_OnCombat")
RegisterUnitEvent(5451, 2, "HazzaliSwarmer_OnLeaveCombat")
RegisterUnitEvent(5451, 3, "HazzaliSwarmer_OnKilledTarget")
RegisterUnitEvent(5451, 4, "HazzaliSwarmer_OnDied")