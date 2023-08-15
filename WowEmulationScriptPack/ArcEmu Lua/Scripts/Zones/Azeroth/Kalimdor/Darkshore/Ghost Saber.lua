--[[

	This is created by zdroid9770  :D

	© Copyright 2012

]]

function GhostSaber_OnCombat(Unit, Event)
	Unit:RegisterEvent("GhostSaber_Claw", 6000, 0)
end

function GhostSaber_Claw(pUnit, Event) 
	pUnit:FullCastSpellOnTarget(16829, 	pUnit:GetMainTank()) 
end

function GhostSaber_OnLeaveCombat(Unit, Event) 
	Unit:RemoveEvents() 
end

function GhostSaber_OnDied(Unit, Event) 
	Unit:RemoveEvents()
end

RegisterUnitEvent(3619, 1, "GhostSaber_OnCombat")
RegisterUnitEvent(3619, 2, "GhostSaber_OnLeaveCombat")
RegisterUnitEvent(3619, 4, "GhostSaber_OnDied")