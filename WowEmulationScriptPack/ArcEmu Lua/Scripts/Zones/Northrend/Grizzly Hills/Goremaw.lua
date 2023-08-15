--[[

	This is created by zdroid9770  :D

	© Copyright 2012

]]


function Goremaw_OnCombat(Unit, Event)
Unit:RegisterEvent("Goremaw_CarnivorousBite", 10000, 0)
Unit:RegisterEvent("Goremaw_InfectedWorgenBite", 4000, 3)
end

function Goremaw_CarnivorousBite(Unit, Event) 
Unit:FullCastSpellOnTarget(50729, Unit:GetMainTank()) 
end

function Goremaw_InfectedWorgenBite(Unit, Event) 
Unit:FullCastSpellOnTarget(53174, Unit:GetMainTank()) 
end

function Goremaw_OnLeaveCombat(Unit, Event) 
Unit:RemoveEvents() 
end

function Goremaw_OnDied(Unit, Event) 
Unit:RemoveEvents()
end

function Goremaw_OnKilledTarget(Unit, Event) 
end

RegisterUnitEvent(27578, 1, "Goremaw_OnCombat")
RegisterUnitEvent(27578, 2, "Goremaw_OnLeaveCombat")
RegisterUnitEvent(27578, 3, "Goremaw_OnKilledTarget")
RegisterUnitEvent(27578, 4, "Goremaw_OnDied")