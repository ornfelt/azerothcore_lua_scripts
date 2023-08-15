--[[

	This is created by zdroid9770  :D

	© Copyright 2012

]]

function AnayaDawnrunner_OnCombat(Unit, Event)
	Unit:RegisterEvent("AnayaDawnrunner_BansheeCurse", 8000, 0)
end

function AnayaDawnrunner_BansheeCurse(pUnit, Event) 
	pUnit:FullCastSpellOnTarget(5884, 	pUnit:GetMainTank()) 
end

function AnayaDawnrunner_OnLeaveCombat(Unit, Event) 
	Unit:RemoveEvents() 
end

function AnayaDawnrunner_OnDied(Unit, Event) 
	Unit:RemoveEvents()
end

RegisterUnitEvent(3667, 1, "AnayaDawnrunner_OnCombat")
RegisterUnitEvent(3667, 2, "AnayaDawnrunner_OnLeaveCombat")
RegisterUnitEvent(3667, 4, "AnayaDawnrunner_OnDied")