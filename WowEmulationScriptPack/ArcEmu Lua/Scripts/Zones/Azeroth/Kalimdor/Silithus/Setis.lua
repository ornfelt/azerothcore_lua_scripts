--[[

	This is created by zdroid9770  :D

	© Copyright 2012

]]


function Setis_OnCombat(Unit, Event)
	Unit:RegisterEvent("Setis_CrowdPummel", 8000, 0)
	Unit:RegisterEvent("Setis_WarStomp", 10000, 0)
end

function Setis_CrowdPummel(Unit, Event) 
	Unit:CastSpell(10887) 
end

function Setis_WarStomp(Unit, Event) 
	Unit:CastSpell(16727) 
end

function Setis_OnLeaveCombat(Unit, Event) 
	Unit:RemoveEvents() 
end

function Setis_OnDied(Unit, Event) 
	Unit:RemoveEvents()
end

function Setis_OnKilledTarget(Unit, Event) 
end

RegisterUnitEvent(14471, 1, "Setis_OnCombat")
RegisterUnitEvent(14471, 2, "Setis_OnLeaveCombat")
RegisterUnitEvent(14471, 3, "Setis_OnKilledTarget")
RegisterUnitEvent(14471, 4, "Setis_OnDied")