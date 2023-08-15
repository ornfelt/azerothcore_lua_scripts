--[[

	This is created by zdroid9770  :D

	© Copyright 2012

]]

function FireRoc_OnCombat(Unit, Event)
	Unit:RegisterEvent("FireRoc_Flamespit", 6000, 0)
end

function FireRoc_Flamespit(Unit, Event) 
	Unit:FullCastSpellOnTarget(11021, 	Unit:GetMainTank()) 
end

function FireRoc_OnLeaveCombat(Unit, Event) 
	Unit:RemoveEvents() 
end

function FireRoc_OnDied(Unit, Event) 
	Unit:RemoveEvents()
end

function FireRoc_OnKilledTarget(Unit, Event) 
end

RegisterUnitEvent(5429, 1, "FireRoc_OnCombat")
RegisterUnitEvent(5429, 2, "FireRoc_OnLeaveCombat")
RegisterUnitEvent(5429, 3, "FireRoc_OnKilledTarget")
RegisterUnitEvent(5429, 4, "FireRoc_OnDied")