--[[

	This is created by zdroid9770  :D

	© Copyright 2012

]]


function InfiniteTimerender_OnCombat(Unit, Event)
Unit:RegisterEvent("InfiniteTimerender_TimeLapse", 7000, 0)
end

function InfiniteTimerender_TimeLapse(Unit, Event) 
Unit:FullCastSpellOnTarget(51020, Unit:GetMainTank()) 
end

function InfiniteTimerender_OnLeaveCombat(Unit, Event) 
Unit:RemoveEvents() 
end

function InfiniteTimerender_OnDied(Unit, Event) 
Unit:RemoveEvents()
end

function InfiniteTimerender_OnKilledTarget(Unit, Event) 
end

RegisterUnitEvent(27900, 1, "InfiniteTimerender_OnCombat")
RegisterUnitEvent(27900, 2, "InfiniteTimerender_OnLeaveCombat")
RegisterUnitEvent(27900, 3, "InfiniteTimerender_OnKilledTarget")
RegisterUnitEvent(27900, 4, "InfiniteTimerender_OnDied")