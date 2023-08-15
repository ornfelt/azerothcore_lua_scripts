--[[

	This is created by zdroid9770  :D

	© Copyright 2012

]]


function VaridustheFlenser_OnCombat(Unit, Event)
Unit:RegisterEvent("VaridustheFlenser_ShadowNova", 6000, 0)
Unit:RegisterEvent("VaridustheFlenser_ShieldofSuffering", 4000, 1)
end

function VaridustheFlenser_ShadowNova(Unit, Event) 
Unit:CastSpell(32711) 
end

function VaridustheFlenser_ShieldofSuffering(Unit, Event) 
Unit:CastSpell(50329) 
end

function VaridustheFlenser_OnLeaveCombat(Unit, Event) 
Unit:RemoveEvents() 
end

function VaridustheFlenser_OnDied(Unit, Event) 
Unit:RemoveEvents()
end

function VaridustheFlenser_OnKilledTarget(Unit, Event) 
end

RegisterUnitEvent(25618, 1, "VaridustheFlenser_OnCombat")
RegisterUnitEvent(25618, 2, "VaridustheFlenser_OnLeaveCombat")
RegisterUnitEvent(25618, 3, "VaridustheFlenser_OnKilledTarget")
RegisterUnitEvent(25618, 4, "VaridustheFlenser_OnDied")