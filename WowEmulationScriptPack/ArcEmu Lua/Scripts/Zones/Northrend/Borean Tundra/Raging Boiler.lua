--[[

	This is created by zdroid9770  :D

	© Copyright 2012

]]


function RagingBoiler_OnCombat(Unit, Event)
Unit:RegisterEvent("RagingBoiler_BoilingBlood", 8000, 0)
end

function RagingBoiler_BoilingBlood(Unit, Event) 
Unit:FullCastSpellOnTarget(50207, Unit:GetMainTank()) 
end

function RagingBoiler_OnLeaveCombat(Unit, Event) 
Unit:RemoveEvents() 
end

function RagingBoiler_OnDied(Unit, Event) 
Unit:RemoveEvents()
end

function RagingBoiler_OnKilledTarget(Unit, Event) 
end

RegisterUnitEvent(25417, 1, "RagingBoiler_OnCombat")
RegisterUnitEvent(25417, 2, "RagingBoiler_OnLeaveCombat")
RegisterUnitEvent(25417, 3, "RagingBoiler_OnKilledTarget")
RegisterUnitEvent(25417, 4, "RagingBoiler_OnDied")