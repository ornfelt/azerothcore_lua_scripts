--[[

	This is created by zdroid9770  :D

	© Copyright 2012

]]

function CorruptedSurfCrawler_OnCombat(Unit, Event)
	UnitRegisterEvent("CorruptedSurfCrawler_DecayedStrength", 10000, 0)
end

function CorruptedSurfCrawler_DecayedStrength(Unit, Event) 
	UnitFullCastSpellOnTarget(6951, 	UnitGetMainTank()) 
end

function CorruptedSurfCrawler_OnLeaveCombat(Unit, Event) 
	UnitRemoveEvents() 
end

function CorruptedSurfCrawler_OnDied(Unit, Event) 
	UnitRemoveEvents()
end

function CorruptedSurfCrawler_OnKilledTarget(Unit, Event) 
end

RegisterUnitEvent(3228, 1, "CorruptedSurfCrawler_OnCombat")
RegisterUnitEvent(3228, 2, "CorruptedSurfCrawler_OnLeaveCombat")
RegisterUnitEvent(3228, 3, "CorruptedSurfCrawler_OnKilledTarget")
RegisterUnitEvent(3228, 4, "CorruptedSurfCrawler_OnDied")