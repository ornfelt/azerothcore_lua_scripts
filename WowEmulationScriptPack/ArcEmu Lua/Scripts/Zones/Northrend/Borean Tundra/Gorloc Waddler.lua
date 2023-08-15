--[[

	This is created by zdroid9770  :D

	© Copyright 2012

]]


function GorlocWaddler_OnCombat(Unit, Event)
Unit:RegisterEvent("GorlocWaddler_GorlocStomp", 7000, 0)
end

function GorlocWaddler_GorlocStomp(Unit, Event) 
Unit:FullCastSpellOnTarget(50522, Unit:GetMainTank()) 
end

function GorlocWaddler_OnLeaveCombat(Unit, Event) 
Unit:RemoveEvents() 
end

function GorlocWaddler_OnDied(Unit, Event) 
Unit:RemoveEvents()
end

function GorlocWaddler_OnKilledTarget(Unit, Event) 
end

RegisterUnitEvent(25685, 1, "GorlocWaddler_OnCombat")
RegisterUnitEvent(25685, 2, "GorlocWaddler_OnLeaveCombat")
RegisterUnitEvent(25685, 3, "GorlocWaddler_OnKilledTarget")
RegisterUnitEvent(25685, 4, "GorlocWaddler_OnDied")