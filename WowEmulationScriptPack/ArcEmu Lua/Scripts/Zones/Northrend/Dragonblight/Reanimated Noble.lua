--[[

	This is created by zdroid9770  :D

	© Copyright 2012

]]

function ReanimatedNoble_OnCombat(Unit, Event)
Unit:RegisterEvent("ReanimatedNoble_SanguineStrike", 8000, 0)
end

function ReanimatedNoble_SanguineStrike(Unit, Event) 
Unit:FullCastSpellOnTarget(51285, Unit:GetMainTank()) 
end

function ReanimatedNoble_OnLeaveCombat(Unit, Event) 
Unit:RemoveEvents() 
end

function ReanimatedNoble_OnDied(Unit, Event) 
Unit:RemoveEvents()
end

function ReanimatedNoble_OnKilledTarget(Unit, Event) 
end

RegisterUnitEvent(27552, 1, "ReanimatedNoble_OnCombat")
RegisterUnitEvent(27552, 2, "ReanimatedNoble_OnLeaveCombat")
RegisterUnitEvent(27552, 3, "ReanimatedNoble_OnKilledTarget")
RegisterUnitEvent(27552, 4, "ReanimatedNoble_OnDied")