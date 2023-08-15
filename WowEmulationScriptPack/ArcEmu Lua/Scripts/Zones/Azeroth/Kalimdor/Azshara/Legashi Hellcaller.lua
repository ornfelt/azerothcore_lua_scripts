--[[

	This is created by zdroid9770  :D

	© Copyright 2012

]]


function LegashiHellcaller_OnCombat(Unit, Event)
	Unit:RegisterEvent("LegashiHellcaller_Fireball", 8000, 0)
end

function LegashiHellcaller_Fireball(pUnit, Event) 
	pUnit:FullCastSpellOnTarget(20823, 	pUnit:GetMainTank()) 
end

function LegashiHellcaller_OnLeaveCombat(Unit, Event) 
	Unit:RemoveEvents() 
end

function LegashiHellcaller_OnDied(Unit, Event) 
	Unit:RemoveEvents()
end

RegisterUnitEvent(6202, 1, "LegashiHellcaller_OnCombat")
RegisterUnitEvent(6202, 2, "LegashiHellcaller_OnLeaveCombat")
RegisterUnitEvent(6202, 4, "LegashiHellcaller_OnDied")