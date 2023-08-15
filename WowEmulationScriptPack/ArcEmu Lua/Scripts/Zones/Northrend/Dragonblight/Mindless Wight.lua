--[[

	This is created by zdroid9770  :D

	© Copyright 2012

]]


function MindlessWight_OnCombat(Unit, Event)
Unit:RegisterEvent("MindlessWight_Smash", 6000, 0)
end

function MindlessWight_Smash(Unit, Event) 
Unit:FullCastSpellOnTarget(51334, Unit:GetMainTank()) 
end

function MindlessWight_OnLeaveCombat(Unit, Event) 
Unit:RemoveEvents() 
end

function MindlessWight_OnDied(Unit, Event) 
Unit:RemoveEvents()
end

function MindlessWight_OnKilledTarget(Unit, Event) 
end

RegisterUnitEvent(27287, 1, "MindlessWight_OnCombat")
RegisterUnitEvent(27287, 2, "MindlessWight_OnLeaveCombat")
RegisterUnitEvent(27287, 3, "MindlessWight_OnKilledTarget")
RegisterUnitEvent(27287, 4, "MindlessWight_OnDied")