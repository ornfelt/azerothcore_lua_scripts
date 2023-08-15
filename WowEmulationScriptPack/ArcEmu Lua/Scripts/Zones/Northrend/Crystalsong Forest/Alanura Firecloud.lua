--[[

	This is created by zdroid9770  :D

	© Copyright 2012

]]


function AlanuraFirecloud_OnCombat(Unit, Event)
Unit:RegisterEvent("AlanuraFirecloud_FieryIntellect", 2000, 1)
end

function AlanuraFirecloud_FieryIntellect(Unit, Event) 
Unit:CastSpell(35917) 
end

function AlanuraFirecloud_OnLeaveCombat(Unit, Event) 
Unit:RemoveEvents() 
end

function AlanuraFirecloud_OnDied(Unit, Event) 
Unit:RemoveEvents()
end

function AlanuraFirecloud_OnKilledTarget(Unit, Event) 
end

RegisterUnitEvent(30239, 1, "AlanuraFirecloud_OnCombat")
RegisterUnitEvent(30239, 2, "AlanuraFirecloud_OnLeaveCombat")
RegisterUnitEvent(30239, 3, "AlanuraFirecloud_OnKilledTarget")
RegisterUnitEvent(30239, 4, "AlanuraFirecloud_OnDied")