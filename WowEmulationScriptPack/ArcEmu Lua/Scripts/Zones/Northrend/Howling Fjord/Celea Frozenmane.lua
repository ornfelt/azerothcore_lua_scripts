--[[

	This is created by zdroid9770  :D

	© Copyright 2012

]]


function CeleaFrozenmane_OnCombat(Unit, Event)
Unit:RegisterEvent("CeleaFrozenmane_Shoot", 6000, 0)
end

function CeleaFrozenmane_Shoot(Unit, Event) 
Unit:FullCastSpellOnTarget(22121, Unit:GetMainTank()) 
end

function CeleaFrozenmane_OnLeaveCombat(Unit, Event) 
Unit:RemoveEvents() 
end

function CeleaFrozenmane_OnDied(Unit, Event) 
Unit:RemoveEvents()
end

function CeleaFrozenmane_OnKilledTarget(Unit, Event) 
end

RegisterUnitEvent(24032, 1, "CeleaFrozenmane_OnCombat")
RegisterUnitEvent(24032, 2, "CeleaFrozenmane_OnLeaveCombat")
RegisterUnitEvent(24032, 3, "CeleaFrozenmane_OnKilledTarget")
RegisterUnitEvent(24032, 4, "CeleaFrozenmane_OnDied")