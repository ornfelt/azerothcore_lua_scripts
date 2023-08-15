--[[

	This is created by zdroid9770  :D

	© Copyright 2012

]]

function MystSpinner_OnCombat(Unit, Event)
	Unit:RegisterEvent("MystSpinner_Web", 10000, 0)
end

function MystSpinner_Web(pUnit, Event) 
	pUnit:FullCastSpellOnTarget(745, 	pUnit:GetMainTank()) 
end

function MystSpinner_OnLeaveCombat(Unit, Event) 
	Unit:RemoveEvents() 
end

function MystSpinner_OnDied(Unit, Event) 
	Unit:RemoveEvents()
end

RegisterUnitEvent(17522, 1, "MystSpinner_OnCombat")
RegisterUnitEvent(17522, 2, "MystSpinner_OnLeaveCombat")
RegisterUnitEvent(17522, 4, "MystSpinner_OnDied")