--[[

	This is created by zdroid9770  :D

	© Copyright 2012

]]


function GorlocHunter_OnCombat(Unit, Event)
Unit:RegisterEvent("GorlocHunter_ParalyzingSlime", 7000, 0)
end

function GorlocHunter_ParalyzingSlime(Unit, Event) 
Unit:FullCastSpellOnTarget(50523, Unit:GetMainTank()) 
end

function GorlocHunter_OnLeaveCombat(Unit, Event) 
Unit:RemoveEvents() 
end

function GorlocHunter_OnDied(Unit, Event) 
Unit:RemoveEvents()
end

function GorlocHunter_OnKilledTarget(Unit, Event) 
end

RegisterUnitEvent(25700, 1, "GorlocHunter_OnCombat")
RegisterUnitEvent(25700, 2, "GorlocHunter_OnLeaveCombat")
RegisterUnitEvent(25700, 3, "GorlocHunter_OnKilledTarget")
RegisterUnitEvent(25700, 4, "GorlocHunter_OnDied")