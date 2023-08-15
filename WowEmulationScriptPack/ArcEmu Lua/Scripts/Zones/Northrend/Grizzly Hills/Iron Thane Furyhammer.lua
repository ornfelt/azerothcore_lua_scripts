--[[

	This is created by zdroid9770  :D

	© Copyright 2012

]]


function IronThaneFuryhammer_OnCombat(Unit, Event)
Unit:RegisterEvent("IronThaneFuryhammer_Furyhammer", 8000, 0)
Unit:RegisterEvent("IronThaneFuryhammer_FuryhammersImmunity", 15000, 1)
end

function IronThaneFuryhammer_Furyhammer(Unit, Event) 
Unit:CastSpell(61576) 
end

function IronThaneFuryhammer_FuryhammersImmunity(Unit, Event) 
Unit:CastSpell(47922) 
end

function IronThaneFuryhammer_OnLeaveCombat(Unit, Event) 
Unit:RemoveEvents() 
end

function IronThaneFuryhammer_OnDied(Unit, Event) 
Unit:RemoveEvents()
end

function IronThaneFuryhammer_OnKilledTarget(Unit, Event) 
end

RegisterUnitEvent(26405, 1, "IronThaneFuryhammer_OnCombat")
RegisterUnitEvent(26405, 2, "IronThaneFuryhammer_OnLeaveCombat")
RegisterUnitEvent(26405, 3, "IronThaneFuryhammer_OnKilledTarget")
RegisterUnitEvent(26405, 4, "IronThaneFuryhammer_OnDied")