--[[

	This is created by zdroid9770  :D

	© Copyright 2012

]]


function ShadethicketBarkRipper_OnCombat(Unit, Event)
	Unit:RegisterEvent("ShadethicketBarkRipper_TendonRip", 8000, 0)
end

function ShadethicketBarkRipper_TendonRip(pUnit, Event) 
	pUnit:FullCastSpellOnTarget(3604, 	pUnit:GetMainTank()) 
end

function ShadethicketBarkRipper_OnLeaveCombat(Unit, Event) 
	Unit:RemoveEvents() 
end

function ShadethicketBarkRipper_OnDied(Unit, Event) 
	Unit:RemoveEvents()
end

RegisterUnitEvent(3784, 1, "ShadethicketBarkRipper_OnCombat")
RegisterUnitEvent(3784, 2, "ShadethicketBarkRipper_OnLeaveCombat")
RegisterUnitEvent(3784, 4, "ShadethicketBarkRipper_OnDied")