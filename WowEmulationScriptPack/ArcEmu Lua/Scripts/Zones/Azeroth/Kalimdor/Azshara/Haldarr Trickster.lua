--[[

	This is created by zdroid9770  :D

	© Copyright 2012

]]


function HaldarrTrickster_OnCombat(Unit, Event)
	Unit:RegisterEvent("HaldarrTrickster_CurseofMending", 8000, 0)
end

function HaldarrTrickster_CurseofMending(pUnit, Event) 
	pUnit:FullCastSpellOnTarget(7098, 	pUnit:GetMainTank()) 
end

function HaldarrTrickster_OnLeaveCombat(Unit, Event) 
	Unit:RemoveEvents() 
end

function HaldarrTrickster_OnDied(Unit, Event) 
	Unit:RemoveEvents()
end

RegisterUnitEvent(6126, 1, "HaldarrTrickster_OnCombat")
RegisterUnitEvent(6126, 2, "HaldarrTrickster_OnLeaveCombat")
RegisterUnitEvent(6126, 4, "HaldarrTrickster_OnDied")