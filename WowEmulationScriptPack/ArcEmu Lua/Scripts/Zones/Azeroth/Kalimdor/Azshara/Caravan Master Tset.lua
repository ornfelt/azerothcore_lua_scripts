--[[

	This is created by zdroid9770  :D

	© Copyright 2012

]]


function CaravanMasterTset_OnCombat(Unit, Event)
	Unit:RegisterEvent("CaravanMasterTset_Frostbolt", 7000, 0)
end

function CaravanMasterTset_Frostbolt(pUnit, Event) 
	pUnit:FullCastSpellOnTarget(9672, 	pUnit:GetMainTank()) 
end

function CaravanMasterTset_OnLeaveCombat(Unit, Event) 
	Unit:RemoveEvents() 
end

function CaravanMasterTset_OnDied(Unit, Event) 
	Unit:RemoveEvents()
end

RegisterUnitEvent(8409, 1, "CaravanMasterTset_OnCombat")
RegisterUnitEvent(8409, 2, "CaravanMasterTset_OnLeaveCombat")
RegisterUnitEvent(8409, 4, "CaravanMasterTset_OnDied")