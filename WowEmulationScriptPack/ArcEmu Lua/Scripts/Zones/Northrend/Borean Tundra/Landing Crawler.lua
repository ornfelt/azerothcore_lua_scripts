--[[

	This is created by zdroid9770  :D

	© Copyright 2012

]]


function LandingCrawler_OnCombat(Unit, Event)
Unit:RegisterEvent("LandingCrawler_ClawGrasp", 10000, 0)
end

function LandingCrawler_ClawGrasp(Unit, Event) 
Unit:FullCastSpellOnTarget(49978, Unit:GetMainTank()) 
end

function LandingCrawler_OnLeaveCombat(Unit, Event) 
Unit:RemoveEvents() 
end

function LandingCrawler_OnDied(Unit, Event) 
Unit:RemoveEvents()
end

function LandingCrawler_OnKilledTarget(Unit, Event) 
end

RegisterUnitEvent(25481, 1, "LandingCrawler_OnCombat")
RegisterUnitEvent(25481, 2, "LandingCrawler_OnLeaveCombat")
RegisterUnitEvent(25481, 3, "LandingCrawler_OnKilledTarget")
RegisterUnitEvent(25481, 4, "LandingCrawler_OnDied")