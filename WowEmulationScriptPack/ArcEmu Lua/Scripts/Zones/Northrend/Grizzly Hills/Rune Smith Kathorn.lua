--[[

	This is created by zdroid9770  :D

	© Copyright 2012

]]


function RuneSmithKathorn_OnCombat(Unit, Event)
Unit:RegisterEvent("RuneSmithKathorn_LightningCharged", 4000, 1)
end

function RuneSmithKathorn_LightningCharged(Unit, Event) 
Unit:CastSpell(52701) 
end

function RuneSmithKathorn_OnLeaveCombat(Unit, Event) 
Unit:RemoveEvents() 
end

function RuneSmithKathorn_OnDied(Unit, Event) 
Unit:RemoveEvents()
end

function RuneSmithKathorn_OnKilledTarget(Unit, Event) 
end

RegisterUnitEvent(26410, 1, "RuneSmithKathorn_OnCombat")
RegisterUnitEvent(26410, 2, "RuneSmithKathorn_OnLeaveCombat")
RegisterUnitEvent(26410, 3, "RuneSmithKathorn_OnKilledTarget")
RegisterUnitEvent(26410, 4, "RuneSmithKathorn_OnDied")