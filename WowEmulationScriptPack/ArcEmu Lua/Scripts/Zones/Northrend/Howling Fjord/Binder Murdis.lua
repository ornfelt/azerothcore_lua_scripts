--[[

	This is created by zdroid9770  :D

	© Copyright 2012

]]


function BinderMurdis_OnCombat(Unit, Event)
Unit:RegisterEvent("BinderMurdis_FlameShock", 7000, 0)
Unit:RegisterEvent("BinderMurdis_RuneofBinding", 11000, 0)
end

function BinderMurdis_FlameShock(Unit, Event) 
Unit:FullCastSpellOnTarget(15039, Unit:GetMainTank()) 
end

function BinderMurdis_RuneofBinding(Unit, Event) 
Unit:FullCastSpellOnTarget(48599, Unit:GetMainTank()) 
end

function BinderMurdis_OnLeaveCombat(Unit, Event) 
Unit:RemoveEvents() 
end

function BinderMurdis_OnDied(Unit, Event) 
Unit:RemoveEvents()
end

function BinderMurdis_OnKilledTarget(Unit, Event) 
end

RegisterUnitEvent(24334, 1, "BinderMurdis_OnCombat")
RegisterUnitEvent(24334, 2, "BinderMurdis_OnLeaveCombat")
RegisterUnitEvent(24334, 3, "BinderMurdis_OnKilledTarget")
RegisterUnitEvent(24334, 4, "BinderMurdis_OnDied")