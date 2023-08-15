--[[

	This is created by zdroid9770  :D

	© Copyright 2012

]]


function HiveZoraWasp_OnCombat(Unit, Event)
	Unit:RegisterEvent("HiveZoraWasp_Poison", 10000, 0)
end

function HiveZoraWasp_Poison(Unit, Event) 
	Unit:FullCastSpellOnTarget(744, 	Unit:GetRandomPlayer(0)) 
end

function HiveZoraWasp_OnLeaveCombat(Unit, Event) 
	Unit:RemoveEvents() 
end

function HiveZoraWasp_OnDied(Unit, Event) 
	Unit:RemoveEvents()
end

function HiveZoraWasp_OnKilledTarget(Unit, Event) 
end

RegisterUnitEvent(11727, 1, "HiveZoraWasp_OnCombat")
RegisterUnitEvent(11727, 2, "HiveZoraWasp_OnLeaveCombat")
RegisterUnitEvent(11727, 3, "HiveZoraWasp_OnKilledTarget")
RegisterUnitEvent(11727, 4, "HiveZoraWasp_OnDied")