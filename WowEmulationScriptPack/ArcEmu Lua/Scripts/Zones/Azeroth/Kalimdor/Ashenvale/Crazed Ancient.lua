--[[

	This is created by zdroid9770  :D

	© Copyright 2012

]]


function CrazedAncient_OnCombat(Unit, Event)
	Unit:RegisterEvent("CrazedAncient_CurseofThorns", 3000, 2)
end

function CrazedAncient_CurseofThorns(pUnit, Event) 
	pUnit:FullCastSpellOnTarget(6909, 	pUnit:GetMainTank()) 
end

function CrazedAncient_OnLeaveCombat(Unit, Event) 
	Unit:RemoveEvents() 
end

function CrazedAncient_OnDied(Unit, Event) 
	Unit:RemoveEvents()
end

RegisterUnitEvent(3834, 1, "CrazedAncient_OnCombat")
RegisterUnitEvent(3834, 2, "CrazedAncient_OnLeaveCombat")
RegisterUnitEvent(3834, 4, "CrazedAncient_OnDied")