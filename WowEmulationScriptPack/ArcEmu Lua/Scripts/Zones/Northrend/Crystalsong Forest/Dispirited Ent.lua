--[[

	This is created by zdroid9770  :D

	© Copyright 2012

]]


function DispiritedEnt_OnCombat(Unit, Event)
Unit:RegisterEvent("DispiritedEnt_Rejuvenation", 12000, 0)
Unit:RegisterEvent("DispiritedEnt_Thorns", 2000, 1)
end

function DispiritedEnt_Rejuvenation(Unit, Event) 
Unit:CastSpell(15981) 
end

function DispiritedEnt_Thorns(Unit, Event) 
Unit:CastSpell(35361) 
end

function DispiritedEnt_OnLeaveCombat(Unit, Event) 
Unit:RemoveEvents() 
end

function DispiritedEnt_OnDied(Unit, Event) 
Unit:RemoveEvents()
end

function DispiritedEnt_OnKilledTarget(Unit, Event) 
end

RegisterUnitEvent(31041, 1, "DispiritedEnt_OnCombat")
RegisterUnitEvent(31041, 2, "DispiritedEnt_OnLeaveCombat")
RegisterUnitEvent(31041, 3, "DispiritedEnt_OnKilledTarget")
RegisterUnitEvent(31041, 4, "DispiritedEnt_OnDied")