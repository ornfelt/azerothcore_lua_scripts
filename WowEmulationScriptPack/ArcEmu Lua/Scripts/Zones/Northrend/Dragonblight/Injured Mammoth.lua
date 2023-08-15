--[[

	This is created by zdroid9770  :D

	© Copyright 2012

]]

function InjuredMammoth_OnCombat(Unit, Event)
Unit:RegisterEvent("InjuredMammoth_Trample", 6000, 0)
end

function InjuredMammoth_Trample(Unit, Event) 
Unit:CastSpell(51944) 
end

function InjuredMammoth_OnLeaveCombat(Unit, Event) 
Unit:RemoveEvents() 
end

function InjuredMammoth_OnDied(Unit, Event) 
Unit:RemoveEvents()
end

function InjuredMammoth_OnKilledTarget(Unit, Event) 
end

RegisterUnitEvent(26711, 1, "InjuredMammoth_OnCombat")
RegisterUnitEvent(26711, 2, "InjuredMammoth_OnLeaveCombat")
RegisterUnitEvent(26711, 3, "InjuredMammoth_OnKilledTarget")
RegisterUnitEvent(26711, 4, "InjuredMammoth_OnDied")