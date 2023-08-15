--[[

	This is created by zdroid9770  :D

	© Copyright 2012

]]

function BlacksiltSeer_OnCombat(Unit, Event)
	Unit:RegisterEvent("BlacksiltSeer_Rejuvenation", 10000, 0)
	Unit:RegisterEvent("BlacksiltSeer_Wrath", 7000, 0)
end

function BlacksiltSeer_Rejuvenation(pUnit, Event) 
	pUnit:CastSpell(12160) 
end

function BlacksiltSeer_Wrath(pUnit, Event) 
	pUnit:FullCastSpellOnTarget(9739, 	pUnit:GetMainTank()) 
end

function BlacksiltSeer_OnLeaveCombat(Unit, Event) 
	Unit:RemoveEvents() 
end

function BlacksiltSeer_OnDied(Unit, Event) 
	Unit:RemoveEvents()
end

RegisterUnitEvent(17330, 1, "BlacksiltSeer_OnCombat")
RegisterUnitEvent(17330, 2, "BlacksiltSeer_OnLeaveCombat")
RegisterUnitEvent(17330, 4, "BlacksiltSeer_OnDied")