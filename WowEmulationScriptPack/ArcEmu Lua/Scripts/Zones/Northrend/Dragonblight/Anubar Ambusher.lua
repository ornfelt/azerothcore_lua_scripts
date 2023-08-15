--[[

	This is created by zdroid9770  :D

	© Copyright 2012

]]

function AnubarAmbusher_OnCombat(Unit, Event)
Unit:RegisterEvent("AnubarAmbusher_Rush", 6000, 0)
end

function AnubarAmbusher_Rush(Unit, Event) 
Unit:CastSpell(50347) 
end

function AnubarAmbusher_OnLeaveCombat(Unit, Event) 
Unit:RemoveEvents() 
end

function AnubarAmbusher_OnDied(Unit, Event) 
Unit:RemoveEvents()
end

function AnubarAmbusher_OnKilledTarget(Unit, Event) 
end

RegisterUnitEvent(26402, 1, "AnubarAmbusher_OnCombat")
RegisterUnitEvent(26402, 2, "AnubarAmbusher_OnLeaveCombat")
RegisterUnitEvent(26402, 3, "AnubarAmbusher_OnKilledTarget")
RegisterUnitEvent(26402, 4, "AnubarAmbusher_OnDied")