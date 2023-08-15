--[[

	This is created by zdroid9770  :D

	© Copyright 2012

]]

function ElderPlainstrider_OnCombat(Unit, Event)
Unit:RegisterEvent("ElderPlainstrider_DustCloud", 20000, 0)
end

function ElderPlainstrider_DustCloud(pUnit, Event) 
pUnit:FullCastSpellOnTarget(7272, pUnit:GetClosestPlayer()) 
end

function ElderPlainstrider_OnLeaveCombat(Unit, Event) 
Unit:RemoveEvents() 
end

function ElderPlainstrider_OnDied(Unit, Event) 
Unit:RemoveEvents()
end

function ElderPlainstrider_OnKilledTarget(Unit, Event) 
end

RegisterUnitEvent(2957, 1, "ElderPlainstrider_OnCombat")
RegisterUnitEvent(2957, 2, "ElderPlainstrider_OnLeaveCombat")
RegisterUnitEvent(2957, 3, "ElderPlainstrider_OnKilledTarget")
RegisterUnitEvent(2957, 4, "ElderPlainstrider_OnDied")