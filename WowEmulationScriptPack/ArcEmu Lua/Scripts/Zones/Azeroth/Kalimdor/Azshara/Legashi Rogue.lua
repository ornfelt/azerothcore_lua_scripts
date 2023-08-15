--[[

	This is created by zdroid9770  :D

	© Copyright 2012

]]


function LegashiRogue_OnCombat(Unit, Event)
	Unit:RegisterEvent("LegashiRogue_Gouge", 10000, 0)
end

function LegashiRogue_Gouge(pUnit, Event) 
	pUnit:FullCastSpellOnTarget(12540, 	pUnit:GetMainTank()) 
end

function LegashiRogue_OnLeaveCombat(Unit, Event) 
	Unit:RemoveEvents() 
end

function LegashiRogue_OnDied(Unit, Event) 
	Unit:RemoveEvents()
end

RegisterUnitEvent(6201, 1, "LegashiRogue_OnCombat")
RegisterUnitEvent(6201, 2, "LegashiRogue_OnLeaveCombat")
RegisterUnitEvent(6201, 4, "LegashiRogue_OnDied")