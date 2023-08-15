--[[

	This is created by zdroid9770  :D

	© Copyright 2012

]]


function TundraScavenger_OnCombat(Unit, Event)
Unit:RegisterEvent("TundraScavenger_Maul", 5000, 0)
end

function TundraScavenger_Maul(Unit, Event) 
Unit:FullCastSpellOnTarget(51875, Unit:GetMainTank()) 
end

function TundraScavenger_OnLeaveCombat(Unit, Event) 
Unit:RemoveEvents() 
end

function TundraScavenger_OnDied(Unit, Event) 
Unit:RemoveEvents()
end

function TundraScavenger_OnKilledTarget(Unit, Event) 
end

RegisterUnitEvent(27294, 1, "TundraScavenger_OnCombat")
RegisterUnitEvent(27294, 2, "TundraScavenger_OnLeaveCombat")
RegisterUnitEvent(27294, 3, "TundraScavenger_OnKilledTarget")
RegisterUnitEvent(27294, 4, "TundraScavenger_OnDied")