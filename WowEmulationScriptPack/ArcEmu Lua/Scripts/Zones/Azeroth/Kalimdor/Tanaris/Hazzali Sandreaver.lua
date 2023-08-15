--[[

	This is created by zdroid9770  :D

	© Copyright 2012

]]
function HazzaliSandreaver_OnCombat(Unit, Event)
	Unit:RegisterEvent("HazzaliSandreaver_ArcingSmash", 4000, 0)
end

function HazzaliSandreaver_ArcingSmash(Unit, Event) 
	Unit:CastSpell(8374) 
end

function HazzaliSandreaver_OnLeaveCombat(Unit, Event) 
	Unit:RemoveEvents() 
end

function HazzaliSandreaver_OnDied(Unit, Event) 
	Unit:RemoveEvents()
end

function HazzaliSandreaver_OnKilledTarget(Unit, Event) 
end

RegisterUnitEvent(5454, 1, "HazzaliSandreaver_OnCombat")
RegisterUnitEvent(5454, 2, "HazzaliSandreaver_OnLeaveCombat")
RegisterUnitEvent(5454, 3, "HazzaliSandreaver_OnKilledTarget")
RegisterUnitEvent(5454, 4, "HazzaliSandreaver_OnDied")