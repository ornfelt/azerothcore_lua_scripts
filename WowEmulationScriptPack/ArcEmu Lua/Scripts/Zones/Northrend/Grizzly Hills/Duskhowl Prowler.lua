--[[

	This is created by zdroid9770  :D

	© Copyright 2012

]]


function DuskhowlProwler_OnCombat(Unit, Event)
Unit:RegisterEvent("DuskhowlProwler_Gore", 10000, 0)
end

function DuskhowlProwler_Gore(Unit, Event) 
Unit:FullCastSpellOnTarget(32019, Unit:GetMainTank()) 
end

function DuskhowlProwler_OnLeaveCombat(Unit, Event) 
Unit:RemoveEvents() 
end

function DuskhowlProwler_OnDied(Unit, Event) 
Unit:RemoveEvents()
end

function DuskhowlProwler_OnKilledTarget(Unit, Event) 
end

RegisterUnitEvent(27408, 1, "DuskhowlProwler_OnCombat")
RegisterUnitEvent(27408, 2, "DuskhowlProwler_OnLeaveCombat")
RegisterUnitEvent(27408, 3, "DuskhowlProwler_OnKilledTarget")
RegisterUnitEvent(27408, 4, "DuskhowlProwler_OnDied")