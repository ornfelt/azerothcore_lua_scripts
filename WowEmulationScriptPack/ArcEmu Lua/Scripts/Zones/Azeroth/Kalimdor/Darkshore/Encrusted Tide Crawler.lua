--[[

	This is created by zdroid9770  :D

	© Copyright 2012

]]

function EncrustedTideCrawler_OnCombat(Unit, Event)
	Unit:RegisterEvent("EncrustedTideCrawler_InfectedWound", 5000, 1)
end

function EncrustedTideCrawler_InfectedWound(pUnit, Event) 
	pUnit:FullCastSpellOnTarget(3427, 	pUnit:GetMainTank()) 
end

function EncrustedTideCrawler_OnLeaveCombat(Unit, Event) 
	Unit:RemoveEvents() 
end

function EncrustedTideCrawler_OnDied(Unit, Event) 
	Unit:RemoveEvents()
end

RegisterUnitEvent(2233, 1, "EncrustedTideCrawler_OnCombat")
RegisterUnitEvent(2233, 2, "EncrustedTideCrawler_OnLeaveCombat")
RegisterUnitEvent(2233, 4, "EncrustedTideCrawler_OnDied")