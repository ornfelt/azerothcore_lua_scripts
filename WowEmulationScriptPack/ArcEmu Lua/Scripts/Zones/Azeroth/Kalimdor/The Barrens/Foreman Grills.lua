--[[

	This is created by zdroid9770  :D

	© Copyright 2012

]]

function ForemanGrills_OnCombat(Unit, Event)
	Unit:RegisterEvent("ForemanGrills_Hamstring", 12000, 0)
end

function ForemanGrills_Hamstring(Unit, Event) 
	Unit:FullCastSpellOnTarget(9080, 	Unit:GetMainTank()) 
end

function ForemanGrills_OnLeaveCombat(Unit, Event) 
	Unit:RemoveEvents() 
end

function ForemanGrills_OnDied(Unit, Event) 
	Unit:RemoveEvents()
end

function ForemanGrills_OnKilledTarget(Unit, Event) 
end

RegisterUnitEvent(5835, 1, "ForemanGrills_OnCombat")
RegisterUnitEvent(5835, 2, "ForemanGrills_OnLeaveCombat")
RegisterUnitEvent(5835, 3, "ForemanGrills_OnKilledTarget")
RegisterUnitEvent(5835, 4, "ForemanGrills_OnDied")