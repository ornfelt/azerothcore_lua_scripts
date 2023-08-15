--[[

	This is created by zdroid9770  :D

	© Copyright 2012

]]


function HiveZoraAbomination_OnCombat(Unit, Event)
	Unit:RegisterEvent("HiveZoraAbomination_AbominationSpit", 8000, 0)
	Unit:RegisterEvent("HiveZoraAbomination_PoisonCloud", 10000, 0)
	Unit:RegisterEvent("HiveZoraAbomination_WingsofDespair", 12000, 0)
end

function HiveZoraAbomination_AbominationSpit(Unit, Event) 
	Unit:FullCastSpellOnTarget(25262, 	Unit:GetMainTank()) 
end

function HiveZoraAbomination_PoisonCloud(Unit, Event) 
	Unit:CastSpell(25198) 
end

function HiveZoraAbomination_WingsofDespair(Unit, Event) 
	Unit:FullCastSpellOnTarget(25260, 	Unit:GetRandomPlayer(0)) 
end

function HiveZoraAbomination_OnLeaveCombat(Unit, Event) 
	Unit:RemoveEvents() 
end

function HiveZoraAbomination_OnDied(Unit, Event) 
	Unit:RemoveEvents()
end

function HiveZoraAbomination_OnKilledTarget(Unit, Event) 
end

RegisterUnitEvent(15449, 1, "HiveZoraAbomination_OnCombat")
RegisterUnitEvent(15449, 2, "HiveZoraAbomination_OnLeaveCombat")
RegisterUnitEvent(15449, 3, "HiveZoraAbomination_OnKilledTarget")
RegisterUnitEvent(15449, 4, "HiveZoraAbomination_OnDied")