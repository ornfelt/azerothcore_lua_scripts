--[[

	This is created by zdroid9770  :D

	© Copyright 2012

]]


function LegashiSatyr_OnCombat(Unit, Event)
	Unit:RegisterEvent("LegashiSatyr_ManaBurn", 8000, 0)
end

function LegashiSatyr_ManaBurn(pUnit, Event) 
	pUnit:FullCastSpellOnTarget(11981, 	pUnit:GetRandomPlayer(4)) 
end

function LegashiSatyr_OnLeaveCombat(Unit, Event) 
	Unit:RemoveEvents() 
end

function LegashiSatyr_OnDied(Unit, Event) 
	Unit:RemoveEvents()
end

RegisterUnitEvent(6200, 1, "LegashiSatyr_OnCombat")
RegisterUnitEvent(6200, 2, "LegashiSatyr_OnLeaveCombat")
RegisterUnitEvent(6200, 4, "LegashiSatyr_OnDied")