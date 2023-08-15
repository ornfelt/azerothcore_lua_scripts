--[[

	This is created by zdroid9770  :D

	© Copyright 2012

]]


function FelmuskShadowstalker_OnCombat(Unit, Event)
	Unit:RegisterEvent("FelmuskShadowstalker_OverwhelmingStench", 10000, 0)
end

function FelmuskShadowstalker_OverwhelmingStench(pUnit, Event) 
	pUnit:FullCastSpellOnTarget(6942, 	pUnit:GetMainTank()) 
end

function FelmuskShadowstalker_OnLeaveCombat(Unit, Event) 
	Unit:RemoveEvents() 
end

function FelmuskShadowstalker_OnDied(Unit, Event) 
	Unit:RemoveEvents()
end

RegisterUnitEvent(3763, 1, "FelmuskShadowstalker_OnCombat")
RegisterUnitEvent(3763, 2, "FelmuskShadowstalker_OnLeaveCombat")
RegisterUnitEvent(3763, 4, "FelmuskShadowstalker_OnDied")