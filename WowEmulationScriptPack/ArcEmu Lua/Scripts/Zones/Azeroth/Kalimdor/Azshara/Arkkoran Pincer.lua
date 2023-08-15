--[[

	This is created by zdroid9770  :D

	© Copyright 2012

]]


function ArkkoranPincer_OnCombat(Unit, Event)
	Unit:RegisterEvent("ArkkoranPincer_Rend", 10000, 0)
end

function ArkkoranPincer_Rend(pUnit, Event) 
	pUnit:FullCastSpellOnTarget(13445, 	pUnit:GetMainTank()) 
end

function ArkkoranPincer_OnLeaveCombat(Unit, Event) 
	Unit:RemoveEvents() 
end

function ArkkoranPincer_OnDied(Unit, Event) 
	Unit:RemoveEvents()
end

RegisterUnitEvent(6137, 1, "ArkkoranPincer_OnCombat")
RegisterUnitEvent(6137, 2, "ArkkoranPincer_OnLeaveCombat")
RegisterUnitEvent(6137, 4, "ArkkoranPincer_OnDied")