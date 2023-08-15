--[[

	This is created by zdroid9770  :D

	© Copyright 2012

]]


function EnragedReefCrawler_OnCombat(Unit, Event)
	Unit:RegisterEvent("EnragedReefCrawler_Enrage", 10000, 1)
end

function EnragedReefCrawler_Enrage(Unit, Event) 
	Unit:CastSpell(8599) 
end

function EnragedReefCrawler_OnLeaveCombat(Unit, Event) 
	Unit:RemoveEvents() 
end

function EnragedReefCrawler_OnDied(Unit, Event) 
	Unit:RemoveEvents()
end

function EnragedReefCrawler_OnKilledTarget(Unit, Event) 
end

RegisterUnitEvent(12347, 1, "EnragedReefCrawler_OnCombat")
RegisterUnitEvent(12347, 2, "EnragedReefCrawler_OnLeaveCombat")
RegisterUnitEvent(12347, 3, "EnragedReefCrawler_OnKilledTarget")
RegisterUnitEvent(12347, 4, "EnragedReefCrawler_OnDied")