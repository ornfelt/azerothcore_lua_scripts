--[[

	This is created by zdroid9770  :D

	© Copyright 2012

]]


function CaptainShely_OnCombat(Unit, Event)
Unit:RegisterEvent("CaptainShely_RunThrough", 5000, 1)
end

function CaptainShely_RunThrough(Unit, Event) 
Unit:FullCastSpellOnTarget(50853, Unit:GetMainTank()) 
end

function CaptainShely_OnLeaveCombat(Unit, Event) 
Unit:RemoveEvents() 
end

function CaptainShely_OnDied(Unit, Event) 
Unit:RemoveEvents()
end

function CaptainShely_OnKilledTarget(Unit, Event) 
end

RegisterUnitEvent(27232, 1, "CaptainShely_OnCombat")
RegisterUnitEvent(27232, 2, "CaptainShely_OnLeaveCombat")
RegisterUnitEvent(27232, 3, "CaptainShely_OnKilledTarget")
RegisterUnitEvent(27232, 4, "CaptainShely_OnDied")