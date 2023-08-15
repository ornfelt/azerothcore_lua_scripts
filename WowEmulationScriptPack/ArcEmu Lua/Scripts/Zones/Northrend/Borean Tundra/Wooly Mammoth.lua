--[[

	This is created by zdroid9770  :D

	© Copyright 2012

]]

function WoolyMammoth_OnCombat(Unit, Event)
Unit:RegisterEvent("WoolyMammoth_Trample", 6000, 0)
end

function WoolyMammoth_Trample(Unit, Event) 
Unit:CastSpell(15550) 
end

function WoolyMammoth_OnLeaveCombat(Unit, Event) 
Unit:RemoveEvents() 
end

function WoolyMammoth_OnDied(Unit, Event) 
Unit:RemoveEvents()
end

function WoolyMammoth_OnKilledTarget(Unit, Event) 
end

RegisterUnitEvent(24614, 1, "WoolyMammoth_OnCombat")
RegisterUnitEvent(24614, 2, "WoolyMammoth_OnLeaveCombat")
RegisterUnitEvent(24614, 3, "WoolyMammoth_OnKilledTarget")
RegisterUnitEvent(24614, 4, "WoolyMammoth_OnDied")