--[[

	This is created by zdroid9770  :D

	© Copyright 2012

]]
function EncrustedSurfCrawler_OnCombat(Unit, Event)
	UnitRegisterEvent("EncrustedSurfCrawler_QuickSidestep", 8000, 0)
end

function EncrustedSurfCrawler_QuickSidestep(Unit, Event) 
	UnitCastSpell(5426) 
end

function EncrustedSurfCrawler_OnLeaveCombat(Unit, Event) 
	UnitRemoveEvents() 
end

function EncrustedSurfCrawler_OnDied(Unit, Event) 
	UnitRemoveEvents()
end

function EncrustedSurfCrawler_OnKilledTarget(Unit, Event) 
end

RegisterUnitEvent(3108, 1, "EncrustedSurfCrawler_OnCombat")
RegisterUnitEvent(3108, 2, "EncrustedSurfCrawler_OnLeaveCombat")
RegisterUnitEvent(3108, 3, "EncrustedSurfCrawler_OnKilledTarget")
RegisterUnitEvent(3108, 4, "EncrustedSurfCrawler_OnDied")