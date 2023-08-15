--[[

	This is created by zdroid9770  :D

	© Copyright 2012

]]


function EmaciatedMammoth_OnCombat(Unit, Event)
Unit:RegisterEvent("EmaciatedMammoth_Trample", 6000, 0)
end

function EmaciatedMammoth_Trample(Unit, Event) 
Unit:CastSpell(51944) 
end

function EmaciatedMammoth_OnLeaveCombat(Unit, Event) 
Unit:RemoveEvents() 
end

function EmaciatedMammoth_OnDied(Unit, Event) 
Unit:RemoveEvents()
end

function EmaciatedMammoth_OnKilledTarget(Unit, Event) 
end

RegisterUnitEvent(26272, 1, "EmaciatedMammoth_OnCombat")
RegisterUnitEvent(26272, 2, "EmaciatedMammoth_OnLeaveCombat")
RegisterUnitEvent(26272, 3, "EmaciatedMammoth_OnKilledTarget")
RegisterUnitEvent(26272, 4, "EmaciatedMammoth_OnDied")