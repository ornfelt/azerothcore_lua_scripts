--[[

	This is created by zdroid9770  :D

	© Copyright 2012

]]


function CarrionHorror_OnCombat(Unit, Event)
	Unit:RegisterEvent("CarrionHorror_InfectedWound", 5000, 2)
end

function CarrionHorror_InfectedWound(Unit, Event) 
	Unit:FullCastSpellOnTarget(3427, 	Unit:GetMainTank()) 
end

function CarrionHorror_OnLeaveCombat(Unit, Event) 
	Unit:RemoveEvents() 
end

function CarrionHorror_OnDied(Unit, Event) 
	Unit:RemoveEvents()
end

RegisterUnitEvent(4695, 1, "CarrionHorror_OnCombat")
RegisterUnitEvent(4695, 2, "CarrionHorror_OnLeaveCombat")
RegisterUnitEvent(4695, 4, "CarrionHorror_OnDied")