--[[

	This is created by zdroid9770  :D

	© Copyright 2012

]]


function ColdwindWasteHuntress_OnCombat(Unit, Event)
Unit:RegisterEvent("ColdwindWasteHuntress_EyePeck", 6000, 0)
end

function ColdwindWasteHuntress_EyePeck(Unit, Event) 
Unit:FullCastSpellOnTarget(49865, Unit:GetMainTank()) 
end

function ColdwindWasteHuntress_OnLeaveCombat(Unit, Event) 
Unit:RemoveEvents() 
end

function ColdwindWasteHuntress_OnDied(Unit, Event) 
Unit:RemoveEvents()
end

function ColdwindWasteHuntress_OnKilledTarget(Unit, Event) 
end

RegisterUnitEvent(26575, 1, "ColdwindWasteHuntress_OnCombat")
RegisterUnitEvent(26575, 2, "ColdwindWasteHuntress_OnLeaveCombat")
RegisterUnitEvent(26575, 3, "ColdwindWasteHuntress_OnKilledTarget")
RegisterUnitEvent(26575, 4, "ColdwindWasteHuntress_OnDied")