--[[ Darkshore -- Raging Reef Crawler.lua

This script was written and is protected
by the GPL v2. This script was released
by MikeBeck  of the BLUA Scripting
Project. Please give proper accredidations
when re-releasing or sharing this script
with others in the emulation community.

~~End of License Agreement
-- MikeBeck, December, 04th, 2008. ]]


function RagingReefCrawler_OnCombat(Unit, Event)
	Unit:RegisterEvent("RagingReefCrawler_Thrash", 6000, 0)
end

function RagingReefCrawler_Thrash(pUnit, Event) 
	pUnit:FullCastSpellOnTarget(3391, 	pUnit:GetMainTank()) 
end

function RagingReefCrawler_OnLeaveCombat(Unit, Event) 
	Unit:RemoveEvents() 
end

function RagingReefCrawler_OnDied(Unit, Event) 
	Unit:RemoveEvents()
end

RegisterUnitEvent(2236, 1, "RagingReefCrawler_OnCombat")
RegisterUnitEvent(2236, 2, "RagingReefCrawler_OnLeaveCombat")
RegisterUnitEvent(2236, 4, "RagingReefCrawler_OnDied")