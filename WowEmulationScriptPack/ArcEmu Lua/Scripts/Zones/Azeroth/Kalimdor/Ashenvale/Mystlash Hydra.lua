--[[

	This is created by zdroid9770  :D

	© Copyright 2012

]]


function MystlashHydra_OnCombat(Unit, Event)
	Unit:RegisterEvent("MystlashHydra_VenomSpit", 8000, 0)
end

function MystlashHydra_VenomSpit(pUnit, Event) 
	pUnit:FullCastSpellOnTarget(6917, 	pUnit:GetMainTank()) 
end

function MystlashHydra_OnLeaveCombat(Unit, Event) 
	Unit:RemoveEvents() 
end

function MystlashHydra_OnDied(Unit, Event) 
	Unit:RemoveEvents()
end

RegisterUnitEvent(3721, 1, "MystlashHydra_OnCombat")
RegisterUnitEvent(3721, 2, "MystlashHydra_OnLeaveCombat")
RegisterUnitEvent(3721, 4, "MystlashHydra_OnDied")