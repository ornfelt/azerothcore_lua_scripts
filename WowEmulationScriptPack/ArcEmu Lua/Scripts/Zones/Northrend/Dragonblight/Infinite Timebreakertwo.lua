--[[

	This is created by zdroid9770  :D

	© Copyright 2012

]]


function InfiniteTimebreaker_OnCombat(Unit, Event)
Unit:RegisterEvent("InfiniteTimebreaker_Enrage", 8000, 0)
Unit:RegisterEvent("InfiniteTimebreaker_TimeStop", 12000, 2)
end

function InfiniteTimebreaker_Enrage(Unit, Event) 
Unit:CastSpell(60075) 
end

function InfiniteTimebreaker_TimeStop(Unit, Event) 
Unit:FullCastSpellOnTarget(60074, Unit:GetMainTank()) 
end

function InfiniteTimebreaker_OnLeaveCombat(Unit, Event) 
Unit:RemoveEvents() 
end

function InfiniteTimebreaker_OnDied(Unit, Event) 
Unit:RemoveEvents()
end

function InfiniteTimebreaker_OnKilledTarget(Unit, Event) 
end

RegisterUnitEvent(32186, 1, "InfiniteTimebreaker_OnCombat")
RegisterUnitEvent(32186, 2, "InfiniteTimebreaker_OnLeaveCombat")
RegisterUnitEvent(32186, 3, "InfiniteTimebreaker_OnKilledTarget")
RegisterUnitEvent(32186, 4, "InfiniteTimebreaker_OnDied")