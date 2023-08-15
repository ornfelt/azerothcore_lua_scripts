--[[

	This is created by zdroid9770  :D

	© Copyright 2012

]]


function FeralNightsaber_OnCombat(Unit, Event)
	Unit:RegisterEvent("FeralNightsaber_MuscleTear", 8000, 0)
end

function FeralNightsaber_MuscleTear(Unit, Event) 
	Unit:FullCastSpellOnTarget(12166, 	Unit:GetMainTank()) 
end

function FeralNightsaber_OnLeaveCombat(Unit, Event) 
	Unit:RemoveEvents() 
end

function FeralNightsaber_OnDied(Unit, Event) 
	Unit:RemoveEvents()
end

function FeralNightsaber_OnKilledTarget(Unit, Event) 
end

RegisterUnitEvent(2034, 1, "FeralNightsaber_OnCombat")
RegisterUnitEvent(2034, 2, "FeralNightsaber_OnLeaveCombat")
RegisterUnitEvent(2034, 3, "FeralNightsaber_OnKilledTarget")
RegisterUnitEvent(2034, 4, "FeralNightsaber_OnDied")