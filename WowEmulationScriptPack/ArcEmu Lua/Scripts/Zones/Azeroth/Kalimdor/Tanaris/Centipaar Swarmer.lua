--[[

	This is created by zdroid9770  :D

	© Copyright 2012

]]

function CentipaarSwarmer_OnCombat(Unit, Event)
	Unit:RegisterEvent("CentipaarSwarmer_SilithidSwarm", 10000, 1)
	Unit:RegisterEvent("CentipaarSwarmer_Thrash", 6000, 0)
end

function CentipaarSwarmer_SilithidSwarm(Unit, Event) 
	Unit:CastSpell(6589) 
end

function CentipaarSwarmer_Thrash(Unit, Event) 
	Unit:FullCastSpellOnTarget(3391, 	Unit:GetMainTank()) 
end

function CentipaarSwarmer_OnLeaveCombat(Unit, Event) 
	Unit:RemoveEvents() 
end

function CentipaarSwarmer_OnDied(Unit, Event) 
	Unit:RemoveEvents()
end

function CentipaarSwarmer_OnKilledTarget(Unit, Event) 
end

RegisterUnitEvent(5457, 1, "CentipaarSwarmer_OnCombat")
RegisterUnitEvent(5457, 2, "CentipaarSwarmer_OnLeaveCombat")
RegisterUnitEvent(5457, 3, "CentipaarSwarmer_OnKilledTarget")
RegisterUnitEvent(5457, 4, "CentipaarSwarmer_OnDied")