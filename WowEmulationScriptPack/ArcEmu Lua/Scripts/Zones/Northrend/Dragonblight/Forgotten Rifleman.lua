--[[

	This is created by zdroid9770  :D

	© Copyright 2012

]]


function ForgottenRifleman_OnCombat(Unit, Event)
Unit:RegisterEvent("ForgottenRifleman_ConcussiveShot", 7000, 0)
Unit:RegisterEvent("ForgottenRifleman_Shoot", 5000, 0)
end

function ForgottenRifleman_ConcussiveShot(Unit, Event) 
Unit:FullCastSpellOnTarget(17174, Unit:GetMainTank()) 
end

function ForgottenRifleman_Shoot(Unit, Event) 
Unit:FullCastSpellOnTarget(15547, Unit:GetMainTank()) 
end

function ForgottenRifleman_OnLeaveCombat(Unit, Event) 
Unit:RemoveEvents() 
end

function ForgottenRifleman_OnDied(Unit, Event) 
Unit:RemoveEvents()
end

function ForgottenRifleman_OnKilledTarget(Unit, Event) 
end

RegisterUnitEvent(27225, 1, "ForgottenRifleman_OnCombat")
RegisterUnitEvent(27225, 2, "ForgottenRifleman_OnLeaveCombat")
RegisterUnitEvent(27225, 3, "ForgottenRifleman_OnKilledTarget")
RegisterUnitEvent(27225, 4, "ForgottenRifleman_OnDied")