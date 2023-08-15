--[[

	This is created by zdroid9770  :D

	© Copyright 2012

]]


function AngratharNecrolord_OnCombat(Unit, Event)
Unit:RegisterEvent("AngratharNecrolord_ShadowBolt", 7000, 0)
end

function AngratharNecrolord_ShadowBolt(Unit, Event) 
Unit:FullCastSpellOnTarget(9613, Unit:GetMainTank()) 
end

function AngratharNecrolord_OnLeaveCombat(Unit, Event) 
Unit:RemoveEvents() 
end

function AngratharNecrolord_OnDied(Unit, Event) 
Unit:RemoveEvents()
end

function AngratharNecrolord_OnKilledTarget(Unit, Event) 
end

RegisterUnitEvent(27603, 1, "AngratharNecrolord_OnCombat")
RegisterUnitEvent(27603, 2, "AngratharNecrolord_OnLeaveCombat")
RegisterUnitEvent(27603, 3, "AngratharNecrolord_OnKilledTarget")
RegisterUnitEvent(27603, 4, "AngratharNecrolord_OnDied")