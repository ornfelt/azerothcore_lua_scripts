--[[

	This is created by zdroid9770  :D

	© Copyright 2012

]]


function MinionofKaw_OnCombat(Unit, Event)
Unit:RegisterEvent("MinionofKaw_DestructiveStrike", 8000, 0)
end

function MinionofKaw_DestructiveStrike(Unit, Event) 
Unit:FullCastSpellOnTarget(51430, Unit:GetMainTank()) 
end

function MinionofKaw_OnLeaveCombat(Unit, Event) 
Unit:RemoveEvents() 
end

function MinionofKaw_OnDied(Unit, Event) 
Unit:RemoveEvents()
end

function MinionofKaw_OnKilledTarget(Unit, Event) 
end

RegisterUnitEvent(25880, 1, "MinionofKaw_OnCombat")
RegisterUnitEvent(25880, 2, "MinionofKaw_OnLeaveCombat")
RegisterUnitEvent(25880, 3, "MinionofKaw_OnKilledTarget")
RegisterUnitEvent(25880, 4, "MinionofKaw_OnDied")