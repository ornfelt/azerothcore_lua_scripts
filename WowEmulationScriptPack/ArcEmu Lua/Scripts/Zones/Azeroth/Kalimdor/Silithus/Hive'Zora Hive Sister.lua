--[[

	This is created by zdroid9770  :D

	© Copyright 2012

]]


function HiveZoraHiveSister_OnCombat(Unit, Event)
	Unit:RegisterEvent("HiveZoraHiveSister_ToxicSpit", 5000, 0)
end

function HiveZoraHiveSister_ToxicSpit(Unit, Event) 
	Unit:FullCastSpellOnTarget(7951, 	Unit:GetClosestPlayer()) 
end

function HiveZoraHiveSister_OnLeaveCombat(Unit, Event) 
	Unit:RemoveEvents() 
end

function HiveZoraHiveSister_OnDied(Unit, Event) 
	Unit:RemoveEvents()
end

function HiveZoraHiveSister_OnKilledTarget(Unit, Event) 
end

RegisterUnitEvent(11729, 1, "HiveZoraHiveSister_OnCombat")
RegisterUnitEvent(11729, 2, "HiveZoraHiveSister_OnLeaveCombat")
RegisterUnitEvent(11729, 3, "HiveZoraHiveSister_OnKilledTarget")
RegisterUnitEvent(11729, 4, "HiveZoraHiveSister_OnDied")