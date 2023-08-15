--[[

	This is created by zdroid9770  :D

	© Copyright 2012

]]


function CenarionVindicator_OnCombat(Unit, Event)
	Unit:RegisterEvent("CenarionVindicator_Moonfire", 7000, 0)
end

function CenarionVindicator_Moonfire(pUnit, Event) 
	pUnit:FullCastSpellOnTarget(15798, 	pUnit:GetMainTank()) 
end

function CenarionVindicator_OnLeaveCombat(Unit, Event) 
	Unit:RemoveEvents() 
end

function CenarionVindicator_OnDied(Unit, Event) 
	Unit:RemoveEvents()
end

RegisterUnitEvent(3833, 1, "CenarionVindicator_OnCombat")
RegisterUnitEvent(3833, 2, "CenarionVindicator_OnLeaveCombat")
RegisterUnitEvent(3833, 4, "CenarionVindicator_OnDied")