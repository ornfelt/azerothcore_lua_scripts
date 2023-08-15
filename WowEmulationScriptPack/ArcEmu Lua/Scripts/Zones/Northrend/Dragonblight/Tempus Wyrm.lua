--[[

	This is created by zdroid9770  :D

	© Copyright 2012

]]


function TempusWyrm_OnCombat(Unit, Event)
Unit:RegisterEvent("TempusWyrm_TimeShock", 5000, 0)
end

function TempusWyrm_TimeShock(Unit, Event) 
Unit:FullCastSpellOnTarget(60076, Unit:GetMainTank()) 
end

function TempusWyrm_OnLeaveCombat(Unit, Event) 
Unit:RemoveEvents() 
end

function TempusWyrm_OnDied(Unit, Event) 
Unit:RemoveEvents()
end

function TempusWyrm_OnKilledTarget(Unit, Event) 
end

RegisterUnitEvent(32180, 1, "TempusWyrm_OnCombat")
RegisterUnitEvent(32180, 2, "TempusWyrm_OnLeaveCombat")
RegisterUnitEvent(32180, 3, "TempusWyrm_OnKilledTarget")
RegisterUnitEvent(32180, 4, "TempusWyrm_OnDied")