--[[ Darkshore -- Reef Crawler.lua

This script was written and is protected
by the GPL v2. This script was released
by MikeBeck  of the BLUA Scripting
Project. Please give proper accredidations
when re-releasing or sharing this script
with others in the emulation community.

~~End of License Agreement
-- MikeBeck, December, 04th, 2008. ]]


function ReefCrawler_OnCombat(Unit, Event)
	Unit:RegisterEvent("ReefCrawler_MuscleTear", 8000, 0)
end

function ReefCrawler_MuscleTear(pUnit, Event) 
	pUnit:FullCastSpellOnTarget(12166, 	pUnit:GetMainTank()) 
end

function ReefCrawler_OnLeaveCombat(Unit, Event) 
	Unit:RemoveEvents() 
end

function ReefCrawler_OnDied(Unit, Event) 
	Unit:RemoveEvents()
end

RegisterUnitEvent(2235, 1, "ReefCrawler_OnCombat")
RegisterUnitEvent(2235, 2, "ReefCrawler_OnLeaveCombat")
RegisterUnitEvent(2235, 4, "ReefCrawler_OnDied")