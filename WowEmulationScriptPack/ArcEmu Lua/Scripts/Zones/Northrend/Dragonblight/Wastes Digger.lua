--[[

	This is created by zdroid9770  :D

	© Copyright 2012

]]


function WastesDigger_OnCombat(Unit, Event)
Unit:RegisterEvent("WastesDigger_CarnivorousBite", 4000, 0)
end

function WastesDigger_CarnivorousBite(Unit, Event) 
Unit:FullCastSpellOnTarget(30639, Unit:GetMainTank()) 
end

function WastesDigger_OnLeaveCombat(Unit, Event) 
Unit:RemoveEvents() 
end

function WastesDigger_OnDied(Unit, Event) 
Unit:RemoveEvents()
end

function WastesDigger_OnKilledTarget(Unit, Event) 
end

RegisterUnitEvent(26492, 1, "WastesDigger_OnCombat")
RegisterUnitEvent(26492, 2, "WastesDigger_OnLeaveCombat")
RegisterUnitEvent(26492, 3, "WastesDigger_OnKilledTarget")
RegisterUnitEvent(26492, 4, "WastesDigger_OnDied")