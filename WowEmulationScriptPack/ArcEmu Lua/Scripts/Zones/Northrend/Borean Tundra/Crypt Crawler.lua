--[[

	This is created by zdroid9770  :D

	© Copyright 2012

]]


function CryptCrawler_OnCombat(Unit, Event)
Unit:RegisterEvent("CryptCrawler_CryptScarabs", 6000, 1)
end

function CryptCrawler_CryptScarabs(Unit, Event) 
Unit:CastSpell(31600) 
end

function CryptCrawler_OnLeaveCombat(Unit, Event) 
Unit:RemoveEvents() 
end

function CryptCrawler_OnDied(Unit, Event) 
Unit:RemoveEvents()
end

function CryptCrawler_OnKilledTarget(Unit, Event) 
end

RegisterUnitEvent(25227, 1, "CryptCrawler_OnCombat")
RegisterUnitEvent(25227, 2, "CryptCrawler_OnLeaveCombat")
RegisterUnitEvent(25227, 3, "CryptCrawler_OnKilledTarget")
RegisterUnitEvent(25227, 4, "CryptCrawler_OnDied")