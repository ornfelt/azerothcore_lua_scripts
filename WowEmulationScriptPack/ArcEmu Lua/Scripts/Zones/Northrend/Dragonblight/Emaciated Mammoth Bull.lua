--[[

	This is created by zdroid9770  :D

	© Copyright 2012

]]


function EmaciatedMammothBull_OnCombat(Unit, Event)
Unit:RegisterEvent("EmaciatedMammothBull_Trample", 6000, 0)
end

function EmaciatedMammothBull_Trample(Unit, Event) 
Unit:CastSpell(51944) 
end

function EmaciatedMammothBull_OnLeaveCombat(Unit, Event) 
Unit:RemoveEvents() 
end

function EmaciatedMammothBull_OnDied(Unit, Event) 
Unit:RemoveEvents()
end

function EmaciatedMammothBull_OnKilledTarget(Unit, Event) 
end

RegisterUnitEvent(26271, 1, "EmaciatedMammothBull_OnCombat")
RegisterUnitEvent(26271, 2, "EmaciatedMammothBull_OnLeaveCombat")
RegisterUnitEvent(26271, 3, "EmaciatedMammothBull_OnKilledTarget")
RegisterUnitEvent(26271, 4, "EmaciatedMammothBull_OnDied")