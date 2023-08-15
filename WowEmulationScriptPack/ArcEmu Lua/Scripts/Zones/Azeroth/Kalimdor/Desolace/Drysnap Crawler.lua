--[[

	This is created by zdroid9770  :D

	© Copyright 2012

]]


function DrysnapCrawler_OnCombat(Unit, Event)
	Unit:RegisterEvent("DrysnapCrawler_FrostArmor", 4000, 1)
	Unit:RegisterEvent("DrysnapCrawler_FrostShock", 9000, 0)
end

function DrysnapCrawler_FrostArmor(Unit, Event) 
	Unit:CastSpell(12544) 
end

function DrysnapCrawler_FrostShock(Unit, Event) 
	Unit:FullCastSpellOnTarget(12548, 	Unit:GetMainTank()) 
end

function DrysnapCrawler_OnLeaveCombat(Unit, Event) 
	Unit:RemoveEvents() 
end

function DrysnapCrawler_OnDied(Unit, Event) 
	Unit:RemoveEvents()
end

RegisterUnitEvent(11562, 1, "DrysnapCrawler_OnCombat")
RegisterUnitEvent(11562, 2, "DrysnapCrawler_OnLeaveCombat")
RegisterUnitEvent(11562, 4, "DrysnapCrawler_OnDied")