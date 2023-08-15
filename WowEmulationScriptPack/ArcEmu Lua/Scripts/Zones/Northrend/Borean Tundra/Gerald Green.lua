--[[

	This is created by zdroid9770  :D

	© Copyright 2012

]]


function GeraldGreen_OnCombat(Unit, Event)
Unit:RegisterEvent("GeraldGreen_Cleave", 7000, 0)
end

function GeraldGreen_Cleave(Unit, Event) 
Unit:FullCastSpellOnTarget(40504, Unit:GetMainTank()) 
end

function GeraldGreen_OnLeaveCombat(Unit, Event) 
Unit:RemoveEvents() 
end

function GeraldGreen_OnDied(Unit, Event) 
Unit:RemoveEvents()
end

function GeraldGreen_OnKilledTarget(Unit, Event) 
end

RegisterUnitEvent(26083, 1, "GeraldGreen_OnCombat")
RegisterUnitEvent(26083, 2, "GeraldGreen_OnLeaveCombat")
RegisterUnitEvent(26083, 3, "GeraldGreen_OnKilledTarget")
RegisterUnitEvent(26083, 4, "GeraldGreen_OnDied")