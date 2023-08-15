--[[

	This is created by zdroid9770  :D

	© Copyright 2012

]]


function FelmuskSatyr_OnCombat(Unit, Event)
	Unit:RegisterEvent("FelmuskSatyr_OverwhelmingStench", 10000, 0)
end

function FelmuskSatyr_OverwhelmingStench(pUnit, Event) 
	pUnit:FullCastSpellOnTarget(6942, 	pUnit:GetMainTank()) 
end

function FelmuskSatyr_OnLeaveCombat(Unit, Event) 
	Unit:RemoveEvents() 
end

function FelmuskSatyr_OnDied(Unit, Event) 
	Unit:RemoveEvents()
end

RegisterUnitEvent(3758, 1, "FelmuskSatyr_OnCombat")
RegisterUnitEvent(3758, 2, "FelmuskSatyr_OnLeaveCombat")
RegisterUnitEvent(3758, 4, "FelmuskSatyr_OnDied")