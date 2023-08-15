--[[

	This is created by zdroid9770  :D

	© Copyright 2012

]]


function RigHaulerAC9_OnCombat(Unit, Event)
Unit:RegisterEvent("RigHaulerAC9_CrowdPummel", 10000, 0)
end

function RigHaulerAC9_CrowdPummel(Unit, Event) 
Unit:CastSpell(10887) 
end

function RigHaulerAC9_OnLeaveCombat(Unit, Event) 
Unit:RemoveEvents() 
end

function RigHaulerAC9_OnDied(Unit, Event) 
Unit:RemoveEvents()
end

function RigHaulerAC9_OnKilledTarget(Unit, Event) 
end

RegisterUnitEvent(25766, 1, "RigHaulerAC9_OnCombat")
RegisterUnitEvent(25766, 2, "RigHaulerAC9_OnLeaveCombat")
RegisterUnitEvent(25766, 3, "RigHaulerAC9_OnKilledTarget")
RegisterUnitEvent(25766, 4, "RigHaulerAC9_OnDied")