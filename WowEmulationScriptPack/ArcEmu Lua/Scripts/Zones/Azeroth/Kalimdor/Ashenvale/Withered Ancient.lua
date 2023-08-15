--[[

	This is created by zdroid9770  :D

	© Copyright 2012

]]

function WitheredAncient_OnCombat(Unit, Event)
	Unit:RegisterEvent("WitheredAncient_CurseofThorns", 8000, 0)
end

function WitheredAncient_CurseofThorns(pUnit, Event) 
	pUnit:FullCastSpellOnTarget(6909, 	pUnit:GetMainTank()) 
end

function WitheredAncient_OnLeaveCombat(Unit, Event) 
	Unit:RemoveEvents() 
end

function WitheredAncient_OnDied(Unit, Event) 
	Unit:RemoveEvents()
end

RegisterUnitEvent(3919, 1, "WitheredAncient_OnCombat")
RegisterUnitEvent(3919, 2, "WitheredAncient_OnLeaveCombat")
RegisterUnitEvent(3919, 4, "WitheredAncient_OnDied")