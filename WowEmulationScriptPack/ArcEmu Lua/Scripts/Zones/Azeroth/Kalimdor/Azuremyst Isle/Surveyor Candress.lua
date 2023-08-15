--[[

	This is created by zdroid9770  :D

	© Copyright 2012

]]


function SurveyorCandress_OnCombat(Unit, Event)
	Unit:RegisterEvent("SurveyorCandress_Fireball", 8000, 0)
end

function SurveyorCandress_Fireball(pUnit, Event) 
	pUnit:FullCastSpellOnTarget(9487, 	pUnit:GetMainTank()) 
end

function SurveyorCandress_OnLeaveCombat(Unit, Event) 
	Unit:RemoveEvents() 
end

function SurveyorCandress_OnDied(Unit, Event) 
	Unit:RemoveEvents()
end

RegisterUnitEvent(16522, 1, "SurveyorCandress_OnCombat")
RegisterUnitEvent(16522, 2, "SurveyorCandress_OnLeaveCombat")
RegisterUnitEvent(16522, 4, "SurveyorCandress_OnDied")