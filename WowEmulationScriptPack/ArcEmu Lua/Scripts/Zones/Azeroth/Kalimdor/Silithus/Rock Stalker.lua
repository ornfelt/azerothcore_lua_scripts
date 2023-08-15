--[[

	This is created by zdroid9770  :D

	© Copyright 2012

]]


function RockStalker_OnCombat(Unit, Event)
	Unit:RegisterEvent("RockStalker_Poison", 8000, 0)
	Unit:RegisterEvent("RockStalker_Web", 10000, 0)
end

function RockStalker_Poison(Unit, Event) 
	Unit:FullCastSpellOnTarget(744, 	Unit:GetMainTank()) 
end

function RockStalker_Web(Unit, Event) 
	Unit:FullCastSpellOnTarget(745, 	Unit:GetRandomPlayer(0)) 
end

function RockStalker_OnLeaveCombat(Unit, Event) 
	Unit:RemoveEvents() 
end

function RockStalker_OnDied(Unit, Event) 
	Unit:RemoveEvents()
end

function RockStalker_OnKilledTarget(Unit, Event) 
end

RegisterUnitEvent(11739, 1, "RockStalker_OnCombat")
RegisterUnitEvent(11739, 2, "RockStalker_OnLeaveCombat")
RegisterUnitEvent(11739, 3, "RockStalker_OnKilledTarget")
RegisterUnitEvent(11739, 4, "RockStalker_OnDied")