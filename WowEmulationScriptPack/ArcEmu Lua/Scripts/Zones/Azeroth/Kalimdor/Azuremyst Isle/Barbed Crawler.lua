--[[

	This is created by zdroid9770  :D

	© Copyright 2012

]]


function BarbedCrawler_OnCombat(Unit, Event)
	Unit:RegisterEvent("BarbedCrawler_Thorns", 2000, 2)
end

function BarbedCrawler_Thorns(pUnit, Event) 
	pUnit:CastSpell(31271) 
end

function BarbedCrawler_OnLeaveCombat(Unit, Event) 
	Unit:RemoveEvents() 
end

function BarbedCrawler_OnDied(Unit, Event) 
	Unit:RemoveEvents()
end

RegisterUnitEvent(17217, 1, "BarbedCrawler_OnCombat")
RegisterUnitEvent(17217, 2, "BarbedCrawler_OnLeaveCombat")
RegisterUnitEvent(17217, 4, "BarbedCrawler_OnDied")