--[[

	This is created by zdroid9770  :D

	© Copyright 2012

]]

function ThunderhawkCloudscraper_OnCombat(Unit, Event)
	Unit:RegisterEvent("ThunderhawkCloudscraper_ThunderClap", 10000, 0)
end

function ThunderhawkCloudscraper_ThunderClap(Unit, Event) 
	Unit:CastSpell(8078) 
end

function ThunderhawkCloudscraper_OnLeaveCombat(Unit, Event) 
	Unit:RemoveEvents() 
end

function ThunderhawkCloudscraper_OnDied(Unit, Event) 
	Unit:RemoveEvents()
end

function ThunderhawkCloudscraper_OnKilledTarget(Unit, Event) 
end

RegisterUnitEvent(3424, 1, "ThunderhawkCloudscraper_OnCombat")
RegisterUnitEvent(3424, 2, "ThunderhawkCloudscraper_OnLeaveCombat")
RegisterUnitEvent(3424, 3, "ThunderhawkCloudscraper_OnKilledTarget")
RegisterUnitEvent(3424, 4, "ThunderhawkCloudscraper_OnDied")