--[[

	This is created by zdroid9770  :D

	© Copyright 2012

]]


function SnowplainShaman_OnCombat(Unit, Event)
Unit:RegisterEvent("SnowplainShaman_SearingTotem", 3000, 1)
end

function SnowplainShaman_SearingTotem(Unit, Event) 
Unit:CastSpell(39591) 
end

function SnowplainShaman_OnLeaveCombat(Unit, Event) 
Unit:RemoveEvents() 
end

function SnowplainShaman_OnDied(Unit, Event) 
Unit:RemoveEvents()
end

function SnowplainShaman_OnKilledTarget(Unit, Event) 
end

RegisterUnitEvent(27279, 1, "SnowplainShaman_OnCombat")
RegisterUnitEvent(27279, 2, "SnowplainShaman_OnLeaveCombat")
RegisterUnitEvent(27279, 3, "SnowplainShaman_OnKilledTarget")
RegisterUnitEvent(27279, 4, "SnowplainShaman_OnDied")