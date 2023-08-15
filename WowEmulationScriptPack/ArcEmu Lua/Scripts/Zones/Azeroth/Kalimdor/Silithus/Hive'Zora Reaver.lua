--[[

	This is created by zdroid9770  :D

	© Copyright 2012

]]


function HiveZoraReaver_OnCombat(Unit, Event)
	Unit:RegisterEvent("HiveZoraReaver_Cleave", 8000, 0)
	Unit:RegisterEvent("HiveZoraReaver_Knockdown", 10000, 0)
end

function HiveZoraReaver_Cleave(Unit, Event) 
	Unit:CastSpell(40504) 
end

function HiveZoraReaver_Knockdown(Unit, Event) 
	Unit:CastSpell(16790) 
end

function HiveZoraReaver_OnLeaveCombat(Unit, Event) 
	Unit:RemoveEvents() 
end

function HiveZoraReaver_OnDied(Unit, Event) 
	Unit:RemoveEvents()
end

function HiveZoraReaver_OnKilledTarget(Unit, Event) 
end

RegisterUnitEvent(11728, 1, "HiveZoraReaver_OnCombat")
RegisterUnitEvent(11728, 2, "HiveZoraReaver_OnLeaveCombat")
RegisterUnitEvent(11728, 3, "HiveZoraReaver_OnKilledTarget")
RegisterUnitEvent(11728, 4, "HiveZoraReaver_OnDied")