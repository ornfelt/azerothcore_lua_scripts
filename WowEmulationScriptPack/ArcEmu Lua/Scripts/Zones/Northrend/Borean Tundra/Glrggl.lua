--[[

	This is created by zdroid9770  :D

	© Copyright 2012

]]


function Glrggl_OnCombat(Unit, Event)
Unit:RegisterEvent("Glrggl_FlipperThwack", 8000, 0)
end

function Glrggl_FlipperThwack(Unit, Event) 
Unit:FullCastSpellOnTarget(50169, Unit:GetMainTank()) 
end

function Glrggl_OnLeaveCombat(Unit, Event) 
Unit:RemoveEvents() 
end

function Glrggl_OnDied(Unit, Event) 
Unit:RemoveEvents()
end

function Glrggl_OnKilledTarget(Unit, Event) 
end

RegisterUnitEvent(25203, 1, "Glrggl_OnCombat")
RegisterUnitEvent(25203, 2, "Glrggl_OnLeaveCombat")
RegisterUnitEvent(25203, 3, "Glrggl_OnKilledTarget")
RegisterUnitEvent(25203, 4, "Glrggl_OnDied")