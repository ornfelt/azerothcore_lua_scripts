--[[

	This is created by zdroid9770  :D

	© Copyright 2012

]]

function LeadCannoneerZierhut_OnCombat(Unit, Event)
Unit:RegisterEvent("LeadCannoneerZierhut_TorchToss", 2000, 1)
end

function LeadCannoneerZierhut_TorchToss(Unit, Event) 
Unit:FullCastSpellOnTarget(50832, Unit:GetMainTank()) 
end

function LeadCannoneerZierhut_OnLeaveCombat(Unit, Event) 
Unit:RemoveEvents() 
end

function LeadCannoneerZierhut_OnDied(Unit, Event) 
Unit:RemoveEvents()
end

function LeadCannoneerZierhut_OnKilledTarget(Unit, Event) 
end

RegisterUnitEvent(27235, 1, "LeadCannoneerZierhut_OnCombat")
RegisterUnitEvent(27235, 2, "LeadCannoneerZierhut_OnLeaveCombat")
RegisterUnitEvent(27235, 3, "LeadCannoneerZierhut_OnKilledTarget")
RegisterUnitEvent(27235, 4, "LeadCannoneerZierhut_OnDied")